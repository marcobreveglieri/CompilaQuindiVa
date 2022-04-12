unit Nimel.Services.Messaging;

interface

uses
  System.Messaging;

type

{ TGameCommandType }

  TGameCommandType = (Start, Terminate, Quit);

{ TGameCommandMessage }

  TGameCommandMessage = class (TMessage<TGameCommandType>)
  private
    function GetCommandType: TGameCommandType;
  public
    property CommandType: TGameCommandType read GetCommandType;
  end;

implementation

{ TGameCommandMessage }

function TGameCommandMessage.GetCommandType: TGameCommandType;
begin
  Result := Self.Value;
end;

end.
