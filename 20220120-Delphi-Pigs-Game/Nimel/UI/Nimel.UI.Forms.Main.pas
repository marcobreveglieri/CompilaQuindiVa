unit Nimel.UI.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, Nimel.UI.Frames.Match, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, System.ImageList, FMX.ImgList, System.Generics.Collections,
  Nimel.UI.Base.View;

type
  TMainForm = class(TForm)
  private
    FMessages: TDictionary<Integer, TClass>;
    FView: TBaseView;
    procedure MessageSubscribe;
    procedure MessageUnsubscribe;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowView(AViewClass: TViewClass);
  end;

implementation

{$R *.fmx}

uses
  System.Messaging,
  Nimel.Services.Messaging,
  Nimel.UI.Frames.Home,
  Nimel.UI.Frames.Winner;

{ TMainForm }

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMessages := TDictionary<Integer, TClass>.Create;
  MessageSubscribe;
  ShowView(THomeView);
end;

destructor TMainForm.Destroy;
begin
  MessageUnsubscribe;
  if Assigned(FMessages) then
    FreeAndNil(FMessages);
  inherited Destroy;
end;

procedure TMainForm.MessageSubscribe;
var
  LMessageManager: TMessageManager;
begin
  LMessageManager := TMessageManager.DefaultManager;
  FMessages.Add(LMessageManager.SubscribeToMessage(
    TGameCommandMessage,
    procedure(const Sender: TObject; const M: TMessage)
    begin
      var LMessage := TGameCommandMessage(M);
      case LMessage.CommandType of
        Start:
          ShowView(TMatchView);
        Terminate:
          ShowView(THomeView);
        Quit:
          Self.Close();
      end;
    end), TGameCommandMessage);
end;

procedure TMainForm.MessageUnsubscribe;
var
  LMessageManager: TMessageManager;
begin
  LMessageManager := TMessageManager.DefaultManager;
  for var LMessagePair in FMessages do
  begin
    var LSubscriptionId := LMessagePair.Key;
    var LMessageClass := LMessagePair.Value;
    LMessageManager.Unsubscribe(LMessageClass, LSubscriptionId);
  end;
end;

procedure TMainForm.ShowView(AViewClass: TViewClass);
begin
  if not Assigned(AViewClass) then
    Exit;

  if Assigned(FView) and (FView.ClassType = AViewClass) then
    Exit;

  var LView := AViewClass.Create(Self);
  try
    LView.Name := '';
    LView.Parent := Self;
  except
    FreeAndNil(LView);
    raise;
  end;

  if Assigned(FView) then
    FreeAndNil(FView);

  FView := LView;
end;

end.
