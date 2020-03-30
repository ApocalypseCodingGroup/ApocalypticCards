library mod_cardgame;

uses
  {$IFDEF MSWINDOWS}
  Winapi.ActiveX,
  {$ENDIF }
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  WebMainModel in 'modules\WebMainModel.pas' {WebModule4: TWebModule};

{$R *.res}

// httpd.conf-Eintr�ge:
//
(*
 LoadModule cardgame_module modules/mod_cardgame.dll

 <Location /xyz>
    SetHandler mod_cardgame-handler
 </Location>
*)
//
// Diese Eintr�ge setzen voraus, dass das Ausgabeverzeichnis f�r dieses Projekt das apache/modules-Verzeichnis ist.
//
// httpd.conf-Eintr�ge sollten unterschiedlich sein, wenn das Projekt auf eine der folgenden Weisen ge�ndert wird:
//   1. Der Name der Variable TApacheModuleData wird ge�ndert.
//   2. Das Projekt wird umbenannt.
//   3. Das Ausgabeverzeichnis ist nicht das Verzeichnis apache/modules.
//   4. Die Erweiterung der dynamischen Bibliothek ist von der Plattform abh�ngig. Verwenden Sie f�r Windows .dll und f�r Linux .so.
//

// Exportierte Variable deklarieren, damit Apache auf dieses Modul zugreifen kann.
var
  GModuleData: TApacheModuleData;
exports
  GModuleData name 'cardgame_module';

begin
{$IFDEF MSWINDOWS}
  CoInitFlags := COINIT_MULTITHREADED;
{$ENDIF}
  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.Run;
end.
