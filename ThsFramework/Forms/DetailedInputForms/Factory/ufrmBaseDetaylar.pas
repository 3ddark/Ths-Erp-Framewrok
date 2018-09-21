unit ufrmBaseDetaylar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Samples.Spin,
  Vcl.Grids, Vcl.Menus, Data.DB,
  ufrmBase,
  ufrmBaseInputDB,
  Ths.Erp.Constants,
  Ths.Erp.SpecialFunctions,
  Ths.Erp.StrinGrid.Helper,
  Ths.Erp.Database,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table;

type
  TfrmBaseDetaylar = class(TfrmBaseInputDB)
    splLeft: TSplitter;
    splHeader: TSplitter;
    pnlHeader: TPanel;
    pnlContent: TPanel;
    pnlLeft: TPanel;
    pgcContent: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    strngrd2: TStringGrid;
    strngrd3: TStringGrid;
    pm1: TPopupMenu;
    pnl1: TPanel;
    grpGenelToplamKalan: TGroupBox;
    grpGenelToplam: TGroupBox;
    flwpnl1: TFlowPanel;
    btnAddDetail: TButton;
    btnConvert: TButton;
    btnSelectContent: TButton;
    pnl2: TPanel;
    flwpnl2: TFlowPanel;
    pnl3: TPanel;
    flwpnl3: TFlowPanel;
    mniExportExcel1: TMenuItem;
    mniPrint1: TMenuItem;
    pm2: TPopupMenu;
    mniExportExcel2: TMenuItem;
    mniPrint2: TMenuItem;
    pm3: TPopupMenu;
    mniExportExcel3: TMenuItem;
    mniPrint3: TMenuItem;
    lblToplamTutar: TLabel;
    lblValToplamTutar: TLabel;
    lblToplamIskontoTutar: TLabel;
    lblValToplamIskontoTutar: TLabel;
    lblAraToplam: TLabel;
    lblValAraToplam: TLabel;
    lblToplamKDVTutar: TLabel;
    lblValToplamKDVTutar: TLabel;
    lblToplamGenelIskontoTutar: TLabel;
    lblValToplamGenelIskontoTutar: TLabel;
    lblTevkifatTutar: TLabel;
    lblValTevkifatTutar: TLabel;
    lblGenelToplam: TLabel;
    lblValGenelToplam: TLabel;
    lblToplamTutarKalan: TLabel;
    lblValToplamTutarKalan: TLabel;
    lblToplamIskontoTutarKalan: TLabel;
    lblValToplamIskontoTutarKalan: TLabel;
    lblAraToplamKalan: TLabel;
    lblValAraToplamKalan: TLabel;
    lblToplamKDVTutarKalan: TLabel;
    lblValToplamKDVTutarKalan: TLabel;
    lblToplamGenelIskontoTutarKalan: TLabel;
    lblValToplamGenelIskontoTutarKalan: TLabel;
    lblTevkifatTutarKalan: TLabel;
    lblValTevkifatTutarKalan: TLabel;
    lblGenelToplamKalan: TLabel;
    lblValGenelToplamKalan: TLabel;
    strngrd1: TStringGrid;
    pgcHeader: TPageControl;
    tsHeader: TTabSheet;
    tsHeaderDiger: TTabSheet;
    btnHeaderShowHide: TButton;
    procedure btnAddDetailClick(Sender: TObject);
    procedure btnAcceptClick(Sender: TObject); override;
    procedure btnDeleteClick(Sender: TObject); override;
    procedure btnHeaderShowHideClick(Sender: TObject);
    procedure strngrd1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    FHeaderFormMode: TInputFormMod;
  protected
    procedure GridReset(); virtual;
    procedure GridFill(); virtual;
  public
    constructor Create(AOwner: TComponent; pParentForm: TForm=nil;
        pTable: TTable=nil; pIsPermissionControl: Boolean=False;
        pFormMode: TInputFormMod=ifmNone;
        pFormOndalikMode: TFormOndalikMod=fomNormal);override;

    function CreateDetailInputForm(pFormMode: TInputFormMod): TForm; virtual;

    procedure ClearTotalLabels;

    procedure AddDetay(pDetay: TTable);virtual;
    procedure RemoveDetay(pDetay: TTable);virtual;
    procedure UpdateDetay(pDetay: TTable);virtual;

    procedure GridIncRow(pGrid: TStringGrid; pCount: Integer = 1);
    procedure GridDecRow(pGrid: TStringGrid; pCount: Integer = 1);
    procedure GridDelRow(pGrid: TStringGrid; pRowNo: Integer);
    procedure GridClearRowsByRowNo(pGrid: TStringGrid; pRowNo: Integer);
    procedure GridHideCol(pGrid: TStringGrid; pColNo: Integer);
    procedure GridColWidth(pGrid: TStringGrid; pColWidth, pColNo: Integer);
    procedure GridAddColTitle(pGrid: TStringGrid; pTitle: string; pColNo: Integer; pRowNo: Integer = 0);
    procedure GridAddRow(pGrid: TStringGrid; pTable: TTAble = nil); virtual;
    procedure GridAddCell(pGrid: TStringGrid; pC, pR: Integer; pVal: string;
        pCellProp: TThsCellStyle = nil; pObj: TObject = nil); virtual;

    property HeaderFormMode: TInputFormMod read FHeaderFormMode write FHeaderFormMode;
  published
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
    procedure FormDestroy(Sender: TObject); override;
  end;

implementation

uses
  ufrmBaseDBGrid;

{$R *.dfm}

{ TfrmBaseDetaylar }

procedure TfrmBaseDetaylar.btnAcceptClick(Sender: TObject);
var
  id, nIndex : integer;
begin
  id := 0;
  if (FormMode = ifmNewRecord) or (FormMode = ifmCopyNewRecord) then
  begin
    if (Table.Database.TranscationIsStarted) then
    begin
      if (Table.LogicalInsert(id, (not Table.Database.TranscationIsStarted), WithCommitTransaction, False)) then
      begin
        if (Self.ParentForm <> nil) then//and (Self.ParentForm.Name = 'frmBaseDBGrid') then
        begin
          TfrmBaseDBGrid(Self.ParentForm).Table.Id.Value := id;
          TfrmBaseDBGrid(Self.ParentForm).RefreshData;
        end;
        ModalResult := mrOK;

        Close;
      end
      else
      begin
        ModalResult := mrNone;//hata durumunda pencere kapanmasýn

        //eðer begin transaction demiyosa insert pencere kapansýn çünkü rollback yapýld artýk insert etmemeli
        //önceki iþlemler geri alýndýðý için
        if (Table.Database.TranscationIsStarted) then
          Close;
        Table.Database.Connection.StartTransaction;
      end;
    end
//      else
//      begin
//        raise Exception.Create(GetTextFromLang('There is an active transaction. Complete it first!', FrameworkLang.WarningActiveTransaction, LngWarning, LngSystem));
//      end;
  end
  else
  if (FormMode = ifmUpdate) then
  begin
    if CustomMsgDlg(
      TranslateText('Are you sure you want to update record?', FrameworkLang.MessageUpdateRecord, LngMessage, LngSystem),
      mtConfirmation, mbYesNo, [TranslateText('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                                TranslateText('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                                TranslateText('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
    then
    begin
      //Burada yeni kayýt veya güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
      SetControlsDisabledOrEnabled(pnlMain, True);

      if (Table.LogicalUpdate(WithCommitTransaction, True)) then
      begin
        ModalResult := mrOK;
        Close;
      end
      else
      begin

        ModalResult := mrNone;
        btnSpin.Visible := true;
        FormMode := ifmRewiev;
        btnAccept.Caption := TranslateText(btnAccept.Caption, FrameworkLang.ButtonUpdate, LngButton, LngSystem);
        btnDelete.Visible := false;
        Repaint;
      end;

    end;
  end
  else if (FormMode = ifmRewiev) then
  begin
    //burada güncelleme modunda olduðu için bütün kontrolleri açmak gerekiyor.
    SetControlsDisabledOrEnabled(pnlMain, False);

    //inceleme modundan güncelleme moduna geçtiði için kontrollerin zorunlu alan ve max length bilgilerini set et
    //False olarak gönder form ilk açýldýðýndan küçük-büyük harf ayarýný yap. Sonrasýnda tekrar bozma
    SetInputControlProperty(False);

    if (not table.Database.TranscationIsStarted) then
    begin
      try
        //kayýt kilitle, eðer baþka kullanýcý tarfýndan bu esnada silinmemiþse
        if (Table.LogicalSelect(DefaultSelectFilter, True, ( not Table.Database.TranscationIsStarted), True)) then
        begin
          //eðer aranan kayýt baþka bir kullanýcý tarafýndan silinmiþse count 0 kalýr
          if (Table.List.Count = 1) then
          begin
            //detaylý tablelar listeye dolduruyo içeriðini
            //Table := TTable(Table.List[0]).Clone;
          end
          else
          if (Table.List.Count = 0) then
          begin
            raise Exception.Create(
              TranslateText('The record was deleted by another user while you were on the review screen.', FrameworkLang.ErrorRecordDeleted, LngError, LngSystem) +
              AddLBs(2) +
              TranslateText('Check the current records again!', FrameworkLang.ErrorRecordDeletedMessage, LngError, LngSystem)
            );
          end;

          RefreshData;
          btnSpin.Visible := false;
          FormMode := ifmUpdate;
          btnAccept.Caption := TranslateText('CONFIRM', FrameworkLang.ButtonAccept, LngButton, LngSystem);
          btnDelete.Visible := True;

          if Table.IsAuthorized(ptUpdate, True, False) then
            btnAccept.Enabled := True
          else
            btnAccept.Enabled := False;

          Repaint;

          //burada varsa ilk komponent setfocus yapýlmalý
          for nIndex := 0 to pnlMain.ControlCount-1 do
          begin
            if TControl(pnlMain.Controls[nIndex]) is TWinControl then
            begin
              TWinControl(pnlMain.Controls[nIndex]).SetFocus;
              break;
            end;
          end;

          btnDelete.Left := btnAccept.Left-btnDelete.Width;
        end;
      except

      end;
    end
    else
    begin
      CustomMsgDlg(TranslateText('There is an active transaction. Complete it first!', FrameworkLang.WarningActiveTransaction, LngWarning, LngSystem),
        mtError, [mbOK], [TranslateText('Tamam', FrameworkLang.ButtonOK, LngButton, LngSystem)], mbOK, '');
    end;

  end;
end;

procedure TfrmBaseDetaylar.btnAddDetailClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) or (FormMode = ifmCopyNewRecord) then
  begin
    CreateDetailInputForm(FormMode);
  end;
end;

procedure TfrmBaseDetaylar.btnDeleteClick(Sender: TObject);
begin
  if (FormMode = ifmUpdate)then
  begin
    if CustomMsgDlg(
      TranslateText('Are you sure you want to delete record?', FrameworkLang.MessageDeleteRecord, LngMessage, LngSystem),
      mtConfirmation, mbYesNo, [TranslateText('Yes', FrameworkLang.GeneralYesLower, LngGeneral, LngSystem),
                                TranslateText('No', FrameworkLang.GeneralNoLower, LngGeneral, LngSystem)], mbNo,
                                TranslateText('Confirmation', FrameworkLang.GeneralConfirmationLower, LngGeneral, LngSystem)) = mrYes
    then
    begin
      if (Table.LogicalDelete(True, False)) then
      begin
        ModalResult := mrOK;
        Close;

        TfrmBaseDBGrid(ParentForm).Table.DataSource.DataSet.Refresh;
        //Table.DataSource.DataSet.Refresh;
      end
      else
      begin
        ModalResult := mrNone;
        FormMode := ifmRewiev;
        btnSpin.Visible := True;
        btnDelete.Visible := False;
        btnAccept.Caption := TranslateText('UPDATE', FrameworkLang.ButtonUpdate, LngButton, LngSystem);

        Repaint;
      end;
    end;
  end;
end;

procedure TfrmBaseDetaylar.btnHeaderShowHideClick(Sender: TObject);
begin
  pnlHeader.Visible := not pnlHeader.Visible;
  if pnlHeader.Visible then
    btnHeaderShowHide.Caption := 'Minimize'
  else
    btnHeaderShowHide.Caption := 'Maximize';
  //set max visible control top + height + 4 on the active tabsheet
  //change active tab sheet resize header panel the max visible control top + height + 4 on the active tabsheet
end;

procedure TfrmBaseDetaylar.ClearTotalLabels;
begin
  lblValToplamTutar.Caption := '';
  lblValToplamIskontoTutar.Caption := '';
  lblValAraToplam.Caption := '';
  lblValToplamKDVTutar.Caption := '';
  lblValToplamGenelIskontoTutar.Caption := '';
  lblValTevkifatTutar.Caption := '';
  lblValGenelToplam.Caption := '';

  lblValToplamTutarKalan.Caption := '';
  lblValToplamIskontoTutarKalan.Caption := '';
  lblValAraToplamKalan.Caption := '';
  lblValToplamKDVTutarKalan.Caption := '';
  lblValToplamGenelIskontoTutarKalan.Caption := '';
  lblValTevkifatTutarKalan.Caption := '';
  lblValGenelToplamKalan.Caption := '';
end;

constructor TfrmBaseDetaylar.Create(AOwner: TComponent; pParentForm: TForm;
  pTable: TTable; pIsPermissionControl: Boolean; pFormMode: TInputFormMod;
  pFormOndalikMode: TFormOndalikMod);
begin
  inherited;

end;

function TfrmBaseDetaylar.CreateDetailInputForm(
  pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
end;

procedure TfrmBaseDetaylar.FormCreate(Sender: TObject);
begin
  inherited;
  pnlLeft.Visible := False;
  splLeft.Visible := False;
  btnHeaderShowHide.Caption := 'Minimize';
  tsHeaderDiger.TabVisible := False;

  ts2.TabVisible := False;
  ts3.TabVisible := False;
  btnAddDetail.Visible := False;
  btnConvert.Visible := False;
  btnSelectContent.Visible := False;

  ClearTotalLabels;
  grpGenelToplamKalan.Visible := False;
  grpGenelToplam.Visible := False;

  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) or (FormMode = ifmCopyNewRecord) then
  begin
    btnAddDetail.Visible := True;
    btnAddDetail.Enabled := True;
  end
  else
  if (FormMode = ifmNone) or (FormMode = ifmRewiev) or (FormMode = ifmReadOnly) then
  begin
    btnAddDetail.Enabled := False;
  end;
end;

procedure TfrmBaseDetaylar.FormDestroy(Sender: TObject);
begin
  inherited;

end;

procedure TfrmBaseDetaylar.FormShow(Sender: TObject);
begin
  inherited;

  if (FormMode <> ifmNewRecord ) then
    RefreshData;
end;

procedure TfrmBaseDetaylar.GridAddCell(pGrid: TStringGrid; pC, pR: Integer;
  pVal: string; pCellProp: TThsCellStyle; pObj: TObject);
begin
//  if Assigned(pObj) then
//    FGridRowStyle.RowObject := TTable(pObj);

//  if Assigned(pCellProp) then
//    pGrid.Objects[pC, pR] := pCellProp
//  else
//    pGrid.Objects[pC, pR] := pCellProp;
//
//  pGrid.Cells[pC, pR] := pVal;
end;

procedure TfrmBaseDetaylar.GridAddColTitle(pGrid: TStringGrid; pTitle: string;
  pColNo, pRowNo: Integer);
begin
//  pGrid.Cells[pColNo, pRowNo] := pTitle;
end;

procedure TfrmBaseDetaylar.GridAddRow(pGrid: TStringGrid; pTable: TTAble);
begin
//  with pGrid do
//  begin
//    if pTable <> nil then
//      FGridRow.FRowObject := pTable.Clone;
//    Objects[pGrid.Col, pGrid.Row] := FGridRow;
//  end;
end;

procedure TfrmBaseDetaylar.GridClearRowsByRowNo(pGrid: TStringGrid;
  pRowNo: Integer);
var
  n1: Integer;
begin
  for n1 := 0 to pGrid.ColCount-1 do
  begin
    pGrid.Cells[n1, pRowNo] := '';
    if n1 = 0 then
    begin
      if Assigned(pGrid.Objects[n1, pRowNo]) then
        pGrid.Objects[n1, pRowNo].Destroy;
    end;
  end;
end;

procedure TfrmBaseDetaylar.GridColWidth(pGrid: TStringGrid; pColWidth,
  pColNo: Integer);
begin
  pGrid.ColWidths[pColNo] := pColWidth;
end;

procedure TfrmBaseDetaylar.GridDecRow(pGrid: TStringGrid; pCount: Integer);
begin
  pGrid.RowCount := pGrid.RowCount - pCount;
end;

procedure TfrmBaseDetaylar.GridDelRow(pGrid: TStringGrid; pRowNo: Integer);
var
  n1: Integer;
begin
  pGrid.Invalidate;
  for n1 := pRowNo to pGrid.RowCount - 2 do
    pGrid.Rows[n1].Assign(pGrid.Rows[n1 + 1]);
  pGrid.RowCount := pGrid.RowCount - 1;
end;

procedure TfrmBaseDetaylar.GridFill;
//var
//  n1: Integer;
begin
//  for n1 := 0 to Length(FGridHeaderRows.Rows)-1 do
//    strngrd1.Objects[COL_OBJ, FGridHeaderRows.Rows[n1]] := FGridHeaderRows.CellStyle;
end;

procedure TfrmBaseDetaylar.GridHideCol(pGrid: TStringGrid; pColNo: Integer);
begin
  pGrid.ColWidths[pColNo] := -1;
end;

procedure TfrmBaseDetaylar.GridIncRow(pGrid: TStringGrid; pCount: Integer);
begin
  pGrid.RowCount := pGrid.RowCount + pCount;
  pGrid.Row := pGrid.Row + pCount;
end;

procedure TfrmBaseDetaylar.GridReset;
begin
  strngrd1.RowCount := 2;
  strngrd1.ColCount := 2;

  strngrd1.FixedCols := 1;
  strngrd1.FixedRows := 1;

  //use for row numbers
  strngrd1.ColWidths[0] := 30;
end;

procedure TfrmBaseDetaylar.strngrd1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  vTextWidth, vTextHeight, vTop, vLeft: Integer;
  vValue: string;
begin
  inherited;
  if Sender is TStringGrid then
  begin
    with Sender as TStringGrid do
    begin
      DoubleBuffered := True;
      vLeft := Rect.Left;

      //header draw
//      if  (Length(GridHeaderRows.Rows) > 0)
//      and (TSpecialFunctions.CheckIntegerInArray(GridHeaderRows.Rows, ARow)) then
      begin
        if Assigned(Objects[COL_OBJ, ARow]) then
        begin
          if (TObject(Objects[COL_OBJ, ARow]).ClassType = TThsCellStyle) then
          begin
            Canvas.Font := TThsCellStyle(Objects[COL_OBJ, ARow]).Font;
            Canvas.Brush.Color := TThsCellStyle(Objects[COL_OBJ, ARow]).BGColor;
            Rect.Left := Rect.Left - 4;
            Canvas.FillRect(Rect);

            vValue := Cells[ACol, ARow];
            vTextWidth := Canvas.TextWidth(vValue);
            vTextHeight := Canvas.TextHeight(vValue);
            vTop := (Rect.Height- vTextHeight) div 2;
            vTop := Rect.Top + vTop;

            if TThsCellStyle(Objects[COL_OBJ, ARow]).TextAlign = taLeftJustify then
              vLeft := Rect.Left
            else if TThsCellStyle(Objects[COL_OBJ, ARow]).TextAlign = taRightJustify then
              vLeft := Rect.Left + ColWidths[ACol] - vTextWidth - 6
            else if TThsCellStyle(Objects[COL_OBJ, ARow]).TextAlign = taCenter then
              vLeft := Rect.Left + (Rect.Width- vTextWidth) div 2;
            Canvas.TextRect(Rect, vLeft, vTop, vValue);
          end;
        end;
      end;
//      else
      //sub total draw
//      if  (Length(GridSubTotalRows.Rows) > 0)
//      and (TSpecialFunctions.CheckIntegerInArray(GridSubTotalRows.Rows, ARow)) then
      begin

      end;
//      else
      //footer draw
//      if  (Length(GridFooterRows.Rows) > 0)
//      and TSpecialFunctions.CheckIntegerInArray(GridFooterRows.Rows, ARow) then
      begin

      end;
//      else
      begin
        //row draw
//        if Assigned(Objects[ACol, ARow]) then
        begin
//          if Objects[ACol, ARow].ClassType = TThsCellStyle then
          begin

          end;
        end;
      end;

    end;
  end;
end;

procedure TfrmBaseDetaylar.AddDetay(pDetay: TTable);
begin
  //
  GridFill;
end;

procedure TfrmBaseDetaylar.RemoveDetay(pDetay: TTable);
begin
  //
  GridFill;
end;

procedure TfrmBaseDetaylar.UpdateDetay(pDetay: TTable);
begin
  //
  GridFill;
end;

end.
