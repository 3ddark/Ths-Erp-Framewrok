unit ufrmCurrencies;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  ufrmBase, ufrmBaseDBGrid, System.ImageList, Vcl.ImgList;

type
  TfrmCurrencies = class(TfrmBaseDBGrid)
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
    procedure SetSelectedItem();override;
  end;

implementation

uses
  ufrmCurrency,
  Ths.Erp.Database.Table.Currency;

{$R *.dfm}

{ TfrmCurrencies }

function TfrmCurrencies.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result:=nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmCurrency.Create(Application, Self, Table.Clone(), True, pFormMode)
  else
  if (pFormMode = ifmNewRecord) then
    Result := TfrmCurrency.Create(Application, Self, TCurrency.Create(Table.Database), True, pFormMode);
end;

procedure TfrmCurrencies.FormCreate(Sender: TObject);
begin
  QueryDefaultFilter := '';
  QueryDefaultOrder := 'code ASC';
  inherited;
end;

procedure TfrmCurrencies.SetSelectedItem;
begin
  inherited;

  TCurrency(Table).Code         := dbgrdBase.DataSource.DataSet.FindField('code').AsString;
  TCurrency(Table).Symbol       := dbgrdBase.DataSource.DataSet.FindField('symbol').AsString;
  TCurrency(Table).IsDefault    := dbgrdBase.DataSource.DataSet.FindField('is_default').AsBoolean;
  TCurrency(Table).CodeComment  := dbgrdBase.DataSource.DataSet.FindField('code_comment').AsString;
end;

end.
