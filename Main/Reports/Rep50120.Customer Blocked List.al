report 50120 "Blocked Customer List"


{
    CaptionML = ENU = 'Blocked Customer List',
                RUS = 'Список заблокированных клиентов';
    RDLCLayout = 'Layouts/Rep50120.rdl';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Blocked EXT" = const(true));
            column(No_; "No.")
            {

            }
            column(Name; Name)
            {

            }
        }
    }
}