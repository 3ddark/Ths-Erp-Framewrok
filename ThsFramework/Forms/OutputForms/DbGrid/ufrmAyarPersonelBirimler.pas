unit ufrmAyarPersonelBirimler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelBirimler = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelBirim,
  Ths.Erp.Database.Table.AyarPersonelBirim;

{$R *.dfm}

{ TfrmAyarPersonelBirimler }

function TfrmAyarPersonelBirimler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelBirim.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelBirim.Create(Self, Self, TAyarPersonelBirim.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelBirim.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelBirimler.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAyarPersonelBirimler.SetSelectedItem;
begin
  inherited;

  TAyarPersonelBirim(Table).Birim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelBirim(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelBirim(Table).Birim.FieldName).Value);
end;

end.
