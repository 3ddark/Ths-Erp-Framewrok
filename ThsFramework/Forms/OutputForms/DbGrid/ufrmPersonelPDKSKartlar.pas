unit ufrmPersonelPDKSKartlar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmPersonelPDKSKartlar = class(TfrmBaseDBGrid)
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
  ufrmPersonelPDKSKart,
  Ths.Erp.Database.Table.PersonelPDKSKart;

{$R *.dfm}

{ TfrmPersonelPDKSKartlar }

function TfrmPersonelPDKSKartlar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmPersonelPDKSKart.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmPersonelPDKSKart.Create(Application, Self, TPersonelPDKSKart.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmPersonelPDKSKart.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmPersonelPDKSKartlar.SetSelectedItem;
begin
  inherited;

  TPersonelPDKSKart(Table).KartID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).KartID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).KartID.FieldName).Value);
  TPersonelPDKSKart(Table).PersonelNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).PersonelNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).PersonelNo.FieldName).Value);
  TPersonelPDKSKart(Table).KartNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).KartNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).KartNo.FieldName).Value);
  TPersonelPDKSKart(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelPDKSKart(Table).IsActive.FieldName).Value);
end;

end.
