program SmartPointerDemo;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils,
  SmartPtr in 'SmartPtr.pas';

type

  TFoo = class(TRefCountable)
  private
    FIntVal: Integer;
    FStrVal: string;
  public
    property IntVal: Integer read FIntVal write FIntVal;
    property StrVal: string read FStrVal write FStrVal;
  end;

begin
  try
    var Foo1 := TSmartPtr<TFoo>.Create(TFoo.Create);
    { The smart pointer has a reference count of 1. }

    { Set some properties }
    Foo1.Ref.IntVal := 42;
    Foo1.Ref.StrVal := 'Foo';

    begin

      { Copy the smart pointer. It has a reference count of 2 now. }
      var Foo2 := Foo1;

      { Check properties }
      Assert(Foo2.Ref.IntVal = 42);
      Assert(Foo2.Ref.StrVal = 'Foo');

      { Foo2 will go out of scope here, so only Foo1
        will keep a reference to the TFoo object.
        The reference count will be reduced to 1. }
    end;

    { Check properties again }
    Assert(Foo1.Ref.IntVal = 42);

    { Now Foo1 will go out of scope, reducing the
      reference count to 0 and destroying the TFoo object. }
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
  end;

end.
