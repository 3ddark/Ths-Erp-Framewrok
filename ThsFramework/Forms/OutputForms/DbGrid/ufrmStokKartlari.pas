unit ufrmStokKartlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmStokKartlari = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmStokKarti,
  Ths.Erp.Database.Table.StokKarti;

{$R *.dfm}

{ TfrmStokKartlari }

function TfrmStokKartlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmStokKarti.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmStokKarti.Create(Application, Self, TStokKarti.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmStokKarti.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmStokKartlari.FormShow(Sender: TObject);
var
  vHaneSayisi: Integer;
begin
  inherited;
  vHaneSayisi := TSingletonDB.GetInstance.HaneMiktari.StokMiktar.Value;
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).HamAlisFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).AlisFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).SatisFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).IhracFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).IhracFiyat.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).OrtalamaMaliyet.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  TFloatField(Table.DataSource.DataSet.FieldByName(TStokKarti(Table).EnAzStokSeviyesi.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
end;

end.
