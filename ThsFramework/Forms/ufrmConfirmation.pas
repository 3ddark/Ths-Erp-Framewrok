unit ufrmConfirmation;

interface

{$I ThsERP.inc}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.AppEvnts, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.Menus,
  ufrmBase
  //, AdvObj, BaseGrid, AdvGrid, AdvSprd, tmsAdvGridExcel
  ;

type
  TfrmConfirmation = class(TfrmBase)
    strngrdReport: TStringGrid;
    imgMessageFormat: TImage;
    lblMessage: TLabel;
    pmReport: TPopupMenu;
    mniExportExcell: TMenuItem;
    procedure FormCreate(Sender: TObject);override;
    procedure mniExportExcellClick(Sender: TObject);
  private
    { Private declarations }
  public
    property btnAccept1: TButton read btnAccept write btnAccept;
  end;

implementation

{$R *.dfm}

procedure TfrmConfirmation.FormCreate(Sender: TObject);
begin
  inherited;
  //
  btnSpin.Visible := False;
  btnAccept.Visible := False;
  btnDelete.Visible := False;
  btnClose.Visible := False;

  lblMessage.Visible := False;
  strngrdReport.Visible := False;
end;

procedure TfrmConfirmation.mniExportExcellClick(Sender: TObject);
//var
//  nIndexRow, nIndexCol, nBosSutun : integer;
//  SaveDialogExcelFile:TSaveDialog;
//  strTemp:string;
//  strFileName:string;
//  nInteger: Integer;
//  dDouble: Double;
//  XLSFile: TAdvSpreadGrid;
//  XLSGridExcelIO: TAdvGridExcelIO;
//  vColTrue: Boolean;
begin
//    SaveDialogExcelFile            := TSaveDialog.Create(Self);
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
//    XLSFile.RowCount := strngrdReport.RowCount + 1;
//    XLSFile.ColCount := strngrdReport.ColCount + 1;
//
//    for nIndexRow := 0 to strngrdReport.RowCount - 1 do
//    begin
//      nBosSutun := 0;
//      for nIndexCol := 0 to strngrdReport.ColCount do
//      begin
//        vColTrue := False;
//        if strngrdReport.ColCount = 4 then
//          vColTrue := strngrdReport.Cells[3, nIndexRow] = 'True';
//
//        if strngrdReport.ColWidths[nIndexCol] > - strngrdReport.GridLineWidth then
//        begin
//          strTemp := strngrdReport.Cells[nIndexCol, nIndexRow];
//
//          XLSFile.Cells[nIndexCol + 1 - nBosSutun, nIndexRow + 1] := strTemp;
//          if nIndexRow >= 0 then
//          begin
//            if TryStrToInt(strTemp, nInteger) or TryStrToFloat(StringReplace(strTemp, '.', '', [rfReplaceAll]), dDouble) then
//              XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].Alignment := taRightJustify;
//
//            if vColTrue then
//              XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].FontColor := clRed;
//          end;
//        end
//        else
//        begin
//          nBosSutun := nBosSutun + 1;
//        end;
//        if nIndexRow = 0 then
//        begin
//          XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].FontStyle := [fsBold];
//          XLSFile.CellProperties[nIndexCol + 1 - nBosSutun, nIndexRow + 1].Alignment := taCenter;
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

end.
