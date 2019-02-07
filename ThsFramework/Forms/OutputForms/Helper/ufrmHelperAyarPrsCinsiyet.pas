unit ufrmHelperAyarPrsCinsiyet;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Data.DB,
  Vcl.DBGrids, Vcl.Menus, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Grids,

  ufrmBase,
  ufrmBaseHelper,
  
  Ths.Erp.Database.Singleton,
  Ths.Erp.Database.Table,
  Ths.Erp.Database.Table.AyarPrsCinsiyet;

type
  TfrmHelperAyarPrsCinsiyet = class(TfrmBaseHelper)
  private
  published
    function getFilterEditData: string; override;
    constructor Create(AOwner: TComponent; pParentForm: TForm=nil;
      pTable: TTable=nil; pIsPermissionControl: Boolean=False;
      pFormMode: TInputFormMod=ifmNone;
      pFormOndalikMode: TFormOndalikMod=fomNormal;
      pFormViewMode: TInputFormViewMod=ivmNormal); override;
  public
  end;

implementation

{$R *.dfm}

constructor TfrmHelperAyarPrsCinsiyet.Create(AOwner: TComponent; pParentForm: TForm;
  pTable: TTable; pIsPermissionControl: Boolean; pFormMode: TInputFormMod;
  pFormOndalikMode: TFormOndalikMod;
  pFormViewMode: TInputFormViewMod);
begin
  pTable := TAyarPrsCinsiyet.Create(TSingletonDB.GetInstance.DataBase);
  inherited Create(AOwner, pParentForm, pTable, pIsPermissionControl, pFormMode, pFormOndalikMode, pFormViewMode);
end;

function TfrmHelperAyarPrsCinsiyet.getFilterEditData: string;
begin
  Result := FormatedVariantVal(dbgrdBase.DataSource.DataSet.FindField(TAyarPrsCinsiyet(Table).Cinsiyet.FieldName).DataType, dbgrdBase.DataSource.DataSet.FindField(TAyarPrsCinsiyet(Table).Cinsiyet.FieldName).Value);
end;

end.
