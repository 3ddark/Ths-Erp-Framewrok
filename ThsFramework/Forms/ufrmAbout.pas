unit ufrmAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ufrmBase, Vcl.AppEvnts, Vcl.StdCtrls,
  Vcl.ExtCtrls, dxGDIPlusClasses,
  Vcl.ComCtrls, Vcl.Samples.Spin;

type
  TfrmAbout = class(TfrmBase)
    lblArchitecture: TLabel;
    lblValArchitecture: TLabel;
    imgLogo: TImage;
    lblWindowsOSVersion: TLabel;
    lblValWindowsOSVersion: TLabel;
    lblDeveloper: TLabel;
    lblValDeveloper: TLabel;
    lblCompany: TLabel;
    lblValCompany: TLabel;
    lblCpuInfo: TLabel;
    lblValCpuInfo: TLabel;
    lblRamInfo: TLabel;
    lblValRamInfo: TLabel;
    procedure FormCreate(Sender: TObject);override;
  private
    { Private declarations }
  public
  end;

implementation

uses
  System.Win.Registry;

{$R *.dfm}

procedure TfrmAbout.FormCreate(Sender: TObject);
var
  vMyOSver: _OSVERSIONINFOW;
  vMemoryStatus: _MEMORYSTATUSEX;

  vReg: TRegistry;
begin
  inherited;

  btnClose.Visible := True;


  vMyOSver.dwOSVersionInfoSize := SizeOf(_OSVERSIONINFOW);
  GetVersionEx(vMyOSver);

  lblValArchitecture.Caption := TOSVersion.ToString;
  lblValWindowsOSVersion.Caption := vMyOSver.dwMajorVersion.ToString;


  //if give parameter KEY_READ dont need administration right
  vReg := TRegistry.Create(KEY_READ);
  try
    vReg.RootKey := HKEY_LOCAL_MACHINE;
    if vReg.OpenKey('\Hardware\Description\System\CentralProcessor\0', False) then
    begin
      lblValCpuInfo.Caption := vReg.ReadString('Identifier') + ' ' +
                               vReg.ReadString('ProcessorNameString');
    end;
  finally
    vReg.Free;
  end;


  vMemoryStatus.dwLength := SizeOf(vMemoryStatus);
  GlobalMemoryStatusEx(vMemoryStatus);
  lblValRamInfo.Caption := (Round((vMemoryStatus.ullTotalPhys/1024)/1024/1024)).ToString + ' GB';
end;

end.
