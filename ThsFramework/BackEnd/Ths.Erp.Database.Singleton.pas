unit Ths.Erp.Database.Singleton;

interface

uses
  IniFiles, SysUtils, WinTypes, Messages, Classes, Graphics, Controls, Forms,
  Dialogs,
  Ths.Erp.Database,
  Ths.Erp.Database.Table.SysUser;

type
  TSingletonDB = class(TObject)
  strict private
    class var FInstance: TSingletonDB;
    constructor CreatePrivate;
  private
    FDataBase: TDatabase;
    FUser: TSysUser;
  public
    property DataBase: TDatabase read FDataBase write FDataBase;
    property User: TSysUser read FUser write FUser;

    constructor Create;
    class function GetInstance(): TSingletonDB;

    destructor Destroy; override;

  end;

var
  SingletonDB: TSingletonDB;

implementation

constructor TSingletonDB.Create();
begin
  raise Exception.Create('Object Singleton');

//  if Self.FDataBase <> nil then
//    Abort
//  else
//  begin
//    FDataBase := TDatabase.Create;
//  end;
//
//  if Self.FUser = nil then
//  begin
//    FUser := TSysUser.Create(Self.FDataBase);
//  end;
//
//  if Self <> nil then
//    SingletonDB := Self;
end;

constructor TSingletonDB.CreatePrivate;
begin
  inherited Create;
  if Self.FDataBase = nil then
    FDataBase := TDatabase.Create;

  if Self.FUser = nil then
    FUser := TSysUser.Create(Self.FDataBase);
end;

destructor TSingletonDB.Destroy();
begin
  if SingletonDB <> Self then
  begin
    SingletonDB := nil;
  end;

  FUser.Free;
  FDataBase.Free;

  inherited Destroy;
end;

class function TSingletonDB.GetInstance: TSingletonDB;
begin
  if not Assigned(FInstance) then
    FInstance := TSingletonDB.CreatePrivate;
  Result := FInstance;
end;

end.

