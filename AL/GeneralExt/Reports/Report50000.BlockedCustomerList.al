report 50000 "Blocked Customer List"
{
    CaptionML = ENU = 'Blocked Customer List',
                RUS = 'Список заблокированных клиентов изменение';
    RDLCLayout = 'Layouts/Layout50000.BlockedCustomerList.rdl';
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
