unit ufrmBaseDBGrid;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, Vcl.Menus, System.Types,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ComCtrls, Math, System.StrUtils, Vcl.Grids,
  Vcl.DBGrids, System.UITypes, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.ImageList,
  Vcl.ImgList, Winapi.Messages,
  AdvObj, BaseGrid, AdvGrid, AdvSprd, tmsAdvGridExcel,
  ufrmBase,
  ufrmBaseOutput,
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table.SysGridColWidth,
  Ths.Erp.Constants, ufrmSysTableLangContent, frxClass, frxDBSet;

type
  TSortType = (stNone, stAsc, stDesc);

type
  THackDBGrid = class(TCustomDBGrid)
  protected
  end;

  TColColor = record
    FieldName: string;
    MinValue: Double;
    MinColor: Integer;
    MaxValue: Double;
    MaxColor: Integer;
    EqualColor: Integer;
  end;

  TColPercent = record
    FieldName: string;
    MaxValue: Double;
    ColorBar: Integer;
    ColorBarBack: Integer;
    ColorBarText: Integer;
    ColorBarTextActive: Integer;
  end;

type
  TValLowHigh = (vlLow, vlHigh, vlEqual);

type
  TfrmBaseDBGrid = class(TfrmBaseOutput)
    pnlButtons: TPanel;
    flwpnlLeft: TFlowPanel;
    flwpnlRight: TFlowPanel;
    dbgrdBase: TDBGrid;
    mniExportExcel: TMenuItem;
    mniPreview: TMenuItem;
    mniPrint: TMenuItem;
    mniSeperator1: TMenuItem;
    mniSeperator2: TMenuItem;
    mniRemoveSort: TMenuItem;
    imgFilterRemove: TImage;
    btnAddNew: TButton;
    mniFilter: TMenuItem;
    mniRemoveFilter: TMenuItem;
    mniSeperator3: TMenuItem;
    mniCopyRecord: TMenuItem;
    mniAddLanguageData: TMenuItem;
    mniExcludeFilter: TMenuItem;
    mniExportExcelAll: TMenuItem;
    mniAddLanguageContent: TMenuItem;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure mniPreviewClick(Sender: TObject);
    procedure mniExportExcelClick(Sender: TObject);
    procedure mniPrintClick(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure FormResize(Sender: TObject);override;
    procedure ResizeForm();virtual;
    function ResizeDBGrid(Sender: TObject):Integer;virtual;
    procedure btnSpinUpClick(Sender: TObject);override;
    procedure btnSpinDownClick(Sender: TObject);override;
    procedure dbgrdBaseCellClick(Column: TColumn);
    procedure dbgrdBaseDblClick(Sender: TObject);
    procedure dbgrdBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);virtual;
    procedure DataSourceDataChange(Sender: TObject; Field: TField);virtual;
    procedure FormDestroy(Sender: TObject);override;
    procedure FormPaint(Sender: TObject);override;
    procedure FormKeyPress(Sender: TObject; var Key: Char);override;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);override;
    procedure dbgrdBaseDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgrdBaseColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure dbgrdBaseTitleClick(Column: TColumn);
    procedure mniRemoveSortClick(Sender: TObject);
    procedure dbgrdBaseDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure dbgrdBaseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgrdBaseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgrdBaseMouseLeave(Sender: TObject);
    procedure dbgrdBaseExit(Sender: TObject);
    procedure imgFilterRemoveClick(Sender: TObject);
    procedure dbgrdBaseKeyPress(Sender: TObject; var Key: Char);
    procedure mniFilterClick(Sender: TObject);
    procedure mniRemoveFilterClick(Sender: TObject);
    procedure WriteRecordCount(pCount: Integer);
    procedure mniCopyRecordClick(Sender: TObject);virtual;
    procedure mniAddLanguageDataClick(Sender: TObject);
    procedure mniExcludeFilterClick(Sender: TObject);
    procedure mniExportExcelAllClick(Sender: TObject);
    procedure mniAddLanguageContentClick(Sender: TObject);
    procedure SetTitleFromLangContent();
  private
    FarRenkliYuzdeColNames: TArray<TColPercent>;
    FYuzdeMaxVal: Integer;
    FColorHigh: TColor;
    FColorLow: TColor;
    FColorEqual: TColor;

    FarRenkliRakamColNames: TArray<TColColor>;
    FColorBar: TColor;
    FColorBarBack: TColor;
    FColorBarText: TColor;
    FColorBarTextActive: TColor;

    function IsYuzdeCizimAlaniVar(pFieldName: string): Boolean;
    function IsRenkliRakamVar(pFieldName: string): Boolean;

    procedure TransferToExcel(pOnlyVisibleCols: Boolean = True);
  protected
    FQueryDefaultFilter, FQueryDefaultOrder, FFilterGrid: String;

    FShowHideColumns: Boolean;

    function CreateInputForm(pFormMode: TInputFormMod):TForm;virtual;
  public
    property arRenkliYuzdeColNames: TArray<TColPercent> read FarRenkliYuzdeColNames write FarRenkliYuzdeColNames;
    property YuzdeMaxVal: Integer read FYuzdeMaxVal write FYuzdeMaxVal;
    property ColorBar: TColor read FColorBar write FColorBar;
    property ColorBarBack: TColor read FColorBarBack write FColorBarBack;
    property ColorBarText: TColor read FColorBarText write FColorBarText;
    property ColorBarTextActive: TColor read FColorBarTextActive write FColorBarTextActive;

    property arRenkliRakamColNames: TArray<TColColor> read FarRenkliRakamColNames write FarRenkliRakamColNames;
    property ColorHigh: TColor read FColorHigh write FColorHigh;
    property ColorLow: TColor read FColorLow write FColorLow;
    property ColorEqual: TColor read FColorEqual write FColorEqual;
    function GetLowHighEqual(pField: TField; pDefaultColor: TColor): Integer;virtual;
    function GetPercentMaxVal(pField: TField): Double;virtual;

    property ShowHideColumns: Boolean read FShowHideColumns write FShowHideColumns;
    property QueryDefaultFilter: string read FQueryDefaultFilter write FQueryDefaultFilter;
    property QueryDefaultOrder: string read FQueryDefaultOrder write FQueryDefaultOrder;
    property FilterGrid: string read FFilterGrid write FFilterGrid;

    procedure RefreshDataFirst();
    procedure RefreshData();
    procedure RefreshGrid();virtual;

    procedure ShowInputForm(pFormType: TInputFormMod); virtual;
    procedure SetSelectedItem();virtual;
    procedure MoveUp();virtual;
    procedure MoveDown();virtual;

    function GetFieldByFieldName(pFieldName: string; pGridColumns: TDBGridColumns): TField;
    procedure SetColWidth(pFieldName: string; pWidth: Integer);
    procedure SetColVisible(pFieldName: string; pVisible: Boolean);

    procedure drawTriangleInRect(r: TRect; st: TSortType; al: TAlignment);
  published
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);override;
    procedure stbBaseDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect); override;
    procedure WmAfterShow(var Msg: TMessage); message WM_AFTER_SHOW;
  end;

implementation

uses
  ufrmFilterDBGrid,
  mORMotReport,
  Ths.Erp.Database,
  Ths.Erp.SpecialFunctions,
  Ths.Erp.Database.Table.SysGridColColor,
  Ths.Erp.Database.Table.SysGridColPercent,
  Ths.Erp.Database.Table.SysQualityFormNumber,
  Ths.Erp.Database.Table.SysTableLangContent,
  Ths.Erp.Database.Table.SysLangContents,
  ufrmSysLangContent;

{$R *.dfm}

procedure TfrmBaseDBGrid.drawTriangleInRect(r: TRect; st: TSortType; al: TAlignment);
const
  OFFSET=2;
var
  goLeft: integer;
begin
  //if IsRightToLeft then
  begin
    if al = taLeftJustify then
      goLeft := 0
    else
      goLeft := r.Right - r.Left - 17;
  end;

  // draw triangle
  dbgrdBase.Canvas.Brush.Color := clRed;
  dbgrdBase.Canvas.Pen.Color := clRed;
  if st = stAsc then
    dbgrdBase.Canvas.Polygon([point(r.Right - 2 - goLeft, r.top + 10),
      point(r.Right - 7 - goLeft, r.top + 5), point(r.Right - 12 - goLeft, r.top + 10)])

  else if st = stDesc then
    dbgrdBase.Canvas.Polygon([point(r.Right - 2 - goLeft, r.top + 5),
      point(r.Right - 7 - goLeft, r.top + 10), point(r.Right - 12 - goLeft, r.top + 5)]);
end;

procedure TfrmBaseDBGrid.btnAddNewClick(Sender: TObject);
begin
  ShowInputForm(ifmNewRecord);
end;

procedure TfrmBaseDBGrid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.FormCreate(Sender: TObject);
begin
  inherited;

  TSingletonDB.GetInstance.HaneMiktari.SelectToList('', False, False);

  stbBase.Panels.Delete(STATUS_KEY_F7);
  stbBase.Panels.Delete(STATUS_KEY_F6);
  stbBase.Panels.Delete(STATUS_KEY_F5);
  stbBase.Panels.Delete(STATUS_KEY_F4);
  stbBase.Panels.Delete(STATUS_USERNAME);
  stbBase.Panels.Delete(STATUS_EX_RATE_EUR);

  pnlBottom.Visible := False;
  stbBase.Visible := True;
  pnlBottom.Visible := True;

  dbgrdBase.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack];

  FShowHideColumns := False;

  dbgrdBase.DataSource := Table.DataSource;

  btnAddNew.Visible := True;
  btnAddNew.Caption := GetTextFromLang('ADD RECORD', FrameworkLang.ButtonAdd, LngButton, LngSystem);


  QueryDefaultFilter := TSingletonDB.GetInstance.GetGridDefaultOrderFilter( ReplaceRealColOrTableNameTo(Table.TableName), False);
  QueryDefaultOrder := TSingletonDB.GetInstance.GetGridDefaultOrderFilter( ReplaceRealColOrTableNameTo(Table.TableName), True);

  //ilk açýlýþta veri tabanýndan kayýtlarý getirmek için RefreshDataFirst çaðýr
  //daha sonraki iþlemlerde sadece query refresh ile update yapacaðýz
  //buda iþlemlerin hazlanmasý için gerekli bir adým.
  //Her zaman db den select yapýnca fazla kolon ve kayýt olduðu durumlarda aþýrý yavaþlamna oluyor
  RefreshDataFirst;

  mniRemoveFilter.Visible := False;
  mniRemoveSort.Visible := False;

  PostMessage(self.Handle, WM_AFTER_CREATE, 0, 0);
end;

procedure TfrmBaseDBGrid.FormDestroy(Sender: TObject);
begin
  SetLength(FarRenkliYuzdeColNames, 0);
  SetLength(FarRenkliRakamColNames, 0);

  while dbgrdBase.Columns.Count > 0 do
    dbgrdBase.Columns[dbgrdBase.Columns.Count-1].Free;

  inherited;
end;

procedure TfrmBaseDBGrid.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then //Enter (Return)
  begin
    if (dbgrdBase.Focused) then
    begin
      Key := 0;
      mniPreview.Click;
    end;
  end
  else
  //CTRL + SHIFT + ALT + T show all columns
  if  (Key = Ord('T')) then
  begin
    if Shift = [ssCtrl, ssShift, ssAlt] then
    begin
      Key := 0;
      FShowHideColumns := not FShowHideColumns;
      RefreshGrid;
      ResizeForm;
    end;
  end
  else
  //CTRL + F key combination show Filter form
  if (Key = Ord('F')) then
  begin
    if Shift = [ssCtrl] then
    begin
      Key := 0;
      TfrmFilterDBGrid.Create(Application, Self).ShowModal;
      if FilterGrid <> '' then
      begin
        RefreshData;
      end;
    end;
  end
  else
  //F7 Key add new record
  if Key = VK_F7 then
  begin
    Key := 0;
    if btnAddNew.Visible and btnAddNew.Enabled then
      btnAddNew.Click;
  end
  else
    inherited;
end;

procedure TfrmBaseDBGrid.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Char(VK_RETURN)) then //Enter (Return)
    Key := #0;

  inherited;
end;

procedure TfrmBaseDBGrid.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.FormPaint(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.btnSpinDownClick(Sender: TObject);
begin
  MoveDown();
end;

procedure TfrmBaseDBGrid.btnSpinUpClick(Sender: TObject);
begin
  MoveUp();
end;

function TfrmBaseDBGrid.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
end;

procedure TfrmBaseDBGrid.DataSourceDataChange(Sender: TObject; Field: TField);
begin
//  WriteRecordCount(Table.DataSource.DataSet.RecordCount);
end;

procedure TfrmBaseDBGrid.dbgrdBaseCellClick(Column: TColumn);
begin
  SetSelectedItem();
end;

procedure TfrmBaseDBGrid.dbgrdBaseColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.dbgrdBaseDblClick(Sender: TObject);
begin
  //if (TCustomDBGridCracker(TDBGrid( Sender)).DataLink.ActiveRecord <> 0) then
  if (Table.DataSource.DataSet.RecordCount <> 0) then
  begin
    SetSelectedItem();
    ShowInputForm(ifmRewiev);
  end;
end;

procedure TfrmBaseDBGrid.dbgrdBaseDrawColumnCell(Sender: TObject;
    const Rect: TRect; DataCol: Integer; Column: TColumn;
    State: TGridDrawState);
const
  CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
  sEMPTY = '';
  chPERCENT = '%';
  SPACE_TO_CENTER_CELLTEXT = 0;
  arrow_size = 4;

var
  nValue, nWidth1, nLeft2: Integer;
  clActualPenColor, clActualBrushColor: TColor;
  bEmptyDS: Boolean;
  DrawRect: TRect;
  sValue: string;

  Bmp: TBitmap;
  AState: TGridDrawState;
begin
  AState := State;
  //Satýrý renklendir.
  if THackDBGrid(dbgrdBase).DataLink.ActiveRecord = THackDBGrid(dbgrdBase).Row - 1 then
    dbgrdBase.Canvas.Brush.Color := $00C4ABCD
  else if dbgrdBase.DataSource.DataSet.RecNo mod 2 = 0 then
    dbgrdBase.Canvas.Brush.Color := $00CAEDC0
  else if dbgrdBase.DataSource.DataSet.RecNo mod 2 = 1 then
    dbgrdBase.Canvas.Brush.Color := $00DFF4D9;

  dbgrdBase.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  //boolean tipler için checkbox çiz
  if (Column.Field.DataType = ftBoolean) then
  begin
    dbgrdBase.Canvas.FillRect(Rect);

    dbgrdBase.Canvas.FillRect(Rect);
    if (VarIsNull(Column.Field.Value)) then
      DrawFrameControl(dbgrdBase.Canvas.Handle, Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE)
    else
      DrawFrameControl(dbgrdBase.Canvas.Handle, Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]);
  end
  else
  if Column.Field is TGraphicField then
  begin
    Bmp := TBitmap.Create;
    try
      Bmp.Assign(Column.Field);
      dbgrdBase.Canvas.StretchDraw(Rect, Bmp);
    finally
      Bmp.Free;
    end
  end
  else
  begin
    if IsYuzdeCizimAlaniVar(Column.FieldName) then
    begin
      begin
        bEmptyDS := ((TDBGrid(Sender).DataSource.DataSet.EoF) and (TDBGrid(Sender).DataSource.DataSet.Bof));

        if (Column.Field.IsNull) then
        begin
          nValue := -1;
          sValue := sEMPTY;
        end
        else
        begin
          nValue := Column.Field.AsInteger;
          sValue := IntToStr(nValue);// + ' ' + chPERCENT;
        end;

        DrawRect := Rect;
        InflateRect(DrawRect, -1, -1);

        nWidth1 := (((DrawRect.Right - DrawRect.Left) * nValue) DIV Trunc(GetPercentMaxVal(Column.Field)) );

        clActualPenColor := TDBGrid(Sender).Canvas.Pen.Color;
        clActualBrushColor := TDBGrid(Sender).Canvas.Brush.Color;

        TDBGrid(Sender).Canvas.Pen.Color := clBlack;
        TDBGrid(Sender).Canvas.Brush.Color := ColorBarBack;
        if THackDBGrid(dbgrdBase).DataLink.ActiveRecord = THackDBGrid(dbgrdBase).Row - 1 then
          TDBGrid(Sender).Canvas.Font.Color := FColorBarTextActive// clActualFontColor
        else
          TDBGrid(Sender).Canvas.Font.Color := FColorBarText;

        TDBGrid(Sender).Canvas.Rectangle(DrawRect);

        if (nValue > 0) then
        begin
          TDBGrid(Sender).Canvas.Pen.Color := ColorBar;
          TDBGrid(Sender).Canvas.Brush.Color := ColorBar;
          DrawRect.Right := DrawRect.Left + nWidth1;
          InflateRect(DrawRect, -1, -1);
          TDBGrid(Sender).Canvas.Rectangle(DrawRect);
        end;

        if not (bEmptyDS) then
        begin
          DrawRect := Rect;
          InflateRect(DrawRect, -2, -2);
          TDBGrid(Sender).Canvas.Brush.Style := bsClear;
          nLeft2 := DrawRect.Left + (DrawRect.Right - DrawRect.Left) shr 1 -
                    (TDBGrid(Sender).Canvas.TextWidth(sValue) shr 1);
          TDBGrid(Sender).Canvas.TextRect(DrawRect, nLeft2, DrawRect.Top + SPACE_TO_CENTER_CELLTEXT, sValue);
        end;

        TDBGrid(Sender).Canvas.Pen.Color := clActualPenColor;
        TDBGrid(Sender).Canvas.Brush.Color := clActualBrushColor;
      end;
    end
    else
    if IsRenkliRakamVar(Column.FieldName) then
    begin
      clActualBrushColor := TDBGrid(Sender).Canvas.Brush.Color;

      TDBGrid(Sender).Canvas.Brush.Color := GetLowHighEqual(Column.Field, TDBGrid(Sender).Canvas.Brush.Color);

      TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
      TDBGrid(Sender).Canvas.Brush.Color := clActualBrushColor;
    end;
  end;


  if  (Column.Visible)
  and (Pos(Column.FieldName, TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames) > 0)
  then
  begin
    sValue := '';
    if Pos(Column.FieldName + ':A', TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames) > 0 then
      sValue := MidStr(
        TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames,
        Pos(Column.FieldName + ':A', TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames),
        Length(Column.FieldName + ':A'))
    else if Pos(Column.FieldName + ':D', TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames) > 0 then
      sValue := MidStr(
        TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames,
        Pos(Column.FieldName + ':D', TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames),
        Length(Column.FieldName + ':D'));

    if Pos(':A', sValue) > 0 then //yukarý yöndeki ok ASC
      drawTriangleInRect(THackDBGrid(dbgrdBase).CellRect(DataCol+1, 0), stAsc, taLeftJustify)
    else if Pos(':D', sValue) > 0 then  //aþaðý yöndeki ok DESC
      drawTriangleInRect(THackDBGrid(dbgrdBase).CellRect(DataCol+1, 0), stDesc, taLeftJustify);
  end;

end;

procedure TfrmBaseDBGrid.dbgrdBaseDrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.dbgrdBaseExit(Sender: TObject);
begin
  inherited;
  dbgrdBase.Repaint;
end;

procedure TfrmBaseDBGrid.dbgrdBaseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //CTRL + DELETE konbinasyonu ile kayýtlarý silmeyi engellemek için yapýldý. Aksi halde kontrol kayýt silme iþlemi yapýlabilir.
  if (Key = VK_DELETE) and (Shift = [ssCtrl]) then
    Key := 0;
end;

procedure TfrmBaseDBGrid.dbgrdBaseKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.dbgrdBaseMouseLeave(Sender: TObject);
begin
  inherited;
  dbgrdBase.Repaint;
end;

procedure TfrmBaseDBGrid.dbgrdBaseMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  dbgrdBase.Repaint;
end;

procedure TfrmBaseDBGrid.dbgrdBaseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  dbgrdBase.Repaint;
end;

procedure TfrmBaseDBGrid.dbgrdBaseTitleClick(Column: TColumn);
var
  sl: TStringList;
  sOrderList: string;
  bOrderedColumn, bIsCTRLKeyPress: Boolean;
  nIndex: Integer;
const
  arrow_size = 4;
begin
  bOrderedColumn := False;
  bIsCTRLKeyPress := False;
  sl := TStringList.Create;
  try
    with TFDQuery(dbgrdBase.DataSource.DataSet) do
    begin
      if TSpecialFunctions.isCtrlDown then
        bIsCTRLKeyPress := True;

      sl.Delimiter := ';';
      if IndexFieldNames <> '' then
        sl.DelimitedText := IndexFieldNames;

      if bIsCTRLKeyPress then
      begin
        //CTRL tuþuna basýlmýþsa
        for nIndex := 0 to sl.Count-1 do
          if (Column.FieldName + ':A' = sl.Strings[nIndex]) or (Column.FieldName + ':D' = sl.Strings[nIndex]) then
            bOrderedColumn := True;

        if bOrderedColumn then
        begin
          //listede zaten varsa ASC DESC deðiþimi yap
          for nIndex := 0 to sl.Count-1 do
          begin
            if (Column.FieldName + ':A' = sl.Strings[nIndex]) then
              sl.Strings[nIndex] := Column.FieldName + ':D'
            else if (Column.FieldName + ':D' = sl.Strings[nIndex]) then
              sl.Strings[nIndex] := Column.FieldName + ':A';
          end;
        end
        else
        begin
          //listede yoksa direkt ASC olarak ekle
          if sl.Count > 0 then
            sl.Add(Column.FieldName + ':A');
        end;
      end
      else
      begin
        //CTRL tuþuna basýlmamýþsa hepsini sil ve direkt olarak ekle
        if sl.Count = 0 then
          sOrderList := Column.FieldName + ':A'
        else
        begin
          for nIndex := 0 to sl.Count-1 do
            if (Column.FieldName + ':A' = sl.Strings[nIndex]) or (Column.FieldName + ':D' = sl.Strings[nIndex]) then
              bOrderedColumn := True;

          if bOrderedColumn then
          begin
            for nIndex := 0 to sl.Count-1 do
            begin
              if (Column.FieldName + ':A' = sl.Strings[nIndex]) then
                sOrderList := Column.FieldName + ':D'
              else if (Column.FieldName + ':D' = sl.Strings[nIndex]) then
                sOrderList := Column.FieldName + ':A';
            end;
          end
          else
            sOrderList := Column.FieldName + ':A';
        end;
        sl.Clear;
        sl.Add(sOrderList);
      end;

      sOrderList := '';

      for nIndex := 0 to sl.Count-1 do
      begin
        sOrderList := sOrderList + sl.Strings[nIndex] + ';';
        if nIndex = sl.Count-1 then
          sOrderList := LeftStr(sOrderList, Length(sOrderList)-1);
      end;

      if sOrderList <> '' then
        mniRemoveSort.Visible := True;

      IndexFieldNames := sOrderList;
    end;

    THackDBGrid(dbgrdBase).InvalidateTitles;

  finally
    sl.Free;
  end;
end;

procedure TfrmBaseDBGrid.FormResize(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.FormShow(Sender: TObject);
var
  vQualityFormNo: string;
  vSysTableLangContent: TSysTableLangContent;
begin
  inherited;

  //Gösterilen Toplam Kayýt Sayýsýný status bara yaz
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
    WriteRecordCount(Table.DataSource.DataSet.RecordCount);

  //Server Adresini status bara yaz
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
    stbBase.Panels.Items[STATUS_DATE].Text := TSingletonDB.GetInstance.DataBase.Connection.Params.Values['Server'];

  //donem bilgsini status bara yaz
  stbBase.Panels.Items[STATUS_EX_RATE_USD].Text := GetTextFromLang('Dönem', FrameworkLang.GeneralPeriod, LngGeneral, LngSystem) + ' ' +
                                                   VarToStr(TSingletonDB.GetInstance.ApplicationSetting.Donem.Value);

  //Form Numarasý status bara yaz
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
  begin
    vQualityFormNo := TSingletonDB.GetInstance.GetQualityFormNo(Table.TableName);
    if vQualityFormNo <> '' then
      stbBase.Panels.Items[STATUS_EX_RATE_EUR].Text := vQualityFormNo
    else
      stbBase.Panels.Items[STATUS_EX_RATE_EUR].Text := '';
  end;




  if Table.IsAuthorized(ptAddRecord, True, False) then
  begin
    btnAddNew.Visible := True;
    btnAddNew.Enabled := True;
    mniCopyRecord.Visible := True;
    mniCopyRecord.Enabled := True;
  end
  else
  begin
    btnAddNew.Enabled := False;
    mniCopyRecord.Visible := False;
    mniCopyRecord.Enabled := False;
  end;
  //her zaman kapalý olsun istenilen formlarda açýlýr.
  mniCopyRecord.Visible := False;


  vSysTableLangContent := TSysTableLangContent.Create(TSingletonDB.GetInstance.DataBase);
  try
    if vSysTableLangContent.IsAuthorized(ptAddRecord, True) then
    begin
      mniAddLanguageData.Visible := True;
      mniAddLanguageData.Enabled := True;
    end
    else
    begin
      mniAddLanguageData.Visible := False;
      mniAddLanguageData.Enabled := False;
    end;
  finally
    vSysTableLangContent.Free;
  end;
  //her zaman kapalý olsun istenilen formlarda açýlýr.
  mniAddLanguageData.Visible := False;



  ResizeForm();

  Self.Caption := GetTextFromLang(Self.Caption, ReplaceRealColOrTableNameTo(Table.TableName), LngOutputFormCaption);
  mniAddLanguageData.Caption := GetTextFromLang(mniAddLanguageData.Caption, FrameworkLang.PopupAddLanguageData, LngPopup, LngSystem);
  mniCopyRecord.Caption := GetTextFromLang(mniCopyRecord.Caption, FrameworkLang.PopupCopyRecord, LngPopup, LngSystem);
  mniExcludeFilter.Caption := GetTextFromLang(mniExcludeFilter.Caption, FrameworkLang.PopupExcludeFilter, LngPopup, LngSystem);
  mniExportExcel.Caption := GetTextFromLang(mniExportExcel.Caption, FrameworkLang.PopupExportExcel, LngPopup, LngSystem);
  mniExportExcelAll.Caption := GetTextFromLang(mniExportExcelAll.Caption, FrameworkLang.PopupExportExcelAll, LngPopup, LngSystem);
  mniFilter.Caption := GetTextFromLang(mniFilter.Caption, FrameworkLang.PopupFilter, LngPopup, LngSystem);
  mniPreview.Caption := GetTextFromLang(mniPreview.Caption, FrameworkLang.PopupPreview, LngPopup, LngSystem);
  mniPrint.Caption := GetTextFromLang(mniPrint.Caption, FrameworkLang.PopupPrint, LngPopup, LngSystem);
  mniRemoveFilter.Caption := GetTextFromLang(mniRemoveFilter.Caption, FrameworkLang.PopupRemoveFilter, LngPopup, LngSystem);
  mniRemoveSort.Caption := GetTextFromLang(mniRemoveSort.Caption, FrameworkLang.PopupRemoveSort, LngPopup, LngSystem);

  PostMessage(Self.Handle, WM_AFTER_SHOW, 0, 0);
end;

function TfrmBaseDBGrid.GetFieldByFieldName(pFieldName: string; pGridColumns: TDBGridColumns): TField;
var
  nIndex: Integer;
begin
  Result := nil;
  if pFieldName <> '' then
  begin
    for nIndex := 0 to pGridColumns.Count-1 do
      if pGridColumns[nIndex].FieldName = pFieldName then
        Result := pGridColumns[nIndex].Field;
  end;
end;

function TfrmBaseDBGrid.GetLowHighEqual(pField: TField; pDefaultColor: TColor): Integer;
var
  n1: Integer;
begin
  Result := pDefaultColor;
  for n1 := 0 to Length(arRenkliRakamColNames) do
  begin
    if pField.FieldName = TColColor(arRenkliRakamColNames[n1]).FieldName then
    begin
      if pField.AsInteger < TColColor(arRenkliRakamColNames[n1]).MinValue then
        Result := TColColor(arRenkliRakamColNames[n1]).MinColor
      else if pField.AsInteger > TColColor(arRenkliRakamColNames[n1]).MaxValue then
        Result := TColColor(arRenkliRakamColNames[n1]).MaxColor;
//      else if pField.AsInteger = TColColor(arRenkliRakamColNames[n1]).MaxValue then
//        Result := TColColor(arRenkliRakamColNames[n1]).EqualColor;
      Break;
    end;
  end;
end;

function TfrmBaseDBGrid.GetPercentMaxVal(pField: TField): Double;
var
  n1: Integer;
begin
  Result := 1;
  for n1 := 0 to Length(arRenkliYuzdeColNames) do
  begin
    if pField.FieldName = TColPercent(arRenkliYuzdeColNames[n1]).FieldName then
    begin
      Result := TColPercent(arRenkliYuzdeColNames[n1]).MaxValue;
      ColorBar := TColPercent(arRenkliYuzdeColNames[n1]).ColorBar;
      ColorBarBack := TColPercent(arRenkliYuzdeColNames[n1]).ColorBarBack;
      ColorBarText := TColPercent(arRenkliYuzdeColNames[n1]).ColorBarText;
      ColorBarTextActive := TColPercent(arRenkliYuzdeColNames[n1]).ColorBarTextActive;
//      if pField.AsInteger < TColColor(arRenkliYuzdeColNames[n1]).MinValue then
//
//      else if pField.AsInteger > TColColor(arRenkliYuzdeColNames[n1]).MaxValue then
//        Result := TColColor(arRenkliYuzdeColNames[n1]).MaxColor
//      else if pField.AsInteger = TColColor(arRenkliYuzdeColNames[n1]).MaxValue then
//        Result := TColColor(arRenkliYuzdeColNames[n1]).EqualColor;
      Break;
    end;
  end;
end;

procedure TfrmBaseDBGrid.imgFilterRemoveClick(Sender: TObject);
begin
  FFilterGrid := '';
  RefreshData;
end;

function TfrmBaseDBGrid.IsRenkliRakamVar(pFieldName: string): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := 0 to Length(arRenkliRakamColNames)-1 do
  begin
    if pFieldName = TColColor(FarRenkliRakamColNames[nIndex]).FieldName then
    begin
      Result := True;
      Break
    end;
  end;
end;

function TfrmBaseDBGrid.IsYuzdeCizimAlaniVar(pFieldName: string): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := 0 to Length(arRenkliYuzdeColNames)-1 do
  begin
    if pFieldName = TColPercent(arRenkliYuzdeColNames[nIndex]).FieldName then
    begin
      Result := True;
      Break
    end;
  end;
end;

procedure TfrmBaseDBGrid.mniCopyRecordClick(Sender: TObject);
begin
  if Table.DataSource.DataSet.RecordCount > 0 then
  begin
    SetSelectedItem;
    ShowInputForm(ifmCopyNewRecord);
  end;
end;

procedure TfrmBaseDBGrid.mniAddLanguageContentClick(Sender: TObject);
var
  vSysLangContent: TSysLangContents;
begin
  vSysLangContent := TSysLangContents.Create(TSingletonDB.GetInstance.DataBase);

  vSysLangContent.Lang.Value := TSingletonDB.GetInstance.DataBase.ConnSetting.Language;
  vSysLangContent.Code.Value := ReplaceRealColOrTableNameTo(dbgrdBase.SelectedField.FieldName);
  vSysLangContent.ContentType.Value := LngGridFieldCaption;
  vSysLangContent.TableName1.Value := ReplaceRealColOrTableNameTo(Table.TableName);
  vSysLangContent.Value.Value := dbgrdBase.Columns.Items[dbgrdBase.SelectedIndex].Title.Caption;

  TfrmSysLangContent.Create(Self, Self, vSysLangContent, True, ifmCopyNewRecord).ShowModal;
  SetTitleFromLangContent();
end;

procedure TfrmBaseDBGrid.mniAddLanguageDataClick(Sender: TObject);
var
  vSysTableLang: TSysTableLangContent;
begin

  vSysTableLang := TSysTableLangContent.Create(TSingletonDB.GetInstance.DataBase);

  vSysTableLang.TableName1.Value := ReplaceRealColOrTableNameTo(Table.TableName);
  vSysTableLang.ColumnName.Value := ReplaceRealColOrTableNameTo(dbgrdBase.SelectedField.FieldName);
  vSysTableLang.RowID.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField(Table.Id.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(Table.Id.FieldName).Value);
  vSysTableLang.Value.Value := GetVarToFormatedValue(dbgrdBase.SelectedField.DataType, dbgrdBase.SelectedField.Value);

  TfrmSysTableLangContent.Create(Application, Self, vSysTableLang, True, ifmCopyNewRecord).Show;
end;

procedure TfrmBaseDBGrid.mniExportExcelAllClick(Sender: TObject);
begin
  TransferToExcel(False);
end;

procedure TfrmBaseDBGrid.mniExportExcelClick(Sender: TObject);
begin
  TransferToExcel();
end;

procedure TfrmBaseDBGrid.mniFilterClick(Sender: TObject);
begin
  if dbgrdBase.DataSource.DataSet.RecordCount > 0 then
  begin
    if FilterGrid = '' then
      FilterGrid := dbgrdBase.SelectedField.FieldName + '=' + QuotedStr(dbgrdBase.SelectedField.Value)
    else
      FilterGrid := FilterGrid + ' and ' + dbgrdBase.SelectedField.FieldName + '=' + QuotedStr(dbgrdBase.SelectedField.Value);
    RefreshData
  end;
end;

procedure TfrmBaseDBGrid.mniExcludeFilterClick(Sender: TObject);
begin
  if dbgrdBase.DataSource.DataSet.RecordCount > 0 then
  begin
    if FilterGrid = '' then
      FilterGrid := dbgrdBase.SelectedField.FieldName + '<>' + QuotedStr(dbgrdBase.SelectedField.Value)
    else
      FilterGrid := FilterGrid + ' and ' + dbgrdBase.SelectedField.FieldName + '<>' + QuotedStr(dbgrdBase.SelectedField.Value);
    RefreshData
  end;
end;

procedure TfrmBaseDBGrid.mniPreviewClick(Sender: TObject);
begin
  dbgrdBaseDblClick(dbgrdBase);
end;

procedure TfrmBaseDBGrid.mniRemoveSortClick(Sender: TObject);
begin
  if mniRemoveSort.Visible then
  begin
    TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames := '';
    if TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames = '' then
      mniRemoveSort.Visible := False;
  end;
end;

procedure TfrmBaseDBGrid.mniPrintClick(Sender: TObject);
begin
  //ShowMessage('Prepare a Print Form');
end;

procedure TfrmBaseDBGrid.MoveDown;
begin
  Table.DataSource.DataSet.Prior;
  SetSelectedItem();
end;

procedure TfrmBaseDBGrid.MoveUp;
begin
  Table.DataSource.DataSet.Next;
  SetSelectedItem();
end;

procedure TfrmBaseDBGrid.RefreshData;
begin
  Table.DataSource.DataSet.Refresh;

  if Table.Id.Value > 0 then
    dbgrdBase.DataSource.DataSet.Locate(Table.Id.FieldName, Table.Id.Value,[]);

  if FFilterGrid <> '' then
  begin
    dbgrdBase.DataSource.DataSet.Filter := FFilterGrid;
    dbgrdBase.DataSource.DataSet.Filtered := True;

    il32x32.GetBitmap(IMG_DOWN, imgFilterRemove.Picture.Bitmap);
    imgFilterRemove.Visible := True;
  end
  else
  begin
    dbgrdBase.DataSource.DataSet.Filtered := False;
    dbgrdBase.DataSource.DataSet.Filter := '';
    imgFilterRemove.Visible := False;
  end;

  if dbgrdBase.DataSource.DataSet.Filter = '' then
    mniRemoveFilter.Visible := False
  else
    mniRemoveFilter.Visible := True;

  RefreshGrid();
end;

procedure TfrmBaseDBGrid.RefreshDataFirst();
var
  nIndex: Integer;
  vGridColColor: TSysGridColColor;
  vGridColPercent: TSysGridColPercent;
  vGridColWidth: TSysGridColWidth;
  col_color: TColColor;
  col_percent: TColPercent;
  n1, vHaneSayisi: Integer;

  procedure AddColumn(pField: TField; pVisible: Boolean=False);
  begin
    with dbgrdBase.Columns.Add do
    begin
      FieldName := pField.FieldName;
      Title.Caption := pField.DisplayName;
      //Title.Caption := GetTextFromLang(Title.Caption, ReplaceRealColOrTableNameTo(FieldName), LngGridFieldCaption, ReplaceRealColOrTableNameTo(Table.TableName));
      Title.Color := clBlack;
      Title.Font.Color := clBlack;
      Title.Font.Style := [fsBold];
      Title.Alignment := TAlignment.taCenter;
      Visible := pVisible;
    end;
  end;
begin
  Table.DataSource.OnDataChange := DataSourceDataChange;
  FQueryDefaultFilter := ' ' + Trim(FQueryDefaultFilter);

  FQueryDefaultOrder := Trim(FQueryDefaultOrder);
  if FQueryDefaultOrder <> '' then
    FQueryDefaultOrder := ' ORDER BY ' + Trim(FQueryDefaultOrder);
  Table.SelectToDatasource(FQueryDefaultFilter + FQueryDefaultOrder, True);

  if Table.Id.Value > 0 then
    dbgrdBase.DataSource.DataSet.Locate(Table.Id.FieldName, Table.Id.Value,[]);


  //todo yüzdeli olarak renklendirme iþlemini yap
  vGridColPercent := TSysGridColPercent.Create(Table.Database);
  try
    SetLength(FarRenkliYuzdeColNames, Table.DataSource.DataSet.FieldCount);
    for nIndex := 0 to Length(FarRenkliYuzdeColNames)-1 do
    begin
      col_percent.FieldName := '';
      col_percent.MaxValue := 0;
      col_percent.ColorBar := 0;
      col_percent.ColorBarBack := 0;
      col_percent.ColorBarText := 0;
      col_percent.ColorBarTextActive := 0;

      FarRenkliYuzdeColNames[nIndex] := col_percent;
    end;

    vGridColPercent.SelectToList(' and table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(Table.TableName)), False, False);
    for nIndex := 0 to vGridColPercent.List.Count-1 do
    begin
      col_percent.FieldName := ReplaceToRealColOrTableName(TSysGridColPercent(vGridColPercent.List[nIndex]).ColumnName.Value);
      col_percent.MaxValue := TSysGridColPercent(vGridColPercent.List[nIndex]).MaxValue.Value;
      col_percent.ColorBar := TSysGridColPercent(vGridColPercent.List[nIndex]).ColorBar.Value;
      col_percent.ColorBarBack := TSysGridColPercent(vGridColPercent.List[nIndex]).ColorBarBack.Value;
      col_percent.ColorBarText := TSysGridColPercent(vGridColPercent.List[nIndex]).ColorBarText.Value;
      col_percent.ColorBarTextActive := TSysGridColPercent(vGridColPercent.List[nIndex]).ColorBarTextActive.Value;

      FarRenkliYuzdeColNames[nIndex] := col_percent;
    end;
  finally
    vGridColPercent.Free;
  end;


  //todo sayýsal renklendirme iþlemini yap
  vGridColColor := TSysGridColColor.Create(Table.Database);
  try
    SetLength(FarRenkliRakamColNames, Table.DataSource.DataSet.FieldCount);
    for nIndex := 0 to Length(FarRenkliRakamColNames)-1 do
    begin
      col_color.FieldName := '';
      col_color.MinValue := 0;
      col_color.MinColor := 0;
      col_color.MaxValue := 0;
      col_color.MaxColor := 0;
      col_color.EqualColor := 0;

      FarRenkliRakamColNames[nIndex] := col_color;
    end;

    //progress bar gibi renklendirme boyama iþlemi yap
    vGridColColor.SelectToList(' and table_name=' + QuotedStr(ReplaceRealColOrTableNameTo(Table.TableName)), False, False);
    for nIndex := 0 to vGridColColor.List.Count-1 do
    begin
      col_color.FieldName := ReplaceToRealColOrTableName(TSysGridColColor(vGridColColor.List[nIndex]).ColumnName.Value);
      col_color.MinValue := TSysGridColColor(vGridColColor.List[nIndex]).MinValue.Value;
      col_color.MinColor := TSysGridColColor(vGridColColor.List[nIndex]).MinColor.Value;
      col_color.MaxValue := TSysGridColColor(vGridColColor.List[nIndex]).MaxValue.Value;
      col_color.MaxColor := TSysGridColColor(vGridColColor.List[nIndex]).MaxColor.Value;
      col_color.EqualColor := clOlive;;

      FarRenkliRakamColNames[nIndex] := col_color;
    end;
  finally
    vGridColColor.Free;
  end;


  //sayýsal bilgilerde otomatik formatlama ve kolonlarýn çýkma sýrasýný ayarla iþlemini yap
  vGridColWidth := TSysGridColWidth.Create(TSingletonDB.GetInstance.DataBase);
  try
    vGridColWidth.SelectToList(' and table_name=' + QuotedStr( ReplaceRealColOrTableNameTo(Table.TableName) ) + ' ORDER by sequence_no ASC ', False, False);

    AddColumn( Table.DataSource.DataSet.FindField(Table.Id.FieldName));

    vHaneSayisi := 2;
    if FormOndalikMod = fomAlis then
      vHaneSayisi := TSingletonDB.GetInstance.HaneMiktari.AlisFiyat.Value
    else if FormOndalikMod = fomSatis then
      vHaneSayisi := TSingletonDB.GetInstance.HaneMiktari.SatisFiyat.Value;

    for n1 := 0 to vGridColWidth.List.Count-1 do
    begin

      for nIndex := 0 to Table.DataSource.DataSet.FieldCount - 1 do
      begin
        if (Table.DataSource.DataSet.Fields[nIndex].DataType = ftSmallint)
        or (Table.DataSource.DataSet.Fields[nIndex].DataType = ftInteger)
        or (Table.DataSource.DataSet.Fields[nIndex].DataType = ftLargeint)
        or (Table.DataSource.DataSet.Fields[nIndex].DataType = ftWord)
        or (Table.DataSource.DataSet.Fields[nIndex].DataType = ftLongWord)
        or (Table.DataSource.DataSet.Fields[nIndex].DataType = ftInteger)
        then
          TIntegerField(Table.DataSource.DataSet.Fields[nIndex]).DisplayFormat := '#,#'
        else if (Table.DataSource.DataSet.Fields[nIndex].DataType = ftFloat) then
          TFloatField(Table.DataSource.DataSet.Fields[nIndex]).DisplayFormat := '#' + FormatSettings.DecimalSeparator + StringOfChar('#', vHaneSayisi) + '0' + FormatSettings.ThousandSeparator + StringOfChar('0', vHaneSayisi)
        else if (Table.DataSource.DataSet.Fields[nIndex].DataType = ftDate) then
          TDateField(Table.DataSource.DataSet.Fields[nIndex]).DisplayFormat   := 'dd' + FormatSettings.DateSeparator + 'mm' + FormatSettings.DateSeparator + 'yyyy'
        else if (Table.DataSource.DataSet.Fields[nIndex].DataType = ftTime) then
          TDateField(Table.DataSource.DataSet.Fields[nIndex]).DisplayFormat   := 'hh' + FormatSettings.TimeSeparator + 'nn' + FormatSettings.DateSeparator + 'ss'
        else if (Table.DataSource.DataSet.Fields[nIndex].DataType = ftDateTime) then
          TDateField(Table.DataSource.DataSet.Fields[nIndex]).DisplayFormat   := 'dd' + FormatSettings.DateSeparator + 'mm' + FormatSettings.DateSeparator + 'yyyy' + ' ' +
                                                                                 'hh' + FormatSettings.TimeSeparator + 'nn' + FormatSettings.DateSeparator + 'ss';

        if Table.DataSource.DataSet.Fields[nIndex].FieldName = ReplaceToRealColOrTableName(TSysGridColWidth(vGridColWidth.List[n1]).ColumnName.Value) then
        begin
          AddColumn( Table.DataSource.DataSet.Fields[nIndex] );
        end;
      end;
    end;
  finally
    vGridColWidth.Free;
  end;

  SetTitleFromLangContent();

  RefreshGrid();
end;

procedure TfrmBaseDBGrid.RefreshGrid;
var
  nIndex, nIndex2: Integer;
  vGridColWidth: TSysGridColWidth;
begin
  WriteRecordCount(Table.DataSource.DataSet.RecordCount);

  //tüm kolonlarý gizle veya tüm kolonlarý göster
  for nIndex := 0 to dbgrdBase.Columns.Count-1 do
  begin
    dbgrdBase.Columns[nIndex].Visible := FShowHideColumns;
    dbgrdBase.Columns[nIndex].Width := 100;
  end;

  //burada görünmesini istediðimiz kolonlarý gösterme iþlemini yapýyoruz.
  if not FShowHideColumns then
  begin
    vGridColWidth := TSysGridColWidth.Create(Table.Database);
    try
      vGridColWidth.SelectToList(' and table_name=' + QuotedStr( ReplaceRealColOrTableNameTo(Table.TableName)), False, False);

      if vGridColWidth.List.Count > 0 then
      begin
        for nIndex := 0 to vGridColWidth.List.Count-1 do
        begin
          for nIndex2 := 0 to dbgrdBase.Columns.Count-1 do
          begin
            if dbgrdBase.Columns[nIndex2].FieldName = ReplaceToRealColOrTableName(TSysGridColWidth(vGridColWidth.List[nIndex]).ColumnName.Value) then
            begin
              dbgrdBase.Columns[nIndex2].Visible := True;
              dbgrdBase.Columns[nIndex2].Width := TSysGridColWidth(vGridColWidth.List[nIndex]).ColumnWidth.Value;
              break;
            end;
          end;
        end;
      end;
    finally
      vGridColWidth.Free;
    end;
  end;

end;

procedure TfrmBaseDBGrid.mniRemoveFilterClick(Sender: TObject);
begin
  if mniRemoveFilter.Visible then
  begin
    FilterGrid := '';
    RefreshData;
  end;
end;

function TfrmBaseDBGrid.ResizeDBGrid(Sender: TObject):Integer;
var
  nIndex, dGridWidth: Integer;
begin
  Result := 0;
  if Sender.ClassType = TDBGrid then
  begin
    with Sender as TDBGrid do
    begin
      dGridWidth := 0;
      for nIndex := 0 to Columns.Count-1 do
      begin
        if Columns[nIndex].Visible then
          dGridWidth := dGridWidth + Columns[nIndex].Width + 1;
      end;

      if AlignWithMargins then
        dGridWidth := dGridWidth + Margins.Left + Margins.Right;

      //çýkan indicator için width bunun kontrolü eklenmeli. Þimdilik sabit bilgi olarak girildi
      if dgIndicator in dbgrdBase.Options then
        dGridWidth := dGridWidth + IndicatorWidth;

      //çýkan scroll için width bunun kontrolü eklenmeli. Þimdilik sabit bilgi olarak girildi
      dGridWidth := dGridWidth + 24;

      (Sender as TDBGrid).Width := dGridWidth;
    end;

    Result := dGridWidth;
  end;
end;

procedure TfrmBaseDBGrid.ResizeForm;
var
//  nIndex, nColCountVisible, nTotalColWidth,
  nDBGridHeight, nClientWidth : Integer;
begin
  Self.Enabled := False;
  dbgrdBase.Enabled := False;
  try
    nClientWidth := ResizeDBGrid(dbgrdBase);

    if pnlContent.AlignWithMargins then
      nClientWidth := nClientWidth + pnlContent.Margins.Left + pnlContent.Margins.Right;

    if pnlLeft.Visible then
    begin
      nClientWidth := nClientWidth + pnlLeft.Width;
      if pnlLeft.AlignWithMargins then
        nClientWidth := nClientWidth + pnlLeft.Margins.Left + pnlLeft.Margins.Right;
    end;

    if splLeft.Visible then
    begin
      nClientWidth := nClientWidth + splLeft.Width;
      if splLeft.AlignWithMargins then
        nClientWidth := nClientWidth + splLeft.Margins.Left + splLeft.Margins.Right;
    end;

    if pnlMain.AlignWithMargins then
      nClientWidth := nClientWidth + pnlMain.Margins.Left + pnlMain.Margins.Right;

    //form kenarlýklarý için windows temadan gelen
    nClientWidth := nClientWidth + 4;

    ClientWidth := Math.Min(nClientWidth, Screen.Width-100);
    Self.Left := (Screen.Width-ClientWidth) div 2;


    nDBGridHeight := 0;
    if pnlHeader.Visible then
    begin
      nDBGridHeight := nDBGridHeight + pnlHeader.Height;
      if pnlHeader.AlignWithMargins then
        nDBGridHeight := nDBGridHeight + pnlHeader.Margins.Top + pnlHeader.Margins.Bottom;
    end;

    if splHeader.Visible then
    begin
      nDBGridHeight := nDBGridHeight + splHeader.Height;
      if splHeader.AlignWithMargins then
        nDBGridHeight := nDBGridHeight + splHeader.Margins.Top + splHeader.Margins.Bottom;
    end;

    if pnlBottom.Visible then
    begin
      nDBGridHeight := nDBGridHeight + pnlBottom.Height;
      if pnlBottom.AlignWithMargins then
        nDBGridHeight := nDBGridHeight + pnlBottom.Margins.Top + pnlBottom.Margins.Bottom;
    end;

    if pnlButtons.Visible then
    begin
      nDBGridHeight := nDBGridHeight + pnlButtons.Height;
      if pnlButtons.AlignWithMargins then
        nDBGridHeight := nDBGridHeight + pnlButtons.Margins.Top + pnlButtons.Margins.Bottom;
    end;

    if stbBase.Visible then
    begin
      nDBGridHeight := nDBGridHeight + stbBase.Height;
      if stbBase.AlignWithMargins then
        nDBGridHeight := nDBGridHeight + stbBase.Margins.Top + stbBase.Margins.Bottom;
    end;

    ClientHeight := nDBGridHeight;

    //form kenarlýklarý için windows temadan gelen
//    ClientHeight := nDBGridHeight + 4;

    //Toplam 20 adet kayýt görünmesi için 20+1 * 20 satýr yüksekliði yapýyoruz (+1 baþlýk için)
    nDBGridHeight := nDBGridHeight + (21*20);

    ClientHeight := Math.Min(nDBGridHeight, Screen.Height-100);
  finally
    dbgrdBase.Invalidate;
    dbgrdBase.Enabled := True;
    Self.Invalidate;
    Self.Enabled := True;
  end;
end;

procedure TfrmBaseDBGrid.SetColWidth(pFieldName: string; pWidth: Integer);
var
  nIndex: Integer;
begin
  for nIndex := 0 to dbgrdBase.Columns.Count-1 do
  begin
    if dbgrdBase.Columns[nIndex].FieldName = pFieldName then
    begin
      dbgrdBase.Columns[nIndex].Width := pWidth;
      break;
    end;
  end;
end;

procedure TfrmBaseDBGrid.SetColVisible(pFieldName: string; pVisible: Boolean);
var
  nIndex: Integer;
begin
  for nIndex := 0 to dbgrdBase.Columns.Count-1 do
  begin
    if dbgrdBase.Columns[nIndex].FieldName = pFieldName then
    begin
      dbgrdBase.Columns[nIndex].Visible := pVisible;
      break;
    end;
  end;
end;

procedure TfrmBaseDBGrid.SetSelectedItem;
begin
  //geri kalan bilgiler inherit eden sýnýfta doldurulur
  Table.Id.Value := GetVarToFormatedValue(dbgrdBase.DataSource.DataSet.FindField( Table.Id.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField( Table.Id.FieldName).Value);
end;

procedure TfrmBaseDBGrid.SetTitleFromLangContent;
var
  n1: Integer;
begin
  for n1 := 0 to dbgrdBase.Columns.Count-1 do
  begin
    dbgrdBase.Columns.Items[n1].Title.Caption :=
        GetTextFromLang(
          dbgrdBase.Columns.Items[n1].Title.Caption,
          ReplaceRealColOrTableNameTo(dbgrdBase.Columns.Items[n1].FieldName),
          LngGridFieldCaption,
          ReplaceRealColOrTableNameTo(Table.TableName)
        );
  end;
end;

procedure TfrmBaseDBGrid.ShowInputForm(pFormType: TInputFormMod);
begin
  if (pFormType = ifmRewiev)
  or ((not Table.Database.TranscationIsStarted) and ((pFormType = ifmNewRecord) or (pFormType = ifmCopyNewRecord)))
  then
  begin
    CreateInputForm(pFormType).Show;
  end
  else
    raise Exception.Create(
      GetTextFromLang(
          'Baþka bir pencere giriþ veya güncelleme için açýlmýþ, önce bu iþlemi tamamlayýn.',
          FrameworkLang.WarningOpenWindow, LngWarning, LngSystem));
end;

procedure TfrmBaseDBGrid.stbBaseDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  vIco: Integer;
begin
  stbBase.Canvas.Font.Name := 'Tahoma';
  stbBase.Canvas.Font.Style := [fsBold];

  stbBase.Canvas.TextRect(Rect,
    Rect.Left + il16x16.Width + 4,
    Rect.Top + (stbBase.Height-Canvas.TextHeight(Panel.Text)) div 2 - 2,
    Panel.Text);

  vIco := -1;
  case Panel.Index of
    STATUS_SQL_SERVER: vIco := IMG_REPEAT;
    STATUS_DATE: vIco := IMG_DATABASE;
    STATUS_EX_RATE_USD: vIco := IMG_HELP;
    STATUS_EX_RATE_EUR:
    begin
      if Panel.Text <> '' then
        vIco := IMG_NOTE
      else
        vIco := -1;
    end;
  end;

  if vIco > -1 then
  begin
    il16x16.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, vIco);
    Panel.Width := stbBase.Canvas.TextWidth(Panel.Text)+ il16x16.Width + 8;
  end;
end;

procedure TfrmBaseDBGrid.TransferToExcel(pOnlyVisibleCols: Boolean);
var
  nIndexRow, nIndexCol, nVisilbeColCount, vInteger: Integer;
  vFileName, vTemp, vFiledName: string;
  nVisibleColNumber:array of Integer;
  vDouble: Double;
  XLSFile: TAdvSpreadGrid;
  XLSGridExcelIO: TAdvGridExcelIO;
begin
  vFileName := TSpecialFunctions.GetDiaglogSave(Self.Caption + DateToStr(Table.Database.GetToday(False)), 'Excel dosyasý (xls)|*.xls') + '.xls';

  XLSFile := TAdvSpreadGrid.Create(nil);
  XLSGridExcelIO := TAdvGridExcelIO.Create(nil);
  XLSGridExcelIO.AdvStringGrid := XLSFile;
  try
    XLSFile.RowCount := Table.DataSource.DataSet.RecordCount + 2;
    XLSFile.ColCount := dbgrdBase.Columns.Count + 1;

    nVisilbeColCount := 0;
    vFiledName := '';

    SetLength(nVisibleColNumber, dbgrdBase.Columns.Count);
    for nIndexCol := 0 to dbgrdBase.Columns.Count-1 do
    begin
      if (dbgrdBase.Columns[nIndexCol].Visible = pOnlyVisibleCols) or (not pOnlyVisibleCols) then
      begin
        nVisilbeColCount := nVisilbeColCount + 1;
        nVisibleColNumber[nVisilbeColCount-1] := nIndexCol;

        if dbgrdBase.Fields[nIndexCol].DisplayLabel <> null then
        begin
          if TSingletonDB.GetInstance.User.IsSuperUser.Value then
            XLSFile.Cells[nVisilbeColCount,1] := dbgrdBase.Columns[nIndexCol].Title.Caption + ' [' + dbgrdBase.Fields[nIndexCol].FieldName + ']'
          else
            XLSFile.Cells[nVisilbeColCount,1] := dbgrdBase.Columns[nIndexCol].Title.Caption;
          XLSFile.CellProperties[nVisilbeColCount,1].FontStyle := [fsBold];
          XLSFile.CellProperties[nVisilbeColCount,1].Alignment := TAlignment.taCenter;
        end
        else
          XLSFile.Cells[nVisilbeColCount,1] := '';
      end;
    end;

    Table.DataSource.DataSet.First;
    for nIndexRow := 0 to Table.DataSource.DataSet.RecordCount-1 do
    begin
      for nIndexCol := 0 to nVisilbeColCount - 1 do
      begin
        if (dbgrdBase.Columns[nVisibleColNumber[nIndexCol]].Visible = pOnlyVisibleCols) or (not pOnlyVisibleCols) then
        begin
          if  (dbgrdBase.Columns[nVisibleColNumber[nIndexCol]].Field.Value <> null) then
            vTemp := dbgrdBase.Columns[nVisibleColNumber[nIndexCol]].Field.Value
          else
            vTemp := '';
          XLSFile.Cells[nIndexCol+1, nIndexRow+2] := vTemp;

          if (nIndexRow >= 0) then
            if TryStrToInt(vTemp, vInteger) or TryStrToFloat(StringReplace(vTemp, '.', '', [rfReplaceAll]), vDouble) then
              XLSFile.CellProperties[nIndexCol+1, nIndexRow+2].Alignment := taRightJustify;
        end;
      end;
      Table.DataSource.DataSet.Next;
    end;
    dbgrdBase.DataSource.DataSet.Locate('id', Table.Id.Value,[]);

    if FileExists(vFileName) then
      DeleteFile(vFileName);
    XLSGridExcelIO.XLSExport(vFileName);

  finally
    XLSFile.Free;
    XLSGridExcelIO.Free;
  end;
end;

procedure TfrmBaseDBGrid.WmAfterShow(var Msg: TMessage);
var
  n1: Integer;
begin
  inherited;
  //
  for n1 := 0 to dbgrdBase.Columns.Count-1 do
  begin
    if dbgrdBase.Columns.Items[n1].Visible then
    begin
      dbgrdBaseTitleClick(dbgrdBase.Columns.Items[n1]);
      mniRemoveSort.Click;
      WriteRecordCount(Table.DataSource.DataSet.RecordCount);
      Break;
    end;
  end;
end;

procedure TfrmBaseDBGrid.WriteRecordCount(pCount: Integer);
begin
  if TSingletonDB.GetInstance.DataBase.Connection.Connected then
    stbBase.Panels.Items[STATUS_SQL_SERVER].Text := GetTextFromLang('Total', FrameworkLang.GeneralRecordCount, LngGeneral, LngSystem) + ': ' + pCount.ToString;
end;

end.
