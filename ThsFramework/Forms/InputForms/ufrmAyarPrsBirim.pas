unit ufrmAyarPrsBirim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts, System.Rtti,
                                      ths.erp.Constants,
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
    lblbolum_id: TLabel;
    edtbolum_id: TEdit;
    lblbirim: TLabel;
    edtbirim: TEdit;
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
  inherited;
  //
end;

procedure TfrmAyarPrsBirim.FormDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TfrmAyarPrsBirim.FormShow(Sender: TObject);
begin
  inherited;
//  edtbolum_id.OnHelperProcess := HelperProcess;
end;

procedure TfrmAyarPrsBirim.HelperProcess(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if Sender is TEdit then
    begin
      if TEdit(Sender).Name = edtbolum_id.Name then
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
  inherited;
  //control içeriðini table class ile doldur
//  edtbolum_id.Text := FormatedVariantVal(TAyarPrsBirim(Table).BolumID.FK.FKCol.FieldType, TAyarPrsBirim(Table).BolumID.FK.FKCol.Value);
//  edtbirim.Text := FormatedVariantVal(TAyarPrsBirim(Table).Birim.FieldType, TAyarPrsBirim(Table).Birim.Value);
end;

procedure TfrmAyarPrsBirim.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;
//      TAyarPrsBirim(Table).BolumID.Value := TAyarPrsBirim(Table).BolumID.Value;
//      TAyarPrsBirim(Table).BolumID.FK.FKCol.Value := edtbolum_id.Text;
//      TAyarPrsBirim(Table).Birim.Value := edtbirim.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
