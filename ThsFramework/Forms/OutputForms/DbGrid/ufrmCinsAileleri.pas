unit ufrmCinsAileleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmCinsAileleri = class(TfrmBaseDBGrid)
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
  ufrmCinsAilesi,
  Ths.Erp.Database.Table.CinsAilesi;

{$R *.dfm}

{ TfrmCinsAileleri }

function TfrmCinsAileleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmCinsAilesi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmCinsAilesi.Create(Application, Self, TCinsAilesi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmCinsAilesi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmCinsAileleri.SetSelectedItem;
begin
  inherited;

  TCinsAilesi(Table).Aile.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TCinsAilesi(Table).Aile.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TCinsAilesi(Table).Aile.FieldName).Value);
end;

end.
