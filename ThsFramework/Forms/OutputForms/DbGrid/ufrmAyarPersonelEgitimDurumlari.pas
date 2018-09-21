unit ufrmAyarPersonelEgitimDurumlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelEgitimDurumlari = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelEgitimDurumu,
  Ths.Erp.Database.Table.AyarPersonelEgitimDurumu;

{$R *.dfm}

{ TfrmAyarPersonelEgitimDurumlari }

function TfrmAyarPersonelEgitimDurumlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelEgitimDurumu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelEgitimDurumu.Create(Application, Self, TAyarPersonelEgitimDurumu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelEgitimDurumu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelEgitimDurumlari.SetSelectedItem;
begin
  inherited;

  TAyarPersonelEgitimDurumu(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelEgitimDurumu(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelEgitimDurumu(Table).Deger.FieldName).Value);
end;

end.
