unit ufrmAyarPrsBirim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInputDB,
  ufrmHelperAyarPrsBolum,

  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarPrsBolum,
  Ths.Erp.Database.Table.AyarPrsBirim;

type
  TfrmAyarPrsBirim = class(TfrmBaseInputDB)
    lblBolum: TLabel;
    edtBolum: TEdit;
    lblBirim: TLabel;
    edtBirim: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vHelperAyarPrsBolum: TfrmHelperAyarPrsBolum;
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
    procedure FormDestroy(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

procedure TfrmAyarPrsBirim.FormCreate(Sender: TObject);
begin
  TAyarPrsBirim(Table).BolumID.SetControlProperty(Table.TableName, edtBolum);
  TAyarPrsBirim(Table).Birim.SetControlProperty(Table.TableName, edtBirim);

  inherited;
end;

procedure TfrmAyarPrsBirim.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmAyarPrsBirim.FormShow(Sender: TObject);
begin
  inherited;
  edtBolum.OnHelperProcess := HelperProcess;
end;

procedure TfrmAyarPrsBirim.HelperProcess(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if Sender is TEdit then
    begin
      if TEdit(Sender).Name = edtBolum.Name then
      begin
        vHelperAyarPrsBolum := TfrmHelperAyarPrsBolum.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperAyarPrsBolum.ShowModal;
          if Assigned(TAyarPrsBirim(Table).BolumID.FK.FKTable) then
            TAyarPrsBirim(Table).BolumID.FK.FKTable.Free;
          TAyarPrsBirim(Table).BolumID.Value := vHelperAyarPrsBolum.Table.Id.Value;
          TAyarPrsBirim(Table).BolumID.FK.FKTable := vHelperAyarPrsBolum.Table.Clone;
        finally
          vHelperAyarPrsBolum.Free;
        end;
      end;
    end;
  end;
end;

procedure TfrmAyarPrsBirim.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtBolum.Text := FormatedVariantVal(TAyarPrsBirim(Table).BolumID.FK.FKCol.FieldType, TAyarPrsBirim(Table).BolumID.FK.FKCol.Value);
  edtBirim.Text := FormatedVariantVal(TAyarPrsBirim(Table).Birim.FieldType, TAyarPrsBirim(Table).Birim.Value);
end;

procedure TfrmAyarPrsBirim.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarPrsBirim(Table).BolumID.Value := TAyarPrsBirim(Table).BolumID.Value;
      TAyarPrsBirim(Table).BolumID.FK.FKCol.Value := edtBolum.Text;
      TAyarPrsBirim(Table).Birim.Value := edtBirim.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
