unit ufrmPersonelTasimaServisleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmPersonelTasimaServisleri = class(TfrmBaseDBGrid)
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
  ufrmPersonelTasimaServisi,
  Ths.Erp.Database.Table.PersonelTasimaServisi;

{$R *.dfm}

{ TfrmPersonelTasimaServisleri }

function TfrmPersonelTasimaServisleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmPersonelTasimaServisi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmPersonelTasimaServisi.Create(Application, Self, TPersonelTasimaServis.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmPersonelTasimaServisi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmPersonelTasimaServisleri.SetSelectedItem;
begin
  inherited;

  TPersonelTasimaServis(Table).ServisNo.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelTasimaServis(Table).ServisNo.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelTasimaServis(Table).ServisNo.FieldName).Value);
  TPersonelTasimaServis(Table).ServisAdi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelTasimaServis(Table).ServisAdi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelTasimaServis(Table).ServisAdi.FieldName).Value);
end;

end.
