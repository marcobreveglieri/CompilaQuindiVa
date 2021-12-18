unit Reflection.Attributes;

interface

uses
  System.Classes, System.TypInfo, System.Rtti;

type

{ IdentAttribute }

  IdentAttribute = class (TCustomAttribute)
  private
    FIdent: string;
  public
    constructor Create(const AIdent: string);
    property Ident: string read FIdent;
  end;

implementation

{ IdentAttribute }

constructor IdentAttribute.Create(const AIdent: string);
begin
  inherited Create;
  FIdent := AIdent;
end;

end.
