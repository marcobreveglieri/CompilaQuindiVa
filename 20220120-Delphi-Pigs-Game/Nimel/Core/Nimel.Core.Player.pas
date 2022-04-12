unit Nimel.Core.Player;

interface

type

{ TPlayer }

  TPlayer = class
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName;
  end;

implementation

{ TPlayer }

constructor TPlayer.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

end.
