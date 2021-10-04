unit RecycleTim.Core.Options;

interface

type

{ TOptions }

  TOptions = class
  private
    FAttempts: Integer;
  public
    constructor Create;
    property Attempts: Integer read FAttempts write FAttempts default 9;
  end;

implementation

{ TOptions }

constructor TOptions.Create;
begin
  inherited Create;
  FAttempts := 9;
end;

end.
