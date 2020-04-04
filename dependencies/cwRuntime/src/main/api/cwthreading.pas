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
unit cwThreading;
{$ifdef fpc}{$mode delphiunicode}{$endif}

interface

type

{$region ' Critical Section'}

  ///  <summary>
  ///    Represents a mutex lock which may be used to protect a critical
  ///    section of code, which must be executed by only one thread at any
  ///    time.
  ///  </summary>
  ICriticalSection = interface
    ['{21F4E11C-C165-4473-82C0-1674EBD90678}']

    ///  <summary>
    ///    Acquire the mutex lock. A thread should call this to ensure that
    ///    it is executing exclusively.
    ///  </summary>
    procedure Acquire;

    ///  <summary>
    ///    Release the mutex lock. A thread calls this method to release it's
    ///    exclusive execution.
    ///  </summary>
    procedure Release;
  end;

{$endregion}

{$region ' Signaled Critical Section'}

  ///  <summary>
  ///    Represents a critical section controlled by a condition variable.
  ///    This works in the same way as an ICriticalSection, except that a
  ///    thread can put it's self to sleep (releasing the mutex), until it
  ///    is woken by an external signal from another thread. Once woken the
  ///    thread re-aquires the mutex lock and continues execution.
  ///  </summary>
  ISignaledCriticalSection = interface
    ['{89D86C88-78BB-4FD5-AE68-BFF81C035BF0}']

    ///  <summary>
    ///    Acquire the mutex lock. A thread should call this to ensure that
    ///    it is executing exclusively.
    ///  </summary>
    procedure Acquire;

    ///  <summary>
    ///    Release the mutex lock. A thread calls this method to release it's
    ///    exclusive execution.
    ///  </summary>
    procedure Release;

    ///  <summary>
    ///    Causes the calling thread to release the mutex lock and begin
    ///    sleeping. While sleeping, the calling thread is excluded from the
    ///    thread scheduler, allowing other threads to consume it's runtime.
    ///    <remarks>
    ///      Sleep may return at any time, regardless of the work having been
    ///      completed. You should check that the work has actually been
    ///      completed, and if not, put the signaled critical seciton back
    ///      to sleep.
    ///    </remarks>
    ///  </summary>
    procedure Sleep;

    ///  <summary>
    ///    Called by some external thread, Wake causes the sleeping thread to
    ///    re-aquire the mutex lock and to continue executing.
    ///  </summary>
    procedure Wake;
  end;

{$endregion}

{$region ' Thread Method'}

  ///  <summary>
  ///    The thread execute method callback, used by IThreadMethod.
  ///  </summary>
  TThreadExecuteMethod = function(): boolean of object;

  ///  <summary>
  ///    IThreadMethod represents a long running thread, which will
  ///    repeatedly call an external execute method, until that method
  ///    returns false.
  ///  </summary>
  IThreadMethod = interface
    ['{FB86E522-F520-4496-AC08-CAAE6FA0C11A}']

    ///  <summary>
    ///    Causes the running thread to shut down.
    ///  </summary>
    function Terminate( Timeout: uint32 = 25 ): boolean;

    ///  <summary>
    ///    Returns a reference to the method to be executed.
    ///  </summary>
    function getExecuteMethod: TThreadExecuteMethod;

    ///  <summary>
    ///    Sets the reference for the method to be executed.
    ///  </summary>
    procedure setExecuteMethod( const value: TThreadExecuteMethod );

    //- Pascal Only, Properties -//
    property ExecuteMethod: TThreadExecuteMethod read getExecuteMethod write setExecuteMethod;
  end;

{$endregion}

{$region ' Message Bus'}
  ///  <summary>
  ///    Represents a message to be transferred along a message channel/pipe.
  ///  </summary>
  TMessage = record
    Value: uint64;
    ParamA: uint64;
    ParamB: uint64;
    ParamC: uint64;
    ParamD: uint64;
  end;

  ///  <summary>
  ///    An implementation of IMessagePipe represents a sender which is able
  ///    to send message into a message channel.
  ///  </summary>
  IMessagePipe = interface
    ['{0BA78A88-4082-4B7E-BD07-3920CE7440B4}']

    ///  <summary>
    ///    Returns true if the pipe is enabled for message sending,
    ///    else returns false.
    ///  </summary>
    function getEnabled: boolean;

    ///  <summary>
    ///    Enable / Disable sending on this message pipe.
    ///  </summary>
    procedure setEnabled( value: boolean );

    ///  <summary>
    ///    Sends a message into the message pipe and waits until the message
    ///    has been handled. The message handler may return a result value
    ///    in the result of this method.
    ///  </summary>
    function SendMessageWait( MessageValue: uint64; ParamA: uint64 = 0; ParamB: uint64 = 0; ParamC: uint64 = 0; ParamD: uint64 = 0 ): uint64;

    ///  <summary>
    ///    Sends a message into the message pipe.
    ///    Returns TRUE if the message was successfully sent, otherwise
    ///    returns FALSE. This method returns immediately and therefore does not
    ///    wait for a response.
    ///  </summary>
    function SendMessage( MessageValue: uint64; ParamA: uint64 = 0; ParamB: uint64 = 0; ParamC: uint64 = 0; ParamD: uint64 = 0 ): boolean;

    ///  <summary>
    ///    Enable / Disable sending on this message pipe.
    ///  </summary>
    property Enabled: boolean read getEnabled write setEnabled;
  end;

  ///  <summary>
  ///    Callback used to handle messages coming from a message channel.
  ///  </summary>
  TMessageHandler = function (aMessage: TMessage): uint64 of object;

  ///  <summary>
  ///    An implementation of IMessageChannel represents a listener for a
  ///    channel of messages. The listener may be used by a single thread only.
  ///    See IMessagePipe for multiple sender.
  ///  </summary>
  IMessageChannel = interface
    ['{69D9504A-3DCC-4294-8D9C-29020D8FB997}']

    ///  <summary>
    ///    Returns true if the message channel is enabled.
    ///    If the channel is not enabled, calls to GetMessage()
    ///    return immediately without handling messages.
    ///  </summary>
    function getEnabled: boolean;

    ///  <summary>
    ///    Enable / Disable the GetMessage() call.
    ///  </summary>
    procedure setEnabled( value: boolean );

    ///  <summary>
    ///    Creates and returns a new instance of IMessagePipe which is able
    ///    to send messages into the channel.
    ///  </summary>
    function GetMessagePipe: IMessagePipe;

    ///  <summary>
    ///    Checks all message pipes connected to the channel for new incomming
    ///    messages. This method will block execution and sleep the thread
    ///    until new messages are available.
    ///  </summary>
    procedure GetMessage( Handler: TMessageHandler );

    ///  <summary>
    ///    Checks all message pipes connected to the channel for new incomming
    ///    messages. If a new message is available, MessagesWaiting will return
    ///    TRUE, otherwise FALSE.
    ///  </summary>
    function MessagesWaiting: boolean;

    ///  <summary>
    ///    Enable / Disable the GetMessage() call.
    ///  </summary>
    property Enabled: boolean read getEnabled write setEnabled;
  end;

  ///  <summary>
  ///    Represents the global messaging system between sub-systems within a
  ///    thread pool.
  ///  </summary>
  IMessageBus = interface
    ['{1C4AB336-BFA5-4A2B-88A3-C79A1CEEFA24}']

    ///  <summary>
    ///    Returns true if the message bus is enabled, else returns
    ///    false. When the message bus is not enabled, none of the
    ///    message channels will operate, allowing threads calling
    ///    those channels to terminate.
    ///  </summary>
    function getEnabled: boolean;

    ///  <summary>
    ///    Enable / Disable the message bus.
    ///  </summary>
    procedure setEnabled( value: boolean );

    ///  <summary>
    ///    Create a new message channel.
    ///    Channel name must be unique, or exception will be raised.
    ///  </summary>
    function CreateChannel( ChannelName: string ): IMessageChannel;

    ///  <summary>
    ///    Returns a message pipe which may be used to send messages into the
    ///    message channel.
    ///  </summary>
    function GetMessagePipe( ChannelName: string ): IMessagePipe;

    ///  <summary>
    ///    Enable / Disable the message bus.
    ///  </summary>
    property Enabled: boolean read getEnabled write setEnabled;
  end;

{$endregion}

{$region ' Thread Pool'}

  ///  <summary>
  ///    Implement IPoolThread to provide functionality for a thread running
  ///    within a thread pool (IThreadPool)
  ///  </summary>
  IPoolThread = interface
    ['{2806DC0F-ADA9-4C52-B65E-3966CBE3FAA6}']

    ///  <summary>
    ///    Called by the operating thread as the thread starts up.
    ///  </summary>
    function Initialize: boolean;

    ///  <summary>
    ///    Called repeatedly by the operating thread, so long as execute
    ///    returns true, and the thread continues running.
    ///  </summary>
    function Execute: boolean;

    ///  <summary>
    ///    Called as the operating thread shuts down.
    ///  </summary>
    procedure Finalize;
  end;

  ///  <summary>
  ///    Manages a pool of processing threads operating on a pool of ISubSystem.
  ///  </summary>
  IThreadPool = interface
    ['{F397A185-FD7E-4748-BA1F-B79D46348F34}']

    ///  <summary>
    ///    Returns the numnber of IPoolThreads that have been installed.
    ///  </summary>
    function getThreadCount: uint64;

    ///  <summary>
    ///    Returns one of the pool thread instances by index.
    ///  </summary>
    function getThread( idx: uint64 ): IPoolThread;

    ///  <summary>
    ///    Installs a thread into the thread pool.
    ///  </summary>
    function InstallThread( aSubSytem: IPoolThread ): boolean;

    ///  <summary>
    ///    Start the threads running.
    ///  </summary>
    function Start: boolean;

    ///  <summary>
    ///    Terminates the running threads and disposes the subsystems.
    ///  </summary>
    procedure Stop;

    //- Pascal Only, Properties -//
    property ThreadCount: uint64 read getThreadCount;
    property Threads[ idx: uint64 ]: IPoolThread read getThread;
  end;

{$endregion}

{$region ' Thread System'}

  ///  <summary>
  ///    Used to specify which thread a sub-system is installed into.
  ///  </summary>
  ///  <remark>
  ///    This enumeration replaces the earlier mechanism of allowing a
  ///    sub-system to decide where it is installed, offering finer control
  ///    over where the sub-system is installed at start-up.
  ///  </remark>
  TInstallInto =
  (
    /// <summary>
    ///   Install into the main thread and dedicate the main thread to this
    ///   sub-system. (Will fail if the main thread already has another
    ///   sub-system).
    /// </summary>
    iiMainThreadDedicated,
    /// <summary>
    ///   Install into the main thread, and allow other sub-systems on the main
    ///   thread.
    /// </summary>
    iiMainThreadShared,
    /// <summary>
    ///   Install into the first available auxiliary thread and dedicate the
    ///   thread to this sub-system. This will fail if there are no remaining
    ///   threads to dedicate to this sub-system.
    /// </summary>
    iiAuxThreadDedicated,
    /// <summary>
    ///   Install into the least used auxiliary thread which is not already
    ///   dedicated to another system.
    /// </summary>
    iiAuxThreadShared,
    /// <summary>
    ///   Install into the thread as specified by index (in subsequent
    ///   parameter), and dedicate the thread to this sub-system. Will fail if
    ///   the specified thread already has a sub-system installed.
    /// </summary>
    iiSpecifiedDedicated,
    /// <summary>
    ///   Installs into the thread specified (in subsequent parameter). Allows
    ///   other sub-systems to be installed into the same thread.
    /// </summary>
    iiSpecifiedShared
  );

  ///  <summary>
  ///    Implement IThreadSubsystem to provide functionality to be executed
  ///    within a thread system (IThreadSystem)
  ///  </summary>
  IThreadSubSystem = interface
    ['{9CBE79FE-CDAA-4D25-A269-F2A199A16E74}']

    ///  <summary>
    ///    The thread system will call this method when the subsystem is
    ///    first installed. This method is always called by the main thread
    ///    as it is called before the auxilary threads are running.
    ///  </summary>
    function Install( MessageBus: IMessageBus ): boolean;

    ///  <summary>
    ///    The operating thread for this thread sub-system will call this
    ///    method immediately after the thread starts running.
    ///  </summary>
    function Initialize( MessageBus: IMessageBus ): boolean;

    ///  <summary>
    ///    The operating thread for this thread sub-system will call this
    ///    method repeatedly during the lifetime of the thread. If this
    ///    method returns true, execution will continue. If this method
    ///    returns false, then this thread sub-system will be removed from
    ///    it's operating thread and will no longer be executed.
    ///  </summary>
    function Execute: boolean;

    ///  <summary>
    ///    The operating thread will call this method when the subsystem is
    ///    being shut down, either because the thread is terminating, or
    ///    when this thread sub-system returns false from it's execute method.
    ///  </summary>
    procedure Finalize;

  end;

  ///  <summary>
  ///    Manages a collection of sub-systems to be executed within a pool
  ///    of threads.
  ///  </summary>
  IThreadSystem = interface
    ['{9C1FB3E1-A9BC-4897-BD01-D5EA2933132D}']

    ///  <summary>
    ///    Returns the message bus which is used to allow sub-modules to
    ///    communicate with each other.
    ///  </summary>
    function MessageBus: IMessageBus;

    /// <summary>
    ///   Installs a subsystem to be executed by the operating threads. <br />
    ///   This method may only be called before the thread system starts
    ///   running.
    /// </summary>
    /// <param name="aSubSystem">
    ///   The sub-system to be installed.
    /// </param>
    /// <param name="Into">
    ///   Specifies how the sub-system should be installed.
    /// </param>
    /// <param name="ThreadIndex">
    ///   If the Into parameter is iiSpecified or iiSpecifiedDedicated, this
    ///   parameter specifies the index of the thread to install the sub-system
    ///   into (where zero is always the main thread). Otherwise, this
    ///   parameter is ignored.
    /// </param>
    function InstallSubSystem( aSubSystem: IThreadSubsystem; Into: TInstallInto; ThreadIndex: uint64 = 0 ): boolean;

    ///  <summary>
    ///    Starts the ancillary threads running. When using the Start()
    ///    method (rather than the run method), the main thread remains with
    ///    the calling application. Sub-systems installed on the main thread
    ///    will not be excuted when using Start()/Stop().
    ///  </summary>
    ///  <remark>
    ///    Between Start() / Stop() the main thread can be progressed manually
    ///    by repeatedly calling the Progress() method.
    ///  </remark>
    procedure Start;

    ///  <summary>
    ///    Stops the ancillary threads which were started with a call to the
    ///    Start() method.
    ///  </summary>
    ///  <remark>
    ///    Between Start() / Stop() the main thread can be progressed manually
    ///    by repeatedly calling the Progress() method.
    ///  </remark>
    procedure Stop;

    /// <summary>
    ///   <para>
    ///     Manually progresses the main thread (executes the main thread
    ///     sub-systems) when called between Start() / Stop() methods. <br />
    ///     This will progress the main thread a single iteration, allowing
    ///     manual progression of the main thread by repeatedly calling
    ///     Progress() between Start() and Stop() methods.
    ///   </para>
    ///   <para>
    ///     The Start() / Progress() / Stop() pattern is mutually exclusive
    ///     to calling the Run() method.
    ///   </para>
    ///   <para>
    ///     So long as there are sub-systems installed on the main thread,
    ///     the following code is an acceptable pattern...
    ///   </para>
    ///   <code lang="Delphi">start;
    /// try
    ///   while Progress do;
    /// finally
    ///   stop;
    /// end; </code>
    /// </summary>
    /// <returns>
    ///   Returns true when there is work remaining to be performed on the main
    ///   thread, else returns false.
    /// </returns>
    function Progress: boolean;

    /// <summary>
    ///   Starts the thread system running. <br />Auxilary threads are started
    ///   first, and then the main thread runs. <br />Execution continues until
    ///   the main thread exits, at which time the Auxilary threads are also
    ///   stopped. <br />Internally, this method executes the following code:
    ///   <code lang="Delphi">start;
    /// try
    ///   while progress do;
    /// finally
    ///   stop;
    /// end;</code>
    ///   This method is mutually exclusive to using the start() / progress() /
    ///   stop() pattern.
    /// </summary>
    procedure Run;

    ///  <summary>
    ///    Returns the number of threads in this thread system.
    ///  </summary>
    function getThreadCount: uint32;

    //- Pascal Only, Properties -//

    ///  <summary>
    ///    Returns the number of threads in this thread system.
    ///  </summary>
    property ThreadCount: uint32 read getThreadCount;
  end;

{$endregion}

{$region ' Threaded Loop'}

  ///  <summary>
  ///    Method prototype for passing to IThreadedLoop.
  ///    The method will be called once by each thread with parameters indicating
  ///    the indicies of the total amount of work which the method should process.
  ///  </summary>
  TThreadedLoopMethod = procedure( const start: nativeuint; const stop: nativeuint );
  TThreadedLoopMethodOfObject = procedure( const start: nativeuint; const stop: nativeuint ) of object;

  ///  <summary>
  ///    Enables threaded execution of multi-dimensional loops for cases
  ///    in which the order of exection is not relevant to the behavior
  ///    of the loop.
  ///  </summary>
  IThreadedLoop = interface
    ['{AF0142CA-F4FA-4A99-B7B6-D71A93C48BF9}']

    ///  <summary>
    ///    The number of work items will be divided up among the running threads,
    ///    each thread method will be called with a start, and stop position indicating
    ///    the work items it should process.
    ///    Optionally an offset may be provided, which will be added to the work start
    ///    and stop parameters to offset the work done by the thread.
    ///    When using the offset parameter, care should be taken to ensure that the
    ///    threads do not interfere with each other.
    ///  </summary>
    procedure Execute( const Method: TThreadedLoopMethod; const Work: nativeuint; const Offset: nativeuint = 0 ); overload;
    procedure Execute( const Method: TThreadedLoopMethodOfObject; const Work: nativeuint; const Offset: nativeuint = 0 ); overload;
    procedure ExecuteDebug( const Method: TThreadedLoopMethod; const Work: nativeuint; const Offset: nativeuint = 0 ); overload;
    procedure ExecuteDebug( const Method: TThreadedLoopMethodOfObject; const Work: nativeuint; const Offset: nativeuint = 0 ); overload;
  end;

{$endregion}

implementation

end.
