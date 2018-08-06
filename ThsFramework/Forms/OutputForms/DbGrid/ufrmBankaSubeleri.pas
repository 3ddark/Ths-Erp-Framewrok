unit ufrmBankaSubeleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmBankaSubeleri = class(TfrmBaseDBGrid)
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
  ufrmBankaSubesi,
  Ths.Erp.Database.Table.BankaSubesi;

{$R *.dfm}

{ TfrmBankaSubeleri }

function TfrmBankaSubeleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmBankaSubesi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmBankaSubesi.Create(Application, Self, TBankaSubesi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmBankaSubesi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmBankaSubeleri.SetSelectedItem;
begin
  inherited;

  TBankaSubesi(Table).BankaID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).BankaID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).BankaID.FieldName).Value);
  TBankaSubesi(Table).Banka.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).Banka.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).Banka.FieldName).Value);
  TBankaSubesi(Table).SubeKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).SubeKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).SubeKodu.FieldName).Value);
  TBankaSubesi(Table).SubeAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).SubeAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).SubeAdi.FieldName).Value);
  TBankaSubesi(Table).SubeIl.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).SubeIl.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBankaSubesi(Table).SubeIl.FieldName).Value);
end;

end.
