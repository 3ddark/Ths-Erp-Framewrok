unit ufrmAyarBarkodUrunTurleri;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmAyarBarkodUrunTurleri = class(TfrmBaseDBGrid)
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
  ufrmAyarBarkodUrunTuru,
  Ths.Erp.Database.Table.AyarBarkodUrunTuru;

{$R *.dfm}

{ TfrmAyarBarkodUrunTurleri }

function TfrmAyarBarkodUrunTurleri.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmAyarBarkodUrunTuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmAyarBarkodUrunTuru.Create(Application, Self, TAyarBarkodUrunTuru.Create(Table.Database), True, pFormMode)
  else
  if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmAyarBarkodUrunTuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmAyarBarkodUrunTurleri.SetSelectedItem;
begin
  inherited;

  TAyarBarkodUrunTuru(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodUrunTuru(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarBarkodUrunTuru(Table).Tur.FieldName).Value);
end;

end.
