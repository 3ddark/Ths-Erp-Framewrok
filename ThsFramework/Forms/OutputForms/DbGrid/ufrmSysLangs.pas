unit ufrmSysLangs;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysLangs = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysLang,
  Ths.Erp.Database.Table.SysLang;

{$R *.dfm}

{ TfrmSysLang }

function TfrmSysLangs.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysLang.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysLang.Create(Application, Self, TSysLang.Create(Table.Database), True, pFormMode);
end;

procedure TfrmSysLangs.SetSelectedItem;
begin
  inherited;

  TSysLang(Table).Language.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField( TSysLang(Table).Language.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField( TSysLang(Table).Language.FieldName).Value);
end;

end.
