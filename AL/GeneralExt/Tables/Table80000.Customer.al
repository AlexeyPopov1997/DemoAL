tableextension 80000 "Customer" extends Customer
{
    Caption = 'Привет';
    fields
    {
        field(50000; "Blocked EXT"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}