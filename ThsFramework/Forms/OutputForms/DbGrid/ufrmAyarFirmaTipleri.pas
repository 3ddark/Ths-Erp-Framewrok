unit ufrmAyarFirmaTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarFirmaTipleri = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmAyarFirmaTipi,
  Ths.Erp.Database.Table.AyarFirmaTipi;

{$R *.dfm}

{ TfrmAyarFirmaTipleri }

function TfrmAyarFirmaTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarFirmaTipi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarFirmaTipi.Create(Self, Self, TAyarFirmaTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarFirmaTipi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarFirmaTipleri.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAyarFirmaTipleri.SetSelectedItem;
begin
  inherited;

  TAyarFirmaTipi(Table).FirmaTipi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTipi(Table).FirmaTipi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTipi(Table).FirmaTipi.FieldName).Value);
  TAyarFirmaTipi(Table).FirmaTuruID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTipi(Table).FirmaTuruID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTipi(Table).FirmaTuruID.FieldName).Value);
  TAyarFirmaTipi(Table).FirmaTuru.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTipi(Table).FirmaTuru.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTipi(Table).FirmaTuru.FieldName).Value);
end;

end.
