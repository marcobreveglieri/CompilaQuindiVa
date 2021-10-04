unit RecycleTim.Core.Game;

interface

uses
  System.Classes,
  System.Generics.Collections,
  System.SysUtils,
  RecycleTim.Core.Options,
  RecycleTim.Core.Types,
  RecycleTim.Core.Words;

type

{ TGame }

  TGame = class
  private
    FAttempts: Integer;
    FChars: TDictionary<Char, Char>;
    FOptions: TOptions;
    FSecretWord: string;
    FStatus: TGameStatus;
    function GetChars: TArray<Char>;
    function GetMaskedWord: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Start(AWordGenerator: IWordGenerator);
    procedure Surrend;
    procedure TryChar(AChar: Char);
    property Attempts: Integer read FAttempts;
    property Chars: TArray<Char> read GetChars;
    property Options: TOptions read FOptions;
    property MaskedWord: string read GetMaskedWord;
    property SecretWord: string read FSecretWord;
    property Status: TGameStatus read FStatus;
  end;

implementation

{ TGame }

constructor TGame.Create;
begin
  inherited Create;
  FChars := TDictionary<Char, Char>.Create();
  FOptions := TOptions.Create();
end;

destructor TGame.Destroy;
begin
  if FChars <> nil then
    FreeAndNil(FChars);
  if FOptions <> nil then
    FreeAndNil(FOptions);
  inherited Destroy;
end;

function TGame.GetChars: TArray<Char>;
begin
  Result := FChars.Keys.ToArray();
end;

function TGame.GetMaskedWord: string;
begin
  var LBuilder := TStringBuilder.Create;
  try
    for var LSecretChar in FSecretWord do
    begin
      if FChars.ContainsKey(LSecretChar) then
        LBuilder.Append(LSecretChar)
      else
        LBuilder.Append('_');
    end;
    Result := LBuilder.ToString();
  finally
    LBuilder.Free;
  end;
end;

procedure TGame.Start(AWordGenerator: IWordGenerator);
begin
  if FStatus = TGameStatus.Playing then
    Exit;
  FSecretWord := AWordGenerator.GetNewWord().ToUpper();
  FAttempts := FOptions.Attempts;
  FChars.Clear();
  FStatus := TGameStatus.Playing;
end;

procedure TGame.Surrend;
begin
  if FStatus <> TGameStatus.Playing then
    Exit;
  FAttempts := 0;
  FStatus := TGameStatus.Lost;
end;

procedure TGame.TryChar(AChar: Char);
begin
  if FStatus <> TGameStatus.Playing then
    Exit;
  AChar := UpCase(AChar);
  if FChars.ContainsKey(AChar) then
    Exit;
  FChars.Add(AChar, #0);
  if not FSecretWord.Contains(AChar) then
  begin
    Dec(FAttempts);
    if FAttempts > 0 then
      Exit;
    Surrend;
  end;
  if MaskedWord <> SecretWord then
    Exit;
  FStatus := TGameStatus.Won;
end;

end.
