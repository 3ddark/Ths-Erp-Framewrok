unit ufrmStokGrubuTurleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmStokGrubuTurleri = class(TfrmBaseDBGrid)
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
  ufrmStokGrubuTuru,
  Ths.Erp.Database.Table.StokGrubuTuru;

{$R *.dfm}

{ TfrmStokGrubuTurleri }

function TfrmStokGrubuTurleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmStokGrubuTuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmStokGrubuTuru.Create(Application, Self, TStokGrubuTuru.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmStokGrubuTuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmStokGrubuTurleri.SetSelectedItem;
begin
  inherited;

  TStokGrubuTuru(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubuTuru(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubuTuru(Table).Tur.FieldName).Value);
end;

end.
