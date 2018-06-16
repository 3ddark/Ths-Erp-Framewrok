program TableClassWizard;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {frmMainClassGenerator};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMainClassGenerator, frmMainClassGenerator);
  Application.Run;
end.
