unit UAppLookupComboBox;

interface

uses
  System.Classes, System.SysUtils, Vcl.StdCtrls, Vcl.Controls, Winapi.Messages,
  Winapi.Windows, Data.DB, Vcl.Graphics, System.Variants, Vcl.DBCtrls;

type
  TAppLookupComboBox = class(TCustomComboBox)
  private
    FDataLink: TFieldDataLink;
    FListSource: TDataSource;
    FListField: string;
    FKeyField: string;
    FUpdatingItems: Boolean;
    FIsTyping: Boolean;
    
    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    procedure ActiveChange(Sender: TObject);
    
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetDataField: string;
    procedure SetDataField(const Value: string);
    
    procedure SetListSource(const Value: TDataSource);
    procedure SetListField(const Value: string);
    procedure SetKeyField(const Value: string);
    
    procedure UpdateItems(const AForceShowAll: Boolean = False);
    function GetKeyValue: Variant;
    procedure SetKeyValue(const Value: Variant);
    procedure SelectCurrentItem;
  protected
    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Click; override;
    procedure DropDown; override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property KeyValue: Variant read GetKeyValue write SetKeyValue;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property ListSource: TDataSource read FListSource write SetListSource;
    property ListField: string read FListField write SetListField;
    property KeyField: string read FKeyField write SetKeyField;
    
    // Propriedades publicadas do TCustomComboBox
    property Align;
    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('IdalBuscaCombo', [TAppLookupComboBox]);
end;

{ TAppLookupComboBox }

constructor TAppLookupComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDown;
  FUpdatingItems := False;
  FIsTyping := False;
  
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TAppLookupComboBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TAppLookupComboBox.ActiveChange(Sender: TObject);
begin
  DataChange(Sender);
end;

procedure TAppLookupComboBox.DataChange(Sender: TObject);
begin
  if not FUpdatingItems and (FDataLink.Field <> nil) then
  begin
    SetKeyValue(FDataLink.Field.Value);
  end;
end;

procedure TAppLookupComboBox.UpdateData(Sender: TObject);
begin
  if (FDataLink.Field <> nil) then
  begin
    FDataLink.Field.Value := GetKeyValue;
  end;
end;

procedure TAppLookupComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (FDataLink <> nil) and (AComponent = DataSource) then
      DataSource := nil;
    if (AComponent = FListSource) then
      FListSource := nil;
  end;
end;

procedure TAppLookupComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
end;

procedure TAppLookupComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TAppLookupComboBox.CNCommand(var Message: TWMCommand);
begin
  // Captura quando o usuário digita
  if Message.NotifyCode = CBN_EDITCHANGE then
    FIsTyping := True;
  inherited;
end;

function TAppLookupComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TAppLookupComboBox.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TAppLookupComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

procedure TAppLookupComboBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TAppLookupComboBox.Change;
begin
  inherited Change;
  if not FUpdatingItems then
  begin
    UpdateItems(not FIsTyping);
  end;
end;

procedure TAppLookupComboBox.Click;
begin
  inherited Click;
  if not FUpdatingItems and (ItemIndex <> -1) then
  begin
    SelectCurrentItem;
  end;
end;

procedure TAppLookupComboBox.DropDown;
begin
  // Ao abrir o dropdown sem estar digitando (ex: clicando na seta), mostra tudo
  if not FIsTyping then
    UpdateItems(True);
  inherited DropDown;
end;

procedure TAppLookupComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: Pointer);
begin
  inherited ComboWndProc(Message, ComboWnd, ComboProc);
end;

procedure TAppLookupComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    FUpdatingItems := True;
    try
      Text := '';
      ItemIndex := -1;
    finally
      FUpdatingItems := False;
    end;
    FIsTyping := False;
    UpdateItems(True);
    Key := 0;
  end
  else if (Key = VK_DOWN) or (Key = VK_UP) then
  begin
    if not DroppedDown then
    begin
      DropDown;
      Key := 0;
    end;
  end
  else if (Key = VK_RETURN) then
  begin
    if DroppedDown then
    begin
      if ItemIndex <> -1 then
        SelectCurrentItem;
      DroppedDown := False;
      Key := 0;
    end;
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TAppLookupComboBox.SetKeyField(const Value: string);
begin
  FKeyField := Value;
end;

procedure TAppLookupComboBox.SetListField(const Value: string);
begin
  FListField := Value;
end;

procedure TAppLookupComboBox.SetListSource(const Value: TDataSource);
begin
  FListSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TAppLookupComboBox.SelectCurrentItem;
begin
  FUpdatingItems := True;
  try
    if (ItemIndex <> -1) then
    begin
      Text := Items[ItemIndex];
      if (FDataLink.DataSource <> nil) and (FDataLink.FieldName <> '') then
      begin
        FDataLink.Edit;
        FDataLink.Field.Value := GetKeyValue;
      end;
    end;
    FIsTyping := False;
  finally
    FUpdatingItems := False;
  end;
end;

function TAppLookupComboBox.GetKeyValue: Variant;
begin
  Result := Null;
  if (FListSource <> nil) and (FListSource.DataSet <> nil) and (ItemIndex <> -1) and (FKeyField <> '') then
  begin
    FListSource.DataSet.DisableControls;
    try
      FListSource.DataSet.First;
      FListSource.DataSet.MoveBy(ItemIndex);
      Result := FListSource.DataSet.FieldByName(FKeyField).Value;
    finally
      FListSource.DataSet.EnableControls;
    end;
  end;
end;

procedure TAppLookupComboBox.SetKeyValue(const Value: Variant);
var
  LValue: string;
begin
  if (FListSource <> nil) and (FListSource.DataSet <> nil) and (FKeyField <> '') then
  begin
    FUpdatingItems := True;
    try
      if FListSource.DataSet.Locate(FKeyField, Value, []) then
      begin
        LValue := FListSource.DataSet.FieldByName(FListField).AsString;
        
        // Garante que a lista está completa para encontrar o item
        FListSource.DataSet.Filtered := False;
        Items.BeginUpdate;
        try
          Items.Clear;
          FListSource.DataSet.First;
          while not FListSource.DataSet.Eof do
          begin
            Items.Add(FListSource.DataSet.FieldByName(FListField).AsString);
            FListSource.DataSet.Next;
          end;
        finally
          Items.EndUpdate;
        end;
        
        ItemIndex := Items.IndexOf(LValue);
        Text := LValue;
      end
      else
      begin
        ItemIndex := -1;
        Text := '';
      end;
      FIsTyping := False;
    finally
      FUpdatingItems := False;
    end;
  end;
end;

procedure TAppLookupComboBox.UpdateItems(const AForceShowAll: Boolean = False);
var
  SavedText: string;
  SS: Integer;
begin
  if (FListSource = nil) or (FListSource.DataSet = nil) or (FListField = '') then
    Exit;

  FUpdatingItems := True;
  try
    SavedText := Text;
    SS := SelStart;

    FListSource.DataSet.DisableControls;
    try
      if (SavedText <> '') and not AForceShowAll then
      begin
        FListSource.DataSet.Filter := FListField + ' LIKE ' + QuotedStr('%' + SavedText + '%');
        FListSource.DataSet.Filtered := True;
      end
      else
      begin
        FListSource.DataSet.Filtered := False;
      end;

      Items.BeginUpdate;
      try
        Items.Clear;
        FListSource.DataSet.First;
        while not FListSource.DataSet.Eof do
        begin
          Items.Add(FListSource.DataSet.FieldByName(FListField).AsString);
          FListSource.DataSet.Next;
        end;
      finally
        Items.EndUpdate;
      end;
    finally
      FListSource.DataSet.EnableControls;
    end;

    Text := SavedText;
    SelStart := SS;
    ItemIndex := -1; // Impede o preenchimento automático
    
    // Mostra o dropdown se estiver digitando
    if (SavedText <> '') and not DroppedDown and FIsTyping then
    begin
      DropDown;
    end;

  finally
    FUpdatingItems := False;
  end;
end;

end.
