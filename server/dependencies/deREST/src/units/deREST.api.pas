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
unit deREST.api;

interface
uses
  Data.DB,
  FireDAC.DApt,
  Web.HTTPApp,
  FireDAC.Comp.Client,
  deREST.authenticator,
  deREST.passthrough,
  deREST.pathinfo,
  deREST.types,
  classes;

type
  /// <exclude/>
  THTTPResponseCode = deREST.types.THTTPResponseCode;
  /// <exclude/>
  IRESTFilterGroup = deREST.types.IRESTFilterGroup;
  /// <exclude/>
  IRESTFilterItem = deREST.types.IRESTFilterItem;
  /// <exclude/>
  IRESTFilter = deREST.types.IRESTFilter;
  /// <exclude>
  IRESTObject = deREST.types.IRESTObject;
  /// <exclude/>
  IRESTArray = deREST.types.IRESTArray;
  /// <exclude/>
  IRESTResponse = deREST.types.IRESTResponse;


type
  ///  <summary>
  ///    Represents a rest collection which is exposed through the TRESTAPI
  ///  </summary>
  TRESTCollection = class(TCollectionItem)
  private
    fConnection: TFDConnection;
    fTableName: string;
    fKeyField: string;
    fEndpoint: string;
    fOnBeforeRESTDelete: TRESTDeleteEvent;
    fOnBeforeRESTUpdate: TRESTUpdateEvent;
    fOnBeforeRESTRead: TRESTReadEvent;
    fOnAfterRESTDelete: TRESTDeleteEvent;
    fOnAfterRESTUpdate: TRESTUpdateEvent;
    fOnAfterRESTRead: TRESTReadEvent;
    fOnBeforeRESTCreate: TRESTCreateEvent;
    fOnAfterRESTCreate: TRESTCreateEvent;
    procedure setConnection(const Value: TFDConnection);
    procedure setEndpoint(const Value: string);
    procedure setKeyField(const Value: string);
    procedure setTableName(const Value: string);
    procedure ProcessCreate( Request: IRESTArray; Response: IRESTResponse ); overload;
    procedure ProcessCreate( Request: IRESTArray; Response: IRESTResponse; Item: string ); overload;
    procedure ProcessRead( Filters: IRESTFilterGroup; Response: IRESTResponse );
    procedure ProcessUpdate( Request: IRESTArray; Filters: IRESTFilterGroup; Response: IRESTResponse );
    procedure ProcessDelete( Filters: IRESTFilterGroup; Response: IRESTResponse );
    function ParseFilters(FilterURL: string): IRESTFilterGroup;
    procedure SendResponse(Response: TWebResponse; RESTResponse: IRESTResponse);
    function VerifyDatabase(Response: IRESTResponse): boolean;
    function VerifyTable(Response: IRESTResponse): boolean;
    function ApplyWhereClause(qry: TFDQuery; Filters: IRESTFilterGroup; Response: IRESTResponse): boolean;
    function ExecuteQuery(qry: TFDQuery; Response: IRESTResponse): boolean;
    function ExecuteSQL(qry: TFDQuery): boolean;
    function DBObjectToResponse(qry: TFDQuery; Response: IRESTResponse): boolean;
    function ModifyDBObject(qry: TFDQuery; Request: IRESTArray): boolean;
    function ItemExists(ItemID: string): boolean;
  protected
    function GetDisplayName: string; override;
    procedure ProcessRequest( PathInfo: TPathInfo; Request: TWebRequest; Response: TWebResponse );
  public
    procedure Assign(Source: TPersistent); override;
  published

    ///  <summary>
    ///    FireDAC connection to the database.
    ///  </summary>
    property Connection: TFDConnection read fConnection write setConnection;

    ///  <summary>
    ///    The name of the database table which backs this REST collection.
    ///  </summary>
    property TableName: string read fTableName write setTableName;

    ///  <summary>
    ///    The name of the field which identifies objects in the database table
    ///    which backs this REST collection.
    ///  </summary>
    property KeyField: string read fKeyField write setKeyField;

    ///  <summary>
    ///    The public name of this REST collection.
    ///  </summary>
    property Endpoint: string read fEndpoint write setEndpoint;

    ///  <summary>
    ///    Event called before a create operation is performed in order to
    ///    create objects in a REST collection.
    ///  </summary>
    property OnBeforeRESTCreate: TRESTCreateEvent read fOnBeforeRESTCreate write fOnBeforeRESTCreate;
    ///  <summary>
    ///    Event called after a create operation is performed in order to create objects
    ///    in a REST collection.
    ///  </summary>
    property OnAfterRESTCreate: TRESTCreateEvent read fOnAfterRESTCreate write fOnAfterRESTCreate;
    ///  <summary>
    ///    Event called before a read operation to read objects from a REST collection.
    ///  </summary>
    property OnBeforeRESTRead: TRESTReadEvent read fOnBeforeRESTRead write fOnBeforeRESTRead;
    ///  <summary>
    ///    Event called after a read operation to read objects from a REST collection.
    ///  </summary>
    property OnAfterRESTRead: TRESTReadEvent read fOnAfterRESTRead write fOnAfterRESTRead;
    ///  <summary>
    ///    Event called before an update operation is performed to update objects in a REST collection.
    ///  </summary>
    property OnBeforeRESTUpdate: TRESTUpdateEvent read fOnBeforeRESTUpdate write fOnBeforeRESTUpdate;
    ///  <summary>
    ///    Event called after an update operation is performed to update objects in a REST collection.
    ///  </summary>
    property OnAfterRESTUpdate: TRESTUpdateEvent read fOnAfterRESTUpdate write fOnAfterRESTUpdate;
    ///  <summary>
    ///    Event called before a delete operation is performed to delete objects from a REST collection.
    ///  </summary>
    property OnBeforeRESTDelete: TRESTDeleteEvent read fOnBeforeRESTDelete write fOnBeforeRESTDelete;
    ///  <summary>
    ///    Event called after a delete operation is performed to delete objects from a REST collection.
    ///  </summary>
    property OnAfterRESTDelete: TRESTDeleteEvent read fOnAfterRESTDelete write fOnAfterRESTDelete;
  end;

  ///  <summary>
  ///    A collection of TRESTCollection objects (to provide a collection
  ///    property for TRESTAPI.
  ///  </summary>
  TRESTCollections = class( TOwnedCollection )
  public
    constructor Create( aOwner: TComponent );
  private
    function GetItem(idx: integer): TRESTCollection;
    procedure setItem(idx: integer; const Value: TRESTCollection);
  public
    property Items[idx: integer]: TRESTCollection read GetItem write setItem; default;
  end;

  /// <exclude/>
  ///  Used internally to forward requests from the producer.
  IProducerDispatch = interface
    ['{354D621D-50B3-4EAB-8ABD-4BB9E708008B}']
    procedure ProcessRequest(Dispatcher: IWebDispatcherAccess; ActionPathInfo: string );
  end;

  ///  <summary>
  ///    Represents a REST API (collection of endpoints) as a component to be
  ///    inserted into a web module.
  ///  </summary>
  TRESTAPI = class(TComponent, IProducerDispatch)
  private
    fPassthrough: TRESTPassthrough;
    fAuthenticator: TRESTAuthenticator;
    fCollections: TRESTCollections;
  private
    function getCollections: TRESTCollections;
    procedure setCollections(const Value: TRESTCollections);
    procedure ProcessRequest(Dispatcher: IWebDispatcherAccess; ActionPathInfo: string);
    function RemoveActionPath(PathInfo, ActionPathInfo: string): string;
    function AttemptAuthentication(Dispatcher: IWebDispatcherAccess): boolean;
    procedure FailedAuthentication(Dispatcher: IWebDispatcherAccess; BecauseMethod: boolean = FALSE );
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    ///  <exclude/>
    constructor Create( aOwner: TComponent ); override;
  published
    ///  <summary>
    ///    Provides access to the REST collections which are exposed through
    ///    this API.
    ///  </summary>
    property Collections: TRESTCollections read getCollections write setCollections;

    ///  <summary>
    ///    Reference to an authenticator component to handle authentication of
    ///    REST Requests. If no authenticator is set, all requests will be
    ///    permitted without authentication.
    ///  </summary>
    property Authenticator: TRESTAuthenticator read fAuthenticator write fAuthenticator;

    ///  <summary>
    ///    Refernece to a passthrough component which will be used to handle
    ///    any requests which are not identified against an endpoint.
    ///    If unassigned and the end-point is not found, a 404 is returned.
    ///  </summary>
    property Passthrough: TRESTPassthrough read fPassthrough write fPassthrough;
  end;

implementation
uses
  sysutils,
  strutils,
  deREST.restarray.standard,
  deREST.filterparser,
  deREST.restfilter.standard,
  deREST.restresponse.standard;


constructor TRESTAPI.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  // Ensure the rest manager component is installed on a web module,
  // we need access to the actions list.
  if not (aOwner is TWebModule) then begin
    raise
      Exception.Create('TRESTManager component must be placed on a TWebModule.');
  end;
  //- Create collections
  fCollections := TRESTCollections.Create(Self);
  fAuthenticator := nil;
  fPassthrough := nil;
end;

function TRESTAPI.getCollections: TRESTCollections;
begin
  Result := fCollections;
end;

procedure TRESTAPI.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=TOperation.opRemove) and (AComponent=fAuthenticator) then begin
    fAuthenticator := nil;
  end;
  inherited;
end;

procedure TRESTAPI.setCollections(const Value: TRESTCollections);
begin
  fCollections.Assign(Value);
end;

function TRESTAPI.RemoveActionPath( PathInfo: string; ActionPathInfo: string ): string;
var
  utPathInfo: string;
  utActionPathInfo: string;
  Test: string;
  L: int32;
begin
  utPathInfo := Uppercase(Trim(PathInfo));
  utActionPathInfo := Uppercase(Trim(ActionPathInfo));
  if (utActionPathInfo='') or (utActionPathInfo='/') then begin
    Result := PathInfo;
    exit;
  end;
  //- Else
  L := Length(utActionPathInfo);
  Test := LeftStr(utPathInfo,L);
  if Test=utActionPathInfo then begin
    Result := RightStr(PathInfo,Length(PathInfo)-L);
  end else begin
    Result := PathInfo;
  end;
end;

procedure TRESTAPI.FailedAuthentication( Dispatcher: IWebDispatcherAccess; BecauseMethod: boolean = FALSE );
begin
  Dispatcher.Response.StatusCode := integer(THTTPResponseCode.rc500_InternalServerError);
  Dispatcher.Response.Content := 'Authentication Failed';
  if BecauseMethod then begin
    Dispatcher.Response.Content := 'Authentication Failed. Requested HTTP Method not supported.';
  end;
  Dispatcher.Response.SendResponse;
end;

function TRESTAPI.AttemptAuthentication( Dispatcher: IWebDispatcherAccess ): boolean;
var
  Operation: TCRUDMethod;
begin
  Result := False;
  case Dispatcher.Request.MethodType of
    mtGet: Operation := TCRUDMethod.cmRead;
    mtPut: Operation := TCRUDMethod.cmUpdate;
    mtPost: Operation := TCRUDMethod.cmCreate;
    mtDelete: Operation := TCRUDMethod.cmDelete;
    else begin
      FailedAuthentication( Dispatcher, TRUE );
      exit;
    end;
  end;
  if assigned(fAuthenticator) then begin
    if not (fAuthenticator as IRequestAuthentication).Authenticate(Operation,Dispatcher.Request.PathInfo,Dispatcher.Request) then begin
      FailedAuthentication( Dispatcher );
      exit;
    end;
  end;
  Result := True;
end;

procedure TRESTAPI.ProcessRequest( Dispatcher: IWebDispatcherAccess; ActionPathInfo: string  );
var
  utPath: string;
  idx: uint32;
  PathInfoStr: string;
  PathInfo: TPathInfo;
  Collection: TRESTCollection;
begin
  if fCollections.Count>0 then begin
    //- Find the REST collection to handle the request.
    PathInfoStr := RemoveActionPath( Dispatcher.Request.PathInfo, ActionPathInfo );
    {$ifndef MSWINDOWS}
    PathInfoStr := RightStr(PathInfoStr,pred(Length(PathInfoStr)));
    {$endif}
    PathInfo := PathInfo.ParsePathInfo(PathInfoStr);
    utPath := Uppercase(Trim(PathInfo.Endpoint));
    for idx := 0 to pred(fCollections.Count) do begin
      Collection := TRESTCollection(fCollections.Items[idx]);
      if Uppercase(Trim(Collection.Endpoint))=utPath then begin
        if not AttemptAuthentication( Dispatcher ) then begin
          exit;
        end;
        TRESTCollection(fCollections.Items[idx]).ProcessRequest(PathInfo,Dispatcher.Request,Dispatcher.Response);
        exit;
      end;
    end;
  end;
  if assigned(fPassthrough) then begin
    fPassthrough.Execute(Dispatcher);
  end else begin
    //- If we get here, something went wrong, let the end user know.
    Dispatcher.Response.Content := 'Endpoint not found ('+PathInfoStr+':'+PathInfo.Endpoint+')';
    Dispatcher.Response.StatusCode := integer(THTTPResponseCode.rc404_NotFound);
    Dispatcher.Response.SendResponse;
  end;
end;

{ TRESTCollection }

function TRESTCollection.ParseFilters( FilterURL: string ): IRESTFilterGroup;
var
  aRestFilterGroup: IRestFilterGroup;
  FilterParser: TRESTFilterParser;
begin
  Result := nil;
  aRESTFilterGroup := TRestFilterGroup.Create;
  FilterParser := TRESTFilterParser.Create;
  try
    if not FilterParser.Parse( FilterURL, aRestFilterGroup ) then begin
      exit;
    end;
  finally
    FilterParser.DisposeOf;
  end;
  Result := aRESTFilterGroup;
end;

function TRESTCollection.VerifyDatabase( Response: IRESTResponse ): boolean;
begin
  Result := False;
  //- Do we have a database assigned?
  if not assigned(fConnection) then begin
    Response.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
    Response.ResponseMessage := 'Connection to database failed.';
    Response.Complete := True;
    exit;
  end;
  //- Can we connect to the database?
  fConnection.Connected := True;
  if not fConnection.Connected then begin
    Response.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
    Response.ResponseMessage := 'Connection to database failed.';
    Response.Complete := True;
    exit;
  end;
  //- We made it, we're good.
  Result := True;
end;

function TRESTCollection.VerifyTable( Response: IRESTResponse ): boolean;
begin
  Result := False;
  //- Do we have a table name.
  if Trim(fTableName)='' then begin
    Response.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
    Response.ResponseMessage := 'Database table not set.';
    Response.Complete := True;
    exit;
  end;
  //- We're done
  Result := True;
end;

function TRESTCollection.ApplyWhereClause( qry: TFDQuery; Filters: IRESTFilterGroup; Response: IRESTResponse ): boolean;
var
  Filter: IRESTFilterItem;
  ParamCounter: uint32;
  idx: uint32;
begin
  Result := False;
  //- Build the where clause and apply the parameters.
  if Filters.Count=0 then begin
    qry.SQL.Text := qry.SQL.Text + ';';
    Result := True;
    exit;
  end;
  //- Add where clause and assign parameters.
  ParamCounter := 0;
  Filters.AssignParameterNames(ParamCounter);
  qry.SQL.Text := qry.SQL.Text + ' where '+Filters.ToWhereClause+';';
  if qry.ParamCount>0 then begin
    for idx := 0 to pred(qry.Params.Count) do begin
      Filter := Filters.ParamValue(qry.Params[idx].Name);
      if (not assigned(Filter)) or (not Filter.IsFilter) then begin
        Response.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
        Response.ResponseMessage := 'Invalid filters (parameter name not found).';
        Response.Complete := True;
        exit;
      end;
      qry.Params[idx].AsString := Filter.AsFilter.AsString;
    end;
  end;
  //- We made it.
  Result := True;
end;

function TRESTCollection.ExecuteQuery( qry: TFDQuery; Response: IRESTResponse ): boolean;
begin
  Result := False;
  try
    qry.Active := True;
  except
    on E: Exception do begin
      Response.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
      Response.ResponseMessage := E.Message;
      Response.Complete := True;
      exit;
    end;
  end;
  //- Check that the query went active.
  if not qry.Active then begin
    Response.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
    Response.ResponseMessage := 'Invalid filters.';
    Response.Complete := True;
    exit;
  end;
  //- We made it.
  Result := True;
end;

function TRESTCollection.ExecuteSQL( qry: TFDQuery ): boolean;
begin
  Result := False;
  try
    qry.ExecSQL;
  except
    on E: Exception do begin
      exit;
    end;
  end;
  //- We made it.
  Result := True;
end;

function TRESTCollection.GetDisplayName: string;
begin
  Result := fEndpoint;
end;

procedure TRESTCollection.Assign(Source: TPersistent);
var
  src: TRESTCollection;
begin
  Src := TRESTCollection(Source);
  Endpoint := src.Endpoint;
  TableName := src.TableName;
  KeyField := src.KeyField;
  Connection := src.Connection;
  OnBeforeRESTCreate := src.OnBeforeRESTCreate;
  OnAfterRESTCreate := src.OnAfterRESTCreate;
  OnBeforeRESTRead := src.OnBeforeRESTRead;
  OnAfterRESTRead := src.OnAfterRESTRead;
  OnBeforeRESTUpdate := src.OnBeforeRESTUpdate;
  OnAfterRESTUpdate := src.OnAfterRESTUpdate;
  OnBeforeRESTDelete := src.OnBeforeRESTDelete;
  OnAfterRESTDelete := src.OnAfterRESTDelete;
end;

function TRESTCollection.DBObjectToResponse( qry: TFDQuery; Response: IRESTResponse ): boolean;
var
  idx: uint32;
  AnObject: IRESTObject;
begin
  Result := False;
  if qry.Fields.Count=0 then begin
    exit;
  end;
  AnObject := Response.ResponseArray.addItem;
  for idx := 0 to pred(qry.Fields.Count) do begin
    AnObject.AddValue(qry.Fields[idx].FieldName,qry.Fields[idx].AsString);
  end;
  Result := True;
end;

procedure TRESTCollection.ProcessRead( Filters: IRESTFilterGroup; Response: IRESTResponse );
var
  qry: TFDQuery;
begin
  //- Do we have a valid database connection?
  if not VerifyDatabase( Response ) then begin
    exit;
  end;

  //- Do we have a valid table name?
  if not VerifyTable( Response ) then begin
    exit;
  end;

  //- Create a query.
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := fConnection;

    //- Set SQL.
    qry.SQL.Text := 'select * from '+fTableName;
    if not ApplyWhereClause( qry, Filters, Response ) then begin
      exit;
    end;

    //- Execute the query.
    if not ExecuteQuery(qry,Response) then begin
      exit;
    end;

    //- Now begin returning the rows of data.
    if qry.RowsAffected>0 then begin
      qry.First;
      while not qry.EOF do begin
        if not DBObjectToResponse( qry, Response ) then begin
          Response.ResponseCode := THTTPResponseCode.rc400_BadRequest;
          Response.ResponseMessage := 'Unable to serialize object.';
          exit;
        end;
        qry.Next;
      end;
    end;
  finally
    qry.DisposeOf;
  end;
  Response.ResponseCode := THTTPResponseCode.rc200_OK;
  Response.Complete := True;
end;

function TRESTCollection.ItemExists( ItemID: string ): boolean;
var
  qry: TFDQuery;
begin
  Result := False;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := fConnection;
    qry.SQL.Text := 'select '+KeyField+' from '+TableName+' where '+KeyField+'=:KeyField;';
    qry.Params.ParamByName('KeyField').AsString:=ItemID;
    qry.Active := True;
    if (qry.Active) and (qry.RowsAffected>0) then begin
      Result := True;
    end;
  finally
    qry.DisposeOf;
  end;
end;

procedure TRESTCollection.ProcessRequest(PathInfo: TPathInfo; Request: TWebRequest; Response: TWebResponse);
var
  Method: TMethodType;
  Filters: IRESTFilterGroup;
  RESTResponse: IRESTResponse;
  RESTRequest: IRESTArray;
begin
  //- Create request to retrieve request body.
  RESTRequest := TRESTArray.Create;

  //- Create a response to handle the results.
  RESTResponse := TRESTResponse.Create;

  //- Determine the HTTP method.
  Method := Request.MethodType;
  case Method of
    mtAny,
    mtHead,
    mtPatch: begin
      exit;
    end;
  end;

  //- Deserialize request.
  case Method of
    mtPut,
    mtPost: RESTRequest.Deserialize(Request.Content);
  end;

  //- There should be no filters.
  if PathInfo.Item<>'' then begin
    if PathInfo.Filters<>'' then begin
      RESTResponse.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
      RESTResponse.ResponseMessage := 'Specify item by ID and use of Filters are mutually exclusive.';
      SendResponse( Response, RESTResponse );
      exit;
    end;
  end;

  //- Parse filters.
  if PathInfo.Item='' then begin
    case Method of
      mtGet,
      mtPut,
      mtDelete: begin
        Filters := ParseFilters( Request.Query );
        if not assigned(Filters) then begin
          RESTResponse.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
          RESTResponse.ResponseMessage := 'Invalid Filters';
          SendResponse( Response, RESTResponse );
          exit;
        end;
      end;
    end;
  end else begin
    Filters := TRestFilterGroup.Create;
    Filters.AddFilter(KeyField,TConstraint.csEqual,PathInfo.Item);
  end;

  //- Run before event.
  case Method of
    mtGet: begin
      if assigned(fOnBeforeRESTRead) then begin
        fOnBeforeRESTRead(Filters, RESTResponse);
      end;
    end;
    mtPut: begin
      if assigned(fOnBeforeRESTUpdate) then begin
        fOnBeforeRESTUpdate(RESTRequest, Filters, RESTResponse);
      end;
    end;
    mtPost: begin
      if assigned(fOnBeforeRESTCreate) then begin
        fOnBeforeRESTCreate(RESTRequest, RESTResponse);
      end;
    end;
    mtDelete: begin
      if assigned(fOnBeforeRESTDelete) then begin
        fOnBeforeRESTDelete(Filters, RESTResponse);
      end;
    end;
  end;

  //- If not processed, process the event.
  if not RESTResponse.Complete then begin
    case Method of
      mtGet: ProcessRead( Filters, RESTResponse );
      mtPut: begin
        if PathInfo.Item<>'' then begin
          if ItemExists(PathInfo.Item) then begin
            ProcessUpdate( RESTRequest, Filters, RESTResponse );
          end else begin
            ProcessCreate( RESTRequest, RESTResponse, PathInfo.Item );
          end;
        end else begin
          ProcessUpdate( RESTRequest, Filters, RESTResponse );
        end;
      end;
      mtPost: begin
        if PathInfo.Item<>'' then begin
          ProcessCreate( RESTRequest, RESTResponse, PathInfo.Item );
        end else begin
          ProcessCreate( RESTRequest, RESTResponse );
        end;
      end;
      mtDelete: ProcessDelete( Filters, RESTResponse );
    end;
  end;

  //- If we've not processed by this point, there's a problem, send the response
  //- and bail out.
  if not RESTResponse.Complete then begin
    RESTResponse.ResponseCode := THTTPResponseCode.rc500_InternalServerError;
    RESTResponse.ResponseMessage := 'Request not processed.';
    SendResponse( Response, RESTResponse );
    exit;
  end;

  //- If we got here, we need to execute the after event.
  case Method of
    mtGet: begin
      if assigned(fOnAfterRESTRead) then begin
        fOnAfterRESTRead(Filters,RESTResponse);
      end;
    end;
    mtPut: begin
      if assigned(fOnAfterRESTUpdate) then begin
        fOnAfterRESTUpdate(RESTRequest,Filters,RESTResponse);
      end;
    end;
    mtPost: begin
      if assigned(fOnAfterRESTCreate) then begin
        fOnAfterRESTCreate(RESTRequest,RESTResponse);
      end;
    end;
    mtDelete: begin
      if assigned(fOnAfterRESTDelete) then begin
        fOnAfterRESTDelete(Filters,RESTResponse);
      end;
    end;
  end;

  //- Send the response.
  SendResponse( Response, RESTResponse );
end;

procedure TRESTCollection.ProcessCreate( Request: IRESTArray; Response: IRESTResponse );
var
  idx,idy: uint32;
  AnObject: IRESTObject;
  qry: TFDQuery;
begin
  //- If there are no items to create, we return successful creation of zero objects..
  if Request.Count=0 then begin
    Response.ResponseCode := THTTPResponseCode.rc200_OK;
    exit;
  end;

  //- Do we have a valid database connection?
  if not VerifyDatabase( Response ) then begin
    exit;
  end;

  //- Do we have a valid table name?
  if not VerifyTable( Response ) then begin
    exit;
  end;

  //- Create a query.
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := fConnection;

    //- Loop through each item in the request in order to create it.
    Response.ResponseCode := THTTPResponseCode.rc201_Created; //- Assume all objects are created, unless they arent (switch to 202_accepted)
    for idx := 0 to pred(Request.Count) do begin
      if Request.Items[idx].Count>0 then begin
        //- Start a new sql string for each object.
        qry.SQL.Text := 'insert into '+fTableName+'(';
        //- Loop through fields and add their names to the query string.
        for idy := 0 to pred(Request.Items[idx].Count) do begin
          qry.SQL.Text := qry.SQL.Text + Request.Items[idx].Name[idy];
          if idy<pred(Request.Items[idx].Count) then begin
            qry.SQL.Text := qry.SQL.Text + ', ';
          end;
        end;
        //- Values as parameters.
        qry.SQL.Text := qry.SQL.Text + ') VALUES (';
        //- Loop through the fields again and add them as parameters to the query string.
        for idy := 0 to pred(Request.Items[idx].Count) do begin
          qry.SQL.Text := qry.SQL.Text + ':' + Request.Items[idx].Name[idy];
          if idy<pred(Request.Items[idx].Count) then begin
            qry.SQL.Text := qry.SQL.Text + ', ';
          end;
        end;
        qry.SQL.Text := qry.SQL.Text + ');';
        //- Loop through one more time, and set the parameter values.
        for idy := 0 to pred(Request.Items[idx].Count) do begin
          qry.Params.ParamByName(Request.Items[idx].Name[idy]).AsString := Request.Items[idx].ValueByIndex[idy];
        end;
        //- Attempt to execute the query, if successful, add the created object.
        if ExecuteSQL(qry) then begin
          AnObject := Response.ResponseArray.addItem;
          AnObject.Assign(Request.Items[idx]);
        end else begin
          Response.ResponseCode := THTTPResponseCode.rc202_Accepted;
        end;
      end;
    end;

  finally
    qry.DisposeOf;
  end;
  Response.ResponseCode := THTTPResponseCode.rc200_OK;
  Response.Complete := True;
end;

function TRESTCollection.ModifyDBObject( qry: TFDQuery; Request: IRESTArray ): boolean;
var
  idx: uint32;
begin
  Result := False;
  //- Only one object may be used to update records.
  if Request.Count=0 then begin
    exit;
  end;
  if Request.Count>1 then begin
    exit;
  end;
  //- There must be at least one field to modify.
  if Request.Items[0].Count=0 then begin
    exit;
  end;
  //- Loop through the fields of the object and make the changes.
  qry.Edit;
  try
    for idx := 0 to pred(request.Items[0].Count) do begin
      if not assigned(qry.FieldByName(request.Items[0].Name[idx])) then begin
        exit;
      end;
      qry.FieldByName(request.Items[0].Name[idx]).AsString := request.Items[0].ValueByIndex[idx];
    end;
  finally
    qry.Post;
  end;
  Result := True;
end;

procedure TRESTCollection.ProcessUpdate( Request: IRESTArray; Filters: IRESTFilterGroup; Response: IRESTResponse );
var
  qry: TFDQuery;
begin
  //- Do we have a valid database connection?
  if not VerifyDatabase( Response ) then begin
    exit;
  end;

  //- Do we have a valid table name?
  if not VerifyTable( Response ) then begin
    exit;
  end;

  //- Create a query.
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := fConnection;

    //- Set SQL.
    qry.SQL.Text := 'select * from '+TableName;
    if not ApplyWhereClause( qry, Filters, Response ) then begin
      exit;
    end;

    //- Execute the query.
    if not ExecuteQuery(qry,Response) then begin
      exit;
    end;

    //- Now begin returning the rows of data.
    if qry.RowsAffected>0 then begin
      qry.First;
      while not qry.EOF do begin
        if not ModifyDBObject( qry, Request ) then begin
          Response.ResponseCode := THTTPResponseCode.rc400_BadRequest;
          Response.ResponseMessage := 'Unable to alter record.';
          exit;
        end;
        if not DBObjectToResponse( qry, Response ) then begin
          Response.ResponseCode := THTTPResponseCode.rc400_BadRequest;
          Response.ResponseMessage := 'Unable to serialize object.';
          exit;
        end;
        qry.Next;
      end;
    end;

  finally
    qry.DisposeOf;
  end;
  Response.ResponseCode := THTTPResponseCode.rc200_OK;
  Response.Complete := True;
end;

procedure TRESTCollection.ProcessCreate(Request: IRESTArray; Response: IRESTResponse; Item: string);
var
  idy: uint32;
  AnObject: IRESTObject;
  qry: TFDQuery;
begin
  //- Do we have a valid database connection?
  if not VerifyDatabase( Response ) then begin
    exit;
  end;

  //- Do we have a valid table name?
  if not VerifyTable( Response ) then begin
    exit;
  end;

  //- If there is more than one item specified, we can't proceed.
  if Request.Count>1 then begin
    Response.ResponseCode := THTTPResponseCode.rc400_BadRequest;
    Response.ResponseMessage := 'Can''t create '+IntToStr(Request.Count)+' objects with a single key.';
    exit;
  end;

  //- Create a query.
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := fConnection;

    //- Loop through each item in the request in order to create it.
    Response.ResponseCode := THTTPResponseCode.rc201_Created; //- Assume all objects are created, unless they arent (switch to 202_accepted)

    if (Request.Count>0) and (Request.Items[0].Count>0) then begin
      //- Start a new sql string for each object.
      qry.SQL.Text := 'insert into '+fTableName+'('+KeyField+',';
      //- Loop through fields and add their names to the query string.
      for idy := 0 to pred(Request.Items[0].Count) do begin
        qry.SQL.Text := qry.SQL.Text + Request.Items[0].Name[idy];
        if idy<pred(Request.Items[0].Count) then begin
          qry.SQL.Text := qry.SQL.Text + ', ';
        end;
      end;
      //- Values as parameters.
      qry.SQL.Text := qry.SQL.Text + ') VALUES (:KeyField,';
      //- Loop through the fields again and add them as parameters to the query string.
      for idy := 0 to pred(Request.Items[0].Count) do begin
        qry.SQL.Text := qry.SQL.Text + ':' + Request.Items[0].Name[idy];
        if idy<pred(Request.Items[0].Count) then begin
          qry.SQL.Text := qry.SQL.Text + ', ';
        end;
      end;
      qry.SQL.Text := qry.SQL.Text + ');';
      //- Loop through one more time, and set the parameter values.
      qry.Params.ParamByName('KeyField').AsString := Item;
      for idy := 0 to pred(Request.Items[0].Count) do begin
        qry.Params.ParamByName(Request.Items[0].Name[idy]).AsString := Request.Items[0].ValueByIndex[idy];
      end;
      //- Attempt to execute the query, if successful, add the created object.
      if ExecuteSQL(qry) then begin
        AnObject := Response.ResponseArray.addItem;
        AnObject.Assign(Request.Items[0]);
      end else begin
        Response.ResponseCode := THTTPResponseCode.rc202_Accepted;
      end;
    end else begin
      //- Start a new sql string for each object.
      qry.SQL.Text := 'insert into '+fTableName+'('+KeyField+') VALUES (:KeyField);';
      qry.Params.ParamByName('KeyField').AsString := Item;
      //- Attempt to execute the query, if successful, add the created object.
      if ExecuteSQL(qry) then begin
        AnObject := Response.ResponseArray.addItem;
        AnObject.AddValue(KeyField,Item);
      end else begin
        Response.ResponseCode := THTTPResponseCode.rc202_Accepted;
      end;
    end;

  finally
    qry.DisposeOf;
  end;
  Response.ResponseCode := THTTPResponseCode.rc200_OK;
  Response.Complete := True;
end;


procedure TRESTCollection.ProcessDelete( Filters: IRESTFilterGroup; Response: IRESTResponse );
var
  qry: TFDQuery;
begin
  //- Do we have a valid database connection?
  if not VerifyDatabase( Response ) then begin
    exit;
  end;

  //- Do we have a valid table name?
  if not VerifyTable( Response ) then begin
    exit;
  end;

  //- Create a query.
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := fConnection;

    //- Set SQL.
    qry.SQL.Text := 'select * from '+fTableName;
    if not ApplyWhereClause( qry, Filters, Response ) then begin
      exit;
    end;

    //- Execute the query.
    if not ExecuteQuery(qry,Response) then begin
      exit;
    end;

    //- Now begin returning the rows of data.
    if qry.RowsAffected>0 then begin
      qry.First;
      while not qry.EOF do begin
        if not DBObjectToResponse( qry, Response ) then begin
          Response.ResponseCode := THTTPResponseCode.rc400_BadRequest;
          Response.ResponseMessage := 'Unable to serialize object.';
          exit;
        end;
        qry.Next;
      end;
    end;

    //- Now we can delete the objects.
    qry.SQL.Text := 'delete from '+fTableName;
    if not ApplyWhereClause(qry, Filters, Response) then begin
      exit;
    end;
    //- Execute the query.
    if not ExecuteSQL(qry) then begin
      exit;
    end;

  finally
    qry.DisposeOf;
  end;
  Response.ResponseCode := THTTPResponseCode.rc200_OK;
  Response.Complete := True;
end;

procedure TRESTCollection.SendResponse( Response: TWebResponse; RESTResponse: IRESTResponse );
var
  Str: string;
begin
  Str := '';
  Response.StatusCode := int32(RESTResponse.ResponseCode);
  if (Response.StatusCode>199) and (Response.StatusCode<300) then begin
    if RESTResponse.ResponseArray.Serialize(Str) then begin
      Response.ContentType := 'application\json; charset="UTF-8"';
      Response.Content := Str;
    end else begin
      Response.StatusCode := integer(THTTPResponseCode.rc500_InternalServerError);
      Response.ContentType := 'text\plain; charset="UTF-8"';
      Response.Content := 'Failed to serialize response JSON.';
    end;
  end else begin
    Response.ContentType := 'text\plain; charset="UTF-8"';
    Response.Content := RESTResponse.ResponseMessage;
  end;
  Response.SendResponse;
end;

procedure TRESTCollection.setConnection(const Value: TFDConnection);
begin
  fConnection := Value;
end;

procedure TRESTCollection.setEndpoint(const Value: string);
begin
  fEndpoint := Value;
end;

procedure TRESTCollection.setKeyField(const Value: string);
begin
  fKeyField := Value;
end;

procedure TRESTCollection.setTableName(const Value: string);
begin
  fTableName := Value;
end;

{ TRESTCollections }

constructor TRESTCollections.Create(aOwner: TComponent);
begin
  inherited Create(aOwner,TRESTCollection);
end;

function TRESTCollections.GetItem(idx: integer): TRESTCollection;
begin
  Result := TRESTCollection(inherited GetItem(idx));
end;

procedure TRESTCollections.setItem(idx: integer; const Value: TRESTCollection);
begin
  inherited SetItem(idx,value);
end;


end.
