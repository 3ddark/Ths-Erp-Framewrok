unit ufrmAyarBarkodTezgahlar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarBarkodTezgahlar = class(TfrmBaseDBGrid)
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
  ufrmAyarBarkodTezgah,
  Ths.Erp.Database.Table.AyarBarkodTezgah;

{$R *.dfm}

{ TfrmAyarBarkodTezgahlar }

function TfrmAyarBarkodTezgahlar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarBarkodTezgah.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarBarkodTezgah.Create(Application, Self, TAyarBarkodTezgah.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarBarkodTezgah.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarBarkodTezgahlar.SetSelectedItem;
begin
  inherited;

  TAyarBarkodTezgah(Table).TezgahAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodTezgah(Table).TezgahAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodTezgah(Table).TezgahAdi.FieldName).Value);
  TAyarBarkodTezgah(Table).AmbarID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodTezgah(Table).AmbarID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodTezgah(Table).AmbarID.FieldName).Value);
  TAyarBarkodTezgah(Table).Ambar.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodTezgah(Table).Ambar.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodTezgah(Table).Ambar.FieldName).Value);
end;

end.
