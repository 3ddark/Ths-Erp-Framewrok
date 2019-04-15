unit ufrmDovizKurlari;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmDovizKurlari = class(TfrmBaseDBGrid)
    procedure FormShow(Sender: TObject); override;
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmDovizKuru,
  Ths.Erp.Database.Table.DovizKuru;

{$R *.dfm}

{ TfrmDovizKurlari }

function TfrmDovizKurlari.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmDovizKuru.Create(Application, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmDovizKuru.Create(Application, Self, TDovizKuru.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmDovizKuru.Create(Application, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmDovizKurlari.FormShow(Sender: TObject);
var
  vHaneSayisi: Integer;
begin
  vHaneSayisi := 4;
  TFloatField(Table.DataSource.DataSet.FieldByName(TDovizKuru(Table).Kur.FieldName)).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi);
  inherited;
end;

end.
