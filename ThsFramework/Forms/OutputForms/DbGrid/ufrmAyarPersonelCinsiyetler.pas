unit ufrmAyarPersonelCinsiyetler;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelCinsiyetler = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelCinsiyet,
  Ths.Erp.Database.Table.AyarPersonelCinsiyet;

{$R *.dfm}

{ TfrmAyarPersonelCinsiyetler }

function TfrmAyarPersonelCinsiyetler.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarCinsiyet.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarCinsiyet.Create(Application, Self, TAyarPersonelCinsiyet.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarCinsiyet.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelCinsiyetler.SetSelectedItem;
begin
  inherited;

  TAyarPersonelCinsiyet(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelCinsiyet(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelCinsiyet(Table).Deger.FieldName).Value);
end;

end.
