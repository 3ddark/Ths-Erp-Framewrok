unit ufrmParaBirimi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils,

  thsEdit,
  ufrmBase, ufrmBaseInputDB, Vcl.AppEvnts, System.ImageList, Vcl.ImgList,
  Vcl.Samples.Spin;

type
  TfrmParaBirimi = class(TfrmBaseInputDB)
    lblKod: TLabel;
    lblSembol: TLabel;
    lblIsVarsayilan: TLabel;
    lblAciklama: TLabel;
    edtKod: TthsEdit;
    edtSembol: TthsEdit;
    chkIsVarsayilan: TCheckBox;
    edtAciklama: TthsEdit;
    destructor Destroy; override;
    procedure FormCreate(Sender: TObject);override;
    procedure Repaint(); override;
    procedure RefreshData();override;
    procedure btnAcceptClick(Sender: TObject);override;
  private
  public

  protected
  published
    procedure FormShow(Sender: TObject); override;
  end;

implementation

uses
  Ths.Erp.Database.Table.ParaBirimi;

{$R *.dfm}

Destructor TfrmParaBirimi.Destroy;
begin
  //
  inherited;
end;

procedure TfrmParaBirimi.FormCreate(Sender: TObject);
begin
  TParaBirimi(Table).Kod.SetControlProperty(Table.TableName, edtKod);
  TParaBirimi(Table).Sembol.SetControlProperty(Table.TableName, edtSembol);
  TParaBirimi(Table).Aciklama.SetControlProperty(Table.TableName, edtAciklama);

  inherited;
end;

procedure TfrmParaBirimi.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmParaBirimi.Repaint();
begin
  inherited;
  //
end;

procedure TfrmParaBirimi.RefreshData();
begin
  //control içeriðini table class ile doldur
  edtKod.Text := TParaBirimi(Table).Kod.Value;
  edtSembol.Text := TParaBirimi(Table).Sembol.Value;
  edtAciklama.Text := TParaBirimi(Table).Aciklama.Value;
  chkIsVarsayilan.Checked := TParaBirimi(Table).IsVarsayilan.Value;
end;

procedure TfrmParaBirimi.btnAcceptClick(Sender: TObject);
begin
  if (FormMode = ifmNewRecord) or (FormMode = ifmUpdate) then
  begin
    if (ValidateInput) then
    begin
      TParaBirimi(Table).Kod.Value := edtKod.Text;
      TParaBirimi(Table).Sembol.Value := edtSembol.Text;
      TParaBirimi(Table).Aciklama.Value := edtAciklama.Text;
      TParaBirimi(Table).IsVarsayilan.Value := chkIsVarsayilan.Checked;
      inherited;
    end;
  end
  else
    inherited;
end;

end.
