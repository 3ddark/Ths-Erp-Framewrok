unit ufrmSysLangDataContent;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,
  Ths.Erp.Helper.Memo,

  ufrmBase, ufrmBaseInputDB
  ;

type
  TfrmSysLangDataContent = class(TfrmBaseInputDB)
    lbllang: TLabel;
    edtlang: TEdit;
    lblval: TLabel;
    edtval: TEdit;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
    Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.SysLangDataContent
  , Ths.Erp.Database.Table.SysLang
  , ufrmHelperSysLang
  ;

{$R *.dfm}

procedure TfrmSysLangDataContent.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TSysLangDataContent(Table).Lang.Value := edtlang.Text;
      TSysLangDataContent(Table).Value.Value := edtval.Text;

      inherited;
    end;
  end
  else
    inherited;
end;

procedure TfrmSysLangDataContent.FormShow(Sender: TObject);
begin
  inherited;
  edtlang.CharCase := ecNormal;
end;

procedure TfrmSysLangDataContent.HelperProcess(Sender: TObject);
var
  vHelperSysLang: TfrmHelperSysLang;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if TEdit(Sender).Name = edtlang.Name then
      begin
        vHelperSysLang := TfrmHelperSysLang.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysLang.ShowModal;

          if Assigned(TSysLangDataContent(Table).Lang.FK.FKTable) then
            TSysLangDataContent(Table).Lang.FK.FKTable.Free;
          TSysLangDataContent(Table).Lang.FK.FKTable := vHelperSysLang.Table.Clone;
        finally
          vHelperSysLang.Free;
        end;
      end
    end;
  end;
end;

end.
