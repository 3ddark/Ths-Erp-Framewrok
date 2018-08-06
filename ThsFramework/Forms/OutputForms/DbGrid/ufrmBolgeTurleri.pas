unit ufrmBolgeTurleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmBolgeTurleri = class(TfrmBaseDBGrid)
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
  ufrmBolgeTuru,
  Ths.Erp.Database.Table.BolgeTuru;

{$R *.dfm}

{ TfrmBolgeTurleri }

function TfrmBolgeTurleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmBolgeTuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmBolgeTuru.Create(Application, Self, TBolgeTuru.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmBolgeTuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmBolgeTurleri.SetSelectedItem;
begin
  inherited;

  TBolgeTuru(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TBolgeTuru(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TBolgeTuru(Table).Tur.FieldName).Value);
end;

end.
