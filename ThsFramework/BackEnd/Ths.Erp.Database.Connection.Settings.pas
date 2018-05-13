unit Ths.Erp.Database.Connection.Settings;

interface

uses
  System.SysUtils, System.IniFiles;

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

    class procedure ReadFromFile(
        const pFileName: UnicodeString;
        out pLanguage, pSQLServer, pDatabaseName, pDBUserName, pDBUserPassword, pDBPortNo: string);

    class procedure SaveToFile(
        const pFileName: UnicodeString;
        pLanguage, pSQLServer, pDatabaseName, pDBUserName, pDBUserPassword, pDBPortNo: string);
  end;

implementation

{ TConnSettings }

class procedure TConnSettings.ReadFromFile(const pFileName: UnicodeString;
    out pLanguage, pSQLServer, pDatabaseName, pDBUserName, pDBUserPassword, pDBPortNo: string);
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(pFileName);
  try
    pLanguage       := iniFile.ReadString('ConnectionSettings', 'Language', '');
    pSQLServer      := iniFile.ReadString('ConnectionSettings', 'SQLServer', '');
    PDatabaseName   := iniFile.ReadString('ConnectionSettings', 'DatabaseName', '');
    pDBUserName     := iniFile.ReadString('ConnectionSettings', 'DBUserName', '');
    pDBUserPassword := iniFile.ReadString('ConnectionSettings', 'DBUserPassword', '');
    pDBPortNo       := iniFile.ReadString('ConnectionSettings', 'DBPortNo', '');
  finally
    iniFile.Free;
  end;
end;

class procedure TConnSettings.SaveToFile(const pFileName: UnicodeString;
    pLanguage, pSQLServer, pDatabaseName, pDBUserName, pDBUserPassword, pDBPortNo: string);
var
  iniFile: TIniFile;
begin
  iniFile := TIniFile.Create(pFileName);
  try
    iniFile.WriteString('ConnectionSettings', 'Language', pLanguage);
    iniFile.ReadString('ConnectionSettings', 'SQLServer', pSQLServer);
    iniFile.ReadString('ConnectionSettings', 'DatabaseName', PDatabaseName);
    iniFile.ReadString('ConnectionSettings', 'DBUserName', pDBUserName);
    iniFile.ReadString('ConnectionSettings', 'DBUserPassword', pDBUserPassword);
    iniFile.ReadString('ConnectionSettings', 'DBPortNo', pDBPortNo);
  finally
    iniFile.Free;
  end;
end;

end.
