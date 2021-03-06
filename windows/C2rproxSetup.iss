; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "c2rprox"
#define MyAppVersion "1.0"
#define MyAppPublisher "C2is"
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "c2rprox.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{3536C665-3816-4D46-9C43-08259BA2DF34}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={sd}\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
InfoAfterFile=C:\Users\root\Documents\dev\go\c2rprox\windows\Help.txt
OutputBaseFilename=c2rproxSetup
OutputDir=.
;SetupIconFile=C:\Users\root\Documents\dev\go\c2rprox\logo.png
Compression=lzma
SolidCompression=yes
PrivilegesRequired=poweruser

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "C:\Users\root\Documents\dev\go\c2rprox\windows\c2rprox.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\root\Documents\dev\go\c2rprox\windows\nssm.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\root\Documents\dev\go\c2rprox\windows\targets"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Run]
Filename: "{app}\nssm.exe"; Parameters: "install {#MyAppName} {app}/c2rprox.exe AppDirectory {app}"; Description: "Install service"; Flags: waituntilterminated postinstall

[UninstallRun]
Filename: "{app}\nssm.exe"; Parameters: "stop {#MyAppName}"; 
Filename: "{app}\nssm.exe"; Parameters: "remove {#MyAppName}"; 

[Code]

procedure DeinitializeSetup();
var
  ResultCode: Integer;
begin
      
      if not Exec(ExpandConstant('{app}\nssm.exe'), 'start c2rprox', '', SW_SHOW, ewWaitUntilTerminated, ResultCode) then
      begin
            MsgBox('Service c2rprox failed to start', mbError, MB_OK);
      end;

end;