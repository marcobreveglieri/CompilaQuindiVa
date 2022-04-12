unit MyRecord;

interface

type

  TMyRecord = record
    Value: Integer;
    class operator Initialize(out Dest: TMyRecord);
    class operator Finalize(var Dest: TMyRecord);
    class operator Assign(var Dest: TMyRecord; const [ref] Src: TMyRecord);
  end;

implementation

uses
  System.SysUtils;

class operator TMyRecord.Initialize(out Dest: TMyRecord);
begin
  Dest.Value := 10;
  Writeln('Created @' + IntToHex(Integer(Pointer(@Dest))));
end;

class operator TMyRecord.Finalize(var Dest: TMyRecord);
begin
  Writeln('Destroyed @' + IntToHex(Integer(Pointer(@Dest))));
end;

class operator TMyRecord.Assign(var Dest: TMyRecord; const [ref] Src: TMyRecord);
begin
  Dest.Value := Src.Value;
  Writeln(Format('Copied @%s in @%s',
    [IntToHex(Integer(Pointer(@Src))), IntToHex(Integer(Pointer(@Dest)))]));
end;

end.
