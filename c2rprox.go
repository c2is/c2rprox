package main

import (
	"bufio"
	"errors"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
	"regexp"
	"strings"
	"time"
)

// Own implementation of transport only to be able to catch response error
type Transport struct {
	Transport   http.RoundTripper
	LogRequest  func(req *http.Request)
	LogResponse func(resp *http.Response)
}

var DefaultTransport = &Transport{
	Transport: http.DefaultTransport,
}

func (t *Transport) RoundTrip(req *http.Request) (*http.Response, error) {

	resp, err := t.transport().RoundTrip(req)
	if err != nil {
		if req.URL.Scheme == "" {
			filelog("No target defined in conf file for host " + req.Host)
			return resp, errors.New("No target defined in conf file for host " + req.Host)
		}
		return resp, err
	}

	return resp, err
}

func (t *Transport) transport() http.RoundTripper {
	if t.Transport != nil {
		return t.Transport
	}

	return http.DefaultTransport
}

func NewSingleHostReverseProxy(target *url.URL, filters []string) *httputil.ReverseProxy {

	targetQuery := target.RawQuery
	director := func(req *http.Request) {

		targetFound := ""
		for _, element := range filters {

			matchComment, _ := regexp.MatchString("^#", element)
			if matchComment {
				continue
			}

			confFields := strings.Split(string(element), " ")
			filterHost := confFields[0]
			if filterHost != "" {
				match, _ := regexp.MatchString(filterHost, req.Host)

				if match {
					fmt.Printf(now()+" Host %s in targets config file match requested host %s\n", filterHost, req.Host)
					filelog("Host " + filterHost + " in targets config file match requested host " + req.Host)

					targetFound = confFields[1]

					fmt.Printf(now()+" Proxying to %s\n", targetFound)
					filelog("Proxying to " + targetFound)
					break
				}

			}

		}

		if targetFound != "" {
			req.URL.Scheme = target.Scheme
			req.URL.Host = targetFound
			req.URL.Path = singleJoiningSlash(target.Path, req.URL.Path)
			if targetQuery == "" || req.URL.RawQuery == "" {
				req.URL.RawQuery = targetQuery + req.URL.RawQuery
			} else {
				req.URL.RawQuery = targetQuery + "&" + req.URL.RawQuery
			}
		}

	}

	proxy := &httputil.ReverseProxy{Director: director, Transport: &Transport{}}

	return proxy
}

func getconf() []string {
	content, err := ioutil.ReadFile("targets")
	if err != nil {
		//Do something
	}
	lines := strings.Split(string(content), "\n")

	return lines
}

func now() string {
	t := time.Now()
	return t.Format(time.Stamp)
}
func singleJoiningSlash(a, b string) string {
	aslash := strings.HasSuffix(a, "/")
	bslash := strings.HasPrefix(b, "/")
	switch {
	case aslash && bslash:
		return a + b[1:]
	case !aslash && !bslash:
		return a + "/" + b
	}
	return a + b
}

func filelog(message string) {

	if _, err := os.Stat("c2rprox.log"); err != nil {
		if os.IsNotExist(err) {
			_, err := os.Create("c2rprox.log")
			if err != nil {
				panic(err)
			}
		}
	}

	f, err := os.OpenFile("c2rprox.log", os.O_APPEND|os.O_WRONLY, 0600)
	w := bufio.NewWriter(f)
	_, err = w.WriteString(now() + " " + message + "\n")
	check(err)
	w.Flush()

	defer f.Close()

}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {

	lines := getconf()

	proxy := NewSingleHostReverseProxy(&url.URL{
		Scheme: "http",
		Host:   "127.0.0.1:81",
	}, lines)

	log.Fatal(http.ListenAndServe(":80", proxy))

}
