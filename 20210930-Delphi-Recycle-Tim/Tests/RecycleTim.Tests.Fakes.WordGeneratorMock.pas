unit RecycleTim.Tests.Fakes.WordGeneratorMock;

interface

uses
  RecycleTim.Core.Words;

type

  TWordGeneratorMock = class(TInterfacedObject, IWordGenerator)
  private
    FSuccess: Boolean;
  public
    function GetNewWord: string;
    property Success: Boolean read FSuccess;
  end;

implementation

{ TWordGeneratorMock }

function TWordGeneratorMock.GetNewWord: string;
begin
  Result := '';
  FSuccess := True;
end;

{ Routines }

function CreateWordGeneratorMock: IWordGenerator;
begin
  Result := TWordGeneratorMock.Create();
end;

end.
