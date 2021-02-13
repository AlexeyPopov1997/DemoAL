tableextension 80000 "Customer" extends Customer
{
    fields
    {
        field(50000; "Blocked EXT"; Boolean)
        {
            CaptionML = ENU = 'Customer Blocked',
                        RUS = 'Клиент заблокирован';

            DataClassification = CustomerContent;
        }
    }
}