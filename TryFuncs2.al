codeunit 70302 "Try Function Example 2"
{
    [TryFunction]
    [ErrorBehavior(ErrorBehavior::Collect)]
    procedure TryGetMasterData(Cust: Text[20]; Vend: Text[20])
    begin
        TryGetCustomer(Cust);
        TryGetVendor(Vend);
        if HasCollectedErrors then
            Error('Error in TryGetMasterData');
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure TryGetCustomer(Cust: Text[20])
    var
        Customer: Record Customer;
    begin
        if not Customer.Get(Cust) then begin
            Error(ErrorInfo.Create(StrSubstNo('Failed to retrieve customer %1', Cust),
                                    true,
                                    Customer, Customer.FieldNo("No.")
                            ));
        end;
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure TryGetVendor(Vend: Text[20])
    var
        Vendor: Record Vendor;
    begin
        if not Vendor.Get(Vend) then
            Error(ErrorInfo.Create(StrSubstNo('Failed to retrieve vendor %1', Vend),
                                    true,
                                    Vendor, Vendor.FieldNo("No.")
                            ));
    end;
}