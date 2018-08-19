unit ufrmHelperStokGrubu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseHelper, Data.DB, Vcl.Menus,
  Vcl.AppEvnts, Vcl.ComCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, thsEdit, thsComboBox;

type
  TfrmHelperStokGrubu = class(TfrmBaseHelper)
  private
    { Private declarations }
  public
    procedure SetSelectedItem; override;
    { Public declarations }
  published
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
  end;

implementation

uses
  ufrmBase,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.StokGrubu,
  ufrmBaseInputDB;

{$R *.dfm}

{ TfrmHelperStokGrubu }

procedure TfrmHelperStokGrubu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DataAktar then
  begin
    if Owner.ClassType = TthsEdit then
    begin
      if ParentForm.ClassParent = TfrmBaseInputDB then
      begin
        if ((ParentForm as TfrmBaseInputDB).FormMode = ifmNewRecord)
        or ((ParentForm as TfrmBaseInputDB).FormMode = ifmCopyNewRecord)
        or ((ParentForm as TfrmBaseInputDB).FormMode = ifmUpdate)
        then
        begin
          TthsEdit(Owner).Text := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Grup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Grup.FieldName).Value);
          TthsEdit(Owner).SelStart := Length(TthsEdit(Owner).Text);
        end;
      end;
    end;
    inherited;
  end
  else
    inherited;
end;

procedure TfrmHelperStokGrubu.SetSelectedItem;
begin
  inherited;

  TStokGrubu(Table).Grup.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Grup.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Grup.FieldName).Value);
  TStokGrubu(Table).AlisHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).AlisHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).AlisHesabi.FieldName).Value);
  TStokGrubu(Table).SatisHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).SatisHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).SatisHesabi.FieldName).Value);
  TStokGrubu(Table).HammaddeHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).HammaddeHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).HammaddeHesabi.FieldName).Value);
  TStokGrubu(Table).MamulHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).MamulHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).MamulHesabi.FieldName).Value);
  TStokGrubu(Table).KDVOraniID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOraniID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOraniID.FieldName).Value);
  TStokGrubu(Table).KDVOrani.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOrani.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).KDVOrani.FieldName).Value);
  TStokGrubu(Table).TurID.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).TurID.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).TurID.FieldName).Value);
  TStokGrubu(Table).Tur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Tur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).Tur.FieldName).Value);
  TStokGrubu(Table).IsIskontoAktif.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsIskontoAktif.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsIskontoAktif.FieldName).Value);
  TStokGrubu(Table).IskontoSatis.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoSatis.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoSatis.FieldName).Value);
  TStokGrubu(Table).IskontoMudur.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoMudur.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IskontoMudur.FieldName).Value);
  TStokGrubu(Table).IsSatisFiyatiniKullan.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsSatisFiyatiniKullan.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsSatisFiyatiniKullan.FieldName).Value);
  TStokGrubu(Table).YariMamulHesabi.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).YariMamulHesabi.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).YariMamulHesabi.FieldName).Value);
  TStokGrubu(Table).IsMaliyetAnalizFarkliDB.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsMaliyetAnalizFarkliDB.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TStokGrubu(Table).IsMaliyetAnalizFarkliDB.FieldName).Value);
end;

end.
