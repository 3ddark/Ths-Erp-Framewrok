unit ufrmAyarPersonelBolumler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelBolumler = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelBolum,
  Ths.Erp.Database.Table.AyarPersonelBolum;

{$R *.dfm}

{ TfrmPersonelBolumler }

function TfrmAyarPersonelBolumler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelBolum.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelBolum.Create(Self, Self, TAyarPersonelBolum.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelBolum.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelBolumler.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAyarPersonelBolumler.SetSelectedItem;
begin
  inherited;

  TAyarPersonelBolum(Table).Bolum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelBolum(Table).Bolum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelBolum(Table).Bolum.FieldName).Value);
end;

end.
