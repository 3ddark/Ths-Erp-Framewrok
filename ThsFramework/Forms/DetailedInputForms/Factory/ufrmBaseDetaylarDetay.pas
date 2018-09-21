unit ufrmBaseDetaylarDetay;

interface

uses
  Winapi.Windows,
  System.SysUtils, System.Classes, System.Variants,
  System.Rtti,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Dialogs, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Graphics, Vcl.AppEvnts, Vcl.Grids,
  Data.DB, FireDAC.Stan.Option, FireDAC.Stan.Intf,
  FireDAC.Comp.Client, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,

  thsEdit, thsMemo, thsComboBox,
  ufrmBase,
  ufrmBaseInput,
  ufrmBaseDetaylar,

  Ths.Erp.Database.Table,
  Ths.Erp.Database.TableDetailed,
  Ths.Erp.SpecialFunctions, Vcl.Samples.Spin;

type
  TfrmBaseInputDetay = class(TfrmBaseInput)
    procedure btnSpinDownClick(Sender: TObject);override;
    procedure btnSpinUpClick(Sender: TObject);override;
    procedure btnCloseClick(Sender: TObject);override;
    procedure btnDeleteClick(Sender: TObject);override;
    procedure btnAcceptClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);override;
  protected
    function getStringGridOnDetailForm(): TStringGrid;
  public
  published
  end;

implementation

uses

  Ths.Erp.Database.Singleton, Ths.Erp.Constants;

{$R *.dfm}

function TfrmBaseInputDetay.getStringGridOnDetailForm(): TStringGrid;
var
  n1: Integer;
begin
  Result := nil;
  if ParentForm <> nil then
  begin
    for n1 := 0 to TfrmBaseDetaylar(ParentForm).pgcContent.ActivePage.ControlCount-1 do
    begin
      if  (TControl(TfrmBaseDetaylar(ParentForm).pgcContent.ActivePage.Controls[n1]).Visible)
      and (TControl(TfrmBaseDetaylar(ParentForm).pgcContent.ActivePage.Controls[n1]).Enabled)
      then
      begin
        if TControl(TfrmBaseDetaylar(ParentForm).pgcContent.ActivePage.Controls[n1]).ClassType = TStringGrid then
        begin
          Result := TStringGrid(TControl(TfrmBaseDetaylar(ParentForm).pgcContent.ActivePage.Controls[n1]));
          Break;
        end;
      end;
    end;
  end;

  if Result = nil then
    raise Exception.Create('StringGrid not found');
end;

procedure TfrmBaseInputDetay.btnSpinDownClick(Sender: TObject);
var
  vGrid: TStringGrid;
begin
  //ba�l�k sat�r� i�in -1 kullan�l�yor.
  vGrid := getStringGridOnDetailForm;
  if (vGrid.Row < vGrid.RowCount-1) then
  begin
    vGrid.Row := vGrid.Row + 1;
    Table := TTable(vGrid.Objects[0, vGrid.Row+1]);
    RefreshData;
  end;
end;

procedure TfrmBaseInputDetay.btnSpinUpClick(Sender: TObject);
var
  vGrid: TStringGrid;
begin
  //ba�l�k sat�r� i�in -1 kullan�l�yor.
  vGrid := getStringGridOnDetailForm;
  if (vGrid.Row > 0) and (vGrid.RowCount > 1) then
  begin
    vGrid.Row := vGrid.Row - 1;
    Table := TTable(vGrid.Objects[0, vGrid.Row-1]);
    RefreshData;
  end;
end;

procedure TfrmBaseInputDetay.btnCloseClick(Sender: TObject);
begin
  Self.Release;
end;

procedure TfrmBaseInputDetay.btnDeleteClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) then
  begin
    TTableDetailed(TfrmBaseDetaylar(ParentForm).Table).RemoveDetay(Table);
    TfrmBaseDetaylar(ParentForm).RemoveDetay(Table);
    Close();
  end;
end;

procedure TfrmBaseInputDetay.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) then
  begin
    TTableDetailed(TfrmBaseDetaylar(ParentForm).Table).UpdateDetay(Table);
    TfrmBaseDetaylar(ParentForm).UpdateDetay(Table);
  end
  else if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    TTableDetailed(TfrmBaseDetaylar(ParentForm).Table).AddDetay(Table);
    TfrmBaseDetaylar(ParentForm).AddDetay(Table);
  end;
  Close;
end;

procedure TfrmBaseInputDetay.FormCreate(Sender: TObject);
begin
  inherited;

  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;
    btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);

    //TRUE olarak g�nder form ilk a��ld���ndan k���k-b�y�k harf ayar�n� yap.
    SetInputControlProperty(True);
  end
  else
  if FormMode = ifmRewiev then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);
    btnDelete.Caption := TranslateText('DELETE', FrameworkLang.ButtonDelete, LngButton, LngSystem);
  end;
end;

end.