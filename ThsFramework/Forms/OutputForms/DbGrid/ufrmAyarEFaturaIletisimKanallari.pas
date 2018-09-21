unit ufrmAyarEFaturaIletisimKanallari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarEFaturaIletisimKanallari = class(TfrmBaseDBGrid)
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
  ufrmAyarEFaturaIletisimKanali,
  Ths.Erp.Database.Table.AyarEFaturaIletisimKanali;

{$R *.dfm}

{ TfrmAyarEFaturaIletisimKanallari }

function TfrmAyarEFaturaIletisimKanallari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarEFaturaIletisimKanali.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarEFaturaIletisimKanali.Create(Self, Self, TAyarEFaturaIletisimKanali.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarEFaturaIletisimKanali.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarEFaturaIletisimKanallari.SetSelectedItem;
begin
  inherited;

  TAyarEFaturaIletisimKanali(Table).Kod.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIletisimKanali(Table).Kod.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIletisimKanali(Table).Kod.FieldName).Value);
  TAyarEFaturaIletisimKanali(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIletisimKanali(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIletisimKanali(Table).Aciklama.FieldName).Value);
end;

end.
