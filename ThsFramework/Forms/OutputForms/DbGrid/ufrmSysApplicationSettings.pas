unit ufrmSysApplicationSettings;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysApplicationSettings = class(TfrmBaseDBGrid)
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
  ufrmSysApplicationSetting,
  Ths.Erp.Database.Table.SysApplicationSettings;

{$R *.dfm}

{ TfrmSysApplicationSettings }

function TfrmSysApplicationSettings.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysApplicationSetting.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmSysApplicationSetting.Create(Application, Self, TSysApplicationSettings.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysApplicationSetting.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysApplicationSettings.SetSelectedItem;
begin
  inherited;

  TSysApplicationSettings(Table).Logo.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Logo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Logo.FieldName).Value);
  TSysApplicationSettings(Table).Unvan.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Unvan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Unvan.FieldName).Value);
  TSysApplicationSettings(Table).Tel1.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel1.FieldName).Value);
  TSysApplicationSettings(Table).Tel2.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel2.FieldName).Value);
  TSysApplicationSettings(Table).Tel3.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel3.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel3.FieldName).Value);
  TSysApplicationSettings(Table).Tel4.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel4.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel4.FieldName).Value);
  TSysApplicationSettings(Table).Tel5.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel5.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Tel5.FieldName).Value);
  TSysApplicationSettings(Table).Fax1.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Fax1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Fax1.FieldName).Value);
  TSysApplicationSettings(Table).Fax2.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Fax2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Fax2.FieldName).Value);
  TSysApplicationSettings(Table).MersisNo.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).MersisNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).MersisNo.FieldName).Value);
  TSysApplicationSettings(Table).WebSitesi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).WebSitesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).WebSitesi.FieldName).Value);
  TSysApplicationSettings(Table).EPostaAdresi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).EPostaAdresi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).EPostaAdresi.FieldName).Value);
  TSysApplicationSettings(Table).VergiDairesi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).VergiDairesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).VergiDairesi.FieldName).Value);
  TSysApplicationSettings(Table).VergiNo.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).VergiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).VergiNo.FieldName).Value);
  TSysApplicationSettings(Table).FormColor.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).FormColor.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).FormColor.FieldName).Value);
  TSysApplicationSettings(Table).Donem.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Donem.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Donem.FieldName).Value);
  TSysApplicationSettings(Table).MukellefTipi.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).MukellefTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).MukellefTipi.FieldName).Value);
  TSysApplicationSettings(Table).Ulke.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Ulke.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Ulke.FieldName).Value);
  TSysApplicationSettings(Table).Sehir.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Sehir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Sehir.FieldName).Value);
  TSysApplicationSettings(Table).Ilce.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Ilce.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Ilce.FieldName).Value);
  TSysApplicationSettings(Table).Mahalle.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Mahalle.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Mahalle.FieldName).Value);
  TSysApplicationSettings(Table).Cadde.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Cadde.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Cadde.FieldName).Value);
  TSysApplicationSettings(Table).Sokak.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Sokak.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Sokak.FieldName).Value);
  TSysApplicationSettings(Table).PostaKodu.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).PostaKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).PostaKodu.FieldName).Value);
  TSysApplicationSettings(Table).Bina.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Bina.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).Bina.FieldName).Value);
  TSysApplicationSettings(Table).KapiNo.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).KapiNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TSysApplicationSettings(Table).KapiNo.FieldName).Value);
end;

end.
