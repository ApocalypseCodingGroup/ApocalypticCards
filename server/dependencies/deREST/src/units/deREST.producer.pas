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
unit deREST.producer;

interface
uses
  Classes,
  deREST.api,
  Web.HTTPApp,
  Web.HTTPProd;

type
  TRESTProducer = class(TPageProducer)
  private
    fRestAPI: TRESTAPI;
    function FindWebAction: TWebActionItem;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create( aOwner: TComponent ); override;
    function Content: string; override;
  published
    property RESTAPI: TRESTAPI read fRestAPI write fRESTAPI;
  end;

implementation
uses
  sysutils;

{ TRESTProducer }
constructor TRESTProducer.Create(aOwner: TComponent);
begin
  inherited Create( aOwner );
  fRESTAPI := nil;
  if not (aOwner is TWebModule) then begin
    raise
      Exception.Create('TRESTProducer must be placed on a web module.');
  end;
end;

function TRESTProducer.FindWebAction: TWebActionItem;
var
  idx: uint32;
  Module: TWebModule;
  Action: TWebActionItem;
begin
  Result := nil;
  Module := (Owner as TWebModule);
  if Module.Actions.Count=0 then begin
    exit;
  end;
  for idx := 0 to pred(Module.Actions.Count) do begin
    Action := Module.Actions.Items[idx];
    if (Action.Producer=Self) and (Action.Default) then begin
      Result := Action;
      exit;
    end;
  end;
end;

function TRESTProducer.Content: string;
var
  Action: TWebActionItem;
begin
  if not assigned(fRESTAPI) then begin
    Dispatcher.Response.StatusCode := 500;
    Dispatcher.Response.Content := 'RESTAPI not assigned to Producer "'+Self.Name+'"';
    Dispatcher.Response.SendResponse;
    exit;
  end;
  Action := FindWebAction;
  if not assigned(Action) then begin
    Dispatcher.Response.StatusCode := 500;
    Dispatcher.Response.Content := 'TRESTProducer cannot find the web action which it is assigned to. Is the action set default?';
    Dispatcher.Response.SendResponse;
    exit;
  end;
  (fRestAPI as IProducerDispatch).ProcessRequest(Dispatcher,Action.PathInfo);
end;

procedure TRESTProducer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=TOperation.opRemove) and (AComponent=fRESTAPI) then begin
    fRESTAPI := nil;
  end;
  inherited;
end;


end.
