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

// httpd.conf-Einträge:
//
(*
 LoadModule cardgame_module modules/mod_cardgame.dll

 <Location /xyz>
    SetHandler mod_cardgame-handler
 </Location>
*)
//
// Diese Einträge setzen voraus, dass das Ausgabeverzeichnis für dieses Projekt das apache/modules-Verzeichnis ist.
//
// httpd.conf-Einträge sollten unterschiedlich sein, wenn das Projekt auf eine der folgenden Weisen geändert wird:
//   1. Der Name der Variable TApacheModuleData wird geändert.
//   2. Das Projekt wird umbenannt.
//   3. Das Ausgabeverzeichnis ist nicht das Verzeichnis apache/modules.
//   4. Die Erweiterung der dynamischen Bibliothek ist von der Plattform abhängig. Verwenden Sie für Windows .dll und für Linux .so.
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
