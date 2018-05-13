unit Ths.Erp.Database.Table.SysUserAccessRight;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, StrUtils, uGenel,
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
    //veri tabaný alaný deðil
    FKaynakGrup        : String;
    FKaynak            : String;
  protected
  published
    constructor Create(OwnerDatabase: TDatabase);override;
  public
    procedure select_to_datasource(pFiltre: string; pHakKontrol: Boolean=True); override;
    procedure select_to_list(pFiltre: string; pLock: Boolean; pHakKontrol: Boolean=True); override;
    procedure insert(out pID: Integer; pHakKontrol: Boolean=True); override;
    procedure update(pHakKontrol: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property KaynakID       : Integer  read FKaynakID           write FKaynakID;
    Property IsRead         : Boolean  read FIsRead             write FIsRead;
    Property IsWrite        : Boolean  read FIsWrite            write FIsWrite;
    Property IsDelete       : Boolean  read FIsDelete           write FIsDelete;
    Property KullaniciID    : Integer  read FKullaniciID        write FKullaniciID;
    //veri tabaný alaný deðil
    Property KaynakGrup     : String   read FKaynakGrup         write FKaynakGrup;
    Property Kaynak         : String   read FKaynak             write FKaynak;
  end;

implementation

constructor TSysUserAccessRight.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TabloAdi := 'kaynak_erisim_hakki';
  Self.FormKaynak := 'ERÝÞÝM HAKKI';
end;

procedure TSysUserAccessRight.select_to_datasource(pFiltre: string; pHakKontrol: Boolean=True);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_READ, bHakKontrol) then
  begin
	  with QueryOfTable do
	  begin
		  Close;    QueryOfTable.EmptyDataSet;
//		  EmptyDataSet;
		  SQL.Clear;
		  SQL.Text := ' SELECT keh.id, keh.validity, kaynak_id, kg.grup, k.kaynak, is_read, is_write, is_delete, kullanici_id ' +
                  ' FROM ' + TabloAdi + ' as keh ' +
                  ' JOIN kaynak k ON k.id = kaynak_id ' +
                  ' JOIN kaynak_grup kg ON kg.id = kaynak_grup_id ' +
                  ' WHERE 1=1 ' + pFiltre;
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
//  else
//    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TSysUserAccessRight.select_to_list(pFiltre: string; pLock: Boolean; pHakKontrol: Boolean=True);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_READ, bHakKontrol) then
  begin
	  if (pLock) then
		  pFiltre := pFiltre + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := ' SELECT keh.id, keh.validity, kaynak_id, kg.grup, k.kaynak, is_read, is_write, is_delete, kullanici_id, table_name ' +
                  ' FROM ' + TabloAdi + ' as keh ' +
                  ' JOIN kaynak k ON k.id = kaynak_id ' +
                  ' JOIN kaynak_grup kg ON kg.id = kaynak_grup_id ' +
                  ' WHERE 1=1 ' + pFiltre;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id               := FieldByName('id').AsInteger;
		    Self.Validity         := FieldByName('validity').AsBoolean;

		    Self.KaynakID         := FieldByName('kaynak_id').AsInteger;
        Self.IsRead           := FieldByName('is_read').AsBoolean;
        Self.IsWrite          := FieldByName('is_write').AsBoolean;
        Self.IsDelete         := FieldByName('is_delete').AsBoolean;
        Self.KullaniciID      := FieldByName('kullanici_id').AsInteger;

		    List.Add(Self.Clone());

//		    if (bLock) then
//			    FDatabase.Logger.RunLog('LOCKING ' + self.ClassName + ' id: ' + IntToStr(self.id));

		    Next;
		  end; 
		  EmptyDataSet;
		  Close;
	  end; 
  end
//  else
//    raise Exception.Create('Bu kaynaða eriþim hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TSysUserAccessRight.insert(out pID: Integer; pHakKontrol: Boolean=True);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_WRITE, bHakKontrol) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
      ' SELECT kaynak_erisim_hakki_insert(' +
          QuotedStr(Self.KaynakID.ToString) + ',' +
          QuotedStr(TGenel.myBoolToStr(Self.IsRead)) + ',' +
          QuotedStr(TGenel.myBoolToStr(Self.IsWrite)) + ',' +
          QuotedStr(TGenel.myBoolToStr(Self.IsDelete)) + ',' +
          QuotedStr(Self.KullaniciID.ToString) +
          ');';

		  Open;
      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.Fields[0].AsInteger
      else
        pID := 0;

		  EmptyDataSet;
		  Close;
	  end;
//	  Database.Logger.RunLog('INSERTING ' + self.ClassName + ' id: ' + IntToStr(id));
    Self.notify;
  end
//  else
//    raise Exception.Create('Bu kaynaða yazma hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TSysUserAccessRight.update(pHakKontrol: Boolean = true);
begin
//  if Database.IsAuthorized(Self.FormKaynak, ACCESS_TYPE_WRITE, bHakKontrol) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text :=
		  ' UPDATE ' + TabloAdi + ' SET validity=:validity, ' +
        ' kaynak_id=:kaynak_id, is_read=:is_read, is_write=:is_write, is_delete=:is_delete, kullanici_id=:kullanici_id ' +
		  ' WHERE id=:id;' ;

		  if (Self.KaynakID <> 0) then
		    ParamByName('kaynak_id').Value := Self.KaynakID;
      ParamByName('is_read').Value := Self.IsRead;
      ParamByName('is_write').Value := Self.IsWrite;
      ParamByName('is_delete').Value := Self.IsDelete;
      if (Self.KullaniciID <> 0) then
		    ParamByName('kullanici_id').Value := Self.KullaniciID;

		  ParamByName('validity').Value := Self.Validity;
		  ParamByName('id').Value       := Self.Id;

		  ExecSQL;
		  EmptyDataSet;
		  Close;
	  end;
//	  Database.Logger.RunLog('UPDATING ' + self.ClassName + ' id: ' + IntToStr(self.id));
    Self.notify;
  end
//  else
//    raise Exception.Create('Bu kaynaðý güncelleme hakkýnýz yok! : ' + self.ClassName + sLineBreak + 'Eksik olan eriþim hakký: ' + Self.FormKaynak);
end;

procedure TSysUserAccessRight.Clear();
begin
  inherited;
  Self.KaynakID := 0;
  Self.IsRead := False;
  Self.IsWrite := False;
  Self.IsDelete := False;
  Self.KullaniciID := 0;
end;

function TSysUserAccessRight.Clone():TTable;
begin
  Result := TKaynakErisimHakki.Create(Database);

  TKaynakErisimHakki(Result).KaynakID        := Self.KaynakID;
  TKaynakErisimHakki(Result).IsRead          := Self.IsRead;
  TKaynakErisimHakki(Result).IsWrite         := Self.IsWrite;
  TKaynakErisimHakki(Result).IsDelete        := Self.IsDelete;
  TKaynakErisimHakki(Result).KullaniciID     := Self.KullaniciID;

  TKaynakErisimHakki(Result).Validity  := Self.Validity;
  TKaynakErisimHakki(Result).Id        := Self.Id;
  TKaynakErisimHakki(Result).FormKaynak      := Self.FormKaynak;
end;

end.
