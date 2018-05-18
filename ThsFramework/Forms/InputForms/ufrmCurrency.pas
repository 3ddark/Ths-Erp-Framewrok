unit ufrmCurrency;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  fyEdit,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts, Vcl.Buttons,
  Vcl.Samples.Spin;

type
  TfrmCurrency = class(TfrmBaseInputDB)
    lblCode: TLabel;
    lblSymbol: TLabel;
    lblIsDefault: TLabel;
    edtCode: TfyEdit;
    edtSymbol: TfyEdit;
    lblCodeComment: TLabel;
    edtCodeComment: TfyEdit;
    chkIsDefault: TCheckBox;
    destructor Destroy; override;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.Currency;

{$R *.dfm}

Destructor TfrmCurrency.Destroy;
begin
  //
  inherited;
end;

procedure TfrmCurrency.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCurrency.FormShow(Sender: TObject);
begin
  inherited;

  edtCode.MaxLength := Table.Database.GetMaxChar(Table.TableName, 'code', 3);
  edtSymbol.MaxLength := Table.Database.GetMaxChar(Table.TableName, 'symbol', 1);
  edtCodeComment.MaxLength := Table.Database.GetMaxChar(Table.TableName, 'code_comment', 64);
end;

procedure TfrmCurrency.Repaint();
begin
  inherited;
  //
end;

procedure TfrmCurrency.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtCode.Text := TCurrency(Table).Code;
  edtSymbol.Text := TCurrency(Table).Symbol;
  chkIsDefault.Checked := TCurrency(Table).IsDefault;
  edtCodeComment.Text := TCurrency(Table).CodeComment;
end;

procedure TfrmCurrency.btnAcceptClick(Sender: TObject);
begin
  if  (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TCurrency(Table).Code         := edtCode.Text;
      TCurrency(Table).Symbol       := edtSymbol.Text;
      TCurrency(Table).IsDefault    := chkIsDefault.Checked;
      TCurrency(Table).CodeComment  := edtCodeComment.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
