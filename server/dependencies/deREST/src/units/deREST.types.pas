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
unit deREST.types;

interface

type
  IRESTObject = interface
    ['{01E34F62-FCD3-4333-B224-76AEEE96D59F}']
    procedure Assign( SourceObject: IRESTObject );
    function getCount: uint32;
    function getNameByIndex( idx: uint32 ): string;
    function getValueByIndex( idx: uint32 ): string;
    function getValueByName( aname: string ): string;
    procedure setNameByIndex( idx: uint32; aname: string );
    procedure setValueByIndex( idx: uint32; avalue: string );
    procedure setValueByName( aname: string; avalue: string );
    procedure AddValue( aname: string; avalue: string );
    procedure RemoveValue( aname: string ); overload;
    procedure RemoveValue( idx: uint32 ); overload;

    //- Pascal Only, properties -//
    property Count: uint32 read getCount;
    property Name[ idx: uint32 ]: string read getNameByIndex write setNameByIndex;
    property Value[ name: string ]: string read getValueByName write setValueByName;
    property ValueByIndex[ idx: uint32 ]: string read getValueByIndex write setValueByIndex;
  end;

type
  ///  <summary>
  ///    Describes the type of constraint applied to the filter.
  ///    For example, opGreaterThan means that the value of items selected
  ///    by the filter, should be greater than the value of the filter it's
  ///    self.
  ///  </summary>
  TConstraint = (
    csUnknown,
    csGreaterThan,
    csLessThan,
    csGreaterOrEqual,
    csLessOrEqual,
    csEqual,
    csNotEqual,
    csLike
  );

  ///  <summary>
  ///    Defines the logical operation used to combine the children of an
  ///    IRESTFilteGroup (group of filters).
  ///  </summary>
  TGroupOperator = (
    opGroup,
    opAND,
    opOR
  );

  ///  <summary>
  ///    HTTP Response codes
  ///  </summary>
  THTTPResponseCode =
    (

      rc100_Continue = 100,
      rc101_witchingProtocols = 101,
      rc102_Processing = 102,
      rc103_EarlyHints = 103,
      rc200_OK = 200,
      rc201_Created = 201,
      rc202_Accepted = 202,
      rc203_NonAuthInfo = 203,
      rc204_NoContent = 204,
      rc205_ResetContent = 205,
      rc206_PartialContent = 206,
      rc207_MultiStatus = 207,
      rc208_AlreadyReported = 208,
      rc226_IMUsed = 226,
      rc300_MultipleChoices = 300,
      rc301_MovedPermanently = 301,
      rc302_Found = 302,
      rc303_SeeOther = 303,
      rc304_NotModified = 304,
      rc305_UseProxy = 305,
      rc306_SwitchProxy = 306,
      rc307_TemporaryRedirect = 307,
      rc308_PermanentRedirect = 308,
      rc400_BadRequest = 400,
      rc401_Unauthorized = 401,
      rc402_PaymentRequired = 402,
      rc403_Forbidden = 403,
      rc404_NotFound = 404,
      rc405_MethodNotAllowed = 405,
      rc406_NotAcceptable = 406,
      rc407_ProxyAuthRequired = 407,
      rc408_RequestTimeout = 408,
      rc409_Conflict = 409,
      rc410_Gone = 410,
      rc411_LengthRequired = 411,
      rc412_PreconditionFailed = 412,
      rc413_PayloadTooLarge = 413,
      rc414_URITooLong = 414,
      rc415_UnsupportedMediaType = 415,
      rc416_RangeNotSatisfiable = 416,
      rc417_ExpectationFailed = 417,
      rc418_Teapot = 418,
      rc421_MisdirectedRequest = 421,
      rc422_UnprocessableEntity = 422,
      rc423_Locked = 423,
      rc424_FailedDependency = 424,
      rc426_UpgradeRequired = 426,
      rc428_PreconditionRequired = 428,
      rc429_TooManyRequests = 429,
      rc431_RequestHeaderFieldsTooLarge = 431,
      rc451_UnavailableForLegalReasons  = 451,
      rc500_InternalServerError = 500,
      rc501_NotImplemented = 501,
      rc502_BadGateway = 502,
      rc503_ServiceUnavailable = 503,
      rc504_GatewayTimeout = 504,
      rc505_HTTPVersionNotSupported = 505,
      rc506_VariantAlsoNegotiates = 506,
      rc507_InsufficientStorage = 507,
      rc508_LoopDetected = 508,
      rc510_NotExtended = 510,
      rc511_NetworkAuthRequired = 511

    );

  /// <exclude/>
  IRESTFilter = interface; // forward declaration.

  /// <exclude/>
  IRESTFilterGroup = interface; // forward declaration.

  /// <exclude/>
  IRESTResponse = interface; // forward declaration.

  /// <exclude/>
  IRESTArray = interface; // forward declaration.

  ///  <summary>
  ///    Callback type for events fired before and after a CREATE event.
  ///  </summary>
  TRESTCreateEvent = procedure( Request: IRESTArray; Response: IRESTResponse ) of object;

  ///  <summary>
  ///    Event called before and after a READ event
  ///  </summary>
  TRESTReadEvent = procedure( RequestFilters: IRESTFilterGroup; Response: IRESTResponse ) of object;

  ///  <summary>
  ///    Event called before and after an UPDATE event.
  ///  </summary>
  TRESTUpdateEvent = procedure( Request: IRESTArray; RequestFilters: IRESTFilterGroup; Response: IRESTResponse ) of object;

  ///  <summary>
  ///    Event called before and after a DELETE event.
  ///  </summary>
  TRESTDeleteEvent = procedure( RequestFilters: IRESTFilterGroup; Response: IRESTResponse ) of object;


  ///  <summary>
  ///    IRESTFilterItem is a common base interface for IRESTFilter and
  ///    IRESTFilterGroup. It's only use is to provide a consistent type
  ///    for handling filters and groups as children of other groups.
  ///    You should not need to work with this interface directly.
  ///  </summary>
  IRESTFilterItem = interface

    ///  <summary>
    ///    Searches the filters by their parameter names and returns
    ///    the the filter.
    ///  </summary>
    function ParamValue( ParamName: string ): IRestFilterItem;

    ///  <summary>
    ///    Returns the filter, or group of filters as a string.
    ///    The returned string should match the input string.
    ///  </summary>
    function ToWhereClause: string;

    ///  <summary>
    ///    Assigns a unique parameter name to each filter item so that
    ///    the parameter values may be applied to a query string.
    ///  </summary>
    procedure AssignParameterNames( var counter: uint32 );

    ///  <summary>
    ///    Returns this item cast as an IRESTFilter.
    ///    If the item implements only IRESTFilterGroup this method will
    ///    return nil.
    ///  </summary>
    function AsFilter: IRESTFilter;

    ///  <summary>
    ///    Returns this item cast as an IRESTFilterGroup.
    ///    If the item implements only IRESTFilter, this method will return
    ///    nil.
    ///  </summary>
    function ASGroup: IRESTFilterGroup;

    ///  <summary>
    ///    Returns true if this item implements IRESTFilter.
    ///  </summary>
    function IsFilter: boolean;

    ///  <summary>
    ///    Returns true if this item implements IRESTFilterGroup.
    ///  </summary>
    function IsGroup: boolean;
  end;

  ///  <summary>
  ///    Represents a selection filter with an identifier (field name), a
  ///    value, and a constraint.
  ///  </summary>
  IRESTFilter = interface( IRESTFilterItem )
    ['{C0F63FF2-F3A3-4672-B110-35280A488C4E}']

    ///  <summary>
    ///    Returns the identifier of the field that this filter applies to.
    ///  </summary>
    function getIdentifier: string;

    ///  <summary>
    ///    Sets the identifier of the field that this filter applies to.
    ///  </summary>
    procedure setIdentifier( value: string );

    ///  <summary>
    ///    Gets the constraint applied by this filter.
    ///  </summary>
    function getConstraint: TConstraint;

    ///  <summary>
    ///    Sets the constraint applied by this filter.
    ///  </summary>
    procedure setConstraint( value: TConstraint );

    ///  <summary>
    ///    Gets the value of this filter as a string.
    ///  </summary>
    function getValueAsString: string;

    ///  <summary>
    ///    Sets the value of this filter as a string.
    ///  </summary>
    procedure setValueAsString( value: string );

    ///  <summary>
    ///    Gets the value of this filter as an integer (int32).
    ///  </summary>
    function getValueAsInteger: int32;

    ///  <summary>
    ///    Sets the value of this filter as an integer (int32).
    ///  </summary>
    procedure setValueAsInteger( value: int32 );

    ///  <summary>
    ///    Gets the value of this filter as a float (double).
    ///  </summary>
    function getValueAsFloat: double;

    ///  <summary>
    ///    Sets the value of this filter as a float (double).
    ///  </summary>
    procedure setValueAsFloat( value: double );

    ///  <summary>
    ///    Gets the value of this filter as a boolean.
    ///  </summary>
    function getValueAsBoolean: boolean;

    ///  <summary>
    ///    Sets the value of this filter as a boolean.
    ///  </summary>
    procedure setValueAsBoolean( value: boolean );

    ///  <summary>
    ///    Gets the value of this filter as a TDateTime.
    ///  </summary>
    function getValueAsDateTime: TDateTime;

    ///  <summary>
    ///    Sets the value of this filter as a TDateTime.
    ///  </summary>
    procedure setValueAsDateTime( value: TDateTime );

    //- Pascal Only, properties -//

    ///  <summary>
    ///    Get or Set the identifier of the field that this filter applies to.
    ///  </summary>
    property Identifier: string read getIdentifier write setIdentifier;

    ///  <summary>
    ///    Get or Set the constraint applied by this filter.
    ///  </summary>
    property Constraint: TConstraint read getConstraint write setConstraint;

    ///  <summary>
    ///    Get or Set the value of this filter as a string.
    ///  </summary>
    property AsString: string read getValueAsString write setValueAsString;

    ///  <summary>
    ///    Get or Set the value of this filter as an integer (int32).
    ///  </summary>
    property AsInteger: int32 read getValueAsInteger write setValueAsInteger;

    ///  <summary>
    ///    Get or Set the value of this filter as a float (double).
    ///  </summary>
    property AsFloat: double read getValueAsFloat write setValueAsFloat;

    ///  <summary>
    ///    Get or Set the value of this filter as a boolean.
    ///  </summary>
    property AsBoolean: boolean read getValueAsBoolean write setValueAsBoolean;

    ///  <summary>
    ///    Get or Set the value of this filter as a TDateTime.
    ///  </summary>
    property AsDateTime: TDateTime read getValueAsDateTime write setValueAsDateTime;
  end;

  ///  <summary>
  ///    Represents a group of filters and a logical operator which binds them.
  ///    For example, the logical operator may be opAND meaning the child
  ///    filters of this group must be appllied using an AND operation.
  ///  </summary>
  IRESTFilterGroup = interface( IRESTFilterItem )
    ['{549F2AFC-E753-4165-ABA9-9E031A287224}']

    ///  <summary>
    ///    Returns the number of child items contained by this group.
    ///  </summary>
    function getCount: uint32;

    ///  <summary>
    ///    Returns a child item of this group as specified by index.
    ///  </summary>
    function getItem( Index: uint32 ): IRESTFilterItem;

    ///  <summary>
    ///    Returns the group operator used to logically combine the group
    ///    of filters.
    ///  </summary>
    function getGroupOperator: TGroupOperator;

    ///  <summary>
    ///    Sets the group operator used to logically combine the group of
    ///    filters.
    ///  </summary>
    procedure setGroupOperator( value: TGroupOperator );

    ///  <summary>
    ///    Adds a new filter to this group. (as a child)
    ///  </summary>
    function AddFilter( Identifier: string; Constraint: TConstraint; Value: string ): IRESTFilter;

    ///  <summary>
    ///    Adds a new group of filters as a child.
    ///  </summary>
    function AddGroup( GroupOperator: TGroupOperator ): IRESTFilterGroup;

    ///  <summary>
    ///    Adds either a group or filter.
    ///  </summary>
    function AddItem( Item: IRESTFilterItem ): IRestFilterItem;

    //- Pascal Only, properties -//
    property Count: uint32 read getCount;
    property Items[ index: uint32 ]: IRESTFilterItem read getItem;
    property GroupOperator: TGroupOperator read getGroupOperator write setGroupOperator;
  end;

  ///  <summary>
  ///    Represents an array of objects (IRESTObject).
  ///  </summary>
  IRESTArray = interface
    ['{AB9B8FEF-6C6E-468C-A4DC-E9303309450F}']

    ///  <summary>
    ///    Returns the number of objects in this collection.
    ///  </summary>
    function getCount: uint32;

    ///  <summary>
    ///    Gets an object from the collection as specified by index.
    ///  </summary>
    function getItem( idx: uint32 ): IRESTObject;

    ///  <summary>
    ///    Adds an object to this collection and returns a reference to it.
    ///  </summary>
    function addItem: IRESTObject;

    ///  <summary>
    ///    Removes an object from this collection as specified by index.
    ///  </summary>
    procedure RemoveItem( idx: uint32 ); overload;

    ///  <summary>
    ///    Removes an object from this collection as specified by reference.
    ///  </summary>
    procedure RemoveItem( aRestObject: IRESTObject ); overload;

    ///  <summary>
    ///    Deserializes this collection from a JSON string.
    ///  </summary>
    function Deserialize( JSONString: string ): boolean;

    ///  <summary>
    ///    Serializes this collection to a JSON string.
    ///  </summary>
    function Serialize( var JSONString: string ): boolean;

    //- Pascal Onky, properties -//

    ///  <summary>
    ///    Returns the number of objects in this collection.
    ///  </summary>
    property Count: uint32 read getCount;

    ///  <summary>
    ///    Array style access to the objects in this collection.
    ///  </summary>
    property Items[ idx: uint32 ]: IRESTObject read getItem;
  end;

  ///  <summary>
  ///    Contains the response to be returned from a REST API call.
  ///    When the response code is 200-299 the response collection is returned
  ///    in the body of the response. When any other response code is used, the
  ///    ResponseMessage will be returned.
  ///  </summary>
  IRESTResponse = interface
    ['{A437EAA6-C487-4BE7-8C62-1477731F7BCD}']

    ///  <summary>
    ///    Returns true if the request is completed, and ready to be sent
    ///    back to the client. Else returns false.
    ///  </summary>
    function getComplete: boolean;

    ///  <summary>
    ///    Sets the completion status of the REST response. When set TRUE the
    ///    response is ready to be sent back to the client.
    ///  </summary>
    procedure setComplete( value: boolean );

    ///  <summary>
    ///    An array of REST objects to be returned as JSON within the
    ///    body of the HTTP response.
    ///  </summary>
    function getResponseArray: IRESTArray;

    ///  <summary>
    ///    Returns the response code which will be sent from this REST response
    ///    in the HTTP response.
    ///  </summary>
    function getResponseCode: THTTPResponseCode;

    ///  <summary>
    ///    Sets the response code which will be sent from this REST response in
    ///    the HTTP response.
    ///  </summary>
    procedure setResponseCode( Code: THTTPResponseCode );

    ///  <summary>
    ///    Gets the response message which will be returned from this REST
    ///    response in the body of the HTTP response, when an error return
    ///    code is set.
    ///  </summary>
    function getResponseMessage: string;

    ///  <summary>
    ///    Sets the response message which will be returned from this REST
    ///    response in the body of the HTTP response, when an error return
    ///    code is set.
    ///  </summary>
    procedure setResponseMessage( value: string );

    //- Pascal Only, properties -//

    ///  <summary>
    ///    Get/Set the response code for the HTTP response. When this is set
    ///    between 200-299, the ResponseCollection property is returned as the
    ///    body of the HTTP response. Any other response value causes the
    ///    ResponseMessage to be sent in the body of the HTTP response.
    ///  </summary>
    property ResponseCode: THTTPResponseCode read getResponseCode write setResponseCode;

    ///  <summary>
    ///    Get or Set the response message to be sent in the body of the HTTP
    ///    response when the response code is not between 200-299.
    ///  </summary>
    property ResponseMessage: string read getResponseMessage write setResponseMessage;

    ///  <summary>
    ///    Get the response array which will be sent in the body of the
    ///    HTTP response as JSON text when the response code is between 200-299.
    ///  </summary>
    property ResponseArray: IRESTArray read getResponseArray;

    ///
    ///  <summary>
    ///    Get/Set completion status of request.
    ///    Complete may be set to true during an OnBeforeREST event handler,
    ///    to prevent the request from being processed further. The OnAfterREST
    ///    event handler for the request will still be called.
    ///  </summary>
    property Complete: boolean read getComplete write setComplete;
  end;


implementation

end.
