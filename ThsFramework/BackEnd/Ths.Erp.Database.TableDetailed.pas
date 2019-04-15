unit Ths.Erp.Database.TableDetailed;

interface

{$I ThsERP.inc}

uses
  Forms, SysUtils, Classes, Dialogs, WinSock, System.Rtti, System.UITypes,
  StrUtils,
  FireDAC.Stan.Param, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Error,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  {$M+}
  TTableDetailed = class(TTable)
  private
  protected
    FListDetay: TList;
    FListSilinenDetay: TList;

    procedure RefreshHeader();virtual;abstract;
    function ValidateDetay(pTable: TTable): boolean; virtual; abstract;
  published
    property ListDetay: TList read FListDetay write FListDetay;
    property ListSilinenDetay: TList read FListSilinenDetay write FListSilinenDetay;

    constructor Create(pOwnerDatabase: TDatabase); override;
    destructor Destroy(); override;
    procedure FreeDetayListContent(); virtual;
  public
    procedure CloneDetayLists(pTableDetailed: TTableDetailed);

    procedure AddDetay(pTable: TTable); virtual; abstract;
    procedure UpdateDetay(pTable: TTable); virtual; abstract;
    procedure RemoveDetay(pTable: TTable); virtual; abstract;
  end;

implementation

{ TTableDetailed }

procedure TTableDetailed.CloneDetayLists(pTableDetailed: TTableDetailed);
var
  n1: Integer;
begin
  for n1 := 0 to ListDetay.Count -1 do
    pTableDetailed.ListDetay.Add(TTable(Self.ListDetay[n1]).Clone());

  for n1 := 0 to ListSilinenDetay.Count -1 do
    pTableDetailed.ListSilinenDetay.Add(TTable(Self.ListSilinenDetay[n1]).Clone());
end;

constructor TTableDetailed.Create(pOwnerDatabase: TDatabase);
begin
  inherited;

  ListDetay := TList.Create();
  ListDetay.Clear();

  ListSilinenDetay := TList.Create();
  ListSilinenDetay.Clear();
end;

destructor TTableDetailed.Destroy;
begin
  FreeDetayListContent();
  if Assigned(ListDetay) then
    ListDetay.Free;
  if Assigned(ListSilinenDetay) then
    ListSilinenDetay.Free;

  inherited;
end;

procedure TTableDetailed.FreeDetayListContent;
var
  n1: Integer;
begin
  if Assigned(ListDetay) then
    for n1 := 0 to ListDetay.Count-1 do
      TTable(ListDetay[n1]).Free;
  ListDetay.Clear;

  if Assigned(ListSilinenDetay) then
    for n1 := 0 to ListSilinenDetay.Count-1 do
      TTable(ListSilinenDetay[n1]).Free;
  ListSilinenDetay.Clear;
end;

end.
