unit ufrmAyarBarkodSeriNoTurleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarBarkodSeriNoTurleri = class(TfrmBaseDBGrid)
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
  ufrmAyarBarkodSeriNoTuru,
  Ths.Erp.Database.Table.AyarBarkodSeriNoTuru;

{$R *.dfm}

{ TfrmAyarBarkodSeriNoTurleri }

function TfrmAyarBarkodSeriNoTurleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarBarkodSeriNoTuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarBarkodSeriNoTuru.Create(Application, Self, TAyarBarkodSeriNoTuru.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarBarkodSeriNoTuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarBarkodSeriNoTurleri.SetSelectedItem;
begin
  inherited;

  TAyarBarkodSeriNoTuru(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodSeriNoTuru(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodSeriNoTuru(Table).Tur.FieldName).Value);
  TAyarBarkodSeriNoTuru(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodSeriNoTuru(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodSeriNoTuru(Table).Aciklama.FieldName).Value);
end;

end.
