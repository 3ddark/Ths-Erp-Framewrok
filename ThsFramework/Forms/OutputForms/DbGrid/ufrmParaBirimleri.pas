unit ufrmParaBirimleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmParaBirimleri = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  ufrmParaBirimi,
  Ths.Erp.Database.Table.ParaBirimi, Ths.Erp.Database.Singleton;

{$R *.dfm}

{ TfrmParaBirimleri }

function TfrmParaBirimleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmParaBirimi.Create(Self, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmParaBirimi.Create(Self, Self, TParaBirimi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmParaBirimi.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmParaBirimleri.SetSelectedItem;
begin
  inherited;

  TParaBirimi(Table).Kod.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).Kod.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).Kod.FieldName).Value);
  TParaBirimi(Table).Sembol.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).Sembol.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).Sembol.FieldName).Value);
  TParaBirimi(Table).Aciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).Aciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).Aciklama.FieldName).Value);
  TParaBirimi(Table).IsVarsayilan.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).IsVarsayilan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TParaBirimi(Table).IsVarsayilan.FieldName).Value);
end;

end.
