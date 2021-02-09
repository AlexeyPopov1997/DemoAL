tableextension 50120 "Customer Blocks" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50120; "Blocked EXT"; Boolean)
        {
            Editable = false;
            CaptionML = ENU = 'Customer Blocked',
                        RUS = 'Клиент заблокирован Привет';

            DataClassification = CustomerContent;
        }
    }
}