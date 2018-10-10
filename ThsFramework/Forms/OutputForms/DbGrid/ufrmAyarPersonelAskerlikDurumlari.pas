unit ufrmAyarPersonelAskerlikDurumlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelAskerlikDurumlari = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelAskerlikDurumu,
  Ths.Erp.Database.Table.AyarPersonelAskerlikDurumu;

{$R *.dfm}

{ TfrmAyarAskerlikDurumlari }

function TfrmAyarPersonelAskerlikDurumlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelAskerlikDurumu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelAskerlikDurumu.Create(Application, Self, TAyarPersonelAskerlikDurumu.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelAskerlikDurumu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelAskerlikDurumlari.SetSelectedItem;
begin
  inherited;

  TAyarPersonelAskerlikDurumu(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelAskerlikDurumu(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelAskerlikDurumu(Table).Deger.FieldName).Value);
end;

end.
