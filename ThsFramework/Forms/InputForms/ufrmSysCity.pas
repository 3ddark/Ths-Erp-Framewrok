unit ufrmSysCity;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Samples.Spin,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInputDB;

type
  TfrmSysCity = class(TfrmBaseInputDB)
    lblcountry_id: TLabel;
    edtcountry_id: TEdit;
    lblcity_name: TLabel;
    edtcity_name: TEdit;
    lblcar_plate_code: TLabel;
    edtcar_plate_code: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
    procedure FormDestroy(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysCountry,
  Ths.Erp.Database.Table.SysCity,
  ufrmHelperSysCountry;

{$R *.dfm}

procedure TfrmSysCity.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysCity.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmSysCity.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysCity.HelperProcess(Sender: TObject);
var
  vHelperSysCountry: TfrmHelperSysCountry;
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if Sender is TEdit then
    begin
      if TEdit(Sender).Name = edtcountry_id.Name then
      begin
        vHelperSysCountry := TfrmHelperSysCountry.Create(TEdit(Sender), Self, nil, True, ifmNone, fomNormal);
        try
          vHelperSysCountry.ShowModal;
          if Assigned(TSysCity(Table).CountryID.FK.FKTable) then
            TSysCity(Table).CountryID.FK.FKTable.Free;
          TSysCity(Table).CountryID.FK.FKTable := vHelperSysCountry.Table.Clone;
        finally
          vHelperSysCountry.Free;
        end;
      end;
    end;
  end;
end;

procedure TfrmSysCity.RefreshData();
begin
  //control içeriðini table class ile doldur
  inherited;
end;

procedure TfrmSysCity.btnAcceptClick(Sender: TObject);
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
