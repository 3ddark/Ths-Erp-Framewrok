program TableClassWizard;

{$I ThsERP.inc}

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {frmMainClassGenerator},
  Ths.Erp.Helper.BaseTypes in '..\ThsFramework\BackEnd\Ths.Erp.Helper.BaseTypes.pas',
  Ths.Erp.Helper.Button in '..\ThsFramework\BackEnd\Ths.Erp.Helper.Button.pas',
  Ths.Erp.Helper.ComboBox in '..\ThsFramework\BackEnd\Ths.Erp.Helper.ComboBox.pas',
  Ths.Erp.Helper.Edit in '..\ThsFramework\BackEnd\Ths.Erp.Helper.Edit.pas',
  Ths.Erp.Helper.Memo in '..\ThsFramework\BackEnd\Ths.Erp.Helper.Memo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ths ERP Class Generator';
  Application.CreateForm(TfrmMainClassGenerator, frmMainClassGenerator);
  Application.Run;
end.
