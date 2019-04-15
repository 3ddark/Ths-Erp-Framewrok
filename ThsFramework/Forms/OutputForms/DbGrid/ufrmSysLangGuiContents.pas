unit ufrmSysLangGuiContents;

interface

{$I ThsERP.inc}

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls,
  ufrmBase, ufrmBaseDBGrid, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmSysLangGuiContents = class(TfrmBaseDBGrid)
  private
  protected
    function CreateInputForm(pFormMode: TInputFormMod):TForm; override;
  public
  published
    procedure FormCreate(Sender: TObject); override;
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton,
  ufrmSysLangGuiContent,
  Ths.Erp.Database.Table.SysLangGuiContent;

{$R *.dfm}

{ TfrmSysLangContents }

function TfrmSysLangGuiContents.CreateInputForm(pFormMode: TInputFormMod): TForm;
begin
  Result := nil;
  if (pFormMode = ifmRewiev) then
    Result := TfrmSysLangGuiContent.Create(Self, Self, Table.Clone(), True, pFormMode)
  else if (pFormMode = ifmNewRecord) then
    Result := TfrmSysLangGuiContent.Create(Self, Self, TSysLangGuiContent.Create(Table.Database), True, pFormMode)
  else if (pFormMode = ifmCopyNewRecord) then
    Result := TfrmSysLangGuiContent.Create(Self, Self, Table.Clone(), True, pFormMode);
end;

procedure TfrmSysLangGuiContents.FormCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmSysLangGuiContents.FormShow(Sender: TObject);
begin
  inherited;

  mniCopyRecord.Visible := True;
end;

end.
