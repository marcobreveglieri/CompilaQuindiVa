unit RecycleTim.Tests.Suites.Game;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TGameUnitTests = class
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure WhenGameIsCreatedAttempsEqualZero;
    [Test]
    procedure WhenGameIsCreatedCharsAreEmpty;
    [Test]
    procedure WhenGameIsCreatedSecretWordIsEmpty;
    [Test]
    procedure WhenGameIsCreatedThenIsPlayingIsNotSet;
    [Test]
    procedure WhenGameIsStartedSecretWordMatches;
    [Test]
    procedure WhenGameIsStartedAttemptsMatchOptions;
    [Test]
    procedure WhenGameIsStartedCharsAreEmpty;
    [Test]
    procedure WhenGameIsStartedGetNewWordIsCalled;
    [Test]
    procedure WhenGameIsStartedThenIsPlayingIsSet;
    [Test]
    procedure WhenGameIsPlayedRightCharDoesNotLoseAttempt;
    [Test]
    procedure WhenGameIsPlayedWrongCharLosesAttempt;
    [Test]
    procedure WhenGameIsPlayingTryingCharsMaskedWordIsRight;
    [Test]
    procedure WhenGameIsPlayingTryingWrongCharsMaskedWordIsRight;
    [Test]
    procedure WhenGameIsPlayedRightCharsFinishGame;
    [Test]
    procedure WhenGameIsPlayedRightCharsWinsGame;
    [Test]
    procedure WhenGameIsPlayedWrongCharsFinishGame;
    [Test]
    procedure WhenGameIsPlayedWrongCharsLosesGame;
    [Test]
    procedure WhenGameIsSurrendedThenGameFinishes;
    [Test]
    procedure WhenGameIsSurrendedThenGameIsLost;
  end;

implementation

uses
  System.SysUtils,
  RecycleTim.Core.Game,
  RecycleTim.Core.Types,
  RecycleTim.Core.Words,
  RecycleTim.Tests.Fakes.WordGeneratorMock,
  RecycleTim.Tests.Fakes.WordGeneratorStub;

procedure TGameUnitTests.Setup;
begin
end;

procedure TGameUnitTests.TearDown;
begin
end;

procedure TGameUnitTests.WhenGameIsCreatedAttempsEqualZero;
begin
  var LGame := TGame.Create;
  try
    Assert.AreEqual(0, LGame.Attempts);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsCreatedCharsAreEmpty;
begin
  var LGame := TGame.Create;
  try
    Assert.AreEqual(0, Length(LGame.Chars));
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsCreatedSecretWordIsEmpty;
begin
  var LGame := TGame.Create;
  try
    Assert.IsEmpty(LGame.SecretWord);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsCreatedThenIsPlayingIsNotSet;
begin
  var LGame := TGame.Create;
  try
    Assert.IsFalse(LGame.Status = TGameStatus.Playing);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsStartedGetNewWordIsCalled;
begin
  var LGame := TGame.Create;
  try
    var LMock := TWordGeneratorMock.Create;
    LGame.Start(LMock);
    Assert.IsTrue(LMock.Success);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsStartedAttemptsMatchOptions;
begin
  var LGame := TGame.Create;
  try
    LGame.Options.Attempts := 123;
    LGame.Start(CreateWordGeneratorStub('secretword'));
    Assert.AreEqual(123, LGame.Attempts);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsStartedCharsAreEmpty;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    Assert.AreEqual(0, Length(LGame.Chars));
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsStartedSecretWordMatches;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    Assert.AreEqual('SECRETWORD', LGame.SecretWord);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayedRightCharDoesNotLoseAttempt;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    var LInitialAttempts := LGame.Attempts;
    LGame.TryChar('R');
    LGame.TryChar('E');
    Assert.AreEqual(LInitialAttempts, LGame.Attempts);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayedRightCharsFinishGame;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('test'));
    LGame.TryChar('T');
    LGame.TryChar('E');
    LGame.TryChar('S');
    Assert.IsFalse(LGame.Status = TGameStatus.Playing);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayedRightCharsWinsGame;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('test'));
    LGame.TryChar('T');
    LGame.TryChar('E');
    LGame.TryChar('S');
    Assert.IsTrue(LGame.Status = TGameStatus.Won);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsStartedThenIsPlayingIsSet;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    Assert.IsTrue(LGame.Status = TGameStatus.Playing);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsSurrendedThenGameFinishes;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    LGame.Surrend;
    Assert.IsFalse(LGame.Status = TGameStatus.Playing);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsSurrendedThenGameIsLost;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    LGame.Surrend;
    Assert.IsTrue(LGame.Status = TGameStatus.Lost);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayedWrongCharLosesAttempt;
begin
  var LGame := TGame.Create;
  try
    LGame.Options.Attempts := 5;
    LGame.Start(CreateWordGeneratorStub('secretword'));
    var LInitialAttempts := LGame.Attempts;
    LGame.TryChar('A');
    LGame.TryChar('Z');
    Assert.AreEqual(LInitialAttempts - 2, LGame.Attempts);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayedWrongCharsFinishGame;
begin
  var LGame := TGame.Create;
  try
    LGame.Options.Attempts := 4;
    LGame.Start(CreateWordGeneratorStub('test'));
    LGame.TryChar('A');
    LGame.TryChar('B');
    LGame.TryChar('C');
    LGame.TryChar('D');
    Assert.IsFalse(LGame.Status = TGameStatus.Playing);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayedWrongCharsLosesGame;
begin
  var LGame := TGame.Create;
  try
    LGame.Options.Attempts := 4;
    LGame.Start(CreateWordGeneratorStub('test'));
    LGame.TryChar('A');
    LGame.TryChar('B');
    LGame.TryChar('C');
    LGame.TryChar('D');
    Assert.IsTrue(LGame.Status = TGameStatus.Lost);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayingTryingCharsMaskedWordIsRight;
begin
  var LGame := TGame.Create;
  try
    LGame.Start(CreateWordGeneratorStub('secretword'));
    LGame.TryChar('R');
    LGame.TryChar('E');
    Assert.AreEqual('_E_RE___R_', LGame.MaskedWord);
  finally
    LGame.Free;
  end;
end;

procedure TGameUnitTests.WhenGameIsPlayingTryingWrongCharsMaskedWordIsRight;
begin
  var LGame := TGame.Create;
  try
    LGame.Options.Attempts := 10;
    LGame.Start(CreateWordGeneratorStub('secretword'));
    LGame.TryChar('A');
    LGame.TryChar('B');
    Assert.AreEqual('__________', LGame.MaskedWord);
  finally
    LGame.Free;
  end;
end;

initialization

  TDUnitX.RegisterTestFixture(TGameUnitTests);

end.
