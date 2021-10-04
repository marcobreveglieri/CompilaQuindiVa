unit RecycleTim.Tests.Fakes.WordGeneratorStub;

interface

uses
  RecycleTim.Core.Words;

{ Routines }

function CreateWordGeneratorStub(const ASampleWord: string): IWordGenerator;

implementation

type

{ TWordGeneratorStub }

  TWordGeneratorStub = class(TInterfacedObject, IWordGenerator)
  private
    FSampleWord: string;
  public
    constructor Create(const ASampleWord: string);
    function GetNewWord: string;
  end;

{ TWordGeneratorStub }

constructor TWordGeneratorStub.Create(const ASampleWord: string);
begin
  inherited Create;
  FSampleWord := ASampleWord;
end;

function TWordGeneratorStub.GetNewWord: string;
begin
  Result := FSampleWord;
end;

{ Routines }

function CreateWordGeneratorStub(const ASampleWord: string): IWordGenerator;
begin
  Result := TWordGeneratorStub.Create(ASampleWord);
end;

end.
