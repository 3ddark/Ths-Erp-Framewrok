unit Ths.Erp.Helper.CustomFileDialog;

interface

{$I ThsERP.inc}

uses
  Winapi.Windows, Vcl.Forms, System.Classes, Dialogs;

type
  TCustomFileDialogHelper = class helper for TCustomFileDialog
  public
    function ExecuteCenter : Boolean;
  end;

implementation

{ TCustomFileDialogHelper }

function TCustomFileDialogHelper.ExecuteCenter: Boolean;
var
  ADialog : TCustomFileDialog;
begin
  ADialog := Self;

  TThread.CreateAnonymousThread(
    procedure
    begin
      while not IsWindowVisible(ADialog.Handle) do ;

      TThread.Queue(
        nil,

        procedure
        var
          ALeft,
          ATop    : Integer;
          ARect   : TRect;

          AHandle : NativeUInt;
        begin
          AHandle := BeginDeferWindowPos(1);

          try
            GetWindowRect(ADialog.Handle, ARect);

            ALeft := (Screen.Width  div 2) - (ARect.Width  div 2);
            ATop  := (Screen.Height div 2) - (ARect.Height div 2);

            DeferWindowPos(
                            AHandle,
                            ADialog.Handle,
                            0,
                            ALeft,
                            ATop,
                            ARect.Width,
                            ARect.Height,
                            SWP_NOZORDER
                          );
          finally
            EndDeferWindowPos(AHandle);
          end;
        end
      );
    end
  ).Start;

  Result := Self.Execute;
end;

end.
