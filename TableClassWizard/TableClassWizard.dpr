program TableClassWizard;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {frmMainClassGenerator};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Ths ERP Class Generator';
  Application.CreateForm(TfrmMainClassGenerator, frmMainClassGenerator);
  Application.Run;
end.
