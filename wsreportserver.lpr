program wsreportserver;

{$mode objfpc}{$H+}


uses
    Classes, fphttpserver, fphttpapp, Process, math, sysutils;

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
      cPathReport: String;
      cReportPdfUrl: String;
      cHostReport: String;
      cPdfRandomName: String;
      nRand: Integer;
begin
    cPathReport:= 'C:\xampp\htdocs\app\reports\wsreport\reports\';
    writeln('Processando um requisito...');
    writeln('Information: ' + ARequest.QueryString);
    if pos('r=', '.' + ARequest.QueryString )>0 then
    begin
      cReport:= cPathReport + copy( ARequest.QueryString, pos('=', ARequest.QueryString )+1 );
      cReport:= copy( cReport, 0, pos( '/', cReport )-1 );
      cParams:= copy( ARequest.QueryString, pos('/', ARequest.QueryString)+1 );
    end
    else
    begin
      cReport:= 'rel_mapa_dieta_por_atendimento_validade';
      cParams:= 'atendimento=4784279';
    end;
    cCommand:= 'c:\xampp\htdocs\app\reports\wsreport\wsreport.exe';
    nRand:=  RandomRange(100000,199999);
    cPdfRandomName:= 'aRelV02022' + intToStr(nRand)  + '.pdf';
    cPdf:= 'c:\xampp\htdocs\app\reports\download\' + cPdfRandomName;
    cHostReport:= 'srvm24:89';
    cReportPdfUrl:= 'http://' + cHostReport + '/app/reports/download/' + cPdfRandomName;

    // Run wsReport with parameters
    RunCommand(cCommand,['-r',cReport,cPdf,cParams], cOutInfo);
    writeln('Resposta realizada...');
    F:=TStringStream.Create('<a href="' + cReportPdfUrl + '">Relatorio gerado</a>' + '<p>' + cOutInfo + '</p>');
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
