unit ufrmBolge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmBolge = class(TfrmBaseInputDB)
    lblBolgeTuru: TLabel;
    cbbBolgeTuru: TComboBox;
    lblBolge: TLabel;
    edtBolge: TEdit;
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
  Ths.Erp.Database.Table.Bolge;

{$R *.dfm}

procedure TfrmBolge.FormCreate(Sender: TObject);
begin
  TBolge(Table).BolgeTuru.SetControlProperty(Table.TableName, cbbBolgeTuru);
  TBolge(Table).Bolge.SetControlProperty(Table.TableName, edtBolge);

  inherited;
end;

procedure TfrmBolge.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbBolgeTuru.Text := FormatedVariantVal(TBolge(Table).BolgeTuru.FieldType, TBolge(Table).BolgeTuru.Value);
  edtBolge.Text := FormatedVariantVal(TBolge(Table).Bolge.FieldType, TBolge(Table).Bolge.Value);
end;

procedure TfrmBolge.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TBolge(Table).BolgeTuru.Value := cbbBolgeTuru.Text;
      TBolge(Table).Bolge.Value := edtBolge.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
