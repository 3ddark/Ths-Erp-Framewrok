unit ufrmAyarPersonelMedeniDurumlar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelMedeniDurumlar = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelMedeniDurum,
  Ths.Erp.Database.Table.AyarPersonelMedeniDurum;

{$R *.dfm}

{ TfrmAyarPersonelMedeniDurumlar }

function TfrmAyarPersonelMedeniDurumlar.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelMedeniDurum.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelMedeniDurum.Create(Application, Self, TAyarPersonelMedeniDurum.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelMedeniDurum.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelMedeniDurumlar.SetSelectedItem;
begin
  inherited;

  TAyarPersonelMedeniDurum(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelMedeniDurum(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelMedeniDurum(Table).Deger.FieldName).Value);
end;

end.
