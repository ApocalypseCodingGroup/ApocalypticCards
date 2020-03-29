//------------------------------------------------------------------------------
// MIT License
//
//  Copyright (c) 2018 Craig Chapman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//------------------------------------------------------------------------------
unit deREST.passthrough;

interface
uses
  Web.HTTPApp,
  System.SysUtils,
  System.Classes;

type
  TRESTPassthrough = class(TComponent)
  private
    fDefaultFiles: TStrings;
    fRootDirectory: string;
    function GetMimeType(Ext: string): string;
    function DefaultFileIfExists: string;
    function RemoveDoubleSeparators(SourceStr: string): string;
  protected
    { Protected declarations }
  public
    procedure Execute( Dispatcher: IWebDispatcherAccess );
    constructor Create( aOwner: TComponent ); override;
  published
    property DefaultFiles: TStrings read fDefaultFiles;
    property RootDirectory: string read fRootDirectory write fRootDirectory;
  end;

procedure Register;

implementation
uses
  deREST.types;

const
  {$ifdef MSWINDOWS}
  cPathSeparator = '\';
  {$else}
  cPathSeparator = '/';
  {$endif}

procedure Register;
begin
  RegisterComponents('deREST', [TRESTPassthrough]);
end;

{ TRESTPassthrough }

function TRESTPassthrough.GetMimeType(Ext: string): string;
var
  ltExt: string;
begin
  ltExt := Lowercase(Trim(Ext));
  ltExt := StringReplace(ltExt,'.','',[rfReplaceAll, rfIgnoreCase]);
  if ltExt='3dm' then Result := 'x-world/x-3dmf' else
  if ltExt='3dmf' then Result := 'x-world/x-3dmf' else
  if ltExt='a' then Result := 'application/octet-stream' else
  if ltExt='aab' then Result := 'application/x-authorware-bin' else
  if ltExt='aam' then Result := 'application/x-authorware-map' else
  if ltExt='aas' then Result := 'application/x-authorware-seg' else
  if ltExt='abc' then Result := 'text/vnd.abc' else
  if ltExt='acgi' then Result := 'text/html' else
  if ltExt='afl' then Result := 'video/animaflex' else
  if ltExt='ai' then Result := 'application/postscript' else
  if ltExt='aif' then Result := 'audio/aiff' else
  if ltExt='aifc' then Result := 'audio/aiff' else
  if ltExt='aiff' then Result := 'audio/aiff' else
  if ltExt='aim' then Result := 'application/x-aim' else
  if ltExt='aip' then Result := 'text/x-audiosoft-intra' else
  if ltExt='ani' then Result := 'application/x-navi-animation' else
  if ltExt='aos' then Result := 'application/x-nokia-9000-communicator-add-on-software' else
  if ltExt='aps' then Result := 'application/mime' else
  if ltExt='arc' then Result := 'application/octet-stream' else
  if ltExt='arj' then Result := 'application/arj' else
  if ltExt='art' then Result := 'image/x-jg' else
  if ltExt='asf' then Result := 'video/x-ms-asf' else
  if ltExt='asm' then Result := 'text/x-asm' else
  if ltExt='asp' then Result := 'text/asp' else
  if ltExt='asx' then Result := 'application/x-mplayer2' else
  if ltExt='au' then Result := 'audio/basic' else
  if ltExt='avi' then Result := 'video/avi' else
  if ltExt='bcpio' then Result := 'application/x-bcpio' else
  if ltExt='bin' then Result := 'application/octet-stream' else
  if ltExt='bm' then Result := 'image/bmp' else
  if ltExt='bmp' then Result := 'image/x-windows-bmp' else
  if ltExt='boo' then Result := 'application/book' else
  if ltExt='book' then Result := 'application/book' else
  if ltExt='boz' then Result := 'application/x-bzip2' else
  if ltExt='bsh' then Result := 'application/x-bsh' else
  if ltExt='bz' then Result := 'application/x-bzip' else
  if ltExt='bz2' then Result := 'application/x-bzip2' else
  if ltExt='c' then Result := 'text/x-c' else
  if ltExt='c++' then Result := 'text/x-c' else
  if ltExt='cat' then Result := 'application/vnd.ms-pki.seccat' else
  if ltExt='cc' then Result := 'text/x-c' else
  if ltExt='ccad' then Result := 'application/clariscad' else
  if ltExt='cco' then Result := 'application/x-cocoa' else
  if ltExt='cdf' then Result := 'application/cdf' else
  if ltExt='cer' then Result := 'application/pkix-cert' else
  if ltExt='cha' then Result := 'application/x-chat' else
  if ltExt='chat' then Result := 'application/x-chat' else
  if ltExt='class' then Result := 'application/java' else
  if ltExt='com' then Result := 'application/octet-stream' else
  if ltExt='conf' then Result := 'text/plain' else
  if ltExt='cpio' then Result := 'application/x-cpio' else
  if ltExt='cpp' then Result := 'text/x-c' else
  if ltExt='cpt' then Result := 'application/x-cpt' else
  if ltExt='crl' then Result := 'application/pkcs-crl' else
  if ltExt='crt' then Result := 'application/pkix-cert' else
  if ltExt='csh' then Result := 'application/x-csh' else
  if ltExt='css' then Result := 'text/css' else
  if ltExt='cxx' then Result := 'text/plain' else
  if ltExt='dcr' then Result := 'application/x-director' else
  if ltExt='deepv' then Result := 'application/x-deepv' else
  if ltExt='def' then Result := 'text/plain' else
  if ltExt='der' then Result := 'application/x-x509-ca-cert' else
  if ltExt='dif' then Result := 'video/x-dv' else
  if ltExt='dir' then Result := 'application/x-director' else
  if ltExt='dl' then Result := 'video/dl' else
  if ltExt='doc' then Result := 'application/msword' else
  if ltExt='dot' then Result := 'application/msword' else
  if ltExt='dp' then Result := 'application/commonground' else
  if ltExt='drw' then Result := 'application/drafting' else
  if ltExt='dump' then Result := 'application/octet-stream' else
  if ltExt='dv' then Result := 'video/x-dv' else
  if ltExt='dvi' then Result := 'application/x-dvi' else
  if ltExt='dwf' then Result := 'model/vnd.dwf' else
  if ltExt='dwg' then Result := 'image/vnd.dwg' else
  if ltExt='dxf' then Result := 'application/dxf' else
  if ltExt='dxr' then Result := 'application/x-director' else
  if ltExt='el' then Result := 'text/x-script.elisp' else
  if ltExt='elc' then Result := 'application/x-elc' else
  if ltExt='env' then Result := 'application/x-envoy' else
  if ltExt='eps' then Result := 'application/postscript' else
  if ltExt='es' then Result := 'application/x-esrehber' else
  if ltExt='etx' then Result := 'text/x-setext' else
  if ltExt='evy' then Result := 'application/envoy' else
  if ltExt='exe' then Result := 'application/octet-stream' else
  if ltExt='f' then Result := 'text/x-fortran' else
  if ltExt='f77' then Result := 'text/x-fortran' else
  if ltExt='f90' then Result := 'text/x-fortran' else
  if ltExt='fdf' then Result := 'application/vnd.fdf' else
  if ltExt='fif' then Result := 'image/fif' else
  if ltExt='fli' then Result := 'video/fli' else
  if ltExt='flo' then Result := 'image/florian' else
  if ltExt='flx' then Result := 'text/vnd.fmi.flexstor' else
  if ltExt='fmf' then Result := 'video/x-atomic3d-feature' else
  if ltExt='for' then Result := 'text/x-fortran' else
  if ltExt='fpx' then Result := 'image/vnd.fpx' else
  if ltExt='frl' then Result := 'application/freeloader' else
  if ltExt='funk' then Result := 'audio/make' else
  if ltExt='g' then Result := 'text/plain' else
  if ltExt='g3' then Result := 'image/g3fax' else
  if ltExt='gif' then Result := 'image/gif' else
  if ltExt='gl' then Result := 'video/gl' else
  if ltExt='gsd' then Result := 'audio/x-gsm' else
  if ltExt='gsm' then Result := 'audio/x-gsm' else
  if ltExt='gsp' then Result := 'application/x-gsp' else
  if ltExt='gss' then Result := 'application/x-gss' else
  if ltExt='gtar' then Result := 'application/x-gtar' else
  if ltExt='gz' then Result := 'application/x-gzip' else
  if ltExt='gzip' then Result := 'application/x-gzip' else
  if ltExt='h' then Result := 'text/x-h' else
  if ltExt='hdf' then Result := 'application/x-hdf' else
  if ltExt='help' then Result := 'application/x-helpfile' else
  if ltExt='hgl' then Result := 'application/vnd.hp-hpgl' else
  if ltExt='hh' then Result := 'text/x-h' else
  if ltExt='hlb' then Result := 'text/x-script' else
  if ltExt='hlp' then Result := 'application/hlp' else
  if ltExt='hpg' then Result := 'application/vnd.hp-hpgl' else
  if ltExt='hpgl' then Result := 'application/vnd.hp-hpgl' else
  if ltExt='hqx' then Result := 'application/binhex' else
  if ltExt='hta' then Result := 'application/hta' else
  if ltExt='htc' then Result := 'text/x-component' else
  if ltExt='htm' then Result := 'text/html' else
  if ltExt='html' then Result := 'text/html' else
  if ltExt='htmls' then Result := 'text/html' else
  if ltExt='htt' then Result := 'text/webviewhtml' else
  if ltExt='htx' then Result := 'text/html' else
  if ltExt='ice' then Result := 'x-conference/x-cooltalk' else
  if ltExt='ico' then Result := 'image/x-icon' else
  if ltExt='idc' then Result := 'text/plain' else
  if ltExt='ief' then Result := 'image/ief' else
  if ltExt='iefs' then Result := 'image/ief' else
  if ltExt='iges' then Result := 'application/iges' else
  if ltExt='ima' then Result := 'application/x-ima' else
  if ltExt='imap' then Result := 'application/x-httpd-imap' else
  if ltExt='inf' then Result := 'application/inf' else
  if ltExt='ins' then Result := 'application/x-internett-signup' else
  if ltExt='ip' then Result := 'application/x-ip2' else
  if ltExt='isu' then Result := 'video/x-isvideo' else
  if ltExt='it' then Result := 'audio/it' else
  if ltExt='iv' then Result := 'application/x-inventor' else
  if ltExt='ivr' then Result := 'i-world/i-vrml' else
  if ltExt='ivy' then Result := 'application/x-livescreen' else
  if ltExt='jam' then Result := 'audio/x-jam' else
  if ltExt='jav' then Result := 'text/x-java-source' else
  if ltExt='java' then Result := 'text/x-java-source' else
  if ltExt='jcm' then Result := 'application/x-java-commerce' else
  if ltExt='jfif' then Result := 'image/jpeg' else
  if ltExt='jfif-' then Result := 'tbnl	image/jpeg' else
  if ltExt='jpe' then Result := 'image/jpeg' else
  if ltExt='jpeg' then Result := 'image/jpeg' else
  if ltExt='jpg' then Result := 'image/jpeg' else
  if ltExt='jps' then Result := 'image/x-jps' else
  if ltExt='js' then Result := 'application/javascript' else
  if ltExt='jut' then Result := 'image/jutvision' else
  if ltExt='kar' then Result := 'audio/midi' else
  if ltExt='ksh' then Result := 'application/x-ksh' else
  if ltExt='la' then Result := 'audio/nspaudio' else
  if ltExt='lam' then Result := 'audio/x-liveaudio' else
  if ltExt='latex' then Result := 'application/x-latex' else
  if ltExt='lha' then Result := 'application/lha' else
  if ltExt='lhx' then Result := 'application/octet-stream' else
  if ltExt='list' then Result := 'text/plain' else
  if ltExt='lma' then Result := 'audio/nspaudio' else
  if ltExt='log' then Result := 'text/plain' else
  if ltExt='lsp' then Result := 'application/x-lisp' else
  if ltExt='lst' then Result := 'text/plain' else
  if ltExt='lsx' then Result := 'text/x-la-asf' else
  if ltExt='ltx' then Result := 'application/x-latex' else
  if ltExt='lzh' then Result := 'application/octet-stream' else
  if ltExt='lzx' then Result := 'application/lzx' else
  if ltExt='m' then Result := 'text/plain' else
  if ltExt='m1v' then Result := 'video/mpeg' else
  if ltExt='m2a' then Result := 'audio/mpeg' else
  if ltExt='m2v' then Result := 'video/mpeg' else
  if ltExt='m3u' then Result := 'audio/x-mpequrl' else
  if ltExt='man' then Result := 'application/x-troff-man' else
  if ltExt='map' then Result := 'application/x-navimap' else
  if ltExt='mar' then Result := 'text/plain' else
  if ltExt='mbd' then Result := 'application/mbedlet' else
  if ltExt='mc$' then Result := 'application/x-magic-cap-package-1.0' else
  if ltExt='mcd' then Result := 'application/mcad' else
  if ltExt='mcf' then Result := 'image/vasa' else
  if ltExt='mcf' then Result := 'text/mcf' else
  if ltExt='mcp' then Result := 'application/netmc' else
  if ltExt='me' then Result := 'application/x-troff-me' else
  if ltExt='mht' then Result := 'message/rfc822' else
  if ltExt='mhtml' then Result := 'message/rfc822' else
  if ltExt='mid' then Result := 'audio/midi' else
  if ltExt='midi' then Result := 'application/x-midi' else
  if ltExt='midi' then Result := 'audio/midi' else
  if ltExt='mif' then Result := 'application/x-mif' else
  if ltExt='mime' then Result := 'www/mime' else
  if ltExt='mjf' then Result := 'audio/x-vnd.audioexplosion.mjuicemediafile' else
  if ltExt='mjpg' then Result := 'video/x-motion-jpeg' else
  if ltExt='mm' then Result := 'application/base64' else
  if ltExt='mme' then Result := 'application/base64' else
  if ltExt='mod' then Result := 'audio/mod' else
  if ltExt='moov' then Result := 'video/quicktime' else
  if ltExt='mov' then Result := 'video/quicktime' else
  if ltExt='movie' then Result := 'video/x-sgi-movie' else
  if ltExt='mp2' then Result := 'video/mpeg' else
  if ltExt='mp3' then Result := 'audio/mpeg3' else
  if ltExt='mpa' then Result := 'audio/mpeg' else
  if ltExt='mpa' then Result := 'video/mpeg' else
  if ltExt='mpc' then Result := 'application/x-project' else
  if ltExt='mpe' then Result := 'video/mpeg' else
  if ltExt='mpeg' then Result := 'video/mpeg' else
  if ltExt='mpg' then Result := 'video/mpeg' else
  if ltExt='mpga' then Result := 'audio/mpeg' else
  if ltExt='mpp' then Result := 'application/vnd.ms-project' else
  if ltExt='mpt' then Result := 'application/x-project' else
  if ltExt='mpv' then Result := 'application/x-project' else
  if ltExt='mpx' then Result := 'application/x-project' else
  if ltExt='mrc' then Result := 'application/marc' else
  if ltExt='ms' then Result := 'application/x-troff-ms' else
  if ltExt='mv' then Result := 'video/x-sgi-movie' else
  if ltExt='my' then Result := 'audio/make' else
  if ltExt='mzz' then Result := 'application/x-vnd.audioexplosion.mzz' else
  if ltExt='nap' then Result := 'image/naplps' else
  if ltExt='naplps' then Result := 'image/naplps' else
  if ltExt='nc' then Result := 'application/x-netcdf' else
  if ltExt='ncm' then Result := 'application/vnd.nokia.configuration-message' else
  if ltExt='nif' then Result := 'image/x-niff' else
  if ltExt='niff' then Result := 'image/x-niff' else
  if ltExt='nix' then Result := 'application/x-mix-transfer' else
  if ltExt='nsc' then Result := 'application/x-conference' else
  if ltExt='nvd' then Result := 'application/x-navidoc' else
  if ltExt='o' then Result := 'application/octet-stream' else
  if ltExt='oda' then Result := 'application/oda' else
  if ltExt='omc' then Result := 'application/x-omc' else
  if ltExt='omcd' then Result := 'application/x-omcdatamaker' else
  if ltExt='omcr' then Result := 'application/x-omcregerator' else
  if ltExt='p' then Result := 'text/x-pascal' else
  if ltExt='p10' then Result := 'application/pkcs10' else
  if ltExt='p12' then Result := 'application/pkcs-12' else
  if ltExt='p7a' then Result := 'application/x-pkcs7-signature' else
  if ltExt='p7c' then Result := 'application/pkcs7-mime' else
  if ltExt='p7m' then Result := 'application/pkcs7-mime' else
  if ltExt='p7r' then Result := 'application/x-pkcs7-certreqresp' else
  if ltExt='p7s' then Result := 'application/pkcs7-signature' else
  if ltExt='part' then Result := 'application/pro_eng' else
  if ltExt='pas' then Result := 'text/pascal' else
  if ltExt='pbm' then Result := 'image/x-portable-bitmap' else
  if ltExt='pcl' then Result := 'application/vnd.hp-pcl' else
  if ltExt='pct' then Result := 'image/x-pict' else
  if ltExt='pcx' then Result := 'image/x-pcx' else
  if ltExt='pdb' then Result := 'chemical/x-pdb' else
  if ltExt='pdf' then Result := 'application/pdf' else
  if ltExt='pfunk' then Result := 'audio/make' else
  if ltExt='pgm' then Result := 'image/x-portable-graymap' else
  if ltExt='pic' then Result := 'image/pict' else
  if ltExt='pict' then Result := 'image/pict' else
  if ltExt='pkg' then Result := 'application/x-newton-compatible-pkg' else
  if ltExt='pko' then Result := 'application/vnd.ms-pki.pko' else
  if ltExt='pl' then Result := 'text/x-script.perl' else
  if ltExt='plx' then Result := 'application/x-pixclscript' else
  if ltExt='pm' then Result := 'text/x-script.perl-module' else
  if ltExt='pm4' then Result := 'application/x-pagemaker' else
  if ltExt='pm5' then Result := 'application/x-pagemaker' else
  if ltExt='png' then Result := 'image/png' else
  if ltExt='pnm' then Result := 'application/x-portable-anymap' else
  if ltExt='pot' then Result := 'application/mspowerpoint' else
  if ltExt='pov' then Result := 'model/x-pov' else
  if ltExt='ppa' then Result := 'application/vnd.ms-powerpoint' else
  if ltExt='ppm' then Result := 'image/x-portable-pixmap' else
  if ltExt='pps' then Result := 'application/mspowerpoint' else
  if ltExt='ppt' then Result := 'application/mspowerpoint' else
  if ltExt='ppz' then Result := 'application/mspowerpoint' else
  if ltExt='pre' then Result := 'application/x-freelance' else
  if ltExt='prt' then Result := 'application/pro_eng' else
  if ltExt='ps' then Result := 'application/postscript' else
  if ltExt='psd' then Result := 'application/octet-stream' else
  if ltExt='pvu' then Result := 'paleovu/x-pv' else
  if ltExt='pwz' then Result := 'application/vnd.ms-powerpoint' else
  if ltExt='py' then Result := 'text/x-script.phyton' else
  if ltExt='pyc' then Result := 'application/x-bytecode.python' else
  if ltExt='qcp' then Result := 'audio/vnd.qcelp' else
  if ltExt='qd3' then Result := 'x-world/x-3dmf' else
  if ltExt='qd3d' then Result := 'x-world/x-3dmf' else
  if ltExt='qif' then Result := 'image/x-quicktime' else
  if ltExt='qt' then Result := 'video/quicktime' else
  if ltExt='qtc' then Result := 'video/x-qtc' else
  if ltExt='qti' then Result := 'image/x-quicktime' else
  if ltExt='qtif' then Result := 'image/x-quicktime' else
  if ltExt='ra' then Result := 'audio/x-realaudio' else
  if ltExt='ram' then Result := 'audio/x-pn-realaudio' else
  if ltExt='ras' then Result := 'image/cmu-raster' else
  if ltExt='rast' then Result := 'image/cmu-raster' else
  if ltExt='rexx' then Result := 'text/x-script.rexx' else
  if ltExt='rf' then Result := 'image/vnd.rn-realflash' else
  if ltExt='rgb' then Result := 'image/x-rgb' else
  if ltExt='rm' then Result := 'application/vnd.rn-realmedia' else
  if ltExt='rmi' then Result := 'audio/mid' else
  if ltExt='rmm' then Result := 'audio/x-pn-realaudio' else
  if ltExt='rmp' then Result := 'audio/x-pn-realaudio' else
  if ltExt='rng' then Result := 'application/ringing-tones' else
  if ltExt='rnx' then Result := 'application/vnd.rn-realplayer' else
  if ltExt='roff' then Result := 'application/x-troff' else
  if ltExt='rp' then Result := 'image/vnd.rn-realpix' else
  if ltExt='rpm' then Result := 'audio/x-pn-realaudio-plugin' else
  if ltExt='rt' then Result := 'text/richtext' else
  if ltExt='rtf' then Result := 'text/richtext' else
  if ltExt='rtx' then Result := 'text/richtext' else
  if ltExt='rv' then Result := 'video/vnd.rn-realvideo' else
  if ltExt='s' then Result := 'text/x-asm' else
  if ltExt='s3m' then Result := 'audio/s3m' else
  if ltExt='saveme' then Result := 'application/octet-stream' else
  if ltExt='sbk' then Result := 'application/x-tbook' else
  if ltExt='scm' then Result := 'video/x-scm' else
  if ltExt='sdml' then Result := 'text/plain' else
  if ltExt='sdp' then Result := 'application/sdp' else
  if ltExt='sdr' then Result := 'application/sounder' else
  if ltExt='sea' then Result := 'application/sea' else
  if ltExt='set' then Result := 'application/set' else
  if ltExt='sgm' then Result := 'text/sgml' else
  if ltExt='sgml' then Result := 'text/sgml' else
  if ltExt='sh' then Result := 'text/x-script.sh' else
  if ltExt='shar' then Result := 'application/x-bsh' else
  if ltExt='shtml' then Result := 'text/html' else
  if ltExt='sid' then Result := 'audio/x-psid' else
  if ltExt='sit' then Result := 'application/x-sit' else
  if ltExt='skd' then Result := 'application/x-koan' else
  if ltExt='skm' then Result := 'application/x-koan' else
  if ltExt='skp' then Result := 'application/x-koan' else
  if ltExt='skt' then Result := 'application/x-koan' else
  if ltExt='sl' then Result := 'application/x-seelogo' else
  if ltExt='smi' then Result := 'application/smil' else
  if ltExt='smil' then Result := 'application/smil' else
  if ltExt='snd' then Result := 'audio/basic' else
  if ltExt='sol' then Result := 'application/solids' else
  if ltExt='spc' then Result := 'text/x-speech' else
  if ltExt='spl' then Result := 'application/futuresplash' else
  if ltExt='spr' then Result := 'application/x-sprite' else
  if ltExt='sprite' then Result := 'application/x-sprite' else
  if ltExt='src' then Result := 'application/x-wais-source' else
  if ltExt='ssi' then Result := 'text/x-server-parsed-html' else
  if ltExt='ssm' then Result := 'application/streamingmedia' else
  if ltExt='sst' then Result := 'application/vnd.ms-pki.certstore' else
  if ltExt='step' then Result := 'application/step' else
  if ltExt='stl' then Result := 'application/sla' else
  if ltExt='stp' then Result := 'application/step' else
  if ltExt='sv4cpio' then Result := 'application/x-sv4cpio' else
  if ltExt='sv4crc' then Result := 'application/x-sv4crc' else
  if ltExt='svf' then Result := 'image/vnd.dwg' else
  if ltExt='svr' then Result := 'application/x-world' else
  if ltExt='swf' then Result := 'application/x-shockwave-flash' else
  if ltExt='t' then Result := 'application/x-troff' else
  if ltExt='talk' then Result := 'text/x-speech' else
  if ltExt='tar' then Result := 'application/x-tar' else
  if ltExt='tbk' then Result := 'application/toolbook' else
  if ltExt='tcl' then Result := 'application/x-tcl' else
  if ltExt='tcsh' then Result := 'text/x-script.tcsh' else
  if ltExt='tex' then Result := 'application/x-tex' else
  if ltExt='texi' then Result := 'application/x-texinfo' else
  if ltExt='texinfo' then Result := 'application/x-texinfo' else
  if ltExt='text' then Result := 'text/plain' else
  if ltExt='tgz' then Result := 'application/x-compressed' else
  if ltExt='tif' then Result := 'image/tiff' else
  if ltExt='tiff' then Result := 'image/tiff' else
  if ltExt='tr' then Result := 'application/x-troff' else
  if ltExt='tsi' then Result := 'audio/tsp-audio' else
  if ltExt='tsp' then Result := 'audio/tsplayer' else
  if ltExt='tsv' then Result := 'text/tab-separated-values' else
  if ltExt='turbot' then Result := 'image/florian' else
  if ltExt='txt' then Result := 'text/plain' else
  if ltExt='uil' then Result := 'text/x-uil' else
  if ltExt='uni' then Result := 'text/uri-list' else
  if ltExt='unis' then Result := 'text/uri-list' else
  if ltExt='unv' then Result := 'application/i-deas' else
  if ltExt='uri' then Result := 'text/uri-list' else
  if ltExt='uris' then Result := 'text/uri-list' else
  if ltExt='ustar' then Result := 'application/x-ustar' else
  if ltExt='uu' then Result := 'application/octet-stream' else
  if ltExt='uue' then Result := 'text/x-uuencode' else
  if ltExt='vcd' then Result := 'application/x-cdlink' else
  if ltExt='vcs' then Result := 'text/x-vcalendar' else
  if ltExt='vda' then Result := 'application/vda' else
  if ltExt='vdo' then Result := 'video/vdo' else
  if ltExt='vew' then Result := 'application/groupwise' else
  if ltExt='viv' then Result := 'video/vivo' else
  if ltExt='vivo' then Result := 'video/vivo' else
  if ltExt='vmd' then Result := 'application/vocaltec-media-desc' else
  if ltExt='vmf' then Result := 'application/vocaltec-media-file' else
  if ltExt='voc' then Result := 'audio/voc' else
  if ltExt='vos' then Result := 'video/vosaic' else
  if ltExt='vox' then Result := 'audio/voxware' else
  if ltExt='vqe' then Result := 'audio/x-twinvq-plugin' else
  if ltExt='vqf' then Result := 'audio/x-twinvq' else
  if ltExt='vql' then Result := 'audio/x-twinvq-plugin' else
  if ltExt='vrml' then Result := 'model/vrml' else
  if ltExt='vrt' then Result := 'x-world/x-vrt' else
  if ltExt='vsd' then Result := 'application/x-visio' else
  if ltExt='vst' then Result := 'application/x-visio' else
  if ltExt='vsw' then Result := 'application/x-visio' else
  if ltExt='w60' then Result := 'application/wordperfect6.0' else
  if ltExt='w61' then Result := 'application/wordperfect6.1' else
  if ltExt='w6w' then Result := 'application/msword' else
  if ltExt='wav' then Result := 'audio/wav' else
  if ltExt='wb1' then Result := 'application/x-qpro' else
  if ltExt='wbmp' then Result := 'image/vnd.wap.wbmp' else
  if ltExt='web' then Result := 'application/vnd.xara' else
  if ltExt='wiz' then Result := 'application/msword' else
  if ltExt='wk1' then Result := 'application/x-123' else
  if ltExt='wmf' then Result := 'windows/metafile' else
  if ltExt='wml' then Result := 'text/vnd.wap.wml' else
  if ltExt='wmlc' then Result := 'application/vnd.wap.wmlc' else
  if ltExt='wmls' then Result := 'text/vnd.wap.wmlscript' else
  if ltExt='wmlsc' then Result := 'application/vnd.wap.wmlscriptc' else
  if ltExt='word' then Result := 'application/msword' else
  if ltExt='wp' then Result := 'application/wordperfect' else
  if ltExt='wp5' then Result := 'application/wordperfect' else
  if ltExt='wp6' then Result := 'application/wordperfect' else
  if ltExt='wpd' then Result := 'application/wordperfect' else
  if ltExt='wq1' then Result := 'application/x-lotus' else
  if ltExt='wri' then Result := 'application/mswrite' else
  if ltExt='wrl' then Result := 'model/vrml' else
  if ltExt='wrz' then Result := 'model/vrml' else
  if ltExt='wsc' then Result := 'text/scriplet' else
  if ltExt='wsrc' then Result := 'application/x-wais-source' else
  if ltExt='wtk' then Result := 'application/x-wintalk' else
  if ltExt='xbm' then Result := 'image/xbm' else
  if ltExt='xdr' then Result := 'video/x-amt-demorun' else
  if ltExt='xgz' then Result := 'xgl/drawing' else
  if ltExt='xif' then Result := 'image/vnd.xiff' else
  if ltExt='xl' then Result := 'application/excel' else
  if ltExt='xla' then Result := 'application/excel' else
  if ltExt='xlb' then Result := 'application/excel' else
  if ltExt='xlc' then Result := 'application/excel' else
  if ltExt='xlc' then Result := 'application/x-excel' else
  if ltExt='xld' then Result := 'application/excel' else
  if ltExt='xlk' then Result := 'application/excel' else
  if ltExt='xll' then Result := 'application/excel' else
  if ltExt='xlm' then Result := 'application/excel' else
  if ltExt='xls' then Result := 'application/excel' else
  if ltExt='xlt' then Result := 'application/excel' else
  if ltExt='xlv' then Result := 'application/excel' else
  if ltExt='xlw' then Result := 'application/excel' else
  if ltExt='xm' then Result := 'audio/xm' else
  if ltExt='xml' then Result := 'application/xml' else
  if ltExt='xmz' then Result := 'xgl/movie' else
  if ltExt='xpix' then Result := 'application/x-vnd.ls-xpix' else
  if ltExt='xpm' then Result := 'image/xpm' else
  if ltExt='x-' then Result := 'png	image/png' else
  if ltExt='xsr' then Result := 'video/x-amt-showrun' else
  if ltExt='xwd' then Result := 'image/x-xwd' else
  if ltExt='xyz' then Result := 'chemical/x-pdb' else
  if ltExt='z' then Result := 'application/x-compress' else
  if ltExt='zip' then Result := 'application/x-compressed' else
  if ltExt='zip' then Result := 'application/zip' else
  if ltExt='zoo' then Result := 'application/octet-stream' else
  if ltExt='zsh' then Result := 'text/x-script.zsh' else
  Result := 'plain/text';
end;


constructor TRESTPassthrough.Create(aOwner: TComponent);
begin
  inherited Create( aOwner );
  fDefaultFiles := TStringList.Create;
  fDefaultFiles.Add('index.html');
  fDefaultFiles.Add('index.php');
end;

function TRESTPassThrough.RemoveDoubleSeparators( SourceStr: string ): string;
var
  WorkStr: string;
begin
  WorkStr := SourceStr;
  while Pos(cPathSeparator+cPathSeparator,WorkStr)>0 do begin
    WorkStr := StringReplace(WorkStr,cPathSeparator+cPathSeparator,cPathSeparator,[rfReplaceAll, rfIgnoreCase]);
  end;
  Result := WorkStr;
end;

function TRESTPassThrough.DefaultFileIfExists: string;
var
  idx: int32;
  Path: string;
begin
  Result := '';
  if fDefaultFiles.Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(fDefaultFiles.Count) do begin
    Path := fRootDirectory + cPathSeparator + fDefaultFiles[idx];
    Path := RemoveDoubleSeparators( Path );
    if FileExists(Path) then begin
      Result := Path;
      exit;
    end;
  end;
end;

procedure TRESTPassthrough.Execute(Dispatcher: IWebDispatcherAccess);
var
  Path: string;
begin
  // Where is the file that we're looking for?
  Path := Dispatcher.Request.TranslateURI(Dispatcher.Request.PathInfo);
  {$ifdef MSWINDOWS}
  Path := StringReplace(Path,'/',cPathSeparator,[rfReplaceAll, rfIgnoreCase]);
  {$endif}
  // Check to see if path is root, and test for default file-names.
  if (Path='') or (Path=cPathSeparator) then begin
    Path := DefaultFileIfExists;
  end else begin
    Path := fRootDirectory + Path;
    Path := RemoveDoubleSeparators(Path);
  end;
  // If the file does not exist.
  if not FileExists(Path) then begin
    Dispatcher.Response.Content := 'Endpoint not found.';
    Dispatcher.Response.StatusCode := integer(THTTPResponseCode.rc404_NotFound);
    Dispatcher.Response.SendResponse;
    exit;
  end;
  // Otherwise, return the file.
  Dispatcher.Response.ContentType := GetMimeType(ExtractFileExt(Path));
  Dispatcher.Response.StatusCode := integer(THTTPResponseCode.rc200_OK);
  Dispatcher.Response.ContentStream := TFileStream.Create(Path,fmOpenRead);
  Dispatcher.Response.SendResponse;
end;

end.
