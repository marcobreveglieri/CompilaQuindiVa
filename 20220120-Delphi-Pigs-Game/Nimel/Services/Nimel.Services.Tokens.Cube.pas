unit Nimel.Services.Tokens.Cube;

interface

uses
  Nimel.Core.Tokens;

{ Routines }

function CreateCubeToken: IToken;

implementation

uses
  System.Math;

type

{ TCubeToken }

  TCubeToken = class(TInterfacedObject, IToken)
  public
    function GetPoints: Integer;
  end;

function TCubeToken.GetPoints: Integer;
const
  MinValue: Integer = 1;
  MaxValue: Integer = 6;
begin
  Result := RandomRange(MinValue, MaxValue + 1);
end;

{ Routines }

function CreateCubeToken: IToken;
begin
  Result := TCubeToken.Create;
end;

initialization

Randomize;

end.
