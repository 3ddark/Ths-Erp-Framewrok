unit ufrmCurrency;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  thsEdit,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts, System.ImageList, Vcl.ImgList,
  Vcl.Samples.Spin;

type
  TfrmCurrency = class(TfrmBaseInputDB)
    lblcode: TLabel;
    lblsymbol: TLabel;
    lblis_default: TLabel;
    lblcode_comment: TLabel;
    edtCode: TthsEdit;
    edtSymbol: TthsEdit;
    chkIsDefault: TCheckBox;
    edtCodeComment: TthsEdit;
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
  TCurrency(Table).Code.SetControlProperty(Table.TableName, edtCode);
  TCurrency(Table).Symbol.SetControlProperty(Table.TableName, edtSymbol);
  TCurrency(Table).CodeComment.SetControlProperty(Table.TableName, edtCodeComment);

  inherited;
end;

procedure TfrmCurrency.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmCurrency.Repaint();
begin
  inherited;
  //
end;

procedure TfrmCurrency.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtCode.Text := TCurrency(Table).Code.Value;
  edtSymbol.Text := TCurrency(Table).Symbol.Value;
  chkIsDefault.Checked := TCurrency(Table).IsDefault.Value;
  edtCodeComment.Text := TCurrency(Table).CodeComment.Value;
end;

procedure TfrmCurrency.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TCurrency(Table).Code.Value := edtCode.Text;
      TCurrency(Table).Symbol.Value := edtSymbol.Text;
      TCurrency(Table).IsDefault.Value := chkIsDefault.Checked;
      TCurrency(Table).CodeComment.Value := edtCodeComment.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
