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
  Ths.Erp.Database.Table.SysGridColWidth in 'BackEnd\Ths.Erp.Database.Table.SysGridColWidth.pas',
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
  ufrmCity in 'Forms\InputForms\ufrmCity.pas' {frmCity},
  Ths.Erp.Database.Table.Currency in 'BackEnd\Ths.Erp.Database.Table.Currency.pas',
  ufrmCurrencies in 'Forms\OutputForms\DbGrid\ufrmCurrencies.pas' {frmCurrencies},
  ufrmCurrency in 'Forms\InputForms\ufrmCurrency.pas' {frmCurrency},
  ufrmAbout in 'Forms\ufrmAbout.pas' {frmAbout},
  Ths.Erp.Database.Table.Field in 'BackEnd\Ths.Erp.Database.Table.Field.pas',
  Ths.Erp.Database.Table.Country.City in 'BackEnd\Ths.Erp.Database.Table.Country.City.pas',
  ufrmCities in 'Forms\OutputForms\DbGrid\ufrmCities.pas' {frmCities},
  ufrmFilterDBGrid in 'Forms\InputForms\ufrmFilterDBGrid.pas' {frmFilterDBGrid},
  ufrmSysPermissionSourceGroups in 'Forms\OutputForms\DbGrid\ufrmSysPermissionSourceGroups.pas' {frmSysPermissionSourceGroups},
  Ths.Erp.Database.Table.SysPermissionSource in 'BackEnd\Ths.Erp.Database.Table.SysPermissionSource.pas',
  ufrmSysPermissionSourceGroup in 'Forms\InputForms\ufrmSysPermissionSourceGroup.pas' {frmSysPermissionSourceGroup},
  ufrmSysPermissionSources in 'Forms\OutputForms\DbGrid\ufrmSysPermissionSources.pas' {frmSysPermissionSources},
  ufrmSysPermissionSource in 'Forms\InputForms\ufrmSysPermissionSource.pas' {frmSysPermissionSource},
  Ths.Erp.Database.Table.SysPermissionSourceGroup in 'BackEnd\Ths.Erp.Database.Table.SysPermissionSourceGroup.pas',
  Ths.Erp.Database.Table.SysLang in 'BackEnd\Ths.Erp.Database.Table.SysLang.pas',
  Ths.Erp.Database.Table.SysLangContents in 'BackEnd\Ths.Erp.Database.Table.SysLangContents.pas',
  ufrmSysUserAccessRights in 'Forms\OutputForms\DbGrid\ufrmSysUserAccessRights.pas' {frmSysUserAccessRights},
  ufrmSysUserAccessRight in 'Forms\InputForms\ufrmSysUserAccessRight.pas' {frmSysUserAccessRight},
  Ths.Erp.Database.Table.SysGridColColor in 'BackEnd\Ths.Erp.Database.Table.SysGridColColor.pas',
  Ths.Erp.Database.Table.SysGridColPercent in 'BackEnd\Ths.Erp.Database.Table.SysGridColPercent.pas',
  Ths.Erp.Database.Table.SysInputGuiSetting in 'BackEnd\Ths.Erp.Database.Table.SysInputGuiSetting.pas',
  Ths.Erp.Database.Table.View.SysViewColumns in 'BackEnd\Ths.Erp.Database.Table.View.SysViewColumns.pas',
  Ths.Erp.Database.Table.View in 'BackEnd\Ths.Erp.Database.Table.View.pas';

{$R *.res}

begin
  Application.Initialize;

  ReportMemoryLeaksOnShutdown := True;

  TStyleManager.TrySetStyle('Silver');
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

