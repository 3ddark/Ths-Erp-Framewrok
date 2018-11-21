unit Ths.Erp.Database.Table.View;

interface

uses
  Forms, SysUtils, Classes, Dialogs, WinSock, System.Rtti,
  FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client,

  Ths.Erp.Database.Table;

type
  TView = class(TTable)
  private
  protected
  published
  public
    procedure Listen();override;
    procedure Unlisten();override;
    procedure Notify();override;

    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;
    procedure Delete(pPermissionControl: Boolean=True); override;

    function LogicalSelect(pFilter: string; pLock, pWithBegin, pPermissionControl: Boolean):Boolean;override;
    function LogicalInsert(out pID: Integer; pWithBegin, pWithCommit, pPermissionControl: Boolean):Boolean;override;
    function LogicalUpdate(pWithCommit, pPermissionControl: Boolean):Boolean;override;
    function LogicalDelete(pWithCommit, pPermissionControl: Boolean):Boolean;override;
  end;

implementation

uses
  Ths.Erp.Database.Singleton, Ths.Erp.Constants, Ths.Erp.Functions;

{ TView }

procedure TView.Listen;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

procedure TView.Notify;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

procedure TView.Unlisten;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

function TView.LogicalSelect(pFilter: string; pLock, pWithBegin,
  pPermissionControl: Boolean): Boolean;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

function TView.LogicalInsert(out pID: Integer; pWithBegin, pWithCommit,
  pPermissionControl: Boolean): Boolean;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

function TView.LogicalUpdate(pWithCommit, pPermissionControl: Boolean): Boolean;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

function TView.LogicalDelete(pWithCommit, pPermissionControl: Boolean): Boolean;
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

procedure TView.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

procedure TView.Update(pPermissionControl: Boolean=True);
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

procedure TView.Delete(pPermissionControl: Boolean);
begin
  raise Exception.Create(
      TranslateText('Unsupported process!', FrameworkLang.MessageUnsupportedProcess, LngMessage, LngSystem) + AddLBs + self.ClassName);
end;

end.
