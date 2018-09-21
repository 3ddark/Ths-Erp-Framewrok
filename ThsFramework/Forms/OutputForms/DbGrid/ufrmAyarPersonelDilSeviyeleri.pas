unit ufrmAyarPersonelDilSeviyeleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelDilSeviyeleri = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelDilSeviyesi,
  Ths.Erp.Database.Table.AyarPersonelDilSeviyesi;

{$R *.dfm}

{ TfrmAyarPersonelDilSeviyeleri }

function TfrmAyarPersonelDilSeviyeleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelDilSeviyesi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelDilSeviyesi.Create(Application, Self, TAyarPersonelDilSeviyesi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelDilSeviyesi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelDilSeviyeleri.SetSelectedItem;
begin
  inherited;

  TAyarPersonelDilSeviyesi(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelDilSeviyesi(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelDilSeviyesi(Table).Deger.FieldName).Value);
end;

end.
