program wsreportserver;

{$mode objfpc}{$H+}


uses
    Classes, fphttpserver, fphttpapp, Process;

Type
    TTestHTTPServer = Class(TFPHTTPServer)
    public
        procedure HandleRequest(
            Var ARequest: TFPHTTPConnectionRequest;
            Var AResponse : TFPHTTPConnectionResponse); override;
    end;

Var
    Serv : TTestHTTPServer;


procedure TTestHTTPServer.HandleRequest(
   var ARequest: TFPHTTPConnectionRequest;
   var AResponse: TFPHTTPConnectionResponse);
   var
      F : TStringStream;
      cOutInfo: String;
      cCommand: String;
      cPdf: String;
      cParams: String;
      cReport: String;
begin
    writeln('Processando um requisito...');
    cCommand:= 'c:\xampp\htdocs\app\reports\wsreport\wsreport.exe';
    cReport:= 'C:\xampp\htdocs\app\reports\wsreport\reports\rel_mapa_dieta_por_atendimento_validade';
    cPdf:= 'c:\temp\rel1.pdf';
    cParams:= 'atendimento=4784279';
    // Run wsReport with parameters
    RunCommand(cCommand,['-r',cReport,cPdf,cParams], cOutInfo);
    writeln('Resposta realizada...');
    F:=TStringStream.Create('Hello,World!' + cOutInfo);
    try
        AResponse.ContentLength:=F.Size;
        AResponse.ContentStream:=F;
        AResponse.SendContent;
        AResponse.ContentStream:=Nil;
    finally
        F.Free;
    end;
end;

begin
    Serv:=TTestHTTPServer.Create(Nil);
    try
        Serv.Threaded:=True;
        Serv.Port:=88;
        Serv.AcceptIdleTimeout:=1000 * 240;
        Serv.Active:=True;
    finally
        Serv.Free;
    end;
end.
