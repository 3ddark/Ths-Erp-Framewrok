unit ufrmAyarEFaturaIstisnaKodlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarEFaturaIstisnaKodlari = class(TfrmBaseDBGrid)
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
  ufrmAyarEFaturaIstisnaKodu,
  Ths.Erp.Database.Table.AyarEFaturaIstisnaKodu;

{$R *.dfm}

{ TfrmAyarEFaturaIstisnaKodlari }

function TfrmAyarEFaturaIstisnaKodlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarEFaturaIstisnaKodu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarEFaturaIstisnaKodu.Create(Application, Self, TAyarEFaturaIstisnaKodu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarEFaturaIstisnaKodu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarEFaturaIstisnaKodlari.SetSelectedItem;
begin
  inherited;

  TAyarEFaturaIstisnaKodu(Table).Kod.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).Kod.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).Kod.FieldName).Value);
  TAyarEFaturaIstisnaKodu(Table).Aciklama.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).Aciklama.FieldName).Value);
  TAyarEFaturaIstisnaKodu(Table).FaturaTipi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).FaturaTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).FaturaTipi.FieldName).Value);
  TAyarEFaturaIstisnaKodu(Table).FaturaTipID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).FaturaTipID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).FaturaTipID.FieldName).Value);
  TAyarEFaturaIstisnaKodu(Table).IsTamIstisna.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).IsTamIstisna.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaIstisnaKodu(Table).IsTamIstisna.FieldName).Value);
end;

end.
