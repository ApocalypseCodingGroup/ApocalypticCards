{$ifdef license}
(*
  Copyright 2020 ChapmanWorld LLC ( https://chapmanworld.com )

  Redistribution and use in source and binary forms, with or without modification,
  are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice,
     this list of conditions and the following disclaimer in the documentation and/or
     other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be
     used to endorse or promote products derived from this software without specific prior
     written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
  IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
  IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)
{$endif}
/// <summary>
///   Chapmanworld Logging system cwLog.
/// </summary>
unit cwLog;
{$ifdef fpc}{$mode delphiunicode}{$endif}  

interface
uses
  sysutils //[RTL] for Exception
, cwTypes
;


type

{$region ' TStatus'}

  ///   <summary>
  ///     TStatus is a data-type intended for return from functions/procedures/methods in place
  ///     of the typically used boolean or int32 return types. <br/>
  ///     TStatus is implemented as a 128-bit integer GUID, which is also the return type of the
  ///     ILog.Insert() method, which returns the GUID of the log entry which was inserted. <br/>
  ///     For example, a function may return as follows...<br/>
  ///     <br/>
  ///     if Index>Count then begin <br/>
  ///       Result := Log.Insert( le_IndexOutOfBounds, lsError, [ Index.AsString ] );<br/>
  ///     end;<br/>
  ///     <br/>
  ///   </summary>
  ///   <remarks>
  ///     It should be noted that while the status values and log entry GUIDS are compatible,
  ///     the TStatus type does not carry sufficient information to translate a log entry which
  ///     has parameters. In case the status places the application into an exception state, you may
  ///     either refer the end user to the log, or alternatively call Log.GetLast() to retrieve the
  ///     most recently inserted log entry.
  ///   </remarks>
  TStatus = record
    Value: TGUID;
  public

    ///  <summary>
    ///    This is a convenience method to return a TStatus representing an unknown
    ///    result state. This is typically the initialization state of a function which
    ///    returns TStatus.
    ///  </summary>
    class function Unknown: TStatus; static;

    ///  <summary>
    ///    This is a convenience method to return a TStatus representing a successful
    ///    result state. Note that the GUID for a success state is always the
    ///    '{00000000-0000-0000-0000-000000000000}' GUID. This can make debug-time
    ///    inspection of results easier, as all components of the TStatus should
    ///    be zero for Success.
    ///  </summary>
    class function Success: TStatus; static;

    ///  <summary>
    ///    This is a convenience method for determining if the TStatus represents
    ///    a success state or not.
    ///  </summary>
    function IsSuccess: boolean; overload;
  end;

{$endregion}

{$region ' TLogSeverity'}

  /// <summary>
  ///   An enumerated type used to indicate the severity of a log entry upon insertion
  ///   into the log. <br />
  /// </summary>
  {$Z4}
  TLogSeverity = (

    /// <summary>
    ///   lsInfo is used to convey a simple piece of information to the end
    ///   user. This is useful for simple state reporting to file for example.
    /// </summary>
    lsInfo = $01,

    /// <summary>
    ///   lsHint is used to indicate potential performance or stability issues
    ///   due to configuration or miss-use of the application. It is similar to
    ///   lsInfo, except that it may be used to flag attention to a possible
    ///   correction.
    /// </summary>
    lsHint = $02,

    /// <summary>
    ///   lsWarning is an indication that there may be an error condition, or that
    ///   the application may not be functioning as expected. <br/>
    ///   Warnings may be used to indicate miss-configuration issues, or states
    ///   which may lead to error conditions later in the application execution cycle.
    /// </summary>
    lsWarning = $03,

    /// <summary>
    ///   lsError indicates that something has gone wrong which may cause
    ///   unexpected behavior in the application. It may be possible for the application
    ///   to proceed despite the error, or not, the end user should be made aware
    ///   of such a condition.
    /// </summary>
    lsError = $04,

    /// <summary>
    ///   <para>
    ///     lsFatal indicates that something has gone wrong which may cause
    ///     unexpected behavior in the application. This is a more severe
    ///     error which may cause the application to terminate.
    ///   </para>
    /// </summary>
    lsFatal = $05
  );

{$endregion}

{$region ' Exceptions'}

  ///  <summary>
  ///    Exception raised when a log entry is inserted which cannot be
  ///    parsed as a log entry.
  ///  </summary>
  EInvalidLogEntry = class(Exception);

{$endregion}

{$region ' ILogTarget'}

  ///  <summary>
  ///    Implementations of ILogTarget will receive log entries as they
  ///    are inserted into the log.
  ///  </summary>
  ILogTarget = interface
    ['{4658C7FB-1AA5-4177-A74D-4F85AEF87564}']

    ///  <summary>
    ///    This method is called for each entry inserted into the log.
    ///  </summary>
    procedure Insert( const LogEntry: TGUID; const TranslatedText: string; const TS: TDateTime; const Severity: TLogSeverity; const Parameters: array of string );
  end;

{$endregion}

{$region ' ILog'}

  /// <summary>
  ///   ILog represents a single application-wide log into which log entries may be inserted. <br/>
  ///   Defining a log entry is done by creating a resource string which begins
  ///   with a GUID identifying the log entry, followed by the default text for
  ///   the entry. (Note, the
  ///   Log entries may also contain place holder values which are denoted
  ///   by enclosing them in brackets with percent characters around them.
  ///   For example (%value%) creates a place holder named 'value'.
  ///   Placeholders are populated using parameters passed into calls to the
  ///   Insert() method.
  /// </summary>
  ILog = interface
    ['{587FD133-6206-461F-A9F7-7D07CF60F93B}']

    ///  <summary>
    ///    Adds a log entry by UUID and default text 'MessageStr' to the log. <br/>
    ///    You should not need to call this method directly for log entries which are
    ///    declared as resourcestring. The log will automatically collect resource strings
    ///    which match the log entry format '<UUID><text>' for example:
    ///
    ///    resourcestring
    ///      le_IndexOutOfBounds = '{C55508DE-73AE-4770-B623-B864077C4177} Index out of bounds ((%index%))';
    ///
    ///    This method may be used to manually add entries to the log if required. <br/>
    ///    Returns FALSE if a log entry with the provided GUID has already been registered.
    ///  </summary>
    function RegisterLogEntry( const EntryString: string ): boolean;

    /// <exclude/> - A convenience overload to prevent the need for type-casting ansi-strings to unicode strings.
    function Insert( const LogEntry: AnsiString; const Severity: TLogSeverity ): TStatus; overload;

    /// <exclude/> - A convenience overload to prevent the need for type-casting ansi-strings to unicode strings.
    function Insert( const LogEntry: AnsiString; const Severity: TLogSeverity; const Parameters: array of string ): TStatus; overload;

    ///  <summary>
    ///    Inserts a log entry into the log. <br/>
    ///    Note: For log entries which do not require parameters, see the overloaded Insert method.
    ///  </summary>
    function Insert( const LogEntry: string; const Severity: TLogSeverity; const Parameters: array of string ): TStatus; overload;

    ///  <summary>
    ///    Inserts a log entry into the log, just like the overload by the same name, however
    ///    this overload does not require parameters to be provided. This method may be convenient
    ///    for inserting log entries which do not require parameters.
    ///  </summary>
    function Insert( const LogEntry: string; const Severity: TLogSeverity ): TStatus; overload;

    ///  <summary>
    ///    When log entries are registered (currently done automatically for fpc
    ///    but manually for Delphi), this method will save those registered entries
    ///    to a json format file. The file may be translated and loaded back into
    ///    the logging system with a call to ImportTranslationFile().
    ///    (*Note File is encoded UTF8 with BOM)
    ///  </summary>
    function ExportTranslationFile( const FilePath: string ): TStatus;

    ///  <summary>
    ///    Imports log entry translations from a json format file.
    ///    (*Note: File must be encoded UTF8 with BOM)
    ///  </summary>
    function ImportTranslationFile( const FilePath: string ): TStatus;

    ///  <summary>
    ///    Returns the most recently inserted log entry for the current running thread, post translation.
    ///  </summary>
    function getLastEntry: string;

    ///  <summary>
    ///    Add a log target to the log.
    ///  </summary>
    procedure AddLogTarget( const LogTarget: ILogTarget );

    ///  <summary>
    ///    Returns the most recently inserted log entry for the current running thread, post translation.
    ///  </summary>
    property LastEntry: string read getLastEntry;

  end;

{$endregion}

implementation

{$region ' TStatus implementation'}

const
  cSuccessUUID = '{00000000-0000-0000-0000-000000000000}';
  cUnknownUUID = '{A334E3A7-D11E-4106-B021-C737523CB51B}';

function TStatus.IsSuccess: boolean;
begin
  Result := string(GUIDToString(Value)) = cSuccessUUID;
end;

class function TStatus.Success: TStatus;
begin
  Result.Value := StringToGUID(cSuccessUUID);
end;

class function TStatus.Unknown: TStatus;
begin
  Result.Value := StringToGUID(cUnknownUUID);
end;

{$endregion}

end.
