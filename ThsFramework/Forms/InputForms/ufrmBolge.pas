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

  ufrmBase,
  ufrmBaseInputDB,

  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.Bolge
  ;

type
  TfrmBolge = class(TfrmBaseInputDB)
    lblBolgeTuru: TLabel;
    edtBolgeTuru: TEdit;
    lblBolge: TLabel;
    edtBolge: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

procedure TfrmBolge.FormCreate(Sender: TObject);
begin
  TBolge(Table).BolgeTuruID.FK.FKCol.SetControlProperty(Table.TableName, edtBolgeTuru);
  TBolge(Table).BolgeAdi.SetControlProperty(Table.TableName, edtBolge);

  inherited;
end;

procedure TfrmBolge.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmBolge.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtBolgeTuru.Text := FormatedVariantVal(TBolge(Table).BolgeTuruID.FK.FKCol.FieldType, TBolge(Table).BolgeTuruID.FK.FKCol.Value);
  edtBolge.Text := FormatedVariantVal(TBolge(Table).BolgeAdi.FieldType, TBolge(Table).BolgeAdi.Value);
end;

procedure TfrmBolge.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;

end;

procedure TfrmBolge.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TBolge(Table).BolgeTuruID.Value := TBolge(Table).BolgeTuruID.FK.FKTable.Id.Value;
      TBolge(Table).BolgeTuruID.FK.FKCol.Value := edtBolgeTuru.Text;
      TBolge(Table).BolgeAdi.Value := edtBolge.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
