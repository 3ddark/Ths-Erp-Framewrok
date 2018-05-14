unit Ths.Erp.Database.Table.SysUserAccessRight;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, StrUtils,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysUserAccessRight = class(TTable)
  private
    FPermissionSourceCode : string;
    FIsRead               : Boolean;
    FIsWrite              : Boolean;
    FIsDelete             : Boolean;
    FIsSpecial            : Boolean;
    FUserName             : string;
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

    Property PermissionCode : string   read FPermissionSourceCode write FPermissionSourceCode;
    Property IsRead         : Boolean  read FIsRead             write FIsRead;
    Property IsWrite        : Boolean  read FIsWrite            write FIsWrite;
    Property IsDelete       : Boolean  read FIsDelete           write FIsDelete;
    Property IsSpecial      : Boolean  read FIsSpecial          write FIsSpecial;
    Property UserName       : string   read FUserName           write FUserName;
  end;

implementation

constructor TSysUserAccessRight.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'kaynak_erisim_hakki';
  Self.PermissionSourceCode := 'ERÝÞÝM HAKKI';
end;

procedure TSysUserAccessRight.SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := ' SELECT keh.id, keh.validity, kaynak_id, kg.grup, k.kaynak, is_read, is_write, is_delete, kullanici_id ' +
                  ' FROM ' + TableName + ' as keh ' +
                  ' JOIN kaynak k ON k.id = kaynak_id ' +
                  ' JOIN kaynak_grup kg ON kg.id = kaynak_grup_id ' +
                  ' WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.Fields[0].DisplayLabel := 'ID';
      Self.DataSource.DataSet.Fields[1].DisplayLabel := 'VALIDITY';
      Self.DataSource.DataSet.Fields[2].DisplayLabel := 'KAYNAK ID';
      Self.DataSource.DataSet.Fields[3].DisplayLabel := 'GRUP';
      Self.DataSource.DataSet.Fields[4].DisplayLabel := 'KAYNAK';
      Self.DataSource.DataSet.Fields[5].DisplayLabel := 'OKUMA?';
      Self.DataSource.DataSet.Fields[6].DisplayLabel := 'YAZMA?';
      Self.DataSource.DataSet.Fields[7].DisplayLabel := 'SÝLME?';
      Self.DataSource.DataSet.Fields[8].DisplayLabel := 'KULLANICI ID';
	  end;
  end
  else
    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TSysUserAccessRight.SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := ' SELECT keh.id, keh.validity, kaynak_id, kg.grup, k.kaynak, is_read, is_write, is_delete, kullanici_id, table_name ' +
                  ' FROM ' + TableName + ' as keh ' +
                  ' JOIN kaynak k ON k.id = kaynak_id ' +
                  ' JOIN kaynak_grup kg ON kg.id = kaynak_grup_id ' +
                  ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id               := FieldByName('id').AsInteger;
		    Self.Validity         := FieldByName('validity').AsBoolean;

		    Self.FPermissionSourceCode := FieldByName('kaynak_id').AsString;
        Self.FIsRead := FieldByName('is_read').AsBoolean;
        Self.FIsWrite := FieldByName('is_write').AsBoolean;
        Self.FIsDelete := FieldByName('is_delete').AsBoolean;
        Self.FUserName := FieldByName('kullanici_id').AsString;

		    List.Add(Self.Clone());

		    Next;
		  end; 
		  EmptyDataSet;
		  Close;
	  end; 
  end
  else
    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TSysUserAccessRight.Insert(out pID: Integer; pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
      ' SELECT kaynak_erisim_hakki_insert(' +
          QuotedStr(Self.PermissionCode) + ',' +
          QuotedStr({TGenel.myBoolToStr(Self.IsRead)}'') + ',' +
          QuotedStr({TGenel.myBoolToStr(Self.IsWrite)}'') + ',' +
          QuotedStr({TGenel.myBoolToStr(Self.IsDelete)}'') + ',' +
          QuotedStr(Self.UserName) +
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
  else
    raise Exception.Create('Bu kaynaða yazma hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TSysUserAccessRight.Update(pPermissionControl: Boolean=True);
begin
  if Database.IsAuthorized(Self.PermissionSourceCode, ptWrite, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
		  ' UPDATE ' + TableName + ' SET validity=:validity, ' +
        ' kaynak_id=:kaynak_id, is_read=:is_read, is_write=:is_write, is_delete=:is_delete, kullanici_id=:kullanici_id ' +
		  ' WHERE id=:id;' ;

	    ParamByName('kaynak_id').Value := Self.FPermissionSourceCode;
      ParamByName('is_read').Value := Self.FIsRead;
      ParamByName('is_write').Value := Self.FIsWrite;
      ParamByName('is_delete').Value := Self.FIsDelete;
      ParamByName('is_delete').Value := Self.FIsSpecial;
	    ParamByName('kullanici_id').Value := Self.FUserName;

		  ParamByName('validity').Value := Self.Validity;
		  ParamByName('id').Value       := Self.Id;

		  ExecSQL;
		  EmptyDataSet;
		  Close;
	  end;

    Self.notify;
  end
  else
    raise Exception.Create('Bu kaynaðý güncelleme hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.PermissionSourceCode);
end;

procedure TSysUserAccessRight.Clear();
begin
  inherited;
  Self.FPermissionSourceCode := '';
  Self.FIsRead := False;
  Self.FIsWrite := False;
  Self.FIsDelete := False;
  Self.FIsSpecial := False;
  Self.FUserName := '';
end;

function TSysUserAccessRight.Clone():TTable;
begin
  Result := TSysUserAccessRight.Create(Database);

  TSysUserAccessRight(Result).FPermissionSourceCode  := Self.FPermissionSourceCode;
  TSysUserAccessRight(Result).FIsRead          := Self.FIsRead;
  TSysUserAccessRight(Result).FIsWrite         := Self.FIsWrite;
  TSysUserAccessRight(Result).FIsDelete        := Self.FIsDelete;
  TSysUserAccessRight(Result).FIsSpecial       := Self.FIsSpecial;
  TSysUserAccessRight(Result).FUserName        := Self.FUserName;

  TSysUserAccessRight(Result).Validity              := Self.Validity;
  TSysUserAccessRight(Result).Id                    := Self.Id;
  TSysUserAccessRight(Result).PermissionSourceCode  := Self.PermissionSourceCode;
end;

end.
