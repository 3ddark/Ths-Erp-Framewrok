program ThsERP;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Winapi.Messages,
  Ths.Erp.Database in 'BackEnd\Ths.Erp.Database.pas',
  Ths.Erp.Database.Singleton in 'BackEnd\Ths.Erp.Database.Singleton.pas',
  Ths.Erp.Database.Connection in 'BackEnd\Ths.Erp.Database.Connection.pas',
  Ths.Erp.Database.Connection.Settings in 'BackEnd\Ths.Erp.Database.Connection.Settings.pas',
  Ths.Erp.Database.Table in 'BackEnd\Ths.Erp.Database.Table.pas',
  Ths.Erp.Database.Table.Country in 'BackEnd\Ths.Erp.Database.Table.Country.pas',
  Ths.Erp.Database.Table.Users in 'BackEnd\Ths.Erp.Database.Table.Users.pas',
  Ths.Erp.Database.Table.Employee in 'BackEnd\Ths.Erp.Database.Table.Employee.pas',
  uAyarGenelAyarlar in 'BackEnd\uAyarGenelAyarlar.pas',
  uSysVisibleColumn in 'BackEnd\uSysVisibleColumn.pas',
  Ths.Erp.Database.Table.SysUserAccessRight in 'BackEnd\Ths.Erp.Database.Table.SysUserAccessRight.pas',
  uGenel in 'BackEnd\uGenel.pas',
  ufrmBase in 'Forms\ufrmBase.pas' {frmBase},
  ufrmBaseOutput in 'Forms\OutputForms\Factory\ufrmBaseOutput.pas' {frmBaseOutput},
  ufrmBaseStrGrid in 'Forms\OutputForms\StrGrid\Factory\ufrmBaseStrGrid.pas' {frmBaseStrGrid},
  ufrmBaseDBGrid in 'Forms\OutputForms\DbGrid\Factory\ufrmBaseDBGrid.pas' {frmBaseDBGrid},
  ufrmBaseInputDB in 'Forms\InputForms\Factory\ufrmBaseInputDB.pas' {frmBaseInputDB},
  ufrmMain in 'Forms\InputForms\ufrmMain.pas' {frmMain},
  ufrmLogin in 'Forms\InputForms\ufrmLogin.pas' {frmLogin},
  ufrmUlkeler in 'Forms\OutputForms\DbGrid\Ulke\ufrmUlkeler.pas' {frmUlkeler},
  ufrmUlke in 'Forms\InputForms\Ulke\ufrmUlke.pas' {frmUlke};

{$R *.res}

begin
  Application.Initialize;

  ReportMemoryLeaksOnShutdown := True;

  TStyleManager.TrySetStyle('Slate Classico');
  Application.Title := 'Thunder Soft ERP';
  Application.CreateForm(TfrmMain, frmMain);
  if TfrmLogin.Execute then
  begin
    Application.MainFormOnTaskbar := True;
    Application.ShowMainForm := True;
    Application.Run;
  end
  else
  begin
    Application.Terminate;
  end;
end.
