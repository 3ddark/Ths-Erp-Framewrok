unit ufrmConfirmation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBase, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Menus, ClipBrd, uGenel, RTFLabel, HTMLabel;

const
  KOLON_BASLIK = 1;
  KOLON_GENISLIK = 1;

  MAL_KODU  = 0;
  MAL_ADI   = 1;
  MIKTAR    = 2;
  BIRIM     = 3;

type
  TfrmConfirmation = class(TfrmBase)
    pmReport: TPopupMenu;
    MenuItemExceleAktar: TMenuItem;
    strngrdReport: TStringGrid;
    ImageMessageFormat: TImage;
    lblMessage: TLabel;
    procedure FormResize(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);override;
    procedure btnKapatClick(Sender: TObject);override;
    procedure btnTamamClick(Sender: TObject);override;
    procedure FormShow(Sender: TObject);override;
    procedure MenuItemExceleAktarClick(Sender: TObject);
    procedure StringGridReportKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private

  public
    arExcelContent : array of array of string;
    icoIcon: TIcon;

    procedure AddIcon(pIconType: PWideChar);
  end;

implementation

uses
  System.Math;

{$R *.dfm}

procedure TfrmConfirmation.FormResize(Sender: TObject);
var
  nHeight, nWidth: Integer;
  nIndex: Integer;
begin
  nWidth := 0;
  nHeight := 0;
  if not strngrdReport.Visible then
  begin
    if lblMessage.Visible then
    begin
      nHeight := lblMessage.Height;
      if lblMessage.AlignWithMargins then
        nHeight := nHeight + lblMessage.Margins.Top + lblMessage.Margins.Bottom;

      nWidth := lblMessage.Width;
    end;

    if PanelBottom.Visible then
    begin
      nHeight := nHeight + PanelBottom.Height;
      if PanelBottom.AlignWithMargins then
        nHeight := nHeight + PanelBottom.Margins.Top + PanelBottom.Margins.Bottom;
    end;
  end;

  if arExcelContent <> nil then
  begin
    strngrdReport.Visible := True;
    nHeight := nHeight + strngrdReport.Height;
    if strngrdReport.AlignWithMargins then
      nHeight := nHeight + strngrdReport.Margins.Top + strngrdReport.Margins.Bottom;

    for nIndex := 0 to strngrdReport.ColCount-1 do
      nWidth := nWidth + strngrdReport.ColWidths[nIndex];
    nWidth := nWidth + 32;
  end;

//  ClientHeight := nHeight;
  //ClientWidth := nWidth;
end;

procedure TfrmConfirmation.FormCreate(Sender: TObject);
begin
  inherited;
  Position := poScreenCenter;
  btnTamam.Caption     := 'EVET';
  btnKapat.Caption     := 'HAYIR';

  btnTamam.Visible := True;
  btnKapat.Visible := True;

  strngrdReport.DefaultRowHeight := 20;
  strngrdReport.Visible := False;
  strngrdReport.FixedCols := 0;
  strngrdReport.ColCount := 1;
  strngrdReport.RowCount := 2;
  strngrdReport.PopupMenu := pmReport;
end;

procedure TfrmConfirmation.AddIcon(pIconType: PWideChar);
begin
  icoIcon := TIcon.Create();
  try
    icoIcon.Handle := LoadIcon(0, pIconType);
    if ( icoIcon.Handle <> 0 ) then
      ImageMessageFormat.Picture.Icon.Assign( icoIcon );
  finally
    icoIcon.Free;
  end;
end;

procedure TfrmConfirmation.btnKapatClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  lblMessage.Caption := '';
end;

procedure TfrmConfirmation.btnTamamClick(Sender: TObject);
begin
  ModalResult := mrYes;
  lblMessage.Caption := '';
end;

procedure TfrmConfirmation.FormShow(Sender: TObject);
var
  nIndexRow, nIndexCol: Integer;
begin
	inherited;

  KeyPreview := false;

  //array excel bilgisi varsa bu iþlemi yap create anýnda array nil olarak geliyor.
  if arExcelContent <> nil then
  begin
    lblMessage.Color := clRed;
    lblMessage.Font.Style := [fsBold];
    strngrdReport.Visible := True;
    strngrdReport.ColCount := Length(arExcelContent);
    strngrdReport.RowCount := 2;   //baþlýk ve bir tane bilgi yazacak kadar satýr sayýsý seçiliyor

    for nIndexCol  := 0 to Length(arExcelContent)-1 do
    begin
      for nIndexRow := 0 to Length(arExcelContent[nIndexCol])-1 do
      begin
        if nIndexRow = 0 then   //Geniþlikleri ayarla
          strngrdReport.ColWidths[nIndexCol] := StrToInt( arExcelContent[nIndexCol][nIndexRow] )
        else if nIndexRow = 1 then   //Baþlýklarý yaz
          strngrdReport.Cells[nIndexCol, nIndexRow-1] := arExcelContent[nIndexCol][nIndexRow]
        else    //Datayý yaz
          strngrdReport.Cells[nIndexCol, nIndexRow-1] := arExcelContent[nIndexCol][nIndexRow];


        //ilk bilgi kolon geniþlikleri olduðu için sonraki iþlemlerde satýr atlasýn
        if (nIndexCol=0) and (nIndexRow>2) then
        begin
          strngrdReport.RowCount := strngrdReport.RowCount + 1;
          strngrdReport.Row := strngrdReport.Row + 1;
        end;

      end;

    end;

    icoIcon := TIcon.Create();
    try
      icoIcon.Handle := LoadIcon(0, IDI_QUESTION);
      if ( icoIcon.Handle <> 0 ) then
        ImageMessageFormat.Picture.Icon.Assign( icoIcon );
    finally
      icoIcon.Free;
    end;
  end;

  Resize;

  btnKapat.SetFocus;
end;

procedure TfrmConfirmation.MenuItemExceleAktarClick(Sender: TObject);
//var
//  nIndexRow, nIndexCol, nBosSutun : integer;
//  SaveDialogExcelFile:TSaveDialog;
//  strTemp:string;
//  strFileName:string;
//  nInteger: Integer;
//  dDouble: Double;
//  XLSFile: TAdvSpreadGrid;
//  XLSGridExcelIO: TAdvGridExcelIO;
begin
//    SaveDialogExcelFile            := TSaveDialog.Create(Self);
//    SaveDialogExcelFile.Filter     := 'Excel dosyasý (xls)|*.xls';
//    SaveDialogExcelFile.FileName   := Self.Caption;
//    SaveDialogExcelFile.InitialDir := '%USERPROFILE%\desktop';
//
//    if not SaveDialogExcelFile.Execute then
//      Exit;
//
//    strFileName     := SaveDialogExcelFile.FileName + '.xls';;
//
//    XLSFile := TAdvSpreadGrid.Create(nil);
//    XLSGridExcelIO := TAdvGridExcelIO.Create(nil);
//    XLSGridExcelIO.AdvStringGrid := XLSFile;
//  try
//    XLSFile.RowCount := StringGridReport.RowCount + 1;
//    XLSFile.ColCount := StringGridReport.ColCount + 1;
//
//    for nIndexRow := 0 to StringGridReport.RowCount - 1 do
//    begin
//      nBosSutun := 0;
//      for nIndexCol := 0 to StringGridReport.ColCount do
//      begin
//        if StringGridReport.ColWidths[nIndexCol] > - StringGridReport.GridLineWidth then
//        begin
//          strTemp := StringGridReport.Cells[nIndexCol, nIndexRow];
//
//          XLSFile.Cells[nIndexCol + 1 - nBosSutun, nIndexRow + 1] := strTemp;
//          if nIndexRow >= 0 then
//          begin
//            if TryStrToInt(strTemp, nInteger) or TryStrToFloat(StringReplace(strTemp, '.', '', [rfReplaceAll]), dDouble) then
//              XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].Alignment := taRightJustify;
//          end;
//        end
//        else
//        begin
//          nBosSutun := nBosSutun + 1;
//        end;
//        if nIndexRow = 0 then
//        begin
//          XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].FontStyle := [fsBold];
//          XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].Alignment := Classes.taCenter;
//        end;
//      end;
//    end;
//
//    if FileExists(strFileName) then
//        DeleteFile(strFileName);
//    XLSGridExcelIO.XLSExport(strFileName);
//
//  finally
//    XLSFile.Free;
//    XLSGridExcelIO.Free;
//  end;
end;

procedure TfrmConfirmation.StringGridReportKeyDown(Sender: TObject; var  Key: Word; Shift: TShiftState);
var
  nCol, nRow, nColWidth: Integer;
begin
  if Shift*[ssShift, ssAlt, ssCtrl] = [ssCtrl] then
  begin
    if ((Key=Word('C')) or (Key=Word('c'))) then
    begin
      ClipBoard.Clear;
      for nRow := 1 to strngrdReport.RowCount-1 do
      begin
        for nCol := 0 to strngrdReport.ColCount-1 do
        begin
          case nCol of
           MAL_KODU : nColWidth := 20;
           MAL_ADI : nColWidth := 80;
           MIKTAR : nColWidth := 10;
           BIRIM : nColWidth := 5;
          else
            nColWidth := 20;
          end;

          ClipBoard.AsText := ClipBoard.AsText + TGenel.CLEN(strngrdReport.Cells[nCol, nRow], nColWidth);
        end;
        ClipBoard.AsText := ClipBoard.AsText + sLineBreak;
      end;
    end;
  end;
end;

end.
