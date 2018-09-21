unit Ths.Erp.StrinGrid.Helper;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Menus,
  Data.DB,
  Ths.Erp.Database.Table,
  Ths.Erp.SpecialFunctions;

const
  COL_OBJ = 0;
  ROW_OBJ = 0;

type
  TThsCellDataType = (ctString, ctInteger, ctDouble, ctDate, ctTime, ctDateTime);

  TThsCellBorder = class
    FLeftBorder: Boolean;
    FLeftBorderColor: TColor;
    FLeftBorderWidth: Integer;
    FLeftBorderStyle: TBorderStyle;
    FRightBorder: Boolean;
    FRightBorderColor: TColor;
    FRightBorderWidth: Integer;
    FRightBorderStyle: TBorderStyle;
    FTopBorder: Boolean;
    FTopBorderColor: TColor;
    FTopBorderWidth: Integer;
    FTopBorderStyle: TBorderStyle;
    FBottomBorder: Boolean;
    FBottomBorderColor: TColor;
    FBottomBorderWidth: Integer;
    FBottomBorderStyle: TBorderStyle;
  public
    property LeftBorder: Boolean read FLeftBorder write FLeftBorder;
    property LeftBorderColor: TColor read FLeftBorderColor write FLeftBorderColor;
    property LeftBorderWidth: Integer read FLeftBorderWidth write FLeftBorderWidth;
    property LeftBorderStyle: TBorderStyle read FLeftBorderStyle write FLeftBorderStyle;
    property RightBorder: Boolean read FRightBorder write FRightBorder;
    property RightBorderColor: TColor read FRightBorderColor write FRightBorderColor;
    property RightBorderWidth: Integer read FRightBorderWidth write FRightBorderWidth;
    property RightBorderStyle: TBorderStyle read FRightBorderStyle write FRightBorderStyle;
    property TopBorder: Boolean read FTopBorder write FTopBorder;
    property TopBorderColor: TColor read FTopBorderColor write FTopBorderColor;
    property TopBorderWidth: Integer read FTopBorderWidth write FTopBorderWidth;
    property TopBorderStyle: TBorderStyle read FTopBorderStyle write FTopBorderStyle;
    property BottomBorder: Boolean read FBottomBorder write FBottomBorder;
    property BottomBorderColor: TColor read FBottomBorderColor write FBottomBorderColor;
    property BottomBorderWidth: Integer read FBottomBorderWidth write FBottomBorderWidth;
    property BottomBorderStyle: TBorderStyle read FBottomBorderStyle write FBottomBorderStyle;

    constructor Create;
  end;

  TThsCellStyle = class
  private
    FCellDataType: TThsCellDataType;
    FFont: TFont;
    FBGColor: TColor;
    FTextAlign: TAlignment;
    FBorder: TThsCellBorder;
    FBorderWidth: Integer;
    FBorderColor: TColor;
    FBorderStyle: TBorderStyle;
    procedure SetBorderWidth(const Value: Integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderStyle(const Value: TBorderStyle);
  public
    property CellDataType: TThsCellDataType read FCellDataType write FCellDataType;
    property Font: TFont read FFont write FFont;
    property BGColor: TColor read FBGColor write FBGColor;
    property TextAlign: TAlignment read FTextAlign write FTextAlign;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property Border: TThsCellBorder read FBorder write FBorder;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle;

    constructor Create();
    destructor Destroy; override;
  end;

  TThsRowsStyle = class(TThsCellStyle)
  private
    FRowObject: TTable;
  public
    constructor Create();
    destructor Destroy; override;

    property RowObject: TTable read FRowObject write FRowObject;
  end;

  THeaderRows = class
  private
    //FRows: ArrayInteger;
    FCellStyle: TThsCellStyle;
  public
    Rows: ArrayInteger;
    property CellStyle: TThsCellStyle read FCellStyle write FCellStyle;

    constructor Create;
    destructor Destroy; override;
  end;

  TSubTotalRows = class
  private
    FRows: ArrayInteger;
    FCellStyle: TThsCellStyle;
  public
    property Rows: ArrayInteger read FRows write FRows;
    property CellStyle: TThsCellStyle read FCellStyle write FCellStyle;

    constructor Create;
    destructor Destroy; override;
  end;

  TFooterRows = class
  private
    FRows: ArrayInteger;
    FCellStyle: TThsCellStyle;
  public
    property Rows: ArrayInteger read FRows write FRows;
    property CellStyle: TThsCellStyle read FCellStyle write FCellStyle;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TThsRowsStyle.Create;
begin
  inherited;

  FFont.Name := 'Arial';
  FFont.Size := 9;
  FFont.Style := [];
  FFont.Color := clBlack;

  FBGColor := clWhite;
  FTextAlign := taLeftJustify;

  FBorderWidth := 1;
  FBorderColor := clBlack;
  FBorderStyle := bsSingle;
end;

destructor TThsRowsStyle.Destroy;
begin
  if Assigned(FRowObject) then
    FRowObject.Free;
  inherited;
end;

{ TGridCell }

constructor TThsCellStyle.Create;
begin
  FCellDataType := ctString;

  FFont := TFont.Create;
  FFont.Name := 'Verdana';
  FFont.Size := 9;
  FFont.Style := [];
  FFont.Color := clBlack;

  FBGColor := clWhite;
  FTextAlign := taLeftJustify;

  FBorder := TThsCellBorder.Create;
  FBorderWidth := 1;
  FBorderColor := clBlack;
  FBorderStyle := bsSingle;
end;

destructor TThsCellStyle.Destroy;
begin
  FFont.Free;
  FBorder.Free;

  inherited;
end;

procedure TThsCellStyle.SetBorderColor(const Value: TColor);
begin
  FBorder.FLeftBorderColor := Value;
  FBorder.FRightBorderColor := Value;
  FBorder.FTopBorderColor := Value;
  FBorder.FBottomBorderColor := Value;
end;

procedure TThsCellStyle.SetBorderStyle(const Value: TBorderStyle);
begin
  FBorder.FLeftBorderStyle := Value;
  FBorder.FRightBorderStyle := Value;
  FBorder.FTopBorderStyle := Value;
  FBorder.FBottomBorderStyle := Value;
end;

procedure TThsCellStyle.SetBorderWidth(const Value: Integer);
begin
  FBorder.FLeftBorderWidth := Value;
  FBorder.FRightBorderWidth := Value;
  FBorder.FTopBorderWidth := Value;
  FBorder.FBottomBorderWidth := Value;
end;

{ TGridCellBorder }

constructor TThsCellBorder.Create();
begin
  LeftBorder := True;
  LeftBorderColor := clBlack;
  LeftBorderWidth := 1;
  LeftBorderStyle := bsSingle;

  RightBorder := True;
  RightBorderColor := clBlack;
  RightBorderWidth := 1;
  RightBorderStyle := bsSingle;

  TopBorder := True;
  TopBorderColor := clBlack;
  TopBorderWidth := 1;
  TopBorderStyle := bsSingle;

  BottomBorder := True;
  BottomBorderColor := clBlack;
  BottomBorderWidth := 1;
  BottomBorderStyle := bsSingle;
end;

{ TFooterRows }

constructor TFooterRows.Create;
begin

  SetLength(FRows, 0);

  FCellStyle := TThsCellStyle.Create;

  FCellStyle.FFont.Name := 'Arial';
  FCellStyle.FFont.Size := 9;
  FCellStyle.FFont.Style := [fsBold];
  FCellStyle.FFont.Color := clBlack;

  FCellStyle.FBGColor := clSilver;
  FCellStyle.FTextAlign := taLeftJustify;

  FCellStyle.FBorderWidth := 1;
  FCellStyle.FBorderColor := clBlack;
  FCellStyle.FBorderStyle := bsSingle;
end;

destructor TFooterRows.Destroy;
begin
  FCellStyle.Free;
  inherited;
end;

{ TSubTotalRows }

constructor TSubTotalRows.Create;
begin
  SetLength(FRows, 0);

  FCellStyle := TThsCellStyle.Create;

  FCellStyle.FFont.Name := 'Arial';
  FCellStyle.FFont.Size := 9;
  FCellStyle.FFont.Style := [fsBold, fsItalic];
  FCellStyle.FFont.Color := clWhite;

  FCellStyle.FBGColor := clPurple;
  FCellStyle.FTextAlign := taLeftJustify;

  FCellStyle.FBorderWidth := 1;
  FCellStyle.FBorderColor := clBlack;
  FCellStyle.FBorderStyle := bsSingle;
end;

destructor TSubTotalRows.Destroy;
begin
  FCellStyle.Free;
  inherited;
end;

{ THeaderRows }

constructor THeaderRows.Create;
begin
  SetLength(Rows, 0);

  FCellStyle := TThsCellStyle.Create;

  FCellStyle.FFont.Name := 'Arial';
  FCellStyle.FFont.Size := 9;
  FCellStyle.FFont.Style := [fsBold];
  FCellStyle.FFont.Color := clBlack;

  FCellStyle.FBGColor := clWhite;
  FCellStyle.FTextAlign := taCenter;

  FCellStyle.FBorderWidth := 1;
  FCellStyle.FBorderColor := clBlack;
  FCellStyle.FBorderStyle := bsSingle;
end;

destructor THeaderRows.Destroy;
begin
  FCellStyle.Free;
  inherited;
end;

end.
