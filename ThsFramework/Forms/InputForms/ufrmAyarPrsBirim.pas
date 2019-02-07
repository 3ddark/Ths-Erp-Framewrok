unit ufrmAyarPrsBirim;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus,
  Vcl.AppEvnts, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase,
  ufrmBaseInputDB,
  ufrmHelperAyarPrsBolum,

  Ths.Erp.Database.Table.AyarPrsBirim;

type
  TfrmAyarPrsBirim = class(TfrmBaseInputDB)
    lblbolum_id: TLabel;
    edtbolum_id: TEdit;
    lblbirim: TLabel;
    edtbirim: TEdit;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vHelperAyarPrsBolum: TfrmHelperAyarPrsBolum;
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
  end;

implementation

{$R *.dfm}

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

procedure TfrmAyarPrsBirim.btnAcceptClick(Sender: TObject);
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
