unit ufrmAyarTeklifDurumlar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarTeklifDurumlar = class(TfrmBaseDBGrid)
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
  ufrmAyarTeklifDurum,
  Ths.Erp.Database.Table.AyarTeklifDurum;

{$R *.dfm}

{ TfrmAyarTeklifDurumlar }

function TfrmAyarTeklifDurumlar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarTeklifDurum.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarTeklifDurum.Create(Application, Self, TAyarTeklifDurum.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarTeklifDurum.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarTeklifDurumlar.SetSelectedItem;
begin
  inherited;

  TAyarTeklifDurum(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifDurum(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifDurum(Table).Deger.FieldName).Value);
  TAyarTeklifDurum(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifDurum(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifDurum(Table).Aciklama.FieldName).Value);
  TAyarTeklifDurum(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifDurum(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifDurum(Table).IsActive.FieldName).Value);
end;

end.
