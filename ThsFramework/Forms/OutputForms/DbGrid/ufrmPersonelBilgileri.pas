unit ufrmPersonelBilgileri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmPersonelBilgileri = class(TfrmBaseDBGrid)
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
  ufrmPersonelBilgisi,
  Ths.Erp.Database.Table.PersonelBilgisi;

{$R *.dfm}

{ TfrmPersonelBilgileri }

function TfrmPersonelBilgileri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmPersonelBilgisi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmPersonelBilgisi.Create(Application, Self, TPersonelBilgisi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmPersonelBilgisi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmPersonelBilgileri.SetSelectedItem;
begin
  inherited;

  TPersonelBilgisi(Table).IsActive.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).IsActive.FieldName).Value);
  TPersonelBilgisi(Table).PersonelAd.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelAd.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelAd.FieldName).Value);
  TPersonelBilgisi(Table).PersonelSoyad.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelSoyad.FieldName).Value);
  TPersonelBilgisi(Table).Telefon1.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Telefon1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Telefon1.FieldName).Value);
  TPersonelBilgisi(Table).Telefon2.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Telefon2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Telefon2.FieldName).Value);
  TPersonelBilgisi(Table).PersonelTipiID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelTipiID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelTipiID.FieldName).Value);
  TPersonelBilgisi(Table).PersonelTipi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).PersonelTipi.FieldName).Value);
  TPersonelBilgisi(Table).Bolum.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Bolum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Bolum.FieldName).Value);
  TPersonelBilgisi(Table).BirimID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).BirimID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).BirimID.FieldName).Value);
  TPersonelBilgisi(Table).Birim.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Birim.FieldName).Value);
  TPersonelBilgisi(Table).GorevID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).GorevID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).GorevID.FieldName).Value);
  TPersonelBilgisi(Table).Gorev.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Gorev.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Gorev.FieldName).Value);
  TPersonelBilgisi(Table).MailAdresi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MailAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MailAdresi.FieldName).Value);
  TPersonelBilgisi(Table).DogumTarihi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).DogumTarihi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).DogumTarihi.FieldName).Value);
  TPersonelBilgisi(Table).KanGrubu.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).KanGrubu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).KanGrubu.FieldName).Value);
  TPersonelBilgisi(Table).CinsiyetID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).CinsiyetID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).CinsiyetID.FieldName).Value);
  TPersonelBilgisi(Table).Cinsiyet.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Cinsiyet.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).Cinsiyet.FieldName).Value);
  TPersonelBilgisi(Table).AskerlikDurumID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).AskerlikDurumID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).AskerlikDurumID.FieldName).Value);
  TPersonelBilgisi(Table).AskerlikDurumu.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).AskerlikDurumu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).AskerlikDurumu.FieldName).Value);
  TPersonelBilgisi(Table).MedeniDurumuID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MedeniDurumuID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MedeniDurumuID.FieldName).Value);
  TPersonelBilgisi(Table).MedeniDurumu.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MedeniDurumu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).MedeniDurumu.FieldName).Value);
  TPersonelBilgisi(Table).CocukSayisi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).CocukSayisi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).CocukSayisi.FieldName).Value);
  TPersonelBilgisi(Table).YakinAdSoyad.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).YakinAdSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).YakinAdSoyad.FieldName).Value);
  TPersonelBilgisi(Table).YakinTelefon.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).YakinTelefon.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).YakinTelefon.FieldName).Value);
  TPersonelBilgisi(Table).EvAdresi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).EvAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelBilgisi(Table).EvAdresi.FieldName).Value);
end;

end.
