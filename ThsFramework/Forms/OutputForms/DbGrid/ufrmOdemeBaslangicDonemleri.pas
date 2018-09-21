unit ufrmOdemeBaslangicDonemleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmOdemeBaslangicDonemleri = class(TfrmBaseDBGrid)
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
  ufrmOdemeBaslangicDonemi,
  Ths.Erp.Database.Table.AyarOdemeBaslangicDonem;

{$R *.dfm}

{ TfrmOdemeBaslangicDonemleri }

function TfrmOdemeBaslangicDonemleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmOdemeBaslangicDonemi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmOdemeBaslangicDonemi.Create(Application, Self, TAyarOdemeBaslangicDonem.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmOdemeBaslangicDonemi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmOdemeBaslangicDonemleri.SetSelectedItem;
begin
  inherited;

  TAyarOdemeBaslangicDonem(Table).Deger.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarOdemeBaslangicDonem(Table).Deger.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarOdemeBaslangicDonem(Table).Deger.FieldName).Value);
end;

end.
