unit ufrmAyarVergiOrani;

interface

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
    lblVergiOrani: TLabel;
    edtVergiOrani: TEdit;
    lblSatisVergiHesapKodu: TLabel;
    edtSatisVergiHesapKodu: TEdit;
    lblSatisIadeVergiHesapKodu: TLabel;
    edtSatisIadeVergiHesapKodu: TEdit;
    lblAlisVergiHesapKodu: TLabel;
    edtAlisVergiHesapKodu: TEdit;
    lblAlisIadeVergiHesapKodu: TLabel;
    edtAlisIadeVergiHesapKodu: TEdit;
    procedure FormCreate(Sender: TObject);override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
    vHesapKarti: THesapKarti;
  public
    destructor Destroy; override;
  protected
  published
    procedure HelperProcess(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  ufrmHelperHesapKarti,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.AyarVergiOrani;

{$R *.dfm}

destructor TfrmAyarVergiOrani.Destroy;
begin
  if Assigned(vHesapKarti) then
    vHesapKarti.Free;
  inherited;
end;

procedure TfrmAyarVergiOrani.FormCreate(Sender: TObject);
begin
  TAyarVergiOrani(Table).VergiOrani.SetControlProperty(Table.TableName, edtVergiOrani);
  TAyarVergiOrani(Table).SatisVergiHesapKodu.SetControlProperty(Table.TableName, edtSatisVergiHesapKodu);
  TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.SetControlProperty(Table.TableName, edtSatisIadeVergiHesapKodu);
  TAyarVergiOrani(Table).AlisVergiHesapKodu.SetControlProperty(Table.TableName, edtAlisVergiHesapKodu);
  TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.SetControlProperty(Table.TableName, edtAlisIadeVergiHesapKodu);

  inherited;

  vHesapKarti := THesapKarti.Create(Table.Database);
end;

procedure TfrmAyarVergiOrani.FormShow(Sender: TObject);
begin
  inherited;
  edtSatisVergiHesapKodu.OnHelperProcess := HelperProcess;
  edtSatisIadeVergiHesapKodu.OnHelperProcess := HelperProcess;
  edtAlisVergiHesapKodu.OnHelperProcess := HelperProcess;
  edtAlisIadeVergiHesapKodu.OnHelperProcess := HelperProcess;
end;

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

          if Assigned(vHesapKarti) then
            vHesapKarti.Free;

          vHesapKarti := THesapKarti(THesapKarti(vHelperHesapKarti.Table).Clone);
          TEdit(Sender).Text := vHesapKarti.HesapKodu.Value;
        finally
          vHelperHesapKarti.Free;
        end;
      end
    end;
  end;
end;

procedure TfrmAyarVergiOrani.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtVergiOrani.Text := FormatedVariantVal(TAyarVergiOrani(Table).VergiOrani.FieldType, TAyarVergiOrani(Table).VergiOrani.Value);
  edtSatisVergiHesapKodu.Text := FormatedVariantVal(TAyarVergiOrani(Table).SatisVergiHesapKodu.FieldType, TAyarVergiOrani(Table).SatisVergiHesapKodu.Value);
  edtSatisIadeVergiHesapKodu.Text := FormatedVariantVal(TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.FieldType, TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.Value);
  edtAlisVergiHesapKodu.Text := FormatedVariantVal(TAyarVergiOrani(Table).AlisVergiHesapKodu.FieldType, TAyarVergiOrani(Table).AlisVergiHesapKodu.Value);
  edtAlisIadeVergiHesapKodu.Text := FormatedVariantVal(TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.FieldType, TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.Value);
end;

procedure TfrmAyarVergiOrani.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TAyarVergiOrani(Table).VergiOrani.Value := edtVergiOrani.Text;
      TAyarVergiOrani(Table).SatisVergiHesapKodu.Value := edtSatisVergiHesapKodu.Text;
      TAyarVergiOrani(Table).SatisIadeVergiHesapKodu.Value := edtSatisIadeVergiHesapKodu.Text;
      TAyarVergiOrani(Table).AlisVergiHesapKodu.Value := edtAlisVergiHesapKodu.Text;
      TAyarVergiOrani(Table).AlisIadeVergiHesapKodu.Value := edtAlisIadeVergiHesapKodu.Text;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
