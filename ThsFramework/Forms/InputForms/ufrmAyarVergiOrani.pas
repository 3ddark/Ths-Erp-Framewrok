unit ufrmAyarVergiOrani;

interface

{$I ThsERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Vcl.Menus, Vcl.Samples.Spin,
  Vcl.AppEvnts,

  Ths.Erp.Helper.BaseTypes,
  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase, ufrmBaseInputDB,
  Ths.Erp.Constants,
  Ths.Erp.Database.Table.HesapKarti;

type
  TfrmAyarVergiOrani = class(TfrmBaseInputDB)
    edtAlisIadeVergiHesapKodu: TEdit;
    edtAlisVergiHesapKodu: TEdit;
    edtSatisIadeVergiHesapKodu: TEdit;
    edtSatisVergiHesapKodu: TEdit;
    edtVergiOrani: TEdit;
    lblAlisIadeVergiHesapKodu: TLabel;
    lblAlisVergiHesapKodu: TLabel;
    lblSatisIadeVergiHesapKodu: TLabel;
    lblSatisVergiHesapKodu: TLabel;
    lblVergiOrani: TLabel;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public
  protected
    procedure HelperProcess(Sender: TObject); override;
  published
  end;

implementation

uses
  ufrmHelperHesapKarti,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarVergiOrani;

{$R *.dfm}

procedure TfrmAyarVergiOrani.HelperProcess(Sender: TObject);
var
  vHelperHesapKarti: TfrmHelperHesapKarti;
begin
  if Sender.ClassType = TEdit then
  begin
    if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
    begin
      if (TEdit(Sender).Name = edtSatisVergiHesapKodu.Name)
      or (TEdit(Sender).Name = edtSatisIadeVergiHesapKodu.Name)
      or (TEdit(Sender).Name = edtAlisVergiHesapKodu.Name)
      or (TEdit(Sender).Name = edtAlisIadeVergiHesapKodu.Name)
      then
      begin
        vHelperHesapKarti := TfrmHelperHesapKarti.Create(TEdit(Sender), Self, THesapKarti.Create(Table.Database), True, ifmNone, fomNormal);
        try
          vHelperHesapKarti.ShowModal;
          if (TEdit(Sender).Name = edtSatisVergiHesapKodu.Name) then
          begin
            if Assigned(TAyarVergiOrani(Table).SatisVergiHesapKodu.FK.FKTable) then
              TAyarVergiOrani(Table).SatisVergiHesapKodu.FK.FKTable.Free;
            TAyarVergiOrani(Table).SatisVergiHesapKodu.Value := THesapKarti(vHelperHesapKarti.Table).HesapKodu.Value;
            TAyarVergiOrani(Table).SatisVergiHesapKodu.FK.FKTable := vHelperHesapKarti.Table.Clone;
          end
          else if (TEdit(Sender).Name = edtSatisIadeVergiHesapKodu.Name) then
          begin
            if Assigned(TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.FK.FKTable) then
              TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.FK.FKTable.Free;
            TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.Value := THesapKarti(vHelperHesapKarti.Table).HesapKodu.Value;
            TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.FK.FKTable := vHelperHesapKarti.Table.Clone;
          end
          else if (TEdit(Sender).Name = edtAlisVergiHesapKodu.Name) then
          begin
            if Assigned(TAyarVergiOrani(Table).AlisVergiHesapKodu.FK.FKTable) then
              TAyarVergiOrani(Table).AlisVergiHesapKodu.FK.FKTable.Free;
            TAyarVergiOrani(Table).AlisVergiHesapKodu.Value := THesapKarti(vHelperHesapKarti.Table).HesapKodu.Value;
            TAyarVergiOrani(Table).AlisVergiHesapKodu.FK.FKTable := vHelperHesapKarti.Table.Clone;
          end
          else if (TEdit(Sender).Name = edtAlisIadeVergiHesapKodu.Name) then
          begin
            if Assigned(TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.FK.FKTable) then
              TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.FK.FKTable.Free;
            TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.Value := THesapKarti(vHelperHesapKarti.Table).HesapKodu.Value;
            TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.FK.FKTable := vHelperHesapKarti.Table.Clone;
          end;
        finally
          vHelperHesapKarti.Free;
        end;
      end
    end;
  end;
end;

procedure TfrmAyarVergiOrani.btnAcceptClick(Sender: TObject);
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
