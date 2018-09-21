unit ufrmCinsOzellikleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmCinsOzellikleri = class(TfrmBaseDBGrid)
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
  ufrmCinsOzelligi,
  Ths.Erp.Database.Table.CinsOzelligi;

{$R *.dfm}

{ TfrmCinsOzellikleri }

function TfrmCinsOzellikleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmCinsOzelligi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmCinsOzelligi.Create(Application, Self, TCinsOzelligi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmCinsOzelligi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmCinsOzellikleri.SetSelectedItem;
begin
  inherited;

  TCinsOzelligi(Table).CinsAileID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).CinsAileID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).CinsAileID.FieldName).Value);
  TCinsOzelligi(Table).CinsAilesi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).CinsAilesi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).CinsAilesi.FieldName).Value);
  TCinsOzelligi(Table).Cins.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).Cins.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).Cins.FieldName).Value);
  TCinsOzelligi(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).Aciklama.FieldName).Value);
  TCinsOzelligi(Table).String1.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String1.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String1.FieldName).Value);
  TCinsOzelligi(Table).String2.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String2.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String2.FieldName).Value);
  TCinsOzelligi(Table).String3.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String3.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String3.FieldName).Value);
  TCinsOzelligi(Table).String4.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String4.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String4.FieldName).Value);
  TCinsOzelligi(Table).String5.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String5.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String5.FieldName).Value);
  TCinsOzelligi(Table).String6.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String6.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String6.FieldName).Value);
  TCinsOzelligi(Table).String7.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String7.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String7.FieldName).Value);
  TCinsOzelligi(Table).String8.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String8.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String8.FieldName).Value);
  TCinsOzelligi(Table).String9.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String9.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String9.FieldName).Value);
  TCinsOzelligi(Table).String10.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String10.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String10.FieldName).Value);
  TCinsOzelligi(Table).String11.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String11.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String11.FieldName).Value);
  TCinsOzelligi(Table).String12.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String12.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).String12.FieldName).Value);
  TCinsOzelligi(Table).IsSerinoIcerir.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).IsSerinoIcerir.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsOzelligi(Table).IsSerinoIcerir.FieldName).Value);
end;

end.
