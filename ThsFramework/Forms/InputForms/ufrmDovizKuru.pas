unit ufrmDovizKuru;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts,
  Ths.Erp.Helper.Edit, Ths.Erp.Helper.ComboBox, Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB, Vcl.Menus, Vcl.Samples.Spin;

type
  TfrmDovizKuru = class(TfrmBaseInputDB)
    lbltarih: TLabel;
    edttarih: TEdit;
    lblpara_birimi: TLabel;
    edtpara_birimi: TEdit;
    lblkur: TLabel;
    edtkur: TEdit;
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
  Ths.Erp.Database.Table.DovizKuru,
  Ths.Erp.Database.Table.ParaBirimi,
  ufrmHelperParaBirimi;

{$R *.dfm}

procedure TfrmDovizKuru.btnAcceptClick(Sender: TObject);
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

procedure TfrmDovizKuru.HelperProcess(Sender: TObject);
var
  vHelperParaBirimi: TfrmHelperParaBirimi;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtpara_birimi.Name then
      begin
        vHelperParaBirimi := TfrmHelperParaBirimi.Create(TEdit(Sender), Self, TParaBirimi.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperParaBirimi.ShowModal;

          if Assigned(TDovizKuru(Table).ParaBirimi.FK.FKTable) then
            TDovizKuru(Table).ParaBirimi.FK.FKTable.Free;
          TDovizKuru(Table).ParaBirimi.Value := TParaBirimi(vHelperParaBirimi.Table).Kod.Value;
          TDovizKuru(Table).ParaBirimi.FK.FKCol.Value := TParaBirimi(vHelperParaBirimi.Table).Kod.Value;
          TDovizKuru(Table).ParaBirimi.FK.FKTable := vHelperParaBirimi.Table.Clone;
        finally
          vHelperParaBirimi.Free;
        end;
      end;
    end;
  end;
end;

end.
