package main

import (
	"net/http"
	"net/http/httputil"
	"net/url"
)

func main() {
	proxy := httputil.NewSingleHostReverseProxy(&url.URL{
		Scheme: "http",
		Host:   "10.63.1.7:82",
	})

	s := &http.Server{
		Addr:    ":80",
		Handler: proxy,
	}
	s.ListenAndServe()
}
