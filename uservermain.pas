unit uservermain;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure onlineRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
  private

  public

  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.onlineRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; var Handled: Boolean);
begin
  Writeln('Requerimento: ' + ARequest.content);
  AResponse.Content:= 'online';
  Handled:= true;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

