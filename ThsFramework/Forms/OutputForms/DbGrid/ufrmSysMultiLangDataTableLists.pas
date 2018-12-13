unit ufrmSysMultiLangDataTableLists;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysMultiLangDataTableLists = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysMultiLangDataTableList,
  Ths.Erp.Database.Table.SysMultiLangDataTableList;

{$R *.dfm}

{ TfrmSysMultiLangDataTableLists }

function TfrmSysMultiLangDataTableLists.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysMultiLangDataTableList.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysMultiLangDataTableList.Create(Application, Self, TSysMultiLangDataTableList.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysMultiLangDataTableList.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

end.
