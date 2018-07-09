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
  Ths.Erp.Database.Table.Ulke in 'BackEnd\Ths.Erp.Database.Table.Ulke.pas',
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
  ufrmUlkeler in 'Forms\OutputForms\DbGrid\ufrmUlkeler.pas' {frmUlkeler},
  ufrmUlke in 'Forms\InputForms\ufrmUlke.pas' {frmUlke},
  Ths.Erp.Constants in 'BackEnd\Ths.Erp.Constants.pas',
  ufrmSehir in 'Forms\InputForms\ufrmSehir.pas' {frmSehir},
  ufrmAbout in 'Forms\ufrmAbout.pas' {frmAbout},
  Ths.Erp.Database.Table.Field in 'BackEnd\Ths.Erp.Database.Table.Field.pas',
  Ths.Erp.Database.Table.Sehir in 'BackEnd\Ths.Erp.Database.Table.Sehir.pas',
  ufrmSehirler in 'Forms\OutputForms\DbGrid\ufrmSehirler.pas' {frmSehirler},
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
  Ths.Erp.Database.Table.View.SysViewColumns in 'BackEnd\Ths.Erp.Database.Table.View.SysViewColumns.pas',
  Ths.Erp.Database.Table.View in 'BackEnd\Ths.Erp.Database.Table.View.pas',
  ufrmSysLangs in 'Forms\OutputForms\DbGrid\ufrmSysLangs.pas' {frmSysLangs},
  ufrmSysLang in 'Forms\InputForms\ufrmSysLang.pas' {frmSysLang},
  ufrmSysGridColWidth in 'Forms\InputForms\ufrmSysGridColWidth.pas' {frmSysGridColWidth},
  ufrmSysGridColWidths in 'Forms\OutputForms\DbGrid\ufrmSysGridColWidths.pas' {frmSysGridColWidths},
  ufrmSysGridColColor in 'Forms\InputForms\ufrmSysGridColColor.pas' {frmSysGridColColor},
  ufrmSysGridColPercent in 'Forms\InputForms\ufrmSysGridColPercent.pas' {frmSysGridColPercent},
  ufrmSysGridColColors in 'Forms\OutputForms\DbGrid\ufrmSysGridColColors.pas' {frmSysGridColColors},
  ufrmSysGridColPercents in 'Forms\OutputForms\DbGrid\ufrmSysGridColPercents.pas' {frmSysGridColPercents},
  mORMotReport in 'BackEnd\synpdf\mORMotReport.pas',
  SynCommons in 'BackEnd\synpdf\SynCommons.pas',
  SynCrypto in 'BackEnd\synpdf\SynCrypto.pas',
  SynGdiPlus in 'BackEnd\synpdf\SynGdiPlus.pas',
  SynLZ in 'BackEnd\synpdf\SynLZ.pas',
  SynPdf in 'BackEnd\synpdf\SynPdf.pas',
  SynZip in 'BackEnd\synpdf\SynZip.pas',
  Ths.Erp.Database.Table.Banka in 'BackEnd\Ths.Erp.Database.Table.Banka.pas',
  Ths.Erp.Database.Table.AyarHaneSayisi in 'BackEnd\Ths.Erp.Database.Table.AyarHaneSayisi.pas',
  Ths.Erp.Database.Table.ParaBirimi in 'BackEnd\Ths.Erp.Database.Table.ParaBirimi.pas',
  ufrmParaBirimi in 'Forms\InputForms\ufrmParaBirimi.pas' {frmParaBirimi},
  ufrmParaBirimleri in 'Forms\OutputForms\DbGrid\ufrmParaBirimleri.pas' {frmParaBirimleri},
  ufrmSysLangContents in 'Forms\OutputForms\DbGrid\ufrmSysLangContents.pas' {frmSysLangContents},
  ufrmSysLangContent in 'Forms\InputForms\ufrmSysLangContent.pas' {frmSysLangContent},
  Ths.Erp.Database.Table.SysTableLangContent in 'BackEnd\Ths.Erp.Database.Table.SysTableLangContent.pas',
  ufrmSysTableLangContents in 'Forms\OutputForms\DbGrid\ufrmSysTableLangContents.pas' {frmSysTableLangContents},
  ufrmSysTableLangContent in 'Forms\InputForms\ufrmSysTableLangContent.pas' {frmSysTableLangContent},
  Ths.Erp.Database.Table.SysQualityFomNumber in 'BackEnd\Ths.Erp.Database.Table.SysQualityFomNumber.pas',
  ufrmSysQualityFomNumbers in 'Forms\OutputForms\DbGrid\ufrmSysQualityFomNumbers.pas' {frmSysQualityFomNumbers},
  ufrmSysQualityFomNumber in 'Forms\InputForms\ufrmSysQualityFomNumber.pas' {frmSysQualityFomNumber},
  Ths.Erp.Database.Table.AyarStokHareketTipi in 'BackEnd\Ths.Erp.Database.Table.AyarStokHareketTipi.pas',
  ufrmAyarStokHareketTipleri in 'Forms\OutputForms\DbGrid\ufrmAyarStokHareketTipleri.pas' {frmAyarStokHareketTipleri},
  ufrmAyarStokHareketTipi in 'Forms\InputForms\ufrmAyarStokHareketTipi.pas' {frmAyarStokHareketTipi},
  Ths.Erp.Database.Table.StokHareketi in 'BackEnd\Ths.Erp.Database.Table.StokHareketi.pas',
  ufrmStokHareketleri in 'Forms\OutputForms\DbGrid\ufrmStokHareketleri.pas' {frmStokHareketleri},
  ufrmStokHareketi in 'Forms\InputForms\ufrmStokHareketi.pas' {frmStokHareketi},
  Ths.Erp.Database.Table.SysGridDefaultOrderFilter in 'BackEnd\Ths.Erp.Database.Table.SysGridDefaultOrderFilter.pas',
  ufrmSysGridDefaultOrderFilters in 'Forms\OutputForms\DbGrid\ufrmSysGridDefaultOrderFilters.pas' {frmSysGridDefaultOrderFilters},
  ufrmSysGridDefaultOrderFilter in 'Forms\InputForms\ufrmSysGridDefaultOrderFilter.pas' {frmSysGridDefaultOrderFilter};

{$R *.res}

begin
  Application.Initialize;

  ReportMemoryLeaksOnShutdown := True;

  TStyleManager.TrySetStyle('Silver');
  Application.Title := 'Thunder Soft ERP';
  Application.CreateForm(TfrmMain, frmMain);
  if TfrmLogin.Execute then
  begin
    Application.ShowMainForm := True;
    Application.Run;
  end
  else
  begin
    Application.Terminate;
  end;
end.

