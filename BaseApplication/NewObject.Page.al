page 50001 "New Customer Card"
{
    Caption = 'New Customer Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Prices & Discounts,Navigate,Customer';
    RefreshOnActivate = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {

                }

                field("Full Name"; "Full Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the full name of the customer.';
                }
            }
        }
    }
}