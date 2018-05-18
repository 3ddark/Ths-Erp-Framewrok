program ThsERP;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  Winapi.Messages,
  Vcl.Styles.Utils.SystemMenu in 'BackEnd\Tools\Vcl.Styles.Utils.SystemMenu.pas',
  Ths.Erp.Database in 'BackEnd\Ths.Erp.Database.pas',
  Ths.Erp.Database.Singleton in 'BackEnd\Ths.Erp.Database.Singleton.pas',
  Ths.Erp.Database.Connection.Settings in 'BackEnd\Ths.Erp.Database.Connection.Settings.pas',
  Ths.Erp.Database.Table in 'BackEnd\Ths.Erp.Database.Table.pas',
  Ths.Erp.Database.Table.Country in 'BackEnd\Ths.Erp.Database.Table.Country.pas',
  Ths.Erp.Database.Table.Employee in 'BackEnd\Ths.Erp.Database.Table.Employee.pas',
  Ths.Erp.Database.Table.SysUserAccessRight in 'BackEnd\Ths.Erp.Database.Table.SysUserAccessRight.pas',
  Ths.Erp.Database.Table.SysVisibleColumn in 'BackEnd\Ths.Erp.Database.Table.SysVisibleColumn.pas',
  ufrmBase in 'Forms\ufrmBase.pas' {frmBase},
  ufrmBaseOutput in 'Forms\OutputForms\Factory\ufrmBaseOutput.pas' {frmBaseOutput},
  ufrmBaseStrGrid in 'Forms\OutputForms\StrGrid\Factory\ufrmBaseStrGrid.pas' {frmBaseStrGrid},
  ufrmBaseDBGrid in 'Forms\OutputForms\DbGrid\Factory\ufrmBaseDBGrid.pas' {frmBaseDBGrid},
  ufrmBaseInputDB in 'Forms\InputForms\Factory\ufrmBaseInputDB.pas' {frmBaseInputDB},
  ufrmMain in 'Forms\InputForms\ufrmMain.pas' {frmMain},
  ufrmLogin in 'Forms\InputForms\ufrmLogin.pas' {frmLogin},
  Ths.Erp.Database.Table.SysUser in 'BackEnd\Ths.Erp.Database.Table.SysUser.pas',
  Ths.Erp.SpecialFunctions in 'BackEnd\Ths.Erp.SpecialFunctions.pas',
  ufrmCountries in 'Forms\OutputForms\DbGrid\ufrmCountries.pas' {frmCountries},
  ufrmCountry in 'Forms\InputForms\ufrmCountry.pas' {frmCOuntry},
  Ths.Erp.Constants in 'BackEnd\Ths.Erp.Constants.pas',
  Ths.Erp.Database.Table.Country.City in 'BackEnd\Ths.Erp.Database.Table.Country.City.pas',
  ufrmCities in 'Forms\OutputForms\DbGrid\ufrmCities.pas' {frmCities},
  ufrmCity in 'Forms\InputForms\ufrmCity.pas' {frmCity},
  Ths.Erp.Database.Table.Currency in 'BackEnd\Ths.Erp.Database.Table.Currency.pas',
  ufrmCurrencies in 'Forms\OutputForms\DbGrid\ufrmCurrencies.pas' {frmCurrencies},
  ufrmCurrency in 'Forms\InputForms\ufrmCurrency.pas' {frmCurrency};

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
