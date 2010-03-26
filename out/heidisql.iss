; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

; Original HeidiSQL setup script for Innosetup

[Setup]
AppId=HeidiSQL
AppName=HeidiSQL
AppVerName=HeidiSQL 5.0 Beta
VersionInfoVersion=5.0

; Displayed on the "Support" dialog of the Add/Remove Programs Control Panel applet:
AppVersion=5.0
AppPublisher=Ansgar Becker
AppPublisherURL=http://www.heidisql.com/
AppSupportURL=http://forum.heidisql.com/
AppUpdatesURL=http://download.heidisql.com/
AppContact=heidisql@anse.de
AppReadmeFile={app}\readme.txt

DefaultDirName={pf}\HeidiSQL
DefaultGroupName=HeidiSQL
LicenseFile=license.txt
ChangesAssociations=yes
WizardImageFile=.\..\res\installer-logo.bmp
WizardImageBackColor=$ffffff
WizardSmallImageFile=.\..\res\installer-small-logo.bmp
OutputDir=.
OutputBaseFilename=HeidiSQL_5.0Beta_Setup
UninstallDisplayIcon={app}\heidisql.exe
SetupIconFile=.\..\res\mainicon.ico
; uncomment the following line if you want your installation to run on NT 3.51 too.
; MinVersion=4,3.51
UsePreviousAppDir=yes
DirExistsWarning=auto
PrivilegesRequired=admin
; uncomment the two following lines if you want to build an update installation
;CreateUninstallRegKey=no
;UpdateUninstallLogAppName=no

[Tasks]
Name: "desktopicon"; Description: "Create a &desktop icon"; GroupDescription: "Additional icons:"; MinVersion: 4,4
Name: "quicklaunchicon"; Description: "Create a &Quick Launch icon"; GroupDescription: "Additional icons:"; MinVersion: 4,4; Flags: unchecked
Name: "associatesqlfiles"; Description: "Associate .&SQL-Files with HeidiSQL"; GroupDescription: "Options:";
Name: "activate_updatechecks"; Description: "Automatically check heidisql.com for updates"; GroupDescription: "Options:";
Name: "activate_statistics"; Description: "Automatically report client and server versions on heidisql.com"; GroupDescription: "Options:";

[InstallDelete]
Type: files; Name: "{app}\libmysql40.dll"
Type: files; Name: "{app}\libmysql41.dll"
Type: files; Name: "{app}\heidisql.exe.manifest"

[Files]
Source: "heidisql.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "readme.txt"; DestDir: "{app}"; Flags: ignoreversion isreadme
Source: "license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "gpl.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "libmysql.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Snippets\*.sql"; DestDir: "{commonappdata}\HeidiSQL\Snippets";

[INI]
Filename: "{app}\heidisql.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://www.heidisql.com/"
Filename: "{app}\heidisql_forum.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://www.heidisql.com/forum/"
Filename: "{app}\donate.url"; Section: "InternetShortcut"; Key: "URL"; String: "http://www.heidisql.com/donate.php"

[Icons]
Name: "{group}\HeidiSQL"; Filename: "{app}\heidisql.exe"
Name: "{group}\HeidiSQL on the Web"; Filename: "{app}\heidisql.url"
Name: "{group}\HeidiSQL Forum"; Filename: "{app}\heidisql_forum.url"
Name: "{group}\Donate"; Filename: "{app}\donate.url"
Name: "{group}\Uninstall HeidiSQL"; Filename: "{uninstallexe}"
Name: "{userdesktop}\HeidiSQL"; Filename: "{app}\heidisql.exe"; MinVersion: 4,4; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\HeidiSQL"; Filename: "{app}\heidisql.exe"; MinVersion: 4,4; Tasks: quicklaunchicon

[Registry]
Root: HKCR; Subkey: ".sql"; ValueType: string; ValueName: ""; ValueData: "SQLScriptFile"; Flags: uninsdeletevalue; Tasks: associatesqlfiles
Root: HKCR; Subkey: "SQLScriptFile"; ValueType: string; ValueName: ""; ValueData: "SQL-Script"; Flags: uninsdeletekey; Tasks: associatesqlfiles
Root: HKCR; Subkey: "SQLScriptFile\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\heidisql.exe,0"; Tasks: associatesqlfiles
Root: HKCR; Subkey: "SQLScriptFile\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\heidisql.exe"" ""%1"""; Tasks: associatesqlfiles
; Enable auto-updatechecks if this option was checked. Only save the value when it's checked, as the default in HeidiSQL is False (see const.inc)
Root: HKCU; Subkey: "Software\HeidiSQL"; ValueType: dword; ValueName: "Updatecheck"; ValueData: 1; Tasks: activate_updatechecks
Root: HKCU; Subkey: "Software\HeidiSQL"; ValueType: dword; ValueName: "DoUsageStatistics"; ValueData: 1; Tasks: activate_statistics

[Run]
Filename: "{app}\heidisql.exe"; Description: "Launch HeidiSQL"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: files; Name: "{app}\heidisql.url"
Type: files; Name: "{app}\heidisql_forum.url"
Type: files; Name: "{app}\donate.url"
Type: files; Name: "{app}\function.txt"

[Code]
procedure DonateClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', 'http://www.heidisql.com/donate.php', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure InitializeWizard();
var
  txt: TNewStaticText;
  btn: TButton;
begin
  txt := TNewStaticText.Create(WizardForm);
  txt.Parent := WizardForm.FinishedPage;
  txt.Caption := 'HeidiSQL is free software. You may make a donation:';
  txt.Left := WizardForm.FinishedLabel.Left;
  txt.Top := WizardForm.FinishedLabel.Top + 130;
  txt.AutoSize := True;

  btn := TButton.Create(WizardForm);
  btn.Parent := WizardForm.FinishedPage;
  btn.Left := txt.Left;
  btn.Top := txt.Top + txt.Height + 10;
  btn.Width := 120;
  btn.Height := WizardForm.CancelButton.Height;
  btn.Caption := 'Donate';
  btn.OnClick := @DonateClick;
end;

