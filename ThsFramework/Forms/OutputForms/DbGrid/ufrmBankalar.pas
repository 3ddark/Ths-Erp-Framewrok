unit ufrmBankalar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmBankalar = class(TfrmBaseDBGrid)
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
  ufrmBanka,
  Ths.Erp.Database.Table.Banka;

{$R *.dfm}

{ TfrmBankalar }

function TfrmBankalar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmBanka.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmBanka.Create(Application, Self, TBanka.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmBanka.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmBankalar.SetSelectedItem;
begin
  inherited;

  TBanka(Table).Adi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBanka(Table).Adi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBanka(Table).Adi.FieldName).Value);
  TBanka(Table).SwiftKodu.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBanka(Table).SwiftKodu.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBanka(Table).SwiftKodu.FieldName).Value);
  TBanka(Table).IsActive.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBanka(Table).IsActive.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBanka(Table).IsActive.FieldName).Value);
end;

end.
