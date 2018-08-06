unit ufrmAyarEFaturaFaturaTipleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarEFaturaFaturaTipleri = class(TfrmBaseDBGrid)
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
  ufrmAyarEFaturaFaturaTipi,
  Ths.Erp.Database.Table.AyarEFaturaFaturaTipi;

{$R *.dfm}

{ TfrmAyarEFaturaFaturaTipleri }

function TfrmAyarEFaturaFaturaTipleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarEFaturaFaturaTipi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarEFaturaFaturaTipi.Create(Self, Self, TAyarEFaturaFaturaTipi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarEFaturaFaturaTipi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarEFaturaFaturaTipleri.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAyarEFaturaFaturaTipleri.SetSelectedItem;
begin
  inherited;

  TAyarEFaturaFaturaTipi(Table).Tip.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaFaturaTipi(Table).Tip.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarEFaturaFaturaTipi(Table).Tip.FieldName).Value);
end;

end.
