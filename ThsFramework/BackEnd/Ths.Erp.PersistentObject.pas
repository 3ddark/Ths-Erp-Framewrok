unit Ths.Erp.PersistentObject;

interface

uses
  Rtti, StrUtils, Variants, Classes, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.DApt, SysUtils,
  Ths.Erp.Database;

type
  TPersintentObject = class
  private
    FSQL: WideString;
    function GetValue(const ARTP: TRttiProperty; const AFK: Boolean): String;
    procedure SetValue(P: TRttiProperty; S: Variant);
  public
    property CustomSQL: WideString read FSQL write FSQL;
    function Insert: Boolean;
    function Update: Boolean;
    function Delete: Boolean;
    procedure Load(const AValue: Integer); overload; virtual; abstract;
    function Load: Boolean; overload;
  end;

implementation

uses
  Ths.Erp.Database.Table.Attribute;

{ TPersintentObject }

function TPersintentObject.Delete: Boolean;
begin
  Result := False;
end;

function TPersintentObject.GetValue(const ARTP: TRttiProperty;
  const AFK: Boolean): String;
begin
  case ARTP.PropertyType.TypeKind of
    tkUnknown, tkInteger,
    tkInt64: Result := ARTP.GetValue(Self).ToString;
    tkEnumeration: Result := IntToStr(Integer(ARTP.GetValue(Self).AsBoolean));
    tkChar, tkString,
    tkWChar, tkLString,
    tkWString, tkUString: Result := QuotedStr(ARTP.GetValue(Self).ToString);
    tkFloat: Result := StringReplace(FormatFloat('0.00',ARTP.GetValue(Self).AsCurrency)
              ,FormatSettings.DecimalSeparator,'.',[rfReplaceAll,rfIgnoreCase]);
  end;

  if (AFK) and (Result = '0') then
    Result := 'null';
end;

function TPersintentObject.Insert: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Value,
  FieldID,
  NomeTabela,Error: String;
  Qry: TFDQuery;
begin
  Field := '';
  Value := '';
//  TDatabase.GetInstance.BeginTrans;
  Ctx := TRttiContext.Create;
  try
    try
      RTT := CTX.GetType(ClassType);
      for Att in RTT.GetAttributes do
      begin
        if Att is AttTableName then
        begin
          SQL := 'INSERT INTO ' + AttTableName(ATT).Name;
          NomeTabela := AttTableName(ATT).Name;
        end;
      end;

      for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
         begin
           if Att is AttFieldName then
           begin
             if not (AttFieldName(ATT).AutoInc) then {Auto incremento não pode entrar no insert}
             begin
               Field := Field + AttFieldName(ATT).Name + ',';
               Value := Value + GetValue(RTP, AttFieldName(ATT).FK) + ',';
             end
             else
               FieldID := AttFieldName(ATT).Name;
           end;
         end;
      end;

      Field := Copy(Field,1,Length(Field)-1);
      Value := Copy(Value,1,Length(Value)-1);

      SQL := SQL + ' (' + Field + ') VALUES (' + Value + ')';
      if Trim(CustomSQL) <> '' then
        SQL := CustomSQL;
//      Result := TConnection.GetInstance.Execute(SQL,Error);

      SQL := 'SELECT ' + FieldID + ' FROM ' + NomeTabela + ' ORDER BY ' + FieldID + ' DESC';
//      Qry := TConnection.GetInstance.ExecuteQuery(SQL);

      for RTP in RTT.GetProperties do
      begin
         for Att in RTP.GetAttributes do
         begin
           if (Att is AttFieldName) and (AttFieldName(ATT).AutoInc) then
           begin
             RTP.SetValue(Self,TValue.FromVariant(qry.Fields[0].AsInteger));
           end;
         end;
      end;
    finally
      CustomSQL := '';
//      TConnection.GetInstance.Commit;
      CTX.Free;
    end;
  except
//    TConnection.GetInstance.Rollback;
    raise;
  end;
end;

function TPersintentObject.Load: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Where: String;
  Reader: TFDQuery;
begin
  Result := True;
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
    begin
      if Att is AttTableName then
        SQL := 'SELECT * FROM ' + AttTableName(ATT).Name;
    end;

    for RTP in RTT.GetProperties do
    begin
       for Att in RTP.GetAttributes do
       begin
         if Att is AttFieldName then
         begin
           if (AttFieldName(ATT).PK) then
             Where := Where + Ifthen(Trim(where)='','',' AND ') + AttFieldName(ATT).Name + ' = ' + GetValue(RTP, AttFieldName(ATT).FK);
         end;
       end;
    end;
    SQL := SQL + ' WHERE ' + Where;

    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;

//    Reader := TConnection.GetInstance.ExecuteQuery(SQL);

    if (Assigned(Reader)) and (Reader.RecordCount > 0) then
    begin
      with Reader do
      begin
        First;
        while not EOF do
        begin
          for RTP in RTT.GetProperties do
          begin
             for Att in RTP.GetAttributes do
             begin
               if Att is AttFieldName then
               begin
                 if Assigned(FindField(AttFieldName(ATT).Name)) then
                   SetValue(RTP, FieldByName(AttFieldName(ATT).Name).Value);
               end;
             end;
          end;
          Next;
        end;
      end;
    end
    else
      Result := False;
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;

procedure TPersintentObject.SetValue(P: TRttiProperty; S: Variant);
var
  V: TValue;
  w: Word;
begin
  w := VarType(S);
  case w of
    271: v := StrToFloat(S); {smallmoney}
    272: v := StrToDateTime(S); {smalldatetime}
    3: v := StrToInt(S);
  else
    begin
      P.SetValue(Self,TValue.FromVariant(S));
      exit;
    end;
  end;
  p.SetValue(Self,v);
end;

function TPersintentObject.Update: Boolean;
var
  Ctx: TRttiContext;
  RTT: TRttiType;
  RTP: TRttiProperty;
  Att: TCustomAttribute;
  SQL,
  Field,
  Where,
  Error: String;
begin
  Field := '';
  Ctx := TRttiContext.Create;
  try
    RTT := CTX.GetType(ClassType);
    for Att in RTT.GetAttributes do
    begin
      if Att is AttTableName then
        SQL := 'UPDATE ' + AttTableName(ATT).Name + ' SET';
    end;

    for RTP in RTT.GetProperties do
    begin
       for Att in RTP.GetAttributes do
       begin
         if Att is AttFieldName then
         begin
           if (not (AttFieldName(ATT).AutoInc)) and (not (AttFieldName(ATT).PK)) then {Auto incremento não pode entrar no update}
           begin
             Field := Field + AttFieldName(ATT).Name + ' = ' + GetValue(RTP, AttFieldName(ATT).FK) + ',';
           end
           else if (AttFieldName(ATT).PK) then
             Where := Where + Ifthen(Trim(where)='','',' AND ') + AttFieldName(ATT).Name + ' = ' + GetValue(RTP, AttFieldName(ATT).FK);
         end;
       end;
    end;

    Field := Copy(Field,1,Length(Field)-1);
    SQL := SQL + ' ' + Field + ' WHERE ' + Where;
    if Trim(CustomSQL) <> '' then
      SQL := CustomSQL;
//    Result := TConnection.GetInstance.Execute(SQL,Error);
    if not Result then
      raise Exception.Create(Error);
  finally
    CustomSQL := '';
    CTX.Free;
  end;
end;

end.

