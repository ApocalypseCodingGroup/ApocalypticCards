unit ViewModel.Standard;

interface
uses
  ViewModel
;

type
  TViewModel = record
    class function Create: IViewModel; static;
  end;

implementation
uses
  DataModel.Standard
, ViewModel.ViewModel.Standard
;

class function TViewModel.Create: IViewModel;
begin
  Result := nil;
  Result := ViewModel.ViewModel.Standard.TViewModel.Create( TDataModel.Create );
end;


end.
