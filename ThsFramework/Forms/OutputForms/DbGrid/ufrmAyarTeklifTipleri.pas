unit ufrmAyarTeklifTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarTeklifTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarTeklifTipi,
  Ths.Erp.Database.Table.AyarTeklifTipi;

{$R *.dfm}

{ TfrmAyarTeklifTipleri }

function TfrmAyarTeklifTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarTeklifTipi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarTeklifTipi.Create(Application, Self, TAyarTeklifTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarTeklifTipi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarTeklifTipleri.SetSelectedItem;
begin
  inherited;

  TAyarTeklifTipi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifTipi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifTipi(Table).Deger.FieldName).Value);
  TAyarTeklifTipi(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifTipi(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifTipi(Table).Aciklama.FieldName).Value);
  TAyarTeklifTipi(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifTipi(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarTeklifTipi(Table).IsActive.FieldName).Value);
end;

end.
