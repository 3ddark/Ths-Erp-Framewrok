unit Ths.Erp.Database.Connection;

interface

uses
  System.SysUtils, Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  Ths.Erp.Database.Connection.Settings;

type
  TConnection = class
  strict private
    class var FConn: TFDConnection;
  private
    FConnSetting: TConnSettings;
    FTranscationIsStarted: Boolean;

    procedure ConnAfterCommit(Sender: TObject);
    procedure ConnAfterRollback(Sender: TObject);
    procedure ConnAfterStartTransaction(Sender: TObject);
    procedure ConnBeforeCommit(Sender: TObject);
    procedure ConnBeforeRollback(Sender: TObject);
    procedure ConnBeforeStartTransaction(Sender: TObject);

    procedure ConfigureConnection();
  public
    property TranscationIsStarted: Boolean read FTranscationIsStarted write FTranscationIsStarted;
    property ConnSetting: TConnSettings read FConnSetting write FConnSetting;

    constructor Create();
    destructor Destroy; override;

    function GetConn: TFDConnection;
    function NewQuery: TFDQuery;
  end;

implementation

{ TConnection }

procedure TConnection.ConfigureConnection();
var
  vLanguage, vSQLServer, vDatabaseName, vDBUserName, vDBUserPassword, vDBPortNo: string;
begin
  FConn.AfterStartTransaction  := ConnAfterStartTransaction;
  FConn.AfterCommit            := ConnAfterCommit;
  FConn.AfterRollback          := ConnAfterRollback;
  FConn.BeforeStartTransaction := ConnBeforeStartTransaction;
  FConn.BeforeCommit           := ConnBeforeCommit;
  FConn.BeforeRollback         := ConnBeforeRollback;

  Self.ConnSetting.ReadFromFile(
      ExtractFilePath(Application.ExeName) + 'Settings' + '\' + 'GlobalSettings.ini',
      vLanguage, vSQLServer, vDatabaseName, vDBUserName, vDBUserPassword, vDBPortNo
  );

  Self.ConnSetting.Language := vLanguage;
  Self.ConnSetting.SQLServer := vSQLServer;
  Self.ConnSetting.DatabaseName := vDatabaseName;
  Self.ConnSetting.DBUserName := vDBUserName;
  Self.ConnSetting.DBUserPassword := vDBUserPassword;
  Self.ConnSetting.DBPortNo := vDBPortNo.ToInteger;
  Self.ConnSetting.AppName := '';

  FConn.Name := 'Connection';
  FConn.Params.Add('DriverID=PG');
  FConn.Params.Add('CharacterSet=UTF8');
  FConn.Params.Add('Server=' + vSQLServer);
  FConn.Params.Add('Database=' + vDatabaseName);
  FConn.Params.Add('User_Name=' + vDBUserName);
  FConn.Params.Add('Password=' + vDBUserPassword);
  FConn.Params.Add('Port=' + vDBPortNo);
  FConn.Params.Add('ApplicationName=' + 'strAppName');
  FConn.LoginPrompt := False;
end;

procedure TConnection.ConnAfterCommit(Sender: TObject);
begin
  TranscationIsStarted := False;
end;

procedure TConnection.ConnAfterRollback(Sender: TObject);
begin
  TranscationIsStarted := False;
end;

procedure TConnection.ConnAfterStartTransaction(Sender: TObject);
begin
  //
end;

procedure TConnection.ConnBeforeCommit(Sender: TObject);
begin
  //
end;

procedure TConnection.ConnBeforeRollback(Sender: TObject);
begin
  //
end;

procedure TConnection.ConnBeforeStartTransaction(Sender: TObject);
begin
  TranscationIsStarted := True;
end;

constructor TConnection.Create();
begin
  if Self.FConn <> nil then
    Abort
  else
  begin
    inherited;
    Self.FConn := TFDConnection.Create(nil);
    Self.ConnSetting := TConnSettings.Create;
    Self.ConfigureConnection;
  end;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(Self);
  inherited;
end;

function TConnection.GetConn: TFDConnection;
begin
  Result := Self.FConn;
end;

function TConnection.NewQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Self.FConn;
end;

end.
