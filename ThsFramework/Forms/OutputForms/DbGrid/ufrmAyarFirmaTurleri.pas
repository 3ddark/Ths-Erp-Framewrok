unit ufrmAyarFirmaTurleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarFirmaTurleri = class(TfrmBaseDBGrid)
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
  ufrmAyarFirmaTuru,
  Ths.Erp.Database.Table.AyarFirmaTuru;

{$R *.dfm}

{ TfrmAyarFirmaTurleri }

function TfrmAyarFirmaTurleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarFirmaTuru.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarFirmaTuru.Create(Self, Self, TAyarFirmaTuru.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarFirmaTuru.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarFirmaTurleri.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAyarFirmaTurleri.SetSelectedItem;
begin
  inherited;

  TAyarFirmaTuru(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTuru(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarFirmaTuru(Table).Tur.FieldName).Value);
end;

end.
