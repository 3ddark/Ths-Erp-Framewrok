unit uPageControlClose;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Styles,
  Vcl.Themes;

type
  TTabControlStyleHookBtnClose = class(TTabControlStyleHook)
  private
    FHotIndex       : Integer;
    FWidthModified  : Boolean;
    procedure WMMouseMove(var Message: TMessage); message WM_MOUSEMOVE;
    procedure WMLButtonUp(var Message: TWMMouse); message WM_LBUTTONUP;
    function GetButtonCloseRect(Index: Integer):TRect;
  strict protected
    procedure DrawTab(Canvas: TCanvas; Index: Integer); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

implementation

constructor TTabControlStyleHookBtnClose.Create(AControl: TWinControl);
begin
  inherited;
  FHotIndex:=-1;
  FWidthModified:=False;
end;

procedure TTabControlStyleHookBtnClose.DrawTab(Canvas: TCanvas; Index: Integer);
var
  Details: TThemedElementDetails;
  ButtonR: TRect;
  FButtonState: TThemedWindow;
begin
  inherited;

  if (FHotIndex >= 0) and (Index = FHotIndex) then
    FButtonState := twSmallCloseButtonHot
  else if Index = TabIndex then
    FButtonState := twSmallCloseButtonNormal
  else
    FButtonState := twSmallCloseButtonDisabled;

  Details := StyleServices.GetElementDetails(FButtonState);

  ButtonR := GetButtonCloseRect(Index);
  if ButtonR.Bottom - ButtonR.Top > 0 then
    StyleServices.DrawElement(Canvas.Handle, Details, ButtonR);
end;

procedure TTabControlStyleHookBtnClose.WMLButtonUp(var Message: TWMMouse);
var
  LPoint: TPoint;
  LIndex: Integer;
begin
  LPoint := Message.Pos;
  for LIndex := 0 to TabCount - 1 do
    if PtInRect(GetButtonCloseRect(LIndex), LPoint) then
    begin
      if Control is TPageControl then
      begin
        TPageControl(Control).Pages[LIndex].Parent := nil;
        TPageControl(Control).Pages[LIndex].Free;
      end;
      break;
    end;
end;

procedure TTabControlStyleHookBtnClose.WMMouseMove(var Message: TMessage);
var
  LPoint: TPoint;
  LIndex: Integer;
  LHotIndex: Integer;
begin
  inherited;
  LHotIndex := -1;
  LPoint := TWMMouseMove(Message).Pos;
  for LIndex := 0 to TabCount - 1 do
    if PtInRect(GetButtonCloseRect(LIndex), LPoint) then
    begin
      LHotIndex := LIndex;
      break;
    end;

  if (FHotIndex <> LHotIndex) then
  begin
    FHotIndex := LHotIndex;
    Invalidate;
  end;
end;

function TTabControlStyleHookBtnClose.GetButtonCloseRect(Index: Integer): TRect;
var
  FButtonState: TThemedWindow;
  Details: TThemedElementDetails;
  R, ButtonR: TRect;
begin
  R := TabRect[Index];
  if R.Left < 0 then
    Exit;

  if TabPosition in [tpTop, tpBottom] then
  begin
    if Index = TabIndex then
      InflateRect(R, 0, 2);
  end
  else
  if Index = TabIndex then
    Dec(R.Left, 2)
  else
    Dec(R.Right, 2);

  Result := R;
  FButtonState := twSmallCloseButtonNormal;

  Details := StyleServices.GetElementDetails(FButtonState);
  if not StyleServices.GetElementContentRect(0, Details, Result, ButtonR) then
    ButtonR := Rect(0, 0, 0, 0);

  Result.Left := Result.Right - (ButtonR.Width) - 5;
  Result.Width := ButtonR.Width;
end;

procedure TTabControlStyleHookBtnClose.MouseEnter;
begin
  inherited;
  FHotIndex := -1;
end;

procedure TTabControlStyleHookBtnClose.MouseLeave;
begin
  inherited;
  if FHotIndex >= 0 then
  begin
    FHotIndex := -1;
    Invalidate;
  end;
end;

end.
