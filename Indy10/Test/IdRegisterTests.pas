unit IdRegisterTests;

interface

uses
  //core
  IdTestBuffer,
  IdTestCmdTCPClient,
  IdTestIOHandler,
  IdTestSchedulerOfThreadPool,
  IdTestSocketHandle,
  IdTestThreadComponent,

  //protocols
  IdTestCoder3to4,
  IdTestCoderHeader,
  IdTestCoderMIME,
  IdTestCoderQuotedPrintable,
  IdTestCookie,
  IdTestFtpServer,
  IdTestHttp,
  IdTestMessage,
  IdTestMessageCoderMime,
  IdTestSMTPServer,
  {$IFNDEF DOTNETDISTRO}
  //currently fails bad
  IdTestVCard,
  {$ENDIF}

  //system
  IdTestStreamHelper,
  IdTestObjs,
  IdTestSys;

implementation

end.
