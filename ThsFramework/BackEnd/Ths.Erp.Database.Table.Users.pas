unit Ths.Erp.Database.Table.Users;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, uGenel,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TUsers = class(TTable)
  private
    FUserName       : string;
    FUserPassword   : string;
    FVersion        : string;
    FIsAdmin        : Boolean;
  protected
  published
    constructor Create(OwnerDatabase: TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property UserName       : string  read FUserName       write FUserName;
    Property UserPassword   : string  read FUserPassword   write FUserPassword;
    Property Version        : string  read FVersion        write FVersion;
    Property IsAdmin        : Boolean read FIsAdmin        write FIsAdmin;
  end;

implementation

constructor TUsers.Create(OwnerDatabase: TDatabase);
begin
  inherited;
  TableName := 'users';
  Self.PermissionSourceCode := 'USER';
end;

procedure TUsers.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
      EmptyDataSet;
		  SQL.Clear;
		  SQL.Text := ' SELECT id, validity, kullanici_adi, sifre, surum, is_yonetici ' +
                  ' FROM ' + TableName + ' WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.Fields[0].DisplayLabel := 'ID';
      Self.DataSource.DataSet.Fields[1].DisplayLabel := 'VALIDITY';
      Self.DataSource.DataSet.Fields[2].DisplayLabel := 'KULLANICI ADI';
      Self.DataSource.DataSet.Fields[3].DisplayLabel := 'ÞÝFRE';
      Self.DataSource.DataSet.Fields[4].DisplayLabel := 'SÜRÜM';
      Self.DataSource.DataSet.Fields[5].DisplayLabel := 'YÖNETÝCÝ?';
	  end;
  end
//  else
//    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TUsers.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_READ, bHakKontrol) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := 'SELECT id, validity, kullanici_adi, sifre, surum, is_yonetici FROM ' + TableName + ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id                 := FieldByName('id').AsInteger;
		    Self.Validity           := FieldByName('validity').AsBoolean;

		    Self.UserName           := FieldByName('kullanici_adi').AsString;
        Self.UserPassword       := FieldByName('sifre').AsString;
        Self.Version            := FieldByName('surum').AsString;
        Self.IsAdmin            := FieldByName('is_yonetici').AsBoolean;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end
//  else
//    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TUsers.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_WRITE, bHakKontrol) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
      ' SELECT kullanici_insert(' +
          QuotedStr(Self.UserName) + ',' +
          QuotedStr(Self.UserPassword) + ',' +
          QuotedStr(Self.Version) + ',' +
          QuotedStr(TGenel.myBoolToStr(Self.IsAdmin)) +
      ');';

		  Open;

      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.Fields[0].AsInteger
      else
        pID := 0;

		  EmptyDataSet;
		  Close;
	  end;
    Self.notify;
  end
//  else
//    raise Exception.Create('Bu kaynaða yazma hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TUsers.Update(pPermissionControl: Boolean=True);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_WRITE, bHakKontrol) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
		  ' UPDATE ' + TableName + ' SET validity=:validity, ' +
        ' kullanici_adi=:kullanici_adi, sifre=:sifre, surum=:surum, is_yonetici=:is_yonetici ' +
		  ' WHERE id=:id;' ;

      if (Self.UserName <> '') then
        ParamByName('kullanici_adi').Value := Self.UserName;
      ParamByName('sifre').Value := Self.UserPassword;
      ParamByName('surum').Value := Self.Version;
      ParamByName('is_yonetici').Value := Self.IsAdmin;

      ParamByName('validity').Value := Self.Validity;
      ParamByName('id').Value := Self.Id;

		  ExecSQL;
		  EmptyDataSet;
		  Close;
	  end;
//	  Database.Logger.RunLog('UPDATING ' + self.ClassName + ' id: ' + IntToStr(self.id));
    self.notify;
  end
//  else
//    raise Exception.Create('Bu kaynaðý güncelleme hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TUsers.Clear();
begin
  inherited;
  Self.UserName := '';
  Self.UserPassword := '';
  Self.Version := '';
  Self.IsAdmin := False;
end;

function TUsers.Clone():TTable;
begin
  Result := TUsers.Create(Database);

  TUsers(Result).UserName          := Self.UserName;
  TUsers(Result).UserPassword      := Self.UserPassword;
  TUsers(Result).Version           := Self.Version;
  TUsers(Result).IsAdmin           := Self.IsAdmin;

  TUsers(Result).Id                := Self.Id;
  TUsers(Result).Validity          := Self.Validity;
  TUsers(Result).PermissionSourceCode  := Self.PermissionSourceCode;
end;

end.
