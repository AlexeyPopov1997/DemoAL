tableextension 80000 "Customer" extends Customer
{
    fields
    {
        field(50000; "Blocked EXT"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}