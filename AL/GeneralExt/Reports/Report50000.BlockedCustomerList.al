report 50000 "Blocked Customer List"
{
    CaptionML = ENU = 'Blocked Customer List',
<<<<<<< HEAD
                RUS = 'Список заблокированных клиентов <изменение 5>';
=======
                RUS = 'Список заблокированных клиентов <изменение 4>';
>>>>>>> d16fdef24db969983504182ba7c194040873e6b3
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
