unit StringGridDetaylar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, BaseForm,
  Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Buttons, Vcl.DBGrids;

type
  TFormStringGridDetaylar = class(TFormBase)
    PanelTop: TPanel;
    Splitter1: TSplitter;
    PanelLeft: TPanel;
    PanelHeader: TPanel;
    PanelMiddle: TPanel;
    Splitter2: TSplitter;
    StringGridRight: TStringGrid;
    Splitter3: TSplitter;
    StringGridLeft: TStringGrid;
    PanelTopFooter: TPanel;
    ButtonDetayEkle: TBitBtn;
    ButtonBaslikDuzenle: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormStringGridDetaylar.FormResize(Sender: TObject);
begin
  inherited;
//  self.ClientWidth := PanelHeader.Width;
  if PanelLeft.Visible then
  begin
    StringGridLeft.Width := (PanelHeader.Width - PanelLeft.Width) div 2 - 8
  end
  else
  begin
    StringGridLeft.Width := PanelHeader.Width div 2 - 8;
  end;

end;

procedure TFormStringGridDetaylar.FormShow(Sender: TObject);
begin
  inherited;
  FormResize(Self);
end;

end.
