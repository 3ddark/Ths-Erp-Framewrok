unit Ths.Erp.Database.Singleton;

interface

uses
  IniFiles, SysUtils, WinTypes, Messages, Classes, Graphics, Controls, Forms,
  Dialogs,
  Ths.Erp.Database,
  Ths.Erp.Database.Table.SysUser;

type
  TSingletonDB = class(TObject)
  private
    FDataBase: TDatabase;
    FUser: TSysUser;
  public
    property DataBase: TDatabase read FDataBase write FDataBase;
    property User: TSysUser read FUser write FUser;

    constructor Create();
    destructor Destroy; override;
  end;

var
  SingletonDB: TSingletonDB;

implementation

constructor TSingletonDB.Create();
begin
  if Self.FDataBase <> nil then
    {NB could show a message or raise a different exception here}
    Abort
  else
  begin
    FDataBase := TDatabase.Create;
  end;

  if Self.FUser = nil then
  begin
    FUser := TSysUser.Create(Self.FDataBase);
  end;

  if Self <> nil then
    SingletonDB := Self;
end;

destructor TSingletonDB.Destroy();
begin
  if SingletonDB <> Self then
  begin
    SingletonDB := nil;
  end;

  FDataBase.Free;
  FUser.Free;

  inherited Destroy;
end;

end.

