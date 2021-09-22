unit Pomo.Core.Timer;

interface

uses
  System.SysUtils,
  FMX.Types,
  Pomo.Core.Options, Pomo.Core.Session, Pomo.Core.Types;

type

  TPomoTimer = class
  private
    FOptions: TPomoOptions;
    FSession: TPomoSession;
    FTimer: TTimer;
    procedure HandleInternalTimer(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    function Idle: Boolean;
    procedure Start(AStage: TPomoStage);
    procedure Stop;
    property Options: TPomoOptions read FOptions;
    property Session: TPomoSession read FSession;
  end;

implementation

constructor TPomoTimer.Create;
begin
  inherited Create;
  FOptions := TPomoOptions.Create;
  FTimer := TTimer.Create(nil);
  FTimer.Enabled := False;
  FTimer.Interval := 200;
  FTimer.OnTimer := HandleInternalTimer;
end;

destructor TPomoTimer.Destroy;
begin
  if FOptions <> nil then
    FreeAndNil(FOptions);
  if FSession <> nil then
    FreeAndNil(FSession);
  if FTimer <> nil then
    FreeAndNil(FTimer);
  inherited Destroy;
end;

procedure TPomoTimer.HandleInternalTimer(Sender: TObject);
begin
  if Idle then
    Exit;
  if not FSession.IsEnded then
    Exit;
  // HINT: Gestire log o evento per fine sessione.
  FreeAndNil(FSession);
end;

function TPomoTimer.Idle: Boolean;
begin
  Result := FSession = nil;
end;

procedure TPomoTimer.Start(AStage: TPomoStage);
begin
  if not Idle then
    raise Exception.Create('Non puoi avviare il timer quando è già attivo');
  FSession := TPomoSession.Create(AStage, FOptions.Minutes[AStage]);
  FTimer.Enabled := True;
end;

procedure TPomoTimer.Stop;
begin
  if Idle then
    Exit;
  // TODO: Gestire log o evento per stop forzato della sessione.
  FreeAndNil(FSession);
end;

end.
