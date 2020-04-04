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
unit cwThreading.Standard;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface
uses
  cwThreading
;

type
  ///  <summary>
  ///    TThreadMethod is a factory record for creating instances of
  ///    IThreadMethod.
  ///  </summary>
  TThreadMethod = record
  public
    class function Create: IThreadMethod; static;
  end;

  ///  <summary>
  ///    TCriticalSection is a factory record for creating instances of
  ///    ICriticalSection.
  ///  </summary>
  TCriticalSection = record
  public
    class function Create: ICriticalSection; static;
  end;

  ///  <summary>
  ///    TSignaledCriticalSection is a factory record for creating
  ///    instances of ISignaledCriticalSection.
  ///  </summary>
  TSignaledCriticalSection = record
  public
    class function Create: ISignaledCriticalSection; static;
  end;

  ///  <summary>
  ///    TThreadPool is a factory record for creating instances of
  ///    IThreadPool.
  ///  </summary>
  TThreadPool = record
  public
    class function Create: IThreadPool; static;
  end;

  ///  <summary>
  ///    TThreadSystem is a factory record for creating instances of
  ///    IThreadSystem.
  ///  </summary>
  TThreadSystem = record
  public
    ///  <summary>
    ///    Creates an instance of IThreadSystem with the specified number of
    ///    threads. If the threads parameter is omitted or passed as zero,
    ///    then the number of threads created will be CPUCount * 2.
    ///    ( Except for IOS, in which case the thread count will be
    ///     CPUCount )
    ///  </summary>
    class function Create( Threads: uint32 = 0 ): IThreadSystem; static;
  end;

  ///  <summary>
  ///    TThreadedLoop is a factory method for creating instances of
  ///    IThreadedLoop.
  ///  </summary>
  TThreadedLoop = record
  public
    ///  <summarsy>
    ///    Creates an instance of IThreadedLoop witrh the specified number
    ///    of threads. If the threads parameter is omitted or passsed as zero,
    ///    then the number of threads created will be CPUCount * 2.
    ///    ( Except for IOS, in which case the thread count will be
    ///      CPUCount )
    ///  </summary>
    class function Create( Threads: uint32 = 0 ): IThreadedLoop; static;
  end;


implementation
uses
  cwThreading.ThreadPool.Standard
  {$ifdef MSWINDOWS}
, cwThreading.ThreadMethod.Windows
, cwThreading.SignaledCriticalSection.Windows
, cwThreading.CriticalSection.Windows
  {$else}
, cwThreading.ThreadMethod.Posix
, cwThreading.SignaledCriticalSection.Posix
, cwThreading.CriticalSection.Posix
  {$endif}
, cwThreading.ThreadSystem.Standard
, cwThreading.ThreadedLoop.Standard
;

class function TThreadedLoop.Create(Threads: uint32): IThreadedLoop;
begin
  Result := cwThreading.ThreadedLoop.Standard.TThreadedLoop.Create( Threads );
end;

{$region 'TThreadMethod'}

class function TThreadMethod.Create: IThreadMethod;
begin
  {$ifdef MSWINDOWS}
  Result := TWindowsThreadMethod.Create;
  {$else}
  Result := TPosixThreadMethod.Create;
  {$endif}
end;

{$endregion}

{$region 'TCriticalSection'}

class function TCriticalSection.Create: ICriticalSection;
begin
  {$ifdef MSWINDOWS}
  Result := TWindowsCriticalSection.Create;
  {$else}
  Result := TPosixCriticalSection.Create;
  {$endif}
end;

{$endregion}

{$region 'TSignaledCriticalSection'}

class function TSignaledCriticalSection.Create: ISignaledCriticalSection;
begin
  {$ifdef MSWINDOWS}
  Result := cwThreading.SignaledCriticalSection.Windows.TSignaledCriticalSection.Create;
  {$else}
  Result := cwThreading.SignaledCriticalSection.Posix.TSignaledCriticalSection.Create;
  {$endif}
end;

{$endregion}

{$region 'TThreadPool'}

class function TThreadPool.Create: IThreadPool;
begin
  Result := cwThreading.Threadpool.Standard.TThreadPool.Create;
end;

{$endregion}

{$region 'TThreadSystem'}

class function TThreadSystem.Create( Threads: uint32 = 0 ): IThreadSystem;
begin
  Result := cwThreading.ThreadSystem.Standard.TThreadSystem.Create( Threads );
end;

{$endregion}

end.

