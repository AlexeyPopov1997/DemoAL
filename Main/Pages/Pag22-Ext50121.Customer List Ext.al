pageextension 50121 "Customer List Ext" extends "Customer List"
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