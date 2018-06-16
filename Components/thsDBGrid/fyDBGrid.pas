unit fyDBGrid;

{******************************************************************************}
{                                                                              }
{         Enhanced Database Grid V0.5                                          }
{                                                                              }
{         By : Amir Mahfoozi                                                   }
{                                                                              }
{         email :  mahfoozi@gmail.com                                          }
{                                                                              }
{******************************************************************************}

interface

uses
  messages,
  inifiles, imgList,
  Winapi.Windows, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, System.StrUtils,
  Vcl.Grids,
  Vcl.DBGrids,
  System.UITypes,
  FireDAC.Comp.Client,

  Math, Vcl.Menus, System.Types,
  FireDAC.Comp.DataSet, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Samples.Spin;

const
  bmArrow = 'DBGARROW2';
  bmEdit = 'DBEDIT2';
  bmInsert = 'DBINSERT2';
  bmMultiDot = 'DBMULTIDOT2';
  bmMultiArrow = 'DBMULTIARROW2';

type
  TSortType = (stNone, stAsc, stDesc);

  TActiveChangedEvent = procedure(Sender: TObject; dataset: TDataSet) of object;

  TFilterEvent = procedure(Sender: TObject; searchCol: TColumn;
    searchStr:String; var filterStr: string) of object;

  TOnPopupCommandEvent = procedure(Sender: TObject; commandID, rowNo: integer ) of object;


  TRowInfo = record
    recNo,
    top,
    bottom: integer;
  end;
  TfyDBGrid = class(TCustomDBGrid)
  protected
    myIndicators:TImageList;

    procedure DblClick; override;
    procedure TitleClick(Column: TColumn); override;
    procedure DrawCell(ACol, ARow: integer; ARect: TRect;
      AState: TGridDrawState); override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: integer;
      Column: TColumn; State: TGridDrawState); override;

    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;

    procedure WndProc(var Message: TMessage); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure edtSearchCriteriaWindowProc(var Message: TMessage);

    procedure ColWidthsChanged; override;
    procedure RowHeightsChanged; override;

    procedure Scroll(Distance: integer); override;
    procedure CalcSizingState(X: integer; Y: integer; var State: TGridState;
      var Index: integer; var SizingPos: integer; var SizingOfs: integer;
      var FixedInfo: TGridDrawInfo); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;

    procedure onPopupMenuItemClick(Sender : TObject);
  private
    tempFont:TFont;

    bmpClipped,
    bmpDrawText:TBitmap;

    pmCommands:TPopupMenu;

    originalRowHeight,
    lastRowHeight: integer;
    lastResizedRow: integer;
    myLeftCol: integer; // grid left column

    lastMouseX, lastMouseY: integer;

    sndEsc, sndSort, sndDblClick, sndHover: TResourceStream;
    resized: boolean;
    searchVisible, filtering: boolean;
    searchFieldName: string;
    lastSearchStr: string;
    lastSearchColumn: TColumn;
    lastEditboxWndProc: TWndMethod;
    edtSearchCriteria: TEdit;

    ri: array of TRowInfo;
    lastRowCount: integer;

    dblClicked: boolean;

    lastSortColumn: TColumn;
    lastSortType: TSortType;
    FAltRowColor1Finish: TColor;
    FAltRowColor1Start: TColor;
    FAltRowColor2Finish: TColor;
    FAltRowColor2Start: TColor;
    FSelectedColorFinish: TColor;
    FSelectedColorStart: TColor;

    grBmpTitle: TBitmap;
    grBmpActive: TBitmap;
    grBmpSelected: TBitmap;
    grBmpAlt1: TBitmap;
    grBmpAlt2: TBitmap;
    FAltRowColor2Steps: integer;
    FAltRowColor1Steps: integer;
    FSelectedColorSteps: integer;
    FAutoFocus: boolean;
    FHotTrack: boolean;
    FAltRowColor1CenterPosition: integer;
    FAltRowColor2CenterPosition: integer;
    FAltRowColor1Center: TColor;
    FAltRowColor2Center: TColor;
    FSelectedColorCenterPosition: integer;
    FSelectedColorCenter: TColor;
    FTitleColorCenterPosition: integer;
    FTitleColorSteps: integer;
    FTitleColorFinish: TColor;
    FTitleColorStart: TColor;
    FTitleColorCenter: TColor;
    FAutoWidthMin: integer;
    FAutoWidthMax: integer;
    FMoveSoundEnabled: boolean;
    FSortArrowColor: TColor;
    FAutoWidthAllColor: TColor;
    FDblClickSoundEnabled: boolean;
    FSortSoundEnabled: boolean;
    FEscSoundEnabled: boolean;
    FAllowFilter: boolean;
    FOnBeforeFilter: TFilterEvent;
    FAllowRowResize: boolean;
    FAllowSort: boolean;
    FActiveColorCenterPosition: integer;
    FActiveColorSteps: integer;
    FActiveColorStart: TColor;
    FActiveColorFinish: TColor;
    FActiveColorCenter: TColor;
    FPopupMenuCommands: TStrings;
    FOnPopupCommand: TOnPopupCommandEvent;
    FActiveCellFontColor: TColor;
    FSelectedCellFontColor: TColor;

    procedure PopupMenuCommandsChanged(Sender: TObject);
    procedure toggleTransparentColor;
    procedure myDrawText(s:string; outputCanvas: Tcanvas; drawRect: TRect;
                  drawAlignment:TAlignment ; drawFont:TFont);
    function rowVisible(rw: integer): boolean;
    function rowFullVisible(rw: integer): boolean;
    function isMultiSelectedRow: Boolean;
    procedure playSoundInMemory(cnd: boolean; m: TResourceStream; name: string);
    function getColumnRightEdgePos(cl: TColumn): integer;

    procedure extractRGB(cl: TColor; var red, green, blue: byte);
    procedure drawVerticalGradient(var grBmp: TBitmap; gHeight: integer;
      color1, color2, color3: TColor; centerPosition: integer = 50);
    procedure produceTitleGradient;
    procedure produceActiveGradient;
    procedure produceSelectedGradient;
    procedure produceAltRow1Gradient;
    procedure produceAltRow2Gradient;
    procedure autoFitColumn(ix: integer; canDisableControls:boolean);
    procedure drawTriangleInRect(r: TRect; st: TSortType; al: TAlignment);
    procedure drawCircleInRect(r: TRect);
    procedure SetAltRowColor1Start(const Value: TColor);
    procedure SetAltRowColor2Start(const Value: TColor);
    procedure SetSelectedColorStart(const Value: TColor);
    procedure SetAltRowColor1Finish(const Value: TColor);
    procedure SetAltRowColor2Finish(const Value: TColor);
    procedure SetSelectedColorFinish(const Value: TColor);
    function checkDBPrerequisites: boolean;
    procedure SetAltRowColor1Steps(const Value: integer);
    procedure SetAltRowColor2Steps(const Value: integer);
    procedure SetSelectedColorSteps(const Value: integer);
    procedure SetAutoFocus(const Value: boolean);
    procedure SetHotTrack(const Value: boolean);
    function  pointInRect(p: TPoint; r: TRect): boolean;
    procedure ClearFilter;
    procedure ClearSort;
    function  isVisibleColumn(cl: TColumn): boolean;
    procedure SetAltRowColor1Center(const Value: TColor);
    procedure SetAltRowColor1CenterPosition(const Value: integer);
    procedure SetAltRowColor2Center(const Value: TColor);
    procedure SetAltRowColor2CenterPosition(const Value: integer);
    procedure SetSelectedColorCenter(const Value: TColor);
    procedure SetSelectedColorCenterPosition(const Value: integer);
    procedure SetTitleColorCenter(const Value: TColor);
    procedure SetTitleColorCenterPosition(const Value: integer);
    procedure SetTitleColorFinish(const Value: TColor);
    procedure SetTitleColorStart(const Value: TColor);
    procedure SetTitleColorSteps(const Value: integer);
    procedure SetAutoWidthMax(const Value: integer);
    procedure SetAutoWidthMin(const Value: integer);
    procedure SetAutoWidthAllColor(const Value: TColor);
    procedure SetMoveSoundEnabled(const Value: boolean);
    procedure SetSortArrowColor(const Value: TColor);
    procedure incLeftCol;
    procedure decLeftCol;
    function  cellWidth(ACol, ARow: integer): integer;
    function  cellHeight(ACol, ARow: integer): integer;
    procedure SetDblClickSoundEnabled(const Value: boolean);
    procedure SetSortSoundEnabled(const Value: boolean);
    procedure SetEscSoundEnabled(const Value: boolean);
    procedure SetAllowFilter(const Value: boolean);
    procedure SetOnBeforeFilter(const Value: TFilterEvent);
    procedure SetAllowRowResize(const Value: boolean);
    procedure SetAllowSort(const Value: boolean);
    procedure SetActiveColorCenter(const Value: TColor);
    procedure SetActiveColorCenterPosition(const Value: integer);
    procedure SetActiveColorFinish(const Value: TColor);
    procedure SetActiveColorStart(const Value: TColor);
    procedure SetActiveColorSteps(const Value: integer);
    procedure SetPopupMenuCommands(const Value: TStrings);
    procedure SetOnPopupCommand(const Value: TOnPopupCommandEvent);
    procedure buildPopUpMenu;
    procedure SetActiveCellFontColor(const Value: TColor);
    procedure SetSelectedCellFontColor(const Value: TColor);

  public
    constructor create(owner: TComponent); override;
    destructor  destroy; override;
    procedure   autoFitAll;
    procedure   saveConfig(fn: String);
    procedure   loadConfig(fn: String);

    property Canvas;
    property SelectedRows;
  published

    property TitleColorStart: TColor read FTitleColorStart
      write SetTitleColorStart default clGray;
    property TitleColorCenter: TColor read FTitleColorCenter
      write SetTitleColorCenter default clWhite;
    property TitleColorCenterPosition: integer read FTitleColorCenterPosition
      write SetTitleColorCenterPosition default 50;
    property TitleColorFinish: TColor read FTitleColorFinish
      write SetTitleColorFinish default clGray;
    property TitleColorSteps: integer read FTitleColorSteps
      write SetTitleColorSteps default 50;

    property ActiveColorStart: TColor read FActiveColorStart write SetActiveColorStart default $00FFD7EB;
    property ActiveColorCenter: TColor read FActiveColorCenter write SetActiveColorCenter default $00FF0080;
    property ActiveColorCenterPosition: integer read FActiveColorCenterPosition write SetActiveColorCenterPosition default 50;
    property ActiveColorFinish: TColor read FActiveColorFinish write SetActiveColorFinish default $00FFD7EB;
    property ActiveColorSteps: integer read FActiveColorSteps write SetActiveColorSteps default 50;

    property SelectedColorStart: TColor read FSelectedColorStart
      write SetSelectedColorStart default $00EDB6B6;
    property SelectedColorCenter: TColor read FSelectedColorCenter
      write SetSelectedColorCenter default $00F31212;
    property SelectedColorCenterPosition: integer
      read FSelectedColorCenterPosition write SetSelectedColorCenterPosition
      default 50;
    property SelectedColorFinish: TColor read FSelectedColorFinish
      write SetSelectedColorFinish default $00EDB6B6;
    property SelectedColorSteps: integer read FSelectedColorSteps
      write SetSelectedColorSteps default 50;

    property AltRowColor1Start: TColor read FAltRowColor1Start
      write SetAltRowColor1Start default $00DAFEFC;
    property AltRowColor1Center: TColor read FAltRowColor1Center
      write SetAltRowColor1Center default $000EFAEE;
    property AltRowColor1CenterPosition: integer
      read FAltRowColor1CenterPosition write SetAltRowColor1CenterPosition
      default 50;
    property AltRowColor1Finish: TColor read FAltRowColor1Finish
      write SetAltRowColor1Finish default $00DAFEFC;
    property AltRowColor1Steps: integer read FAltRowColor1Steps
      write SetAltRowColor1Steps default 50;

    property AltRowColor2Start: TColor read FAltRowColor2Start
      write SetAltRowColor2Start default $00ECD9FF;
    property AltRowColor2Center: TColor read FAltRowColor2Center
      write SetAltRowColor2Center default $00B164FF;
    property AltRowColor2CenterPosition: integer
      read FAltRowColor2CenterPosition write SetAltRowColor2CenterPosition
      default 50;
    property AltRowColor2Finish: TColor read FAltRowColor2Finish
      write SetAltRowColor2Finish default $00ECD9FF;
    property AltRowColor2Steps: integer read FAltRowColor2Steps
      write SetAltRowColor2Steps default 50;

    property AutoFocus: boolean read FAutoFocus write SetAutoFocus
      default false;
    property HotTrack: boolean read FHotTrack write SetHotTrack default false;

    property AutoWidthMax: integer read FAutoWidthMax write SetAutoWidthMax
      default 0;
    property AutoWidthMin: integer read FAutoWidthMin write SetAutoWidthMin
      default 0;

    property EscSoundEnabled: boolean read FEscSoundEnabled
      write SetEscSoundEnabled default false;
    property SortSoundEnabled: boolean read FSortSoundEnabled
      write SetSortSoundEnabled default false;
    property DblClickSoundEnabled: boolean read FDblClickSoundEnabled
      write SetDblClickSoundEnabled default false;
    property MoveSoundEnabled: boolean read FMoveSoundEnabled
      write SetMoveSoundEnabled default false;

    property SortArrowColor: TColor read FSortArrowColor write SetSortArrowColor
      default clRed;
    property AutoWidthAllColor: TColor read FAutoWidthAllColor
      write SetAutoWidthAllColor default clBlue;

    property AllowFilter: boolean read FAllowFilter write SetAllowFilter
      default true;
    property AllowSort: boolean read FAllowSort write SetAllowSort default true ;
    property OnBeforeFilter: TFilterEvent read FOnBeforeFilter
      write SetOnBeforeFilter;

    property AllowRowResize: boolean read FAllowRowResize
      write SetAllowRowResize default false;

    property PopupMenuCommands:TStrings read FPopupMenuCommands write SetPopupMenuCommands;
    property OnPopupCommand:TOnPopupCommandEvent read FOnPopupCommand write SetOnPopupCommand;

    property ActiveCellFontColor:TColor read FActiveCellFontColor write SetActiveCellFontColor default clWhite;
    property SelectedCellFontColor:TColor read FSelectedCellFontColor write SetSelectedCellFontColor default clWhite;


    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns stored False;
    property Constraints;
    property Ctl3D;
    property DataSource;
    property DefaultDrawing;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixedColor;
    property Font;
    property ImeMode;
    property ImeName;
    property Options;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property TitleFont;
    property Visible;
    property OnCellClick;
    property OnColEnter;
    property OnColExit;
    property OnColumnMoved;
    property OnDrawDataCell;  { obsolete }
    property OnDrawColumnCell;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditButtonClick;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnTitleClick;
    property DataLink;

  end;

procedure Register;

{$R 'TEnhDBGrid.dcr'}
{$R data.res}

implementation

uses DateUtils, TypInfo;

{ TEnhDBGrid }

function TfyDBGrid.checkDBPrerequisites: boolean;
begin
  Result := false;
  if not Assigned(DataSource) then
    Exit;
  if not Assigned(DataSource.DataSet) then
    Exit;
  if not DataSource.DataSet.Active then
    Exit;
  Result := true;
end;

constructor TfyDBGrid.create(owner: TComponent);
var
 bmp:TBitmap;
begin
  inherited;

  bmpDrawText:=TBitmap.Create;
  bmpDrawText.Transparent:=true;
  bmpDrawText.TransparentMode:=tmFixed;
  bmpDrawText.TransparentColor:=clWhite;
  bmpDrawText.Canvas.Brush.Color:=clWhite;

  bmpClipped:=TBitmap.Create;
  bmpClipped.Transparent:=true;
  bmpClipped.TransparentMode:=tmFixed;
  bmpClipped.TransparentColor:=clWhite;
  bmpClipped.Canvas.Brush.Color:=clWhite;


  Bmp := TBitmap.Create;
  try
    Bmp.LoadFromResourceName(HInstance, bmArrow);
    myIndicators := TImageList.CreateSize(Bmp.Width, Bmp.Height);
    myIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmEdit);
    myIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmInsert);
    myIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiDot);
    myIndicators.AddMasked(Bmp, clWhite);
    Bmp.LoadFromResourceName(HInstance, bmMultiArrow);
    myIndicators.AddMasked(Bmp, clWhite);
  finally
    Bmp.Free;
  end;

  try
    sndHover := TResourceStream.create(HInstance, 'hover', RT_RCDATA);
    sndDblClick := TResourceStream.create(HInstance, 'dblclick', RT_RCDATA);
    sndSort := TResourceStream.create(HInstance, 'click', RT_RCDATA);
    sndEsc := TResourceStream.create(HInstance, 'esc', RT_RCDATA);
  except
    OutputDebugString('Error in loading sounds from resources');
  end;

  originalRowHeight:=0;

  FOnBeforeFilter:=nil;

  FMoveSoundEnabled := false;
  FDblClickSoundEnabled := false;
  FSortSoundEnabled := false;

  FAllowFilter := true;
  FAllowSort := true;
  FAllowRowResize := false;

  myLeftCol := leftCol;

  grBmpSelected := nil;
  grBmpAlt1 := nil;
  grBmpAlt2 := nil;

  resized := false;

  FAutoFocus := false;
  FHotTrack := false;

  lastSortColumn := nil;
  lastSortType := stNone;

  dblClicked := false;

  FAutoWidthMax := 0;
  FAutoWidthMin := 0;

  lastRowCount := 0;

  edtSearchCriteria := TEdit.create(Self);
  edtSearchCriteria.Width := 0;
  edtSearchCriteria.Height := 0;
  edtSearchCriteria.Parent := Self;
  edtSearchCriteria.Visible := false;
  searchVisible := false;

  lastEditboxWndProc := edtSearchCriteria.WindowProc;
  edtSearchCriteria.WindowProc := edtSearchCriteriaWindowProc;

  filtering := false;

  FTitleColorStart := clGreen;
  FTitleColorCenter := clGreen;
  FTitleColorCenterPosition := 50;
  FTitleColorFinish := $00BBFFBB;
  FTitleColorSteps := 50;


  FActiveColorStart := $00FFD7EB;
  FActiveColorCenter := $00FF0080;
  FActiveColorCenterPosition := 50;
  FActiveColorFinish := $00FFD7EB;
  FActiveColorSteps := 50;




  FSelectedColorStart := $00EDB6B6;
  FSelectedColorCenter := $00F31212;
  FSelectedColorCenterPosition := 50;
  FSelectedColorFinish := $00EDB6B6;
  FSelectedColorSteps := 50;

  FAltRowColor1Start := $00DAFEFC;
  FAltRowColor1Center := $000EFAEE;
  FAltRowColor1CenterPosition := 50;
  FAltRowColor1Finish := $00DAFEFC;
  FAltRowColor1Steps := 50;

  FAltRowColor2Start := $00ECD9FF;
  FAltRowColor2Center := $00B164FF;
  FAltRowColor2CenterPosition := 50;
  FAltRowColor2Finish := $00ECD9FF;
  FAltRowColor2Steps := 50;

  FMoveSoundEnabled := false;
  FSortArrowColor := clRed;
  FAutoWidthAllColor := clBlue;

  produceTitleGradient;
  produceActiveGradient;
  produceSelectedGradient;
  produceAltRow1Gradient;
  produceAltRow2Gradient;

  tempFont:=TFont.Create;
  FActiveCellFontColor:=Font.Color;
  FSelectedCellFontColor:=Font.Color;

  FPopupMenuCommands:=TStringList.Create;
  TStringList(FPopupMenuCommands).OnChange:=PopupMenuCommandsChanged;

  buildPopUpMenu;

end;

procedure TfyDBGrid.DblClick;
var
  plc, // previous left column
  i: integer;
  p: TPoint;
  r: TRect;

begin
  inherited;

  if not checkDBPrerequisites then
    Exit;

  playSoundInMemory(FDblClickSoundEnabled, sndDblClick, 'DblClick');

  plc := leftCol;
  p := CalcCursorPos;

  // if cell is the corner one then autofit all columns
  if pointInRect(p, CellRect(0, 0)) then
  begin
    autoFitAll;
    Exit;
  end;

  // find the column that should be auto widthed
  for i := 0 to Columns.Count - 1 do
  begin
    r := CellRect(i + 1, 0);
    // if you want just title DblClicks uncomment this line
    // if (p.Y>=r.Top) and (p.Y<=r.Bottom) then
    begin
      if (UseRightToLeftAlignment and (abs(p.X - r.Left) < 5)) or
        ((not UseRightToLeftAlignment) and (abs(p.X - r.Right) < 5)) then
      begin
        autoFitColumn(i, true);
        leftCol := plc;
        // don't allow an extra click event
        dblClicked := true;
        break;
      end
    end;
  end;

end;

function TfyDBGrid.isMultiSelectedRow: Boolean;
var
    Index: Integer;
begin
    Result := (dgMultiSelect in Options) and
      SelectedRows.Find(Datalink.Datasource.Dataset.Bookmark, Index);
end;

procedure TfyDBGrid.DrawCell(ACol, ARow: integer; ARect: TRect;
  AState: TGridDrawState);
var
  ar: TRect;
  MultiSelected: Boolean;
  myLeft, indicIndex, prevousActive: integer;
begin
  try
    if not checkDBPrerequisites then
      Exit;

    if ARow > 0 then  //draw contents
    begin

      if ACol = 0 then  // draw indicators
      begin
        dec(ARow);
        Canvas.StretchDraw(ARect, grBmpTitle);
        // shape borders like a button
        DrawEdge(Canvas.Handle, ARect, BDR_RAISEDOUTER, BF_RECT);

        if (gdFixed in AState) then
        begin
          if Assigned(DataLink) and DataLink.Active  then
          begin
            MultiSelected := False;
            if ARow >= 0 then
            begin
              prevousActive := DataLink.ActiveRecord;
              try
                Datalink.ActiveRecord := ARow;
                MultiSelected := isMultiSelectedRow;
              finally
                Datalink.ActiveRecord := prevousActive;
              end;
            end;
            if (ARow = DataLink.ActiveRecord) or MultiSelected then
            begin
              indicIndex := 0;
              if DataLink.DataSet <> nil then
                case DataLink.DataSet.State of
                  dsEdit: indicIndex := 1;
                  dsInsert: indicIndex := 2;
                  dsBrowse:
                    if MultiSelected then
                      if (ARow <> Datalink.ActiveRecord) then
                        indicIndex := 3
                      else
                        indicIndex := 4;  // multiselected and current row
                end;
              myIndicators.BkColor := FixedColor;
              myLeft := ARect.Right - myIndicators.Width - 1;
              if Canvas.CanvasOrientation = coRightToLeft then Inc(myLeft);
              myIndicators.Draw(Canvas, myLeft,
                (ARect.Top + ARect.Bottom - myIndicators.Height) shr 1, indicIndex, dsTransparent, itImage,True);
            end;
          end;
        end;
        inc(ARow);
      end
      else // draw grid content
        inherited;
    end
    else // draw titles
    begin
      Canvas.StretchDraw(ARect, grBmpTitle);

      ar:=ARect;
      // shape borders like a button
      DrawEdge(Canvas.Handle, AR, BDR_RAISEDOUTER, BF_RECT);

      // write title
      if ACol > 0 then
        myDrawText(Columns[ACol - 1].Title.Caption, Canvas, AR, Columns[ACol - 1].Title.Alignment , Columns[ACol - 1].Title.Font)

    end;

    // make search editbox visible if it is necessary
    if lastSearchColumn <> nil then
      if (ACol > 0) and (ARow = 0) then
      begin

        if searchVisible then
        begin
          edtSearchCriteria.Visible :=isVisibleColumn(lastSearchColumn);

          // reposition edit box
          if (Columns[ACol - 1].FieldName = searchFieldName) then
          begin
            // adjust search edit box position
            ar := CellRect(ACol, 0);
            if edtSearchCriteria.Visible then
            begin
              if UseRightToLeftAlignment then
                edtSearchCriteria.Left := ClientWidth - ARect.Right
              else
                edtSearchCriteria.Left := ARect.Left;
              edtSearchCriteria.Width := ARect.Right - ARect.Left;
            end;
          end;

        end
      end;

    if (ARow = 0) and (ACol = 0) then
      drawCircleInRect(ARect);

    // draw an arrow in sorted columns
    if (lastSortColumn <> nil) then
    begin
      if (lastSortColumn.Index + 1 = ACol) and (ARow = 0) then
        drawTriangleInRect(ARect, lastSortType,
             Columns[ACol - 1].Title.Alignment);
    end;

  except
    OutputDebugString(pchar(format('Error in DrawCell c = %d  r = %d' , [ACol,ARow])));
  end;
end;



procedure TfyDBGrid.DrawColumnCell(const Rect: TRect; DataCol: integer;
  Column: TColumn; State: TGridDrawState);
var
  row, i: integer;
  r:trect;
begin
  try
    inherited;

    if not checkDBPrerequisites then
      Exit;

    row := DataSource.DataSet.recNo;

    // if number of rows have been changed then reallocate memory for their info
    if RowCount <> lastRowCount then
    begin
      SetLength(ri, RowCount);
      lastRowCount := RowCount;
      // reset all records
      for i := 0 to RowCount - 1 do
      begin
        ri[i].recNo := -1;
        ri[i].top := 0;
        ri[i].bottom := 0;
      end;
    end;

    // find first empty rowInfo element or same row position
    // and store this row info
    for i := 0 to RowCount - 1 do
      if (ri[i].recNo = -1) or
        ((ri[i].top = Rect.top) and (ri[i].bottom = Rect.bottom)) then
      begin
        ri[i].recNo := row;
        ri[i].top := Rect.top;
        ri[i].bottom := Rect.bottom;
        break;
      end;

    //save previous column font
    tempFont.Assign(Column.Font);

    if (gdSelected in State) then
    begin
      // draw gradient background
      Canvas.StretchDraw(Rect, grBmpActive);
      tempFont.Color:=FActiveCellFontColor;
    end
    else if isMultiSelectedRow then
    begin
      Canvas.StretchDraw(Rect, grBmpSelected);
      tempFont.Color:=FSelectedCellFontColor;
    end
    else if Odd(row) then
    begin
      Canvas.StretchDraw(Rect, grBmpAlt1);
    end
    else
    begin
      Canvas.StretchDraw(Rect, grBmpAlt2);
    end;

    if Column.Field<>nil then
      myDrawText(Column.Field.DisplayText, Canvas, Rect, Column.alignment, tempFont);

    //draw border
    r:=rect;
    Canvas.Brush.Style := bsClear;
    Canvas.Pen.Color:=clGray;
    InflateRect(r, 1,1);
    Canvas.Rectangle(r);

  except
    OutputDebugString(PChar(format('Error in DCC : %d %d',
      [Rect.top, Rect.Left])));
  end;
end;

procedure TfyDBGrid.drawTriangleInRect(r: TRect; st: TSortType; al: TAlignment);
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

  // draw shadow
  Canvas.Brush.Color := clGray;
  Canvas.Pen.Color := clGray;
  if st = stAsc then
    Canvas.Polygon([point(r.Right - 2 - OFFSET - goLeft, r.top + 10 + OFFSET),
      point(r.Right - 7 - OFFSET - goLeft, r.top + 5 + OFFSET),
      point(r.Right - 12 - OFFSET - goLeft, r.top + 10 + OFFSET)])

  else if st = stDesc then
    Canvas.Polygon([point(r.Right - 2 - OFFSET - goLeft, r.top + 5 + OFFSET),
      point(r.Right - 7 - OFFSET - goLeft, r.top + 10 + OFFSET),
      point(r.Right - 12 - OFFSET - goLeft, r.top + 5 + OFFSET)]);

  // draw triangle
  Canvas.Brush.Color := FSortArrowColor;
  Canvas.Pen.Color := FSortArrowColor;
  if st = stAsc then
    Canvas.Polygon([point(r.Right - 2 - goLeft, r.top + 10),
      point(r.Right - 7 - goLeft, r.top + 5), point(r.Right - 12 - goLeft,
      r.top + 10)])

  else if st = stDesc then
    Canvas.Polygon([point(r.Right - 2 - goLeft, r.top + 5),
      point(r.Right - 7 - goLeft, r.top + 10), point(r.Right - 12 - goLeft,
      r.top + 5)]);

end;

procedure TfyDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var
  p1: pointer;
  p: TArray<System.Byte>;
begin
  inherited;

  if not checkDBPrerequisites then
    Exit;

  // clear filters and search criteria if users presses escape
  if Key = VK_ESCAPE then
  begin
    playSoundInMemory(FEscSoundEnabled, sndEsc, 'Escape');

    p := DataSource.DataSet.GetBookmark;

    ClearFilter;
    ClearSort;

    if DataSource.DataSet.BookmarkValid(p) then
    begin
      DataSource.DataSet.GotoBookmark(p);
      DataSource.DataSet.FreeBookmark(p);
    end;

    invalidate;
  end;

end;

procedure TfyDBGrid.MouseMove(Shift: TShiftState; X, Y: integer);
var
  i: integer;
  gc: TGridCoord;
  gr: TGridRect;
begin
  inherited;



  if not checkDBPrerequisites then
    Exit;

  // if need auto focus then take focus to this control
 // if (not searchVisible) and FAutoFocus and (not Focused) then
   // SetFocus(Handle);

  if FHotTrack then
  if DataSource.DataSet.State = dsBrowse then  //do not bother user actions
  begin

    // prevent repetitive mouse move events
    if (lastMouseX = X) and (lastMouseY = Y) then
      Exit
    else
    begin
      lastMouseX := X;
      lastMouseY := Y;
    end;

    // move to the suitable row
    // ri was filled in CellDraw
    for i := 0 to high(ri) do
      if (Y >= ri[i].top) and (Y <= ri[i].bottom) then
      begin

        if ri[i].recNo < 1 then
          continue;

        // movebackward or forward to reach to the pointer
        // you could set RecNo exactly to the desired no to
        // see the disastrous results

        if ri[i].recNo > DataSource.DataSet.recNo then
        begin
          while ri[i].recNo > DataSource.DataSet.recNo do
            DataSource.DataSet.Next;
          break;
        end
        else if ri[i].recNo < DataSource.DataSet.recNo then
        begin
          while ri[i].recNo < DataSource.DataSet.recNo do
            DataSource.DataSet.Prior;
          break;
        end
      end;

    // if row select is not enabled
    if not(dgRowSelect in Options) then
    begin
      // move to cell under mouse pointer
      gc := MouseCoord(X, Y);
      if (gc.X > 0) and (gc.Y > 0) then
      begin
        gr.Left := gc.X;
        gr.Right := gc.X;
        gr.top := gc.Y;
        gr.bottom := gc.Y;
        Selection := gr;
      end;
    end;
    // update indicator column
    InvalidateCol(0);
  end;

end;

// gets a column index and finds the minimum with ofits content
procedure TfyDBGrid.autoFitColumn(ix: integer; canDisableControls:boolean);
var
  mw, cw: integer;
  p1: pointer;
  p: TArray<System.Byte>;
begin
  if not checkDBPrerequisites then
    Exit;

  mw := 0;

  with DataSource.DataSet do
  begin
    if canDisableControls then
    begin
      p := GetBookmark;
      DisableControls;
    end;


    First;
    while not Eof do
    begin
      cw := Canvas.TextWidth(FieldByName(Columns[ix].FieldName).AsString);
      if cw > mw then
        mw := cw;
      Next;
    end;

    if canDisableControls then
    begin
      EnableControls;

      if BookmarkValid(p) then
      begin
        GotoBookmark(p);
        FreeBookmark(p);
      end;
    end;
  end;

  mw := mw + 5; // put a margin aside

  if (FAutoWidthMin <> 0) then
    mw := Max(FAutoWidthMin, mw);

  if (FAutoWidthMax <> 0) then
    mw := Min(FAutoWidthMax, mw);

  Columns[ix].Width := mw;
end;

procedure TfyDBGrid.SetAltRowColor1Start(const Value: TColor);
begin
  FAltRowColor1Start := Value;
  produceAltRow1Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor2Start(const Value: TColor);
begin
  FAltRowColor2Start := Value;
  produceAltRow2Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetSelectedColorStart(const Value: TColor);
begin
  FSelectedColorStart := Value;
  produceSelectedGradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor1Finish(const Value: TColor);
begin
  FAltRowColor1Finish := Value;
  produceAltRow1Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor2Finish(const Value: TColor);
begin
  FAltRowColor2Finish := Value;
  produceAltRow2Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetSelectedColorFinish(const Value: TColor);
begin
  FSelectedColorFinish := Value;
  produceSelectedGradient;
  invalidate;
end;

procedure TfyDBGrid.TitleClick(Column: TColumn);
var
  p1: pointer;
  p: TArray<System.Byte>;
  plc: integer; // previous left column
begin
  inherited;

  if dblClicked then
  begin
    // ignore DblClicks
    dblClicked := false;
    Exit;
  end;

  if not FAllowSort then
    Exit;

  if not checkDBPrerequisites then
    Exit;

  if not(DataSource.DataSet is TFDQuery) then
    Exit;

  playSoundInMemory(FSortSoundEnabled, sndSort, 'Sort');

  plc := leftCol;
  p := DataSource.DataSet.GetBookmark;

  try

    if lastSortColumn <> Column then
    begin
      // new column to sort
      lastSortColumn := Column;
      lastSortType := stAsc;

      TFDQuery(DataSource.DataSet).IndexFieldNames := Column.FieldName + ':A';
    end
    else
    begin
      // reverse sort order
      if lastSortType = stAsc then
      begin
        lastSortType := stDesc;
        TFDQuery(DataSource.DataSet).IndexFieldNames := Column.FieldName + ':D';
      end
      else
      begin
        lastSortType := stAsc;
        TFDQuery(DataSource.DataSet).IndexFieldNames := Column.FieldName + ':A';
      end;
    end;

  except
      showmessage('Error in sorting !');
  end;


  if DataSource.DataSet.BookmarkValid(p) then
  begin
    DataSource.DataSet.GotoBookmark(p);
    DataSource.DataSet.FreeBookmark(p);
  end;
  leftCol := plc;
end;

procedure Register;
begin
  RegisterComponents('fyControls', [TfyDBGrid]);
end;

procedure TfyDBGrid.WndProc(var Message: TMessage);
var
  di: TGridDrawInfo;
  ctrlPressed: boolean;
begin
  // disable unwanted scrolls
  if (Message.Msg <> WM_MOUSEWHEEL) then
    inherited;

  // leftCol is not stable for our job so we had to have an internal myLeftCol
  if Message.Msg = WM_HSCROLL then
  begin
    CalcDrawInfo(di);
    myLeftCol := di.Horz.FirstGridCell;
  end;

  // the control should have focus to receive this message
  if Message.Msg = WM_MOUSEWHEEL then
  begin
    ctrlPressed := ((Message.WParam and $FFFF) and (MK_CONTROL)) > 0;

    if Message.WParam < 0 then
    begin
      if not checkDBPrerequisites then
        Exit;
      if ctrlPressed then
      begin
        // horizontal scroll
        incLeftCol;
      end
      else
      begin
        // vertical scroll
        if not DataSource.DataSet.Eof then
        begin
          DataSource.DataSet.Next;
          InvalidateCol(0);
        end;
      end;
    end
    else
    begin
      if not checkDBPrerequisites then
        Exit;
      if ctrlPressed then
        // horizontal scroll
        decLeftCol
      else
      begin
        // vertical scroll
        if not DataSource.DataSet.Bof then
        begin
          DataSource.DataSet.Prior;
          InvalidateCol(0);
        end;
      end;
    end;

  end;

end;


procedure TfyDBGrid.extractRGB(cl: TColor; var red, green, blue: byte);
begin
  red := getRValue(cl);
  green := getGValue(cl);
  blue := getBValue(cl);
end;

procedure TfyDBGrid.SetAltRowColor1Steps(const Value: integer);
begin
  if (Value < 1) or (Value > 50) then
  begin
    ShowMessage('Value should be between 1 and 50');
    Exit;
  end;

  FAltRowColor1Steps := Value;
  produceAltRow1Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor2Steps(const Value: integer);
begin
  if (Value < 1) or (Value > 50) then
  begin
    ShowMessage('Value should be between 1 and 50');
    Exit;
  end;

  FAltRowColor2Steps := Value;
  produceAltRow2Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetSelectedColorSteps(const Value: integer);
begin
  if (Value < 1) or (Value > 50) then
  begin
    ShowMessage('Value should be between 1 and 50');
    Exit;
  end;

  FSelectedColorSteps := Value;
  produceSelectedGradient;
  invalidate;
end;

procedure TfyDBGrid.SetAutoFocus(const Value: boolean);
begin
  FAutoFocus := Value;
end;

procedure TfyDBGrid.SetHotTrack(const Value: boolean);
begin
  FHotTrack := Value;
  if FHotTrack then
    Cursor := crHandPoint
  else
    Cursor := crDefault;
end;

procedure TfyDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
var
  i: integer;
  r: TRect;
  mp: TPoint;
begin
  inherited;

  if not checkDBPrerequisites then
    Exit;

  //remember last rows height and restore it to
  //previous state after column resizing
  if RowCount>0 then
    lastRowHeight:=RowHeights[0];

  //remember an original row height and
  //restore it in case of rows were oversized by user.
  //in autoWidthAll it will be restored
  if originalRowHeight=0 then
    originalRowHeight:=DefaultRowHeight;

  // if user clicked out of editbox then make it invisible
  if edtSearchCriteria.Visible then
  begin
    mp:= CalcCursorPos;
    if not pointInRect(mp, edtSearchCriteria.ClientRect) then
    begin
      edtSearchCriteria.Visible := false;
      searchVisible := false;
      edtSearchCriteria.invalidate;
    end;
  end;

  //right click on content
  if cellHeight(0,0)<y then
  begin
   if (Button = mbRight) and Assigned(pmCommands) then
      pmCommands.Popup(ClientToScreen(point(x,y) ).X,ClientToScreen(point(x,y) ).Y);
  end
  else if (Button = mbRight) and FAllowFilter then //right click on title
  begin
    for i := 0 to Columns.Count - 1 do
    begin
      r := CellRect(i + 1, 0);

      mp := CalcCursorPos;

      // if mouse in column title
      if pointInRect(mp, r) then
      begin
        if (Columns[i].Field.DataType = ftString) or
          (Columns[i].Field.DataType = ftWideString) then
        begin
          if not(filtering and (lastSearchColumn = Columns[i])) then
            ClearFilter;

          lastSearchColumn := Columns[i];
          edtSearchCriteria.Visible := true;
          searchVisible := true;

          if searchFieldName <> Columns[i].FieldName then
            searchFieldName := Columns[i].FieldName
          else
            edtSearchCriteria.Text := lastSearchStr;

          edtSearchCriteria.Font := Columns[i].Title.Font;
          edtSearchCriteria.Color := clWindow;
          edtSearchCriteria.Font.Color := clWindowText;

          // alignEditToRect(edtSearchCriteria, r);

          edtSearchCriteria.Left := r.Left;
          edtSearchCriteria.top := r.top;
          edtSearchCriteria.Width := r.Right - r.Left;
          edtSearchCriteria.Height := r.bottom - r.top;

          filtering := true;
          LeftCol:=myLeftCol;
          //SetFocus(edtSearchCriteria.Handle);
          break;
        end;
      end;

    end;
  end;


end;

procedure TfyDBGrid.edtSearchCriteriaWindowProc(var Message: TMessage);
var
  plc, psp: integer;
  Msg: tagMSG;
  critStr: string;
begin
  // windowproc for search criteria edit box

  // edtbox doesn't know what to do whith WM_MOUSEWHEEL so we have diverted it
  if Message.Msg = WM_MOUSEWHEEL then
    PostMessage(Handle, Message.Msg, Message.WParam, Message.LParam)
  else
    lastEditboxWndProc(Message);

  if not(( Message.Msg = WM_KEYDOWN ) or ( Message.Msg = WM_CHAR )) then
    exit;

  if Message.Msg = WM_KEYDOWN then
  begin

    if Message.WParam = VK_ESCAPE then
    begin

      playSoundInMemory(FEscSoundEnabled, sndEsc, 'Escape');

      // first escape disappears the search box
      // second escape disables searchs and  sortings
      if searchVisible then
      begin
        // there are some remaining messages that cause windows to play an
        // exclamation sound because editbox is not visible after this.
        // by removing remaining messages we prevent that unwanted sounds
        while (GetQueueStatus(QS_ALLINPUT)) > 0 do
          PeekMessage(Msg, 0, 0, 0, PM_REMOVE);

        edtSearchCriteria.Visible := false;
        searchVisible := false;
        edtSearchCriteria.invalidate;
      end
      else
        ClearFilter;

    end
    else if (Message.WParam = VK_DOWN) then
    begin
      // if user presses down arrow it means that he/she needs to go forward
      // in records
      DataSource.DataSet.Next;
      //SetFocus(Handle);
    end
    else if (Message.WParam = VK_UP) then
    begin
      DataSource.DataSet.Prior;
      //SetFocus(Handle);
    end;
  end;

  // there was a change in search criteria
  if lastSearchStr<>edtSearchCriteria.Text then
  begin
    if filtering then
    begin
      plc := leftCol;
      lastSearchStr := edtSearchCriteria.Text;
      psp:=edtSearchCriteria.SelStart;

      if lastSearchStr <> '' then
      begin
        DataSource.DataSet.Filtered := false;

        critStr := '[' + searchFieldName + '] LIKE ''%' + lastSearchStr + '%''';
        //critStr := '[' + searchFieldName + '] = ''' + lastSearchStr + '*''';
        if Assigned(FOnBeforeFilter) then
          FOnBeforeFilter(Self, lastSearchColumn, lastSearchStr, critStr);
        DataSource.DataSet.Filter := critStr;

        try
          DataSource.DataSet.Filtered := true;
        except
          ShowMessage('Couldn''t filter data.');
        end;
      end
      else
      begin
        DataSource.DataSet.Filtered := false;
      end;

      leftCol := plc;
      if not edtSearchCriteria.Focused then
      begin
        //SetFocus(edtSearchCriteria.Handle);
        edtSearchCriteria.SelStart:=psp;
      end;
    end;
  end;

end;

function TfyDBGrid.pointInRect(p: TPoint; r: TRect): boolean;
begin
  Result := (p.X >= r.Left) and (p.X <= r.Right) and (p.Y >= r.top) and
    (p.Y <= r.bottom);
end;

procedure TfyDBGrid.ClearFilter;
var
  lrh, llc: integer;
begin
  try
    if not checkDBPrerequisites then
      Exit;
    if DataSource.DataSet.Filtered then
    begin

      llc := leftCol;
      lrh := DefaultRowHeight;

      DataSource.DataSet.Filtered := false;
      DataSource.DataSet.Filter := '';

      lastSearchStr := '';
      searchFieldName := '';
      lastSearchColumn := nil;

      edtSearchCriteria.Text := '';
      edtSearchCriteria.Visible := false;
      searchVisible := false;

      leftCol := llc;
      filtering := false;

      DefaultRowHeight := lrh;

      invalidate;

    end;
  except
    ShowMessage('Error in clearing filter !')
  end;
end;

procedure TfyDBGrid.Paint;
var
  B: TBitmap;
begin

  if checkDBPrerequisites then
  begin
    inherited
  end
  else
  begin
    // draw a gradient and write NO DATA whenthere is no data connection
    B := nil;
    drawVerticalGradient(B, Height, clRed, clWhite, clBlue);

    Canvas.StretchDraw(ClientRect, B);
    B.Free;
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Name := 'Tahoma';
    Canvas.Font.Size := 20;
    Canvas.TextRect(ClientRect, 10, 10, 'No Data !');

    // detect resizes
    if resized then
    begin
      invalidate;
      resized := false;
    end;
  end;

end;

procedure TfyDBGrid.autoFitAll;
var
  i: integer;
begin
  if not checkDBPrerequisites then
    Exit;

  //just one disablecontrols makes autofitcolumn faster but
  //it makes a longtime to respond to user in huge datasets
  //no application.processmessages to prevent application confusion
  DataSource.DataSet.DisableControls;

  for i := 0 to Columns.Count - 1 do
    autoFitColumn(Columns[i].Index, false);

  DataSource.DataSet.EnableControls;

  DefaultRowHeight:=originalRowHeight;
end;

function TfyDBGrid.isVisibleColumn(cl: TColumn): boolean;
var
  tw, i: integer;
  di: TGridDrawInfo;
begin
  Result := (cellWidth(cl.Index + 1, 0) > 0);
  Exit;

  if myLeftCol > (cl.Index + 1) then
  begin
    Result := false;
    Exit;
  end
  else if myLeftCol = (cl.Index + 1) then
  begin
    Result := true;
    Exit;
  end;

  CalcDrawInfo(di);
  tw := 0;
  for i := 0 to di.Horz.FixedCellCount - 1 do
    tw := cellWidth(i, 0) + di.Vert.EffectiveLineWidth;

  // iterate through data columns up to one before this column
  for i := myLeftCol - 1 to cl.Index - 1 do
    tw := tw + Columns[i].Width + di.Vert.EffectiveLineWidth;
  Result := (tw > 0) and (tw <= ClientWidth);

end;

procedure TfyDBGrid.SetAltRowColor1Center(const Value: TColor);
begin
  FAltRowColor1Center := Value;
  produceAltRow1Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor1CenterPosition(const Value: integer);
begin
  if (Value < 0) or (Value > 100) then
  begin
    ShowMessage('Value should be between 0 and 100');
    Exit;
  end;

  FAltRowColor1CenterPosition := Value;
  produceAltRow1Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor2Center(const Value: TColor);
begin
  FAltRowColor2Center := Value;
  produceAltRow2Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetAltRowColor2CenterPosition(const Value: integer);
begin
  if (Value < 0) or (Value > 100) then
  begin
    ShowMessage('Value should be between 0 and 100');
    Exit;
  end;

  FAltRowColor2CenterPosition := Value;
  produceAltRow2Gradient;
  invalidate;
end;

procedure TfyDBGrid.SetSelectedColorCenter(const Value: TColor);
begin
  FSelectedColorCenter := Value;
  produceSelectedGradient;
  invalidate;
end;

procedure TfyDBGrid.SetSelectedColorCenterPosition(const Value: integer);
begin
  if (Value < 0) or (Value > 100) then
  begin
    ShowMessage('Value should be between 0 and 100');
    Exit;
  end;

  FSelectedColorCenterPosition := Value;
  produceSelectedGradient;
  invalidate;
end;

procedure TfyDBGrid.produceSelectedGradient;
begin
  drawVerticalGradient(grBmpSelected, FSelectedColorSteps, FSelectedColorStart,
    FSelectedColorCenter, FSelectedColorFinish, FSelectedColorCenterPosition);
end;

procedure TfyDBGrid.produceAltRow1Gradient;
begin
  drawVerticalGradient(grBmpAlt1, FAltRowColor1Steps, FAltRowColor1Start,
    FAltRowColor1Center, FAltRowColor1Finish, FAltRowColor1CenterPosition);
end;

procedure TfyDBGrid.produceAltRow2Gradient;
begin
  drawVerticalGradient(grBmpAlt2, FAltRowColor2Steps, FAltRowColor2Start,
    FAltRowColor2Center, FAltRowColor2Finish, FAltRowColor2CenterPosition);
end;

procedure TfyDBGrid.drawVerticalGradient(var grBmp: TBitmap; gHeight: integer;
  color1, color2, color3: TColor; centerPosition: integer);
var
  graphics: TGraphic;
  //linGrBrush: TGPLinearGradientBrush;
  r1, g1, b1, r2, g2, b2, r3, g3, b3: byte;
  colors: array [0 .. 2] of TColor;
  blendPoints: array [0 .. 2] of single;
begin
{  try
    if Assigned(grBmp) then
      grBmp.Free;
    grBmp := TBitmap.create;

    grBmp.Width := 1;
    grBmp.Height := gHeight;

    extractRGB(color1, r1, g1, b1);
    extractRGB(color2, r2, g2, b2);
    extractRGB(color3, r3, g3, b3);
    //graphics := TGraphic.Create(grBmp.Canvas.Handle);
    //linGrBrush := TGPLinearGradientBrush.create(MakePoint(0, 0),
    //  MakePoint(0, gHeight), MakeColor(255, 255, 255, 255),
    //  MakeColor(255, 255, 255, 255));

    colors[0] := RGB(r1, g1, b1);
    blendPoints[0] := 0;
    colors[1] := RGB(r2, g2, b2);
    blendPoints[1] := centerPosition / 100;
    colors[2] := RGB(r3, g3, b3);
    blendPoints[2] := 1;

    //linGrBrush.SetInterpolationColors(@colors, @blendPoints, 3);

    //graphics.FillRectangle(linGrBrush, 0, 0, 1, gHeight);

    //linGrBrush.Free;
    graphics.Free;
  except
    OutputDebugString('Error in creating gradient.');
  end;}
end;

procedure TfyDBGrid.drawCircleInRect(r: TRect);
begin
  Canvas.Lock;
  Canvas.Brush.Color := clGray;
  Canvas.Pen.Color := clGray;
  Canvas.Ellipse(1, 4, 7, 10);

  Canvas.Brush.Color := FAutoWidthAllColor;
  Canvas.Pen.Color := FAutoWidthAllColor;
  Canvas.Ellipse(3, 3, 9, 9);
  Canvas.Unlock;
end;

procedure TfyDBGrid.SetTitleColorCenter(const Value: TColor);
begin
  FTitleColorCenter := Value;
  produceTitleGradient;
  InvalidateTitles;
end;

procedure TfyDBGrid.SetTitleColorCenterPosition(const Value: integer);
begin
  if (Value < 0) or (Value > 100) then
  begin
    ShowMessage('Value should be between 1 and 50');
    Exit;
  end;
  FTitleColorCenterPosition := Value;
  produceTitleGradient;
  InvalidateTitles;
end;

procedure TfyDBGrid.SetTitleColorFinish(const Value: TColor);
begin
  FTitleColorFinish := Value;
  produceTitleGradient;
  InvalidateTitles;
end;

procedure TfyDBGrid.SetTitleColorStart(const Value: TColor);
begin
  FTitleColorStart := Value;
  produceTitleGradient;
  InvalidateTitles;
end;

procedure TfyDBGrid.SetTitleColorSteps(const Value: integer);
begin
  if (Value < 1) or (Value > 50) then
  begin
    ShowMessage('Value should be between 1 and 50');
    Exit;
  end;
  FTitleColorSteps := Value;
  produceTitleGradient;
  InvalidateTitles;
end;

procedure TfyDBGrid.produceTitleGradient;
begin
  drawVerticalGradient(grBmpTitle, FTitleColorSteps, FTitleColorStart,
    FTitleColorCenter, FTitleColorFinish, FTitleColorCenterPosition);
end;


procedure TfyDBGrid.SetAutoWidthMax(const Value: integer);
begin
  if (Value < 0) then
  begin
    ShowMessage('Value should be greater equal to zero.');
    Exit;
  end;
  if (Value <> 0) and (Value < FAutoWidthMin) then
  begin
    ShowMessage('Value should be greater than auto with min value.');
    Exit;
  end;

  FAutoWidthMax := Value;
end;

procedure TfyDBGrid.SetAutoWidthMin(const Value: integer);
begin
  if (Value < 0) then
  begin
    ShowMessage('Value should be greater equal to zero.');
    Exit;
  end;
  if (Value <> 0) and (FAutoWidthMax <> 0) and (Value > FAutoWidthMax) then
  begin
    ShowMessage('Value should be less than auto with max value.');
    Exit;
  end;
  FAutoWidthMin := Value;
end;

procedure TfyDBGrid.Resize;
begin
  inherited;
  // notify PAINT method of a resize event
  resized := true;
end;

procedure TfyDBGrid.ClearSort;
begin
  lastSortColumn := nil;
  lastSortType := stNone;
  if DataSource.DataSet is TFDQuery then
    TFDQuery(DataSource.DataSet).IndexFieldNames := '';
end;

procedure TfyDBGrid.ColWidthsChanged;
begin
  myLeftCol := leftCol;

  inherited;

  // update internal myLeftCol value
  leftCol:=myLeftCol;

  //restore resized row heights
  if lastRowHeight>0 then
    DefaultRowHeight:=lastRowHeight;
end;

procedure TfyDBGrid.Scroll(Distance: integer);
begin
  inherited;
  playSoundInMemory(FMoveSoundEnabled, sndHover, 'hover');

  if row > TopRow then
  begin
    while not rowVisible(row) do
      TopRow := TopRow + 1;
  end
  else if row < TopRow then
  begin
    while not rowVisible(row) do
      TopRow := TopRow - 1;
  end
end;

procedure TfyDBGrid.SetAutoWidthAllColor(const Value: TColor);
begin
  FAutoWidthAllColor := Value;
  InvalidateCell(0, 0);
end;

procedure TfyDBGrid.SetMoveSoundEnabled(const Value: boolean);
begin
  FMoveSoundEnabled := Value;
end;

procedure TfyDBGrid.SetSortArrowColor(const Value: TColor);
begin
  FSortArrowColor := Value;
  InvalidateTitles;
end;

procedure TfyDBGrid.decLeftCol;
begin
  if leftCol > 1 then
  begin
    leftCol := leftCol - 1;
    myLeftCol := leftCol;
    invalidate;
  end;

end;

procedure TfyDBGrid.incLeftCol;
begin
  if leftCol < (Columns.Count) then
  begin
    leftCol := leftCol + 1;
    myLeftCol := leftCol;
    invalidate;
  end;

end;

function TfyDBGrid.cellWidth(ACol, ARow: integer): integer;
var
  r: TRect;
begin
  r := CellRect(ACol, ARow);
  Result := r.Right - r.Left;
end;

procedure TfyDBGrid.CalcSizingState(X, Y: integer; var State: TGridState;
  var Index, SizingPos, SizingOfs: integer; var FixedInfo: TGridDrawInfo);
var
  i: integer;
begin
  inherited;

  if MouseCoord(x,y).X=-1 then
    exit;

  for i := myLeftCol - 1 to Columns.Count - 1 do
    if abs(getColumnRightEdgePos(Columns[i]) - X) < 5 then
    begin
      State := gsColSizing;
      Index := i + 1;
      if IsRightToLeft then
        SizingPos := ClientWidth - X
      else
        SizingPos := X;
      SizingOfs := 0;
    end;


  if FAllowRowResize then
    if State <> gsColSizing then
        for i := 0 to high(ri) do
        begin //search rows bottom line positions
          if (abs(ri[i].bottom - Y) < 3) and  (ri[i].bottom>0) then
          begin
            State := gsRowSizing;
            Index := i + 1;
            SizingPos := Y;
            SizingOfs := 0;
            lastResizedRow := Index;
            Break;
          end;
        end;

end;

function TfyDBGrid.getColumnRightEdgePos(cl: TColumn): integer;
var
  tw, i: integer;
  di: TGridDrawInfo;
begin

  if myLeftCol > (cl.Index + 1) then
  begin
    Result := 0;
    Exit;
  end;

  CalcDrawInfo(di);
  // add fixed cells width and lines between them
  tw := 0;
  for i := 0 to di.Horz.FixedCellCount - 1 do
    tw := cellWidth(i, 0) + di.Vert.EffectiveLineWidth;

  // iterate through data columns up to this column
  for i := myLeftCol - 1 to cl.Index do
    tw := tw + cellWidth(i + di.Horz.FixedCellCount, 0) +
      di.Vert.EffectiveLineWidth;

  if IsRightToLeft then
    Result := Min(abs(ClientWidth - tw), ClientWidth)
  else
    Result := Min(tw, ClientWidth);
end;

procedure TfyDBGrid.SetDblClickSoundEnabled(const Value: boolean);
begin
  FDblClickSoundEnabled := Value;
end;

procedure TfyDBGrid.SetSortSoundEnabled(const Value: boolean);
begin
  FSortSoundEnabled := Value;
end;

procedure TfyDBGrid.SetEscSoundEnabled(const Value: boolean);
begin
  FEscSoundEnabled := Value;
end;

procedure TfyDBGrid.playSoundInMemory(cnd: boolean; m: TResourceStream;
  name: string);
begin
  try
//    if cnd then
//      sndPlaySound(m.Memory, SND_MEMORY or SND_ASYNC);
  except
    OutputDebugString(PChar('Error in playing ' + name + ' sound !'));
  end;
end;

procedure TfyDBGrid.SetAllowFilter(const Value: boolean);
begin
  if not Value then
    ClearFilter;

  FAllowFilter := Value;
end;

procedure TfyDBGrid.SetAllowRowResize(const Value: boolean);
begin
  FAllowRowResize := Value;
end;

procedure TfyDBGrid.SetOnBeforeFilter(const Value: TFilterEvent);
begin
  FOnBeforeFilter := Value;
end;

procedure TfyDBGrid.loadConfig(fn: String);
var
  cf: TIniFile;
begin
  try
    cf := TIniFile.create(fn);
    TitleColorStart := cf.ReadInteger('config', 'TCS', clWhite);
    TitleColorCenter := cf.ReadInteger('config', 'TCC', clWhite);
    TitleColorCenterPosition := cf.ReadInteger('config', 'TCCP', 50);
    TitleColorFinish := cf.ReadInteger('config', 'TCF', clWhite);
    TitleColorSteps := cf.ReadInteger('config', 'TCSTP', 50);

    ActiveColorStart := cf.ReadInteger('config', 'ACS', clWhite);
    ActiveColorCenter := cf.ReadInteger('config', 'ACC', clNavy);
    ActiveColorCenterPosition := cf.ReadInteger('config', 'ACCP', 50);
    ActiveColorFinish := cf.ReadInteger('config', 'ACF', clWhite);
    ActiveColorSteps := cf.ReadInteger('config', 'ACSTP', 50);
    ActiveCellFontColor := cf.ReadInteger('config', 'ACFC', clBlack);


    SelectedColorStart := cf.ReadInteger('config', 'SCS', clWhite);
    SelectedColorCenter := cf.ReadInteger('config', 'SCC', clWhite);
    SelectedColorCenterPosition := cf.ReadInteger('config', 'SCCP', 50);
    SelectedColorFinish := cf.ReadInteger('config', 'SCF', clWhite);
    SelectedColorSteps := cf.ReadInteger('config', 'SCSTP', 50);
    SelectedCellFontColor := cf.ReadInteger('config', 'SCFC', clBlack);

    AltRowColor1Start := cf.ReadInteger('config', 'A1CS', clWhite);
    AltRowColor1Center := cf.ReadInteger('config', 'A1CC', clWhite);
    AltRowColor1CenterPosition := cf.ReadInteger('config', 'A1CCP', 50);
    AltRowColor1Finish := cf.ReadInteger('config', 'A1CF', clWhite);
    AltRowColor1Steps := cf.ReadInteger('config', 'A1CSTP', 50);

    AltRowColor2Start := cf.ReadInteger('config', 'A2CS', clWhite);
    AltRowColor2Center := cf.ReadInteger('config', 'A2CC', clWhite);
    AltRowColor2CenterPosition := cf.ReadInteger('config', 'A2CCP', 50);
    AltRowColor2Finish := cf.ReadInteger('config', 'A2CF', clWhite);
    AltRowColor2Steps := cf.ReadInteger('config', 'A2CSTP', 50);

    SortArrowColor := cf.ReadInteger('config', 'SortArrowColor', clYellow);
    AutoWidthAllColor := cf.ReadInteger('config', 'AutoWidthAllColor',
      clYellow);

    AutoWidthMin := cf.ReadInteger('config', 'AutoWidthMin', 0);
    AutoWidthMax := cf.ReadInteger('config', 'AutoWidthMax', 0);

    AllowSort := cf.ReadBool('config', 'AllowSort', false);
    AllowRowResize := cf.ReadBool('config', 'AllowRowResize', false);
    AllowFilter := cf.ReadBool('config', 'AllowFilter', false);
    MoveSoundEnabled := cf.ReadBool('config', 'MoveSoundEnabled', false);
    SortSoundEnabled := cf.ReadBool('config', 'SortSoundEnabled', false);
    DblClickSoundEnabled := cf.ReadBool('config',
      'DblClickSoundEnabled', false);
    EscSoundEnabled := cf.ReadBool('config', 'EscSoundEnabled', false);
    HotTrack := cf.ReadBool('config', 'HotTrack', false);
    AutoFocus := cf.ReadBool('config', 'AutoFocus', false);

    // *********************************************************************

    Font.Name := cf.ReadString('config', 'FN', 'Tahoma');
    Font.Size := cf.ReadInteger('config', 'FS', 8);
    Font.Color := cf.ReadInteger('config', 'FC', clBlack);
    SetSetProp(Font, 'Style', cf.ReadString('config', 'FSTL', ''));
    Color := cf.ReadInteger('config', 'Color', clWhite);
    FixedColor := cf.ReadInteger('config', 'FixColor', clBtnFace);
    TitleFont.Name := cf.ReadString('config', 'TFN', 'Tahoma');
    TitleFont.Color := cf.ReadInteger('config', 'TFC', clBlack);
    TitleFont.Size := cf.ReadInteger('config', 'TFS', 8);
    SetSetProp(TitleFont, 'Style', cf.ReadString('config', 'TFSTL', ''));

    SetSetProp(Self, 'Options', cf.ReadString('config', 'OPT',
      'dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgConfirmDelete,dgCancelOnExit')
      );
  finally
    cf.Free;
  end;
end;

procedure TfyDBGrid.saveConfig(fn: String);
var
  cf: TIniFile;
begin
  try
    cf := TIniFile.create(fn);
    cf.WriteInteger('config', 'TCS', TitleColorStart);
    cf.WriteInteger('config', 'TCC', TitleColorCenter);
    cf.WriteInteger('config', 'TCCP', TitleColorCenterPosition);
    cf.WriteInteger('config', 'TCF', TitleColorFinish);
    cf.WriteInteger('config', 'TCSTP', TitleColorSteps);

    cf.WriteInteger('config', 'ACS', ActiveColorStart);
    cf.WriteInteger('config', 'ACC', ActiveColorCenter);
    cf.WriteInteger('config', 'ACCP', ActiveColorCenterPosition);
    cf.WriteInteger('config', 'ACF', ActiveColorFinish);
    cf.WriteInteger('config', 'ACSTP', ActiveColorSteps);
    cf.WriteInteger('config', 'ACFC', ActiveCellFontColor);

    cf.WriteInteger('config', 'SCS', SelectedColorStart);
    cf.WriteInteger('config', 'SCC', SelectedColorCenter);
    cf.WriteInteger('config', 'SCCP', SelectedColorCenterPosition);
    cf.WriteInteger('config', 'SCF', SelectedColorFinish);
    cf.WriteInteger('config', 'SCSTP', SelectedColorSteps);
    cf.WriteInteger('config', 'SCFC', SelectedCellFontColor);

    cf.WriteInteger('config', 'A1CS', AltRowColor1Start);
    cf.WriteInteger('config', 'A1CC', AltRowColor1Center);
    cf.WriteInteger('config', 'A1CCP', AltRowColor1CenterPosition);
    cf.WriteInteger('config', 'A1CF', AltRowColor1Finish);
    cf.WriteInteger('config', 'A1CSTP', AltRowColor1Steps);

    cf.WriteInteger('config', 'A2CS', AltRowColor2Start);
    cf.WriteInteger('config', 'A2CC', AltRowColor2Center);
    cf.WriteInteger('config', 'A2CCP', AltRowColor2CenterPosition);
    cf.WriteInteger('config', 'A2CF', AltRowColor2Finish);
    cf.WriteInteger('config', 'A2CSTP', AltRowColor2Steps);

    cf.WriteInteger('config', 'SortArrowColor', SortArrowColor);
    cf.WriteInteger('config', 'AutoWidthAllColor', AutoWidthAllColor);

    cf.WriteInteger('config', 'AutoWidthMin', AutoWidthMin);
    cf.WriteInteger('config', 'AutoWidthMax', AutoWidthMax);

    cf.WriteBool('config', 'AllowFilter', AllowFilter);
    cf.WriteBool('config', 'AllowSort', AllowSort);
    cf.WriteBool('config', 'AllowRowResize', AllowRowResize);
    cf.WriteBool('config', 'MoveSoundEnabled', MoveSoundEnabled);
    cf.WriteBool('config', 'SortSoundEnabled', SortSoundEnabled);
    cf.WriteBool('config', 'DblClickSoundEnabled', DblClickSoundEnabled);
    cf.WriteBool('config', 'EscSoundEnabled', EscSoundEnabled);
    cf.WriteBool('config', 'HotTrack', HotTrack);
    cf.WriteBool('config', 'AutoFocus', AutoFocus);

    // ************************************************************************

    cf.WriteString('config', 'FN', Font.Name);
    cf.WriteInteger('config', 'FS', Font.Size);
    cf.WriteInteger('config', 'FC', Font.Color);
    cf.WriteString('config', 'FSTL', SetToString(GetPropInfo(Font, 'Style'),
      GetOrdProp(Font, 'Style')));
    cf.WriteInteger('config', 'Color', Color);
    cf.WriteInteger('config', 'FixColor', FixedColor);
    cf.WriteString('config', 'TFN', TitleFont.Name);
    cf.WriteInteger('config', 'TFC', TitleFont.Color);
    cf.WriteInteger('config', 'TFS', TitleFont.Size);
    cf.WriteString('config', 'TFSTL',
      SetToString(GetPropInfo(TitleFont, 'Style'), GetOrdProp(TitleFont,
      'Style')));

    cf.WriteString('config', 'OPT', SetToString(GetPropInfo(Self, 'Options'),
      GetOrdProp(Self, 'options')));
  finally
    cf.Free;
  end;
end;

procedure TfyDBGrid.RowHeightsChanged;
var
  t: integer;
begin
  inherited;

  //resize all rows to the resized row height
  t := RowHeights[lastResizedRow];

  if DefaultRowHeight <> t then
    DefaultRowHeight := t;

  // force recalculating row Infos
  lastRowCount := 0;

  // force recalculate number of visible rows
  SendMessage(Handle, WM_SIZE, 0,0);

  invalidate;
end;

function TfyDBGrid.cellHeight(ACol, ARow: integer): integer;
var
  r: TRect;
begin
  r := CellRect(ACol, ARow);
  Result := r.bottom - r.top;
end;

function TfyDBGrid.rowVisible(rw: integer): boolean;
begin
  Result := not(cellHeight(0, rw) = 0);
end;

function TfyDBGrid.rowFullVisible(rw: integer): boolean;
begin
  Result := (cellHeight(0, rw) = RowHeights[rw]);
  Exit;
end;

destructor TfyDBGrid.destroy;
begin
  try
    grBmpTitle.Free;
    grBmpSelected.Free;
    grBmpAlt1.Free;
    grBmpAlt2.Free;

    sndEsc.Free;
    sndSort.Free;
    sndDblClick.Free;
    sndHover.Free;

    bmpDrawText.Free;
    bmpClipped.Free;
  finally
    inherited;
  end;
end;


procedure TfyDBGrid.SetAllowSort(const Value: boolean);
begin
  FAllowSort := Value;
end;

procedure TfyDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  myLeftCol:= LeftCol;

  inherited;
  LeftCol:=myLeftCol;
end;

procedure TfyDBGrid.SetActiveColorCenter(const Value: TColor);
begin
  FActiveColorCenter := Value;
  produceActiveGradient;
  invalidate;
end;

procedure TfyDBGrid.SetActiveColorCenterPosition(const Value: integer);
begin
  FActiveColorCenterPosition := Value;
  produceActiveGradient;
  invalidate;
end;

procedure TfyDBGrid.SetActiveColorFinish(const Value: TColor);
begin
  FActiveColorFinish := Value;
  produceActiveGradient;
  invalidate;
end;

procedure TfyDBGrid.SetActiveColorStart(const Value: TColor);
begin
  FActiveColorStart := Value;
  produceActiveGradient;
  invalidate;
end;

procedure TfyDBGrid.SetActiveColorSteps(const Value: integer);
begin
  FActiveColorSteps := Value;
  produceActiveGradient;
  invalidate;
end;

procedure TfyDBGrid.produceActiveGradient;
begin
  drawVerticalGradient(grBmpActive, FActiveColorSteps, FActiveColorStart,
    FActiveColorCenter, FActiveColorFinish, FActiveColorCenterPosition);
end;

procedure TfyDBGrid.myDrawText(s:string; outputCanvas: Tcanvas; drawRect: TRect;
                  drawAlignment:TAlignment ; drawFont:TFont);
const
  drawFlags : array [TAlignment] of Integer =
    (DT_WORDBREAK or DT_LEFT  or DT_NOPREFIX,
     DT_WORDBREAK or DT_RIGHT  or DT_NOPREFIX,
     DT_WORDBREAK or DT_CENTER or DT_NOPREFIX );
var
  r:trect;
  bw, bh, cw, ch:integer;
begin
    if s='' then
      exit;

    if UseRightToLeftAlignment then
      case drawAlignment of
        taLeftJustify:  drawAlignment := taRightJustify;
        taRightJustify: drawAlignment := taLeftJustify;
      end;

    r:= drawRect;
    cw:=ClientWidth;
    ch:=ClientHeight;


    //set dimentions for output
    bmpDrawText.Width:=( r.Right - r.Left);
    bmpDrawText.Height:=r.Bottom- r.Top;
    bw:=bmpDrawText.Width;
    bh:=bmpDrawText.Height;


    //set drawing area in output bmp
    drawRect.Left:=0;
    drawRect.Top:=0;
    drawRect.Right:=bw;
    drawRect.Bottom:=bh;

    // if the drawing font color is same as transparent color
    //change transparent color
    if ColorToRGB( drawFont.Color )=(ColorToRGB( bmpDrawText.TransparentColor) and $ffffff) then
       toggleTransparentColor;

    //to make entire surface of canvas transparent
    bmpDrawText.Canvas.FillRect(drawRect);


    //shrink the rectangle
    InflateRect(drawRect, -2,-2);

    //Canvas.Font.Color:=clRed;
    bmpDrawText.Canvas.Font:= drawFont;

    DrawText(bmpDrawText.Canvas.Handle,
               pchar(s), length(s), drawRect,
               drawFlags[drawAlignment]
               );

    if UseRightToLeftAlignment then
    begin
       if r.Right > ClientWidth then
       begin
          bmpClipped.Width:=cw-r.Left;
          bmpClipped.Height:=bh;
          bmpClipped.Canvas.CopyRect(bmpClipped.Canvas.ClipRect, bmpDrawText.Canvas, Rect(bw, 0, bw-( cw - r.Left ), bh) );
          outputCanvas.StretchDraw(rect(r.Left , r.Top, cw, r.Bottom), bmpClipped);
       end
       else
          outputCanvas.StretchDraw(Rect(r.Right, r.Top, r.Left, r.Bottom), bmpDrawText);
    end
    else
       outputCanvas.Draw(r.Left, r.top, bmpDrawText);
end;

procedure TfyDBGrid.SetPopupMenuCommands(const Value: TStrings);
begin
  FPopupMenuCommands.Assign(Value);
end;

procedure TfyDBGrid.onPopupMenuItemClick(Sender: TObject);
begin
  if checkDBPrerequisites then
   if Assigned(fonpopupcommand) then
    FOnPopupCommand(sender, tmenuitem(sender).Tag, DataSource.DataSet.RecNo);
end;

procedure TfyDBGrid.SetOnPopupCommand(const Value: TOnPopupCommandEvent);
begin
  FOnPopupCommand := Value;
end;


procedure TfyDBGrid.buildPopUpMenu;
var
 mi:TMenuItem;
 i, j, t:integer;
begin
  if not assigned(pmCommands) then
  begin
    pmCommands:= tpopupmenu.Create(Parent);
    pmCommands.AutoPopup:=false;
  end;

  pmCommands.Items.Clear;

  for i:= 0 to FPopupMenuCommands.Count-1 do
  begin
    j:=pos(',',  FPopupMenuCommands[i]);
    if j>0 then
    if TryStrToInt(midstr(FPopupMenuCommands[i], j+1, length(FPopupMenuCommands[i])), t) then
    begin
       mi:=TMenuItem.Create(pmCommands);
       mi.Caption:=midstr(FPopupMenuCommands[i], 0 , j-1);
       mi.Tag:=t;
       mi.OnClick:=onPopupMenuItemClick;
       pmCommands.Items.Add(mi);
    end;
  end;

  PopupMenu:=pmCommands;


end;

procedure TfyDBGrid.toggleTransparentColor;
begin
  if (not Assigned(bmpClipped)) or (not Assigned(bmpDrawText)) then
    Exit;
  try
    if (bmpDrawText.TransparentColor and $ffffff)=clWhite then
    begin
      bmpDrawText.TransparentColor:=clBlack;
      bmpDrawText.Canvas.Brush.Color:=clBlack;
      bmpClipped.TransparentColor:=clBlack;
      bmpClipped.Canvas.Brush.Color:=clBlack;
    end
    else
    begin
      bmpDrawText.TransparentColor:=clWhite;
      bmpDrawText.Canvas.Brush.Color:=clWhite;
      bmpClipped.TransparentColor:=clWhite;
      bmpClipped.Canvas.Brush.Color:=clWhite;
    end;
  except
    OutputDebugString('Error in toggling transparent color.');
  end;
end;

procedure TfyDBGrid.PopupMenuCommandsChanged(Sender: TObject);
begin
  buildPopUpMenu;
end;

procedure TfyDBGrid.SetActiveCellFontColor(const Value: TColor);
begin
  FActiveCellFontColor := Value;
  InvalidateGrid;
end;

procedure TfyDBGrid.SetSelectedCellFontColor(const Value: TColor);
begin
  FSelectedCellFontColor := Value;
  InvalidateGrid;
end;

end.

