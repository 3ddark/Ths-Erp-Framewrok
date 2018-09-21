unit ufrmAyarBarkodTezgah;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts,
  thsEdit, thsComboBox, thsMemo,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Database.Table.Ambar, Vcl.Samples.Spin;

type
  TfrmAyarBarkodTezgah = class(TfrmBaseInputDB)
    lblTezgahAdi: TLabel;
    edtTezgahAdi: TthsEdit;
    lblAmbar: TLabel;
    cbbAmbar: TthsComboBox;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vAmbar: TAmbar;
  public
  protected
  published
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarBarkodTezgah;

{$R *.dfm}

procedure TfrmAyarBarkodTezgah.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TAyarBarkodTezgah(Table).TezgahAdi.SetControlProperty(Table.TableName, edtTezgahAdi);
  TAyarBarkodTezgah(Table).Ambar.SetControlProperty(Table.TableName, cbbAmbar);

  inherited;

  vAmbar := TAmbar.Create(Table.Database);
  vAmbar.SelectToList('', False, False);
  cbbAmbar.Clear;
  for n1 := 0 to vAmbar.List.Count-1 do
    cbbAmbar.AddItem( TAmbar(vAmbar.List[n1]).AmbarAdi.Value, TAmbar(vAmbar.List[n1]) );
  cbbAmbar.ItemIndex := -1;
end;

procedure TfrmAyarBarkodTezgah.FormDestroy(Sender: TObject);
begin
  vAmbar.Free;

  inherited;
end;

procedure TfrmAyarBarkodTezgah.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtTezgahAdi.Text := FormatedVariantVal(TAyarBarkodTezgah(Table).TezgahAdi.FieldType, TAyarBarkodTezgah(Table).TezgahAdi.Value);
  cbbAmbar.ItemIndex := cbbAmbar.Items.IndexOf( FormatedVariantVal(TAyarBarkodTezgah(Table).Ambar.FieldType, TAyarBarkodTezgah(Table).Ambar.Value) );
end;

procedure TfrmAyarBarkodTezgah.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarBarkodTezgah(Table).TezgahAdi.Value := edtTezgahAdi.Text;
      TAyarBarkodTezgah(Table).Ambar.Value := cbbAmbar.Text;
      if Assigned( TAmbar(cbbAmbar.Items.Objects[cbbAmbar.ItemIndex]) ) then
        TAyarBarkodTezgah(Table).AmbarID.Value := TAmbar(cbbAmbar.Items.Objects[cbbAmbar.ItemIndex]).Id.Value;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
