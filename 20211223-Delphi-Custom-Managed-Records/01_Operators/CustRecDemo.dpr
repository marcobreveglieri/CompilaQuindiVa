program CustRecDemo;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils,
  MyRecord in 'MyRecord.pas';

type
  TMyRecordStaticArray = array [1 .. 5] of TMyRecord;
  TMyRecordDynArray = array of TMyRecord;

begin
  try
    Writeln('Block START');
    var r1: TMyRecord;
    Writeln(IntToStr(r1.Value));
    var r2: TMyRecord;
    r2 := r1;
    Writeln('Static array');
    var staticArray: TMyRecordStaticArray;
    Writeln('Dyn array - Declaration');
    var dynArr: TMyRecordDynArray;
    Writeln('Dyn array - SetLength(10)');
    SetLength(dynArr, 10);
    Writeln('Dyn array - SetLength(5)');
    SetLength(dynArr, 5);
    Writeln('Dyn array - SetLength(10)');
    SetLength(dynArr, 10);
    Writeln('Block END');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
