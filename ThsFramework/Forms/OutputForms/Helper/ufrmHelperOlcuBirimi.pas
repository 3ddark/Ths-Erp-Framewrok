unit ufrmHelperOlcuBirimi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBaseHelper, Data.DB, Vcl.Menus,
  Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBGrids, thsEdit, thsComboBox, Vcl.Samples.Spin, Vcl.Grids;

type
  TfrmHelperOlcuBirimi = class(TfrmBaseHelper)
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
  Ths.Erp.Database.Table.OlcuBirimi,
  ufrmBaseInputDB;

{$R *.dfm}

{ TfrmHelperOlcuBirimi }

procedure TfrmHelperOlcuBirimi.FormClose(Sender: TObject;
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
          TthsEdit(Owner).Text := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).Birim.FieldName).Value);
          TthsEdit(Owner).SelStart := Length(TthsEdit(Owner).Text);
        end;
      end;
    end;
    inherited;
  end
  else
    inherited;
end;

procedure TfrmHelperOlcuBirimi.SetSelectedItem;
begin
  inherited;

  TOlcuBirimi(Table).Birim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).Birim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).Birim.FieldName).Value);
  TOlcuBirimi(Table).EFaturaBirim.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).EFaturaBirim.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).EFaturaBirim.FieldName).Value);
  TOlcuBirimi(Table).BirimAciklama.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).BirimAciklama.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).BirimAciklama.FieldName).Value);
  TOlcuBirimi(Table).IsFloatTip.Value := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).IsFloatTip.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TOlcuBirimi(Table).IsFloatTip.FieldName).Value);
end;

end.
