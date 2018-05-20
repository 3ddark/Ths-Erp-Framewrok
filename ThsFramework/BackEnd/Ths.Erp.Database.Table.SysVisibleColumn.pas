unit Ths.Erp.Database.Table.SysVisibleColumn;

interface

uses
  SysUtils, Classes, Dialogs, Forms, Windows, Controls, Types, DateUtils,
  FireDAC.Stan.Param, System.Variants,
  Ths.Erp.Database,
  Ths.Erp.Database.Table;

type
  TSysVisibleColumns = class(TTable)
  private
    FTableName              : string;
    FColumnName             : string;
    FGridColumnWidth        : Integer;
    FGridIsPercentColorBar  : Boolean;
    FGridPercentMin         : Double;
    FGridPercentMax         : Double;
    FGridIsColorNumber      : Boolean;
    FGridColorNumberMin     : Double;
    FGridColorNumberMax     : Double;
    FGUIIsRequired          : Boolean;
    FGUIMaxLength           : Integer;
  protected
  published
    constructor Create(OwnerDatabase:TDatabase);override;
  public
    procedure SelectToDatasource(pFilter: string; pPermissionControl: Boolean=True); override;
    procedure SelectToList(pFilter: string; pLock: Boolean; pPermissionControl: Boolean=True); override;
    procedure Insert(out pID: Integer; pPermissionControl: Boolean=True); override;
    procedure Update(pPermissionControl: Boolean=True); override;

    procedure Clear();override;
    function Clone():TTable;override;

    Property TableName1             : string      read FTableName               write FTableName;
    Property ColumnName             : string      read FColumnName              write FColumnName;
    property GridColumnWidth        : Integer     read FGridColumnWidth         write FGridColumnWidth;
    property GridIsPercentColorBar  : Boolean     read FGridIsPercentColorBar   write FGridIsPercentColorBar;
    property GridPercentMin         : Double      read FGridPercentMin          write FGridPercentMin;
    property GridPercentMax         : Double      read FGridPercentMax          write FGridPercentMax;
    property GridIsColorNumber      : Boolean     read FGridIsColorNumber       write FGridIsColorNumber;
    property GridColorNumberMin     : Double      read FGridColorNumberMin      write FGridColorNumberMin;
    property GridColorNumberMax     : Double      read FGridColorNumberMax      write FGridColorNumberMax;
    property GUIIsRequired          : Boolean     read FGUIIsRequired           write FGUIIsRequired;
    property GUIMaxLength           : Integer     read FGUIMaxLength            write FGUIMaxLength;
  end;

implementation

uses
  Ths.Erp.Constants;

constructor TSysVisibleColumns.Create(OwnerDatabase:TDatabase);
begin
  inherited Create(OwnerDatabase);
  TableName := 'sys_visible_columns';
end;

procedure TSysVisibleColumns.SelectToDatasource(pFilter: string;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'table_name',
        TableName + '.' + 'column_name',
        TableName + '.' + 'grid_column_width',
        TableName + '.' + 'grid_is_percent_color_bar',
        TableName + '.' + 'grid_percent_min',
        TableName + '.' + 'grid_percent_max',
        TableName + '.' + 'grid_is_color_number',
        TableName + '.' + 'grid_color_number_min',
        TableName + '.' + 'grid_color_number_max',
        TableName + '.' + 'gui_is_required',
        TableName + '.' + 'gui_max_length'
        ]) +
        'WHERE 1=1 ' + pFilter;
		  Open;
		  Active := True;

      Self.DataSource.DataSet.FindField('id').DisplayLabel := 'ID';
      Self.DataSource.DataSet.FindField('table_name').DisplayLabel := 'TABLE NAME';
      Self.DataSource.DataSet.FindField('column_name').DisplayLabel := 'COLUMN NAME';
      Self.DataSource.DataSet.FindField('grid_column_width').DisplayLabel := 'GRID COLUMN WIDTH';
      Self.DataSource.DataSet.FindField('grid_is_percent_color_bar').DisplayLabel := 'GRÝD PERCENT COLOR BAR?';
      Self.DataSource.DataSet.FindField('grid_percent_min').DisplayLabel := 'GRID PERCENT MIN';
      Self.DataSource.DataSet.FindField('grid_percent_max').DisplayLabel := 'GRID PERCENT MAX';
      Self.DataSource.DataSet.FindField('grid_is_color_number').DisplayLabel := 'GRID COLOR NUMBER?';
      Self.DataSource.DataSet.FindField('grid_color_number_min').DisplayLabel := 'GRID COLOR NUMBER MIN';
      Self.DataSource.DataSet.FindField('grid_color_number_max').DisplayLabel := 'GRID COLOR NUMBER MAX';
      Self.DataSource.DataSet.FindField('gui_is_required').DisplayLabel := 'GUI REQUIRED?';
      Self.DataSource.DataSet.FindField('gui_max_length').DisplayLabel := 'GUI MAX LENGTH';
	  end;
  end;
end;

procedure TSysVisibleColumns.SelectToList(pFilter: string; pLock: Boolean;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptRead, pPermissionControl) then
  begin
	  if (pLock) then
		  pFilter := pFilter + ' FOR UPDATE NOWAIT; ';

	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Text := Self.Database.GetSQLSelectCmd(TableName,
        [TableName + '.' + 'id',
        TableName + '.' + 'table_name',
        TableName + '.' + 'column_name',
        TableName + '.' + 'grid_column_width',
        TableName + '.' + 'grid_is_percent_color_bar',
        TableName + '.' + 'grid_percent_min',
        TableName + '.' + 'grid_percent_max',
        TableName + '.' + 'grid_is_color_number',
        TableName + '.' + 'grid_color_number_min',
        TableName + '.' + 'grid_color_number_max',
        TableName + '.' + 'gui_is_required',
        TableName + '.' + 'gui_max_length'
        ]) +
        ' WHERE 1=1 ' + pFilter;
		  Open;

		  FreeListContent();
		  List.Clear;
		  while NOT EOF do
		  begin
		    Self.Id            := FieldByName('id').AsInteger;

		    Self.FTableName             := FieldByName('table_name').AsString;
        Self.FColumnName            := FieldByName('column_name').AsString;
        Self.FGridColumnWidth       := FieldByName('grid_column_width').AsInteger;
        Self.FGridIsPercentColorBar := FieldByName('grid_is_percent_color_bar').AsBoolean;
        Self.FGridPercentMin        := FieldByName('grid_percent_min').AsFloat;
        Self.FGridPercentMax        := FieldByName('grid_percent_max').AsFloat;
        Self.FGridIsColorNumber     := FieldByName('grid_is_color_number').AsBoolean;
        Self.FGridColorNumberMin    := FieldByName('grid_color_number_min').AsFloat;
        Self.FGridColorNumberMax    := FieldByName('grid_color_number_max').AsFloat;
        Self.FGUIIsRequired         := FieldByName('gui_is_required').AsBoolean;
        Self.FGUIMaxLength          := FieldByName('gui_max_length').AsInteger;

		    List.Add(Self.Clone());

		    Next;
		  end;
		  EmptyDataSet;
		  Close;
	  end;
  end;
end;

procedure TSysVisibleColumns.Insert(out pID: Integer;
  pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptAddRecord, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLInsertCmd(TableName, SQL_PARAM_SEPERATE,
        ['table_name', 'column_name', 'grid_column_width',
        'grid_is_percent_color_bar', 'grid_percent_min', 'grid_percent_max',
        'grid_is_color_number', 'grid_color_number_min', 'grid_color_number_max',
        'gui_is_required', 'gui_max_length']);

      ParamByName('table_name').Value := Self.FTableName;
      ParamByName('column_name').Value := Self.FColumnName;
      ParamByName('grid_column_width').Value := Self.FGridColumnWidth;
      ParamByName('grid_is_percent_color_bar').Value := Self.FGridColumnWidth;
      ParamByName('grid_percent_min').Value := Self.FGridPercentMin;
      ParamByName('grid_percent_max').Value := Self.FGridPercentMax;
      ParamByName('grid_is_color_number').Value := Self.FGridIsColorNumber;
      ParamByName('grid_color_number_min').Value := Self.FGridColorNumberMin;
      ParamByName('grid_color_number_max').Value := Self.FGridColorNumberMax;
      ParamByName('gui_is_required').Value := Self.FGUIIsRequired;
      ParamByName('gui_max_length').Value := Self.FGUIMaxLength;

      Database.SetQueryParamsDefaultValue(QueryOfTable);

		  Open;
      if (Fields.Count > 0) and (not Fields.Fields[0].IsNull) then
        pID := Fields.FieldByName('id').AsInteger
      else
        pID := 0;

		  EmptyDataSet;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysVisibleColumns.Update(pPermissionControl: Boolean=True);
begin
  if Self.IsAuthorized(ptUpdate, pPermissionControl) then
  begin
	  with QueryOfTable do
	  begin
		  Close;
		  SQL.Clear;
		  SQL.Text := Self.Database.GetSQLUpdateCmd(TableName, SQL_PARAM_SEPERATE,
        ['table_name', 'column_name', 'grid_column_width',
        'grid_is_percent_color_bar', 'grid_percent_min', 'grid_percent_max',
        'grid_is_color_number', 'grid_color_number_min', 'grid_color_number_max',
        'gui_is_required', 'gui_max_length']);

      ParamByName('table_name').Value := Self.FTableName;
      ParamByName('column_name').Value := Self.FColumnName;
      ParamByName('grid_column_width').Value := Self.FGridColumnWidth;
      ParamByName('grid_is_percent_color_bar').Value := Self.FGridColumnWidth;
      ParamByName('grid_percent_min').Value := Self.FGridPercentMin;
      ParamByName('grid_percent_max').Value := Self.FGridPercentMax;
      ParamByName('grid_is_color_number').Value := Self.FGridIsColorNumber;
      ParamByName('grid_color_number_min').Value := Self.FGridColorNumberMin;
      ParamByName('grid_color_number_max').Value := Self.FGridColorNumberMax;
      ParamByName('gui_is_required').Value := Self.FGUIIsRequired;
      ParamByName('gui_max_length').Value := Self.FGUIMaxLength;

		  ParamByName('id').Value := Self.Id;

      Self.Database.SetQueryParamsDefaultValue(QueryOfTable);

		  ExecSQL;
		  Close;
	  end;
    Self.notify;
  end;
end;

procedure TSysVisibleColumns.Clear();
begin
  inherited;
  Self.FTableName := '';
  Self.FColumnName := '';
  Self.FGridColumnWidth := 0;
  Self.FGridIsPercentColorBar := False;
  Self.FGridPercentMin := 0;
  Self.FGridPercentMax := 0;
  Self.FGridIsColorNumber := False;
  Self.FGridColorNumberMin := 0;
  Self.FGridColorNumberMax := 0;
  Self.FGUIIsRequired := False;
  Self.FGUIMaxLength := 0;
end;

function TSysVisibleColumns.Clone():TTable;
begin
  Result := TSysVisibleColumns.Create(Database);
  TSysVisibleColumns(Result).FTableName             := Self.FTableName;
  TSysVisibleColumns(Result).FColumnName            := Self.FColumnName;
  TSysVisibleColumns(Result).FGridColumnWidth       := Self.FGridColumnWidth;
  TSysVisibleColumns(Result).FGridIsPercentColorBar := Self.FGridIsPercentColorBar;
  TSysVisibleColumns(Result).FGridPercentMin        := Self.FGridPercentMin;
  TSysVisibleColumns(Result).FGridPercentMax        := Self.FGridPercentMax;
  TSysVisibleColumns(Result).FGridIsColorNumber     := Self.FGridIsColorNumber;
  TSysVisibleColumns(Result).FGridColorNumberMin    := Self.FGridColorNumberMin;
  TSysVisibleColumns(Result).FGridColorNumberMax    := Self.FGridColorNumberMax;
  TSysVisibleColumns(Result).FGUIIsRequired         := Self.FGUIIsRequired;
  TSysVisibleColumns(Result).FGUIMaxLength          := Self.FGUIMaxLength;

  TSysVisibleColumns(Result).Id                     := Self.Id;
end;

end.
