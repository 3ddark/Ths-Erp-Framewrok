unit ufrmAyarFirmaTipi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB,

  Ths.Erp.Database.Table.AyarFirmaTuru
  ;

type
  TfrmAyarFirmaTipi = class(TfrmBaseInputDB)
    lblFirmaTuru: TLabel;
    cbbFirmaTuru: TComboBox;
    lblFirmaTipi: TLabel;
    edtFirmaTipi: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure FormDestroy(Sender: TObject); override;
  private
    vFirmaTuru: TAyarFirmaTuru;
  public
  protected
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarFirmaTipi;

{$R *.dfm}

procedure TfrmAyarFirmaTipi.FormCreate(Sender: TObject);
var
  n1: Integer;
begin
  TAyarFirmaTipi(Table).FirmaTipi.SetControlProperty(Table.TableName, edtFirmaTipi);
  TAyarFirmaTipi(Table).FirmaTuruID.SetControlProperty(Table.TableName, cbbFirmaTuru);

  inherited;

  vFirmaTuru := TAyarFirmaTuru.Create(Table.Database);
  vFirmaTuru.SelectToList('', False, False);
  cbbFirmaTuru.Clear;
  for n1 := 0 to vFirmaTuru.List.Count-1 do
    cbbFirmaTuru.AddItem(TAyarFirmaTuru(vFirmaTuru.List[n1]).Tur.Value, TAyarFirmaTuru(vFirmaTuru.List[n1]));
end;

procedure TfrmAyarFirmaTipi.FormDestroy(Sender: TObject);
begin
  vFirmaTuru.Free;

  inherited;
end;

procedure TfrmAyarFirmaTipi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtFirmaTipi.Text := TAyarFirmaTipi(Table).FirmaTipi.Value;
  cbbFirmaTuru.ItemIndex := cbbFirmaTuru.Items.IndexOf( FormatedVariantVal(TAyarFirmaTipi(Table).FirmaTuru.FieldType, TAyarFirmaTipi(Table).FirmaTuru.Value) );
end;

procedure TfrmAyarFirmaTipi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarFirmaTipi(Table).FirmaTipi.Value := edtFirmaTipi.Text;
      TAyarFirmaTipi(Table).FirmaTuru.Value := cbbFirmaTuru.Text;
      if Assigned(cbbFirmaTuru.Items.Objects[cbbFirmaTuru.ItemIndex]) then
        TAyarFirmaTipi(Table).FirmaTuruID.Value := TAyarFirmaTipi(cbbFirmaTuru.Items.Objects[cbbFirmaTuru.ItemIndex]).Id.Value;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
