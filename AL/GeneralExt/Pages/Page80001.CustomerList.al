pageextension 80001 "Customer List" extends "Customer List"
{
    actions
    {
        // Add changes to page actions here
        addlast(reporting)
        {
            action(ShowCustList)
            {
                Image = CustomerLedger;
                CaptionML = ENU = 'Blocked Customer List',
                            RUS = 'Список заблокированных клиентов';
                trigger OnAction()
                begin
                    report.RunModal(report::"Blocked Customer List");
                end;
            }
        }
    }
}
