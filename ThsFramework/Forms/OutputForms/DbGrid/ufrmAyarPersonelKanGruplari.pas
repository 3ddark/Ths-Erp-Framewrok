unit ufrmAyarPersonelKanGruplari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarPersonelKanGruplari = class(TfrmBaseDBGrid)
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
  ufrmAyarPersonelKanGrubu,
  Ths.Erp.Database.Table.AyarPersonelKanGrubu;

{$R *.dfm}

{ TfrmAyarKanGruplari }

function TfrmAyarPersonelKanGruplari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarPersonelKanGrubu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarPersonelKanGrubu.Create(Application, Self, TAyarPersonelKanGrubu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarPersonelKanGrubu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarPersonelKanGruplari.SetSelectedItem;
begin
  inherited;

  TAyarPersonelKanGrubu(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelKanGrubu(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPersonelKanGrubu(Table).Deger.FieldName).Value);
end;

end.
