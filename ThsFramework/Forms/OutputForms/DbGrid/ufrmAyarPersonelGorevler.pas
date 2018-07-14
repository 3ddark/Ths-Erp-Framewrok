unit ufrmAyarPersonelGorevler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelGorevler = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelGorev,
  Ths.Erp.Database.Table.AyarPersonelGorev;

{$R *.dfm}

{ TfrmPersonelGorevler }

function TfrmAyarPersonelGorevler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelGorev.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelGorev.Create(Application, Self, TAyarPersonelGorev.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelGorev.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelGorevler.SetSelectedItem;
begin
  inherited;

  TAyarPersonelGorev(Table).Gorev.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelGorev(Table).Gorev.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelGorev(Table).Gorev.FieldName).Value);
end;

end.
