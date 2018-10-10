unit Ths.Erp.Helper.BaseTypes;

interface

uses
  System.SysUtils;

type
  TInputType = (itString, itInteger, itFloat, itMoney, itDate);

  function LowCase(pKey: Char): Char;
  function LowCaseTr(pKey: Char): Char;
  function UpCaseTr(pKey: Char): Char;

implementation

function LowCase(pKey: Char): Char;
begin
  //Result := Char(Word(pKey) or $0020);
  Result := pKey;
  if CharInSet(Result, ['A'..'Z']) then
    Inc(Result, Ord('a')-Ord('A'));
end;

function LowCaseTr(pKey: Char): Char;
begin
  case pKey of
    'I': pKey := 'ý';
    'Ý': pKey := 'i';
    'Ð': pKey := 'ð';
    'Ü': pKey := 'ü';
    'Þ': pKey := 'þ';
    'Ö': pKey := 'ö';
    'Ç': pKey := 'ç';
  else
    pKey := LowCase(pKey);
  end;
  Result := pKey;
end;

function UpCaseTr(pKey: Char): Char;
begin
  case pKey of
    'ý': pKey := 'I';
    'i': pKey := 'Ý';
    'ð': pKey := 'Ð';
    'ü': pKey := 'Ü';
    'þ': pKey := 'Þ';
    'ö': pKey := 'Ö';
    'ç': pKey := 'Ç';
  else
    pKey := UpCase(pKey);
  end;
  Result := pKey;
end;

end.
