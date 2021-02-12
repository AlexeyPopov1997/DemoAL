tableextension 18 "Customer Blocks" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Blocked EXT"; Boolean)
        {
            Editable = true;
            CaptionML = ENU = 'Customer Blocked',
                        RUS = 'Клиент заблокирован';

            DataClassification = CustomerContent;
        }
        field(50001; "Bloc"; Boolean)
        {
            Editable = true;
            CaptionML = ENU = 'Customer Blocked',
                        RUS = 'Клиент заблокирован апрапоапо';

            DataClassification = CustomerContent;
        }
    }
}