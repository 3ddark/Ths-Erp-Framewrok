unit ufrmStokCinsOzelligi;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB;

type
  TfrmStokCinsOzelligi = class(TfrmBaseInputDB)
    lblayar_stk_cins_aile_id: TLabel;
    edtayar_stk_cins_aile_id: TEdit;
    lblcins: TLabel;
    edtcins: TEdit;
    lblaciklama: TLabel;
    edtaciklama: TEdit;
    lblstring1: TLabel;
    edtstring1: TEdit;
    lblstring2: TLabel;
    edtstring2: TEdit;
    lblstring3: TLabel;
    edtstring3: TEdit;
    lblstring4: TLabel;
    edtstring4: TEdit;
    lblstring5: TLabel;
    edtstring5: TEdit;
    lblstring6: TLabel;
    edtstring6: TEdit;
    lblstring7: TLabel;
    edtstring7: TEdit;
    lblstring8: TLabel;
    edtstring8: TEdit;
    lblstring9: TLabel;
    edtstring9: TEdit;
    lblstring10: TLabel;
    edtstring10: TEdit;
    lblstring11: TLabel;
    edtstring11: TEdit;
    lblstring12: TLabel;
    edtstring12: TEdit;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarStkCinsOzelligi,
  ufrmHelperStokCinsAileleri;

{$R *.dfm}

procedure TfrmStokCinsOzelligi.HelperProcess(Sender: TObject);
var
  vHelperStokCinsAileleri: TfrmHelperStokCinsAileleri;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtayar_stk_cins_aile_id.Name then
      begin
        vHelperStokCinsAileleri := TfrmHelperStokCinsAileleri.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperStokCinsAileleri.ShowModal;

          if Assigned(TAyarStkCinsOzelligi(Table).AyarStkCinsAileID.FK.FKTable) then
            TAyarStkCinsOzelligi(Table).AyarStkCinsAileID.FK.FKTable.Free;
          TAyarStkCinsOzelligi(Table).AyarStkCinsAileID.Value := vHelperStokCinsAileleri.Table.Id.Value;
          TAyarStkCinsOzelligi(Table).AyarStkCinsAileID.FK.FKTable := vHelperStokCinsAileleri.Table.Clone;
        finally
          vHelperStokCinsAileleri.Free;
        end;
      end;
    end;
  end;
end;

procedure TfrmStokCinsOzelligi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      btnAcceptAuto;

      inherited;
    end;
  end
  else
    inherited;
end;

end.
