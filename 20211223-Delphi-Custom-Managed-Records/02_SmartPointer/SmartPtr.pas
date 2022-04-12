unit SmartPtr;

interface

type

  TRefCountable = class abstract
  protected
    FRefCount: Integer;
  end;

  TSmartPtr<T: TRefCountable> = record
  private
    FRef: T;
    procedure Retain; inline;
    procedure Release; inline;
  public
    constructor Create(const ARef: T);
    class operator Initialize(out ADest: TSmartPtr<T>);
    class operator Finalize(var ADest: TSmartPtr<T>);
    class operator Assign(var ADest: TSmartPtr<T>;
      const [ref] ASrc: TSmartPtr<T>);
    property Ref: T read FRef;
  end;

implementation

constructor TSmartPtr<T>.Create(const ARef: T);
begin
  // We perform a sanity check to make sure that the same object cannot be
  // passed to the constructor of multiple smart pointers
  // (that is, its reference count should be 0).
  Assert((ARef = nil) or (ARef.FRefCount = 0));

  // The constructor sets the reference to the object
  // (derived from TRefCountable) and retains it.
  FRef := ARef;
  Retain;
end;

class operator TSmartPtr<T>.Initialize(out ADest: TSmartPtr<T>);
begin
  // The Initialize operator just sets the reference to nil.
  // This is a very common pattern for CMRs.
  ADest.FRef := nil;
end;

class operator TSmartPtr<T>.Finalize(var ADest: TSmartPtr<T>);
begin
  // The Finalize operator just releases the reference,
  // which may result in freeing the object.
  ADest.Release;
end;

procedure TSmartPtr<T>.Retain;
begin
  // Increments the reference count (if the object isn't nil).
  // It does this in an atomic way so that smart pointers can be
  // shared across multiple threads.
  if (FRef <> nil) then
    AtomicIncrement(FRef.FRefCount);
end;

procedure TSmartPtr<T>.Release;
begin
  // Decrements the reference count. When it reaches 0, it will destroy
  // the referenced object; in any case, it sets the reference to nil
  // since it shouldn't be used anymore.
  if (FRef <> nil) then
  begin
    if (AtomicDecrement(FRef.FRefCount) = 0) then
      FRef.Free;
    FRef := nil;
  end;
end;

class operator TSmartPtr<T>.Assign(var ADest: TSmartPtr<T>;
  const [ref] ASrc: TSmartPtr<T>);
begin
  // First it checks if the two smart pointers already reference
  // the same object: if so, there is nothing to be done.
  // If not, it first releases the target smart pointer since
  // it is going to be assigned a new one. This may result in the
  // destruction of the object if no other smart pointers have a
  // reference to it. Then, it copies the reference and retains it.
  // This is a common pattern, that is also used by the RTL when
  // assigning object interfaces.
  if (ADest.FRef <> ASrc.FRef) then
  begin
    ADest.Release;
    ADest.FRef := ASrc.FRef;
    ADest.Retain;
  end;
end;

end.
