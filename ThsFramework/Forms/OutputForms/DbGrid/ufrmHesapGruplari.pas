unit ufrmHesapGruplari;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmHesapGruplari = class(TfrmBaseDBGrid)
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
  ufrmHesapGrubu,
  Ths.Erp.Database.Table.HesapGrubu;

{$R *.dfm}

{ TfrmHesapGruplari }

function TfrmHesapGruplari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmHesapGrubu.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmHesapGrubu.Create(Application, Self, THesapGrubu.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmHesapGrubu.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmHesapGruplari.SetSelectedItem;
begin
  inherited;

  THesapGrubu(Table).Grup.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(THesapGrubu(Table).Grup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(THesapGrubu(Table).Grup.FieldName).Value);
end;

end.
