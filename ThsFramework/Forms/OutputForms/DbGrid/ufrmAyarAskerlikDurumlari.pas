unit ufrmAyarAskerlikDurumlari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarAskerlikDurumlari = class(TfrmBaseDBGrid)
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
  ufrmAyarAskerlikDurumu,
  Ths.Erp.Database.Table.AyarAskerlikDurumu;

{$R *.dfm}

{ TfrmAyarAskerlikDurumlari }

function TfrmAyarAskerlikDurumlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarAskerlikDurumu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarAskerlikDurumu.Create(Application, Self, TAyarAskerlikDurumu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarAskerlikDurumu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarAskerlikDurumlari.SetSelectedItem;
begin
  inherited;

  TAyarAskerlikDurumu(Table).Durum.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarAskerlikDurumu(Table).Durum.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarAskerlikDurumu(Table).Durum.FieldName).Value);
end;

end.
