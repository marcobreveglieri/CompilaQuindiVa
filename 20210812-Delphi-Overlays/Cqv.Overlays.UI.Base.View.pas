unit Cqv.Overlays.UI.Base.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Actions, FMX.ActnList, Cqv.Overlays.UI.Base.Widget,
  FMX.Controls.Presentation;

type

  /// <summary>
  ///  Rappresenta la classe base da cui derivano tutte le viste specifiche
  ///  dell'applicazione che trovano posto nella finestra principale.
  /// </summary>
  TViewBaseFrame = class(TFrame)
    ViewActions: TActionList;
    ShowWidgetAction: TAction;
    HideWidgetAction: TAction;
    ViewToolBar: TToolBar;
    ShowWidgetButton: TButton;
    HideWidgetButton: TButton;
    procedure ViewActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure ShowWidgetActionExecute(Sender: TObject);
    procedure HideWidgetActionExecute(Sender: TObject);
  private
    FWidgetInstance: TWidgetBaseFrame;
  protected
    function GetWidgetClass: TWidgetClass; virtual;
    procedure InitializeWidget(const AWidget: TWidgetBaseFrame); virtual;
  public
    /// <summary>
    ///  Restituisce un titolo descrittivo per la vista.
    /// </summary>
    /// <remarks>
    ///  Ridefinire questo metodo nelle classi discendenti allo scopo
    ///  di restituire un titolo personalizzato per la vista specifica.
    /// </remarks>
    function GetTitle: string; virtual;
  end;

  TViewClass = class of TViewBaseFrame;

implementation

{$R *.fmx}

uses
  Cqv.Overlays.UI.Forms.Chroma;

function TViewBaseFrame.GetTitle: string;
begin
  Result := EmptyStr;
end;

function TViewBaseFrame.GetWidgetClass: TWidgetClass;
begin
  Result := nil;
end;

procedure TViewBaseFrame.HideWidgetActionExecute(Sender: TObject);
begin
  if FWidgetInstance = nil then
    Exit;
  FreeAndNil(FWidgetInstance);
end;

procedure TViewBaseFrame.InitializeWidget(const AWidget: TWidgetBaseFrame);
begin
  with AWidget do
  begin
    Parent := ChromaForm;
    Position.X := 0;
    Position.Y := 0;
    Align := TAlignLayout.Client;
  end;
end;

procedure TViewBaseFrame.ShowWidgetActionExecute(Sender: TObject);
begin
  if FWidgetInstance <> nil then
    Exit;
  var LWidgetClass := GetWidgetClass();
  if LWidgetClass = nil then
    Exit;
  FWidgetInstance := LWidgetClass.Create(Self);
  try
    InitializeWidget(FWidgetInstance);
  except
    FreeAndNil(FWidgetInstance);
    raise;
  end;
end;

procedure TViewBaseFrame.ViewActionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  var LHasWidgetClass := GetWidgetClass <> nil;
  var LHasWidgetInstance := FWidgetInstance <> nil;
  ShowWidgetAction.Visible := LHasWidgetClass;
  ShowWidgetAction.Enabled := not LHasWidgetInstance;
  HideWidgetAction.Visible := LHasWidgetClass;
  HideWidgetAction.Enabled := LHasWidgetInstance;
  Handled := True;
end;

end.
