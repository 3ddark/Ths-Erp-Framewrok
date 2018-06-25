unit Ths.Erp.Database.Connection.Settings;

interface

uses
  Vcl.Forms, System.SysUtils, System.IniFiles;

type
  TConnSettings = class
  private
    FLanguage: string;
    FDBUserPassword: UnicodeString;
    FDBPortNo: Integer;
    FDBUserName: UnicodeString;
    FSQLServer: UnicodeString;
    FDatabaseName: UnicodeString;
    FAppName: UnicodeString;
  protected
  public
    property Language: UnicodeString read FLanguage write FLanguage;
    property SQLServer: UnicodeString read FSQLServer write FSQLServer;
    property DatabaseName: UnicodeString read FDatabaseName write FDatabaseName;
    property DBUserName: UnicodeString read FDBUserName write FDBUserName;
    property DBUserPassword: UnicodeString read FDBUserPassword write FDBUserPassword;
    property DBPortNo: Integer read FDBPortNo write FDBPortNo;
    property AppName: UnicodeString read FAppName write FAppName;

    procedure ReadFromFile();
    procedure SaveToFile();
  end;

implementation

{ TConnSettings }

procedure TConnSettings.ReadFromFile();
var
  iniFile: TIniFile;
begin

  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings' + '\' + 'GlobalSettings.ini');
  try
    Self.FLanguage       := iniFile.ReadString('ConnectionSettings', 'Language', '');
    Self.FSQLServer      := iniFile.ReadString('ConnectionSettings', 'SQLServer', '');
    Self.FDatabaseName   := iniFile.ReadString('ConnectionSettings', 'DatabaseName', '');
    Self.FDBUserName     := iniFile.ReadString('ConnectionSettings', 'DBUserName', '');
    Self.FDBUserPassword := iniFile.ReadString('ConnectionSettings', 'DBUserPassword', '');
    Self.DBPortNo        := iniFile.ReadInteger('ConnectionSettings', 'DBPortNo', 0);
  finally
    iniFile.Free;
  end;
end;

procedure TConnSettings.SaveToFile();
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings' + '\' + 'GlobalSettings.ini');
  try
    iniFile.WriteString('ConnectionSettings', 'Language', Self.FLanguage);
    iniFile.WriteString('ConnectionSettings', 'SQLServer', Self.FSQLServer);
    iniFile.WriteString('ConnectionSettings', 'DatabaseName', Self.DatabaseName);
    iniFile.WriteString('ConnectionSettings', 'DBUserName', Self.DBUserName);
    iniFile.WriteString('ConnectionSettings', 'DBUserPassword', Self.DBUserPassword);
    iniFile.WriteInteger('ConnectionSettings', 'DBPortNo', Self.DBPortNo);
  finally
    iniFile.Free;
  end;
end;

end.
