unit ufrmHelperPersonelKarti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.DBGrids, Vcl.Samples.Spin, Vcl.Grids,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.ComboBox,

  ufrmBaseHelper;

type
  TfrmHelperPersonelKarti = class(TfrmBaseHelper)
  private
    { Private declarations }
  protected
  public
  published
    procedure FormClose(Sender: TObject; var Action: TCloseAction); override;
  end;

implementation

uses
  ufrmBase
  , Ths.Erp.Database.Singleton
  , Ths.Erp.Database.Table.PersonelKarti
  , ufrmBaseInputDB
  ;

{$R *.dfm}

procedure TfrmHelperPersonelKarti.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DataAktar then
  begin
    if Owner.ClassType = TEdit then
    begin
      if ParentForm.ClassParent = TfrmBaseInputDB then
      begin
        if ((ParentForm as TfrmBaseInputDB).FormMode = ifmNewRecord)
        or ((ParentForm as TfrmBaseInputDB).FormMode = ifmCopyNewRecord)
        or ((ParentForm as TfrmBaseInputDB).FormMode = ifmUpdate)
        then
        begin
          TEdit(Owner).Text := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelAdSoyad.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TPersonelKarti(Table).PersonelAdSoyad.FieldName).Value);
          TEdit(Owner).SelStart := Length(TEdit(Owner).Text);
        end;
      end;
    end;
    inherited;
  end
  else
    inherited;
end;

end.

