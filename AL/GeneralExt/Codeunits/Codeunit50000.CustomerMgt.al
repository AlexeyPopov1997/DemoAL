codeunit 50000 "Customer Mgt"
{
    trigger OnRun();
    begin

    end;

    [EventSubscriber(ObjectType::Table, database::Customer, 'OnAfterValidateEvent', 'Name', true, true)]
    local procedure ChangeName(var Rec: Record Customer);
    begin
        Rec.Validate("Blocked EXT", StrPos(Rec.Name, 'block') > 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(VAR SalesHeader: Record "Sales Header");
    var
        cust: Record Customer;
    begin
        cust.get(SalesHeader."Sell-to Customer No.");
        cust.TestField("Blocked EXT", false);
    end;
}