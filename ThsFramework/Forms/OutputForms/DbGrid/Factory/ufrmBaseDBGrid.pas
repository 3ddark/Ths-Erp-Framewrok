unit ufrmBaseDBGrid;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, Vcl.Menus, System.Types,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Math, System.StrUtils, Vcl.Grids,
  Vcl.DBGrids, System.UITypes, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  ufrmBase,
  Ths.Erp.Database.Table.SysVisibleColumn,
  ufrmBaseOutput;

const
  GRID_COLUMN_ID = 0;
  GRID_COLUMN_VALIDITY = 1;

type
  TSortType = (stNone, stAsc, stDesc);

type
  THackDBGrid = class(TCustomDBGrid)
  protected
  end;

type
  TValLowHigh = (vlLow, vlHigh, vlEqual);

type
  TfrmBaseDBGrid = class(TfrmBaseOutput)
    pnlButtons: TPanel;
    flwpnlLeft: TFlowPanel;
    btnAddNew: TBitBtn;
    flwpnlRight: TFlowPanel;
    dbgrdBase: TDBGrid;
    mniExcelKaydet: TMenuItem;
    mniIncele: TMenuItem;
    mniYazdir: TMenuItem;
    mniSeperator1: TMenuItem;
    mniSeperator2: TMenuItem;
    btnTest: TBitBtn;
    stbDBGrid: TStatusBar;
    mniSiralamayiIptalEt: TMenuItem;
    procedure FormCreate(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure mniInceleClick(Sender: TObject);
    procedure mniExcelKaydetClick(Sender: TObject);
    procedure mniYazdirClick(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure FormResize(Sender: TObject);override;
    procedure btnFiltreKaldirClick(Sender: TObject);
    procedure btnFiltreClick(Sender: TObject);
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
    procedure dbgrdBaseDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgrdBaseColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure dbgrdBaseTitleClick(Column: TColumn);
    procedure mniSiralamayiIptalEtClick(Sender: TObject);
    procedure dbgrdBaseDrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure dbgrdBaseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgrdBaseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbgrdBaseMouseLeave(Sender: TObject);
    procedure dbgrdBaseExit(Sender: TObject);
  private
    FarRenkliYuzdeColNames: TArray<string>;
    FarRenkliRakamColNames: TArray<string>;
    FYuzdeMaxVal: Integer;
    FYuzdeMinVal: Integer;
    FColorHigh: TColor;
    FColorLow: TColor;
    FColorEqual: TColor;
    FColorRakamText: TColor;
    FColorYuzdeText: TColor;
    FColorBar: TColor;
    FColorBarBorder: TColor;
    FColorBarBack: TColor;

    function IsYuzdeCizimAlaniVar(pFieldName: string): Boolean;
    function IsRenkliRakamVar(pFieldName: string): Boolean;
  protected
    FQueryDefaultFilter, FQueryDefaultOrder: String;

    FGorunmeyenKolonlarGosterilsin: Boolean;

    function CreateInputForm(pFormMode: TInputFormMod):TForm;virtual;
  public
    property arRenkliYuzdeColNames: TArray<string> read FarRenkliYuzdeColNames write FarRenkliYuzdeColNames;
    property YuzdeMaxVal: Integer read FYuzdeMaxVal write FYuzdeMaxVal;
    property YuzdeMinVal: Integer read FYuzdeMinVal write FYuzdeMinVal;
    property ColorBar: TColor read FColorBar write FColorBar;
    property ColorBarBack: TColor read FColorBarBack write FColorBarBack;
    property ColorBarBorder: TColor read FColorBarBorder write FColorBarBorder;
    property ColorYuzdeText: TColor read FColorYuzdeText write FColorYuzdeText;

    property arRenkliRakamColNames: TArray<string> read FarRenkliRakamColNames write FarRenkliRakamColNames;
    property ColorHigh: TColor read FColorHigh write FColorHigh;
    property ColorLow: TColor read FColorLow write FColorLow;
    property ColorEqual: TColor read FColorEqual write FColorEqual;
    property ColorRakamText: TColor read FColorRakamText write FColorRakamText;
    function GetLowHighEqual(pField: TField): Integer;virtual;

    property GorunmeyenKolonlarGosterilsin: Boolean read FGorunmeyenKolonlarGosterilsin write FGorunmeyenKolonlarGosterilsin;
    property QueryDefaultFilter: string read FQueryDefaultFilter write FQueryDefaultFilter;
    property QueryDefaultOrder: string read FQueryDefaultOrder write FQueryDefaultOrder;

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
  end;

implementation

uses
  uSpecialFunctions;

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
  dbgrdBase.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack];

  FGorunmeyenKolonlarGosterilsin := False;

  dbgrdBase.DataSource := Table.DataSource;

  btnAddNew.Visible := True;


  //ilk açýlýþta veri tabanýndan kayýtlarý getirmek için RefreshDataFirst çaðýr
  //daha sonraki iþlemlerde sadece query refresh ile update yapacaðýz
  //buda iþlemlerin hazlanmasý için gerekli bir adým.
  //Her zaman db den select yapýnca fazla kolon ve kayýt olduðu durumlarda aþýrý yavaþlamna oluyor
  RefreshDataFirst;

  mniSiralamayiIptalEt.Visible := False;

  PostMessage(self.Handle, WM_AFTER_CREATE, 0, 0);
end;

procedure TfrmBaseDBGrid.FormDestroy(Sender: TObject);
begin
  while dbgrdBase.Columns.Count > 0 do
    dbgrdBase.Columns[dbgrdBase.Columns.Count-1].Free;
  inherited;
end;

procedure TfrmBaseDBGrid.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and (dbgrdBase.Focused) then
  begin
    mniIncele.Click;
    Key := #0;
  end
  else
    inherited;
end;

procedure TfrmBaseDBGrid.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  //ctrl+shift+alt+t ile tüm kolonlar görünsün
  if  (Char(Key) = 'T') and (Shift = [ssCtrl, ssShift, ssAlt]) then
  begin
    FGorunmeyenKolonlarGosterilsin := not FGorunmeyenKolonlarGosterilsin;
    RefreshGrid;
    ResizeForm;
  end;

  if Key = VK_F7 then  //F7
    btnAddNew.Click;
end;

procedure TfrmBaseDBGrid.FormPaint(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmBaseDBGrid.btnFiltreClick(Sender: TObject);
begin
//  inherited;
//  //filtre kaldýrma iþlemini yap
//  btnFiltreKaldir.Enabled := True;
end;

procedure TfrmBaseDBGrid.btnFiltreKaldirClick(Sender: TObject);
begin
//  lblFiltreKolonAdi.Visible := False;
//  edtFiltre.Visible := False;
//  chkFiltre.Visible := False;
//  lblFiltreTipi.Visible := False;
//  cbbFiltreTipi.Visible := False;
//
//  btnFiltre.Enabled := False;
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
  stbDBGrid.Panels.Items[0].Text := Table.DataSource.DataSet.RecordCount.ToString;
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
  //headera basýlýrsa açma input formu
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
  clActualPenColor, clActualBrushColor, clActualFontColor: TColor;
  bEmptyDS: Boolean;
  DrawRect: TRect;
  sValue: string;

  Bmp: TBitmap;
  AState: TGridDrawState;
begin
  AState := State;
  //Satýrý renklendir.
  if THackDBGrid(dbgrdBase).DataLink.ActiveRecord = THackDBGrid(dbgrdBase).Row - 1 then
    dbgrdBase.Canvas.Brush.Color := $006C9976
  else if dbgrdBase.DataSource.DataSet.RecNo mod 2 = 0 then
    dbgrdBase.Canvas.Brush.Color := $00FBFBFB
  else if dbgrdBase.DataSource.DataSet.RecNo mod 2 = 1 then
    dbgrdBase.Canvas.Brush.Color := $00DFECE6;

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

        nWidth1 := (((DrawRect.Right - DrawRect.Left) * nValue) DIV YuzdeMaxVal);

        clActualPenColor := TDBGrid(Sender).Canvas.Pen.Color;
        clActualBrushColor := TDBGrid(Sender).Canvas.Brush.Color;
        clActualFontColor := TDBGrid(Sender).Canvas.Font.Color;

        TDBGrid(Sender).Canvas.Pen.Color := ColorBarBorder;
        TDBGrid(Sender).Canvas.Brush.Color := ColorBarBack;
        if THackDBGrid(dbgrdBase).DataLink.ActiveRecord = THackDBGrid(dbgrdBase).Row - 1 then
          TDBGrid(Sender).Canvas.Font.Color := clBlack
        else
          TDBGrid(Sender).Canvas.Font.Color := clActualFontColor;

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

      if GetLowHighEqual(Column.Field) = 1 then
        TDBGrid(Sender).Canvas.Brush.Color := ColorHigh
      else if GetLowHighEqual(Column.Field) = -1 then
        TDBGrid(Sender).Canvas.Brush.Color := ColorLow
      else if GetLowHighEqual(Column.Field) = 0 then
        TDBGrid(Sender).Canvas.Brush.Color := ColorEqual;

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
        mniSiralamayiIptalEt.Visible := True;

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
begin
  inherited;
  //RefreshDataFirst;

  ResizeForm();

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

function TfrmBaseDBGrid.GetLowHighEqual(pField: TField): Integer;
begin
  Result := 2;
end;

function TfrmBaseDBGrid.IsRenkliRakamVar(pFieldName: string): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := 0 to Length(arRenkliRakamColNames)-1 do
  begin
    if pFieldName = arRenkliRakamColNames[nIndex] then
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
    if pFieldName = arRenkliYuzdeColNames[nIndex] then
    begin
      Result := True;
      Break
    end;
  end;
end;

procedure TfrmBaseDBGrid.mniExcelKaydetClick(Sender: TObject);
begin
  inherited;
  ShowMessage('excel kaydet');
end;

procedure TfrmBaseDBGrid.mniInceleClick(Sender: TObject);
begin
  dbgrdBaseDblClick(dbgrdBase);
end;

procedure TfrmBaseDBGrid.mniSiralamayiIptalEtClick(Sender: TObject);
begin
  TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames := '';
  if TFDQuery(dbgrdBase.DataSource.DataSet).IndexFieldNames = '' then
    mniSiralamayiIptalEt.Visible := False;
end;

procedure TfrmBaseDBGrid.mniYazdirClick(Sender: TObject);
begin
  inherited;
  ShowMessage('yazdir');
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

  if Table.Id > 0 then
    dbgrdBase.DataSource.DataSet.Locate('id', Table.Id,[]);

  RefreshGrid();
end;

procedure TfrmBaseDBGrid.RefreshDataFirst();
var
  nIndex: Integer;
begin
  Table.DataSource.OnDataChange := DataSourceDataChange;
  FQueryDefaultFilter := ' ' + Trim(FQueryDefaultFilter);

  FQueryDefaultOrder := Trim(FQueryDefaultOrder);
  if FQueryDefaultOrder <> '' then
    FQueryDefaultOrder := ' ORDER BY ' + Trim(FQueryDefaultOrder);
  Table.SelectToDatasource(FQueryDefaultFilter + FQueryDefaultOrder, True);

  if Table.Id > 0 then
    dbgrdBase.DataSource.DataSet.Locate('id', Table.Id,[]);


  //db alan uzunluðu kadar array boyutunu belirle
  SetLength(FarRenkliYuzdeColNames, Table.DataSource.DataSet.FieldCount);
  for nIndex := 0 to Length(FarRenkliYuzdeColNames)-1 do
    FarRenkliYuzdeColNames[nIndex] := '';
  YuzdeMaxVal := 100;
  YuzdeMinVal := 0;
  ColorYuzdeText := clBlack;
  ColorBar := clSkyBlue;
  ColorBarBack := clWhite;
  ColorBarBorder := clBlack;

  SetLength(FarRenkliRakamColNames, Table.DataSource.DataSet.FieldCount);
  for nIndex := 0 to Length(FarRenkliRakamColNames)-1 do
    FarRenkliRakamColNames[nIndex] := '';
  ColorHigh := clGreen;
  ColorLow := clRed;
  ColorEqual := clBlue;
  ColorRakamText := clBlack;

  for nIndex := 0 to Table.DataSource.DataSet.FieldCount - 1 do
  begin
    with dbgrdBase.Columns.Add do
    begin
      FieldName := Table.DataSource.DataSet.Fields[nIndex].FieldName;
      Title.Caption := Table.DataSource.DataSet.Fields[nIndex].DisplayName;
      Title.Color := clBlack;
      Title.Font.Color := clWhite;
      Title.Font.Style := [fsBold];
      Title.Alignment := taCenter;
      Visible := False;
//burasý kapalý
//      Color := clGreen;
//      Width := Table.DataSource.DataSet.Fields[nIndex].DataSize + 8;//
//      Width := Canvas.TextWidth(Title.Caption) + 16;
    end;
  end;

  RefreshGrid();
end;

procedure TfrmBaseDBGrid.RefreshGrid;
var
  nIndex, nIndex2: Integer;
  visible_column: TSysVisibleColumns;
begin  
  //tüm kolonlarý gizle veya tüm kolonlarý göster
  for nIndex := 0 to dbgrdBase.Columns.Count-1 do
  begin
    dbgrdBase.Columns[nIndex].Visible := FGorunmeyenKolonlarGosterilsin;
    dbgrdBase.Columns[nIndex].Width := 100;
  end;

  //burada görünmesini istediðimiz kolonlarý gösterme iþlemini yapýyoruz.
  if not FGorunmeyenKolonlarGosterilsin then
  begin
    visible_column := TSysVisibleColumns.Create(Table.Database);
    try
      visible_column.SelectToList(' and table_name=' + QuotedStr(Table.TableName), False, False);
      for nIndex := 0 to visible_column.List.Count-1 do
      begin
        for nIndex2 := 0 to dbgrdBase.Columns.Count-1 do
        begin
          if dbgrdBase.Columns[nIndex2].FieldName = TSysVisibleColumns(visible_column.List[nIndex]).ColumnName then
          begin
            dbgrdBase.Columns[nIndex2].Visible := True;
            dbgrdBase.Columns[nIndex2].Width := TSysVisibleColumns(visible_column.List[nIndex]).ColumnWidth;
            break;
          end;
        end;
      end;
    finally
      visible_column.Free;
    end;
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

//    nTotalColWidth := 0;
//    nColCountVisible := 0;
//    for nIndex := 0 to dbgrdBase.Columns.Count-1 do
//    begin
//      if dbgrdBase.Columns[nIndex].Visible then
//      begin
//        nTotalColWidth := nTotalColWidth + dbgrdBase.Columns[nIndex].Width + 1;
//        nColCountVisible := nColCountVisible + 1;
//      end;
//    end;

    //32 çýkmasýnýn sebebi scroll bar + kolon kenarlýklarý + indicator için
//    if Math.CompareValue(nTotalColWidth, dbgrdBase.Width-34) = LessThanValue then
//      nTotalColWidth := dbgrdBase.Width - 34 - nTotalColWidth;
//
//    for nIndex := 0 to dbgrdBase.Columns.Count-1 do
//      if dbgrdBase.Columns[nIndex].Visible then
//        dbgrdBase.Columns[nIndex].Width := dbgrdBase.Columns[nIndex].Width + (nTotalColWidth div nColCountVisible);

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

    if stbDBGrid.Visible then
    begin
      nDBGridHeight := nDBGridHeight + stbDBGrid.Height;
      if stbDBGrid.AlignWithMargins then
        nDBGridHeight := nDBGridHeight + stbDBGrid.Margins.Top + stbDBGrid.Margins.Bottom;
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
  Table.Id        := Self.GetFieldByFieldName('id', dbgrdBase.Columns).AsInteger;
  Table.Validity  := Self.GetFieldByFieldName('validity', dbgrdBase.Columns).AsBoolean;
end;

procedure TfrmBaseDBGrid.ShowInputForm(pFormType: TInputFormMod);
begin
  if  (pFormType = ifmRewiev) or ((not Table.Database.TranscationIsStarted)
  and (pFormType = ifmNewRecord))
  then
  begin
    CreateInputForm(pFormType).Show;
  end
  else
    raise Exception.Create('Baþka bir pencere giriþ veya güncelleme için açýlmýþ, önce bu iþlemi tamamlayýn.');
end;

end.
