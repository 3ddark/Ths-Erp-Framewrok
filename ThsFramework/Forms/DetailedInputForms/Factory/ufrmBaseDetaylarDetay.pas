unit ufrmBaseDetaylarDetay;

interface

{$I ThsERP.inc}

uses
  Winapi.Windows,
  System.SysUtils, System.Classes, System.Variants,
  System.Rtti, Vcl.Samples.Spin,
  Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Dialogs, Vcl.Menus,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Graphics, Vcl.AppEvnts, Vcl.Grids,
  Data.DB, FireDAC.Stan.Option, FireDAC.Stan.Intf,
  FireDAC.Comp.Client, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,

  Ths.Erp.Helper.Edit,
  Ths.Erp.Helper.Memo,
  Ths.Erp.Helper.ComboBox,

  ufrmBase,
  ufrmBaseInput,
  ufrmBaseDetaylar,

  Ths.Erp.Database.Table,
  Ths.Erp.Database.TableDetailed,
  Ths.Erp.Functions;

type
  TfrmBaseDetaylarDetay = class(TfrmBaseInput)
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
    procedure FormShow(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses

  Ths.Erp.Database.Singleton, Ths.Erp.Constants;

{$R *.dfm}

function TfrmBaseDetaylarDetay.getStringGridOnDetailForm(): TStringGrid;
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

procedure TfrmBaseDetaylarDetay.btnSpinDownClick(Sender: TObject);
var
  vGrid: TStringGrid;
begin
  //baþlýk satýrý için -1 kullanýlýyor.
  vGrid := getStringGridOnDetailForm;
  if (vGrid.Row < vGrid.RowCount-1) then
  begin
    vGrid.Row := vGrid.Row + 1;
    Table := TTable(vGrid.Objects[0, vGrid.Row+1]);
    RefreshData;
  end;
end;

procedure TfrmBaseDetaylarDetay.btnSpinUpClick(Sender: TObject);
var
  vGrid: TStringGrid;
begin
  //baþlýk satýrý için -1 kullanýlýyor.
  vGrid := getStringGridOnDetailForm;
  if (vGrid.Row > 0) and (vGrid.RowCount > 1) then
  begin
    vGrid.Row := vGrid.Row - 1;
    Table := TTable(vGrid.Objects[0, vGrid.Row-1]);
    RefreshData;
  end;
end;

procedure TfrmBaseDetaylarDetay.btnCloseClick(Sender: TObject);
begin
  Self.Release;
end;

procedure TfrmBaseDetaylarDetay.btnDeleteClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) then
  begin
    TTableDetailed(TfrmBaseDetaylar(ParentForm).Table).RemoveDetay(Table);
    TfrmBaseDetaylar(ParentForm).RemoveDetay(Table);
    Close();
  end;
end;

procedure TfrmBaseDetaylarDetay.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate) then
  begin
    TTableDetailed(TfrmBaseDetaylar(ParentForm).Table).UpdateDetay(Table);
    TfrmBaseDetaylar(ParentForm).UpdateDetay(Table);
  end
  else if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    TTableDetailed(TfrmBaseDetaylar(ParentForm).Table).AddDetay( Table.Clone );
    TfrmBaseDetaylar(ParentForm).AddDetay(Table);
  end;
  Close;
end;

procedure TfrmBaseDetaylarDetay.FormCreate(Sender: TObject);
begin
  inherited;

  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;
    btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);

    //TRUE olarak gönder form ilk açýldýðýndan küçük-büyük harf ayarýný yap.
//    SetInputControlProperty(True);
  end
  else
  if (FormMode = ifmRewiev) then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);
    btnDelete.Caption := TranslateText('DELETE', FrameworkLang.ButtonDelete, LngButton, LngSystem);
  end
  else
  if (FormMode = ifmUpdate) then
  begin
    btnAccept.Visible := True;
    btnClose.Visible := True;

    btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);
    btnDelete.Caption := TranslateText('DELETE', FrameworkLang.ButtonDelete, LngButton, LngSystem);
  end;
end;

procedure TfrmBaseDetaylarDetay.FormDestroy(Sender: TObject);
begin
  if (FormMode <> ifmRewiev) and (FormMode <> ifmUpdate) then
  begin
    if Assigned(Table) then
      Table.Destroy;
  end;

  btnSpin.Free;
  btnDelete.Free;
  btnAccept.Free;
  btnClose.Free;

  pnlBottom.Free;
  pnlMain.Free;

  frmConfirmation.Free;

//  inherited;
end;

procedure TfrmBaseDetaylarDetay.FormShow(Sender: TObject);
begin
  inherited;
  if (TfrmBaseDetaylar(ParentForm).FormMode = ifmRewiev)
  or (TfrmBaseDetaylar(ParentForm).FormMode = ifmReadOnly) then
  begin
    btnAccept.Visible := False;
  end
  else
  if (TfrmBaseDetaylar(ParentForm).FormMode = ifmUpdate) then
    btnDelete.Visible := True;
end;

end.
