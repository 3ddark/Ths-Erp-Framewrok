unit ufrmOlcuBirimleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmOlcuBirimleri = class(TfrmBaseDBGrid)
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;

  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmOlcuBirimi,
  Ths.Erp.Database.Table.OlcuBirimi;

{$R *.dfm}

{ TfrmOlcuBirimleri }

function TfrmOlcuBirimleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmOlcuBirimi.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmOlcuBirimi.Create(Application, Self, TOlcuBirimi.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmOlcuBirimi.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmOlcuBirimleri.FormShow(Sender: TObject);
begin
  inherited;
end;

procedure TfrmOlcuBirimleri.SetSelectedItem;
begin
  inherited;

  TOlcuBirimi(Table).Birim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).Birim.FieldName).Value);
  TOlcuBirimi(Table).EFaturaBirim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).EFaturaBirim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).EFaturaBirim.FieldName).Value);
  TOlcuBirimi(Table).BirimAciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).BirimAciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).BirimAciklama.FieldName).Value);
  TOlcuBirimi(Table).IsFloatTip.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).IsFloatTip.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).IsFloatTip.FieldName).Value);
end;

end.
