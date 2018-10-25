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

  ufrmBase, ufrmBaseInputDB,

  Ths.Erp.Database.Table.BolgeTuru
  ;

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
    vBolgeTuru: TBolgeTuru;
  public
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.Bolge;

{$R *.dfm}

procedure TfrmBolge.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TBolge(Table).BolgeTuru.SetControlProperty(Table.TableName, cbbBolgeTuru);
  TBolge(Table).BolgeAdi.SetControlProperty(Table.TableName, edtBolge);

  inherited;

  vBolgeTuru := TBolgeTuru.Create(Table.Database);
  vBolgeTuru.SelectToList('', False, False);
  cbbBolgeTuru.Clear;
  for n1 := 0 to vBolgeTuru.List.Count-1 do
    cbbBolgeTuru.AddItem(TBolgeTuru(vBolgeTuru.List[n1]).Tur.Value, TBolgeTuru(vBolgeTuru.List[n1]));
end;

procedure TfrmBolge.FormDestroy(Sender: TObject);
begin
  vBolgeTuru.Free;

  inherited;
end;

procedure TfrmBolge.RefreshData();
begin
  //control içeriðini table class ile doldur
  cbbBolgeTuru.ItemIndex := cbbBolgeTuru.Items.IndexOf( FormatedVariantVal(TBolge(Table).BolgeTuruID.FieldType, TBolge(Table).BolgeTuru.Value) );
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
      if Assigned(cbbBolgeTuru.Items.Objects[cbbBolgeTuru.ItemIndex]) then
        TBolge(Table).BolgeTuruID.Value := TBolge(cbbBolgeTuru.Items.Objects[cbbBolgeTuru.ItemIndex]).Id.Value;
      TBolge(Table).BolgeTuru.Value := cbbBolgeTuru.Text;
      TBolge(Table).BolgeAdi.Value := edtBolge.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
