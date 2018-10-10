unit ufrmOlcuBirimi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmOlcuBirimi = class(TfrmBaseInputDB)
    lblBirim: TLabel;
    edtBirim: TEdit;
    lblEFaturaBirim: TLabel;
    edtEFaturaBirim: TEdit;
    lblBirimAciklama: TLabel;
    edtBirimAciklama: TEdit;
    lblIsFloatTip: TLabel;
    chkIsFloatTip: TCheckBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.OlcuBirimi;

{$R *.dfm}

procedure TfrmOlcuBirimi.FormCreate(Sender: TObject);
begin
  TOlcuBirimi(Table).Birim.SetControlProperty(Table.TableName, edtBirim);
  TOlcuBirimi(Table).EFaturaBirim.SetControlProperty(Table.TableName, edtEFaturaBirim);
  TOlcuBirimi(Table).BirimAciklama.SetControlProperty(Table.TableName, edtBirimAciklama);

  inherited;
end;

procedure TfrmOlcuBirimi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtBirim.Text := FormatedVariantVal(TOlcuBirimi(Table).Birim.FieldType, TOlcuBirimi(Table).Birim.Value);
  edtEFaturaBirim.Text := FormatedVariantVal(TOlcuBirimi(Table).EFaturaBirim.FieldType, TOlcuBirimi(Table).EFaturaBirim.Value);
  edtBirimAciklama.Text := FormatedVariantVal(TOlcuBirimi(Table).BirimAciklama.FieldType, TOlcuBirimi(Table).BirimAciklama.Value);
  chkIsFloatTip.Checked := FormatedVariantVal(TOlcuBirimi(Table).IsFloatTip.FieldType, TOlcuBirimi(Table).IsFloatTip.Value);
end;

procedure TfrmOlcuBirimi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TOlcuBirimi(Table).Birim.Value := edtBirim.Text;
      TOlcuBirimi(Table).EFaturaBirim.Value := edtEFaturaBirim.Text;
      TOlcuBirimi(Table).BirimAciklama.Value := edtBirimAciklama.Text;
      TOlcuBirimi(Table).IsFloatTip.Value := chkIsFloatTip.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
