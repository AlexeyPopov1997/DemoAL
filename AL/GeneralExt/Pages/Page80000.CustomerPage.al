pageextension 80000 "Customer Page" extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Blocked EXT"; Rec."Blocked EXT")
            {

            }
        }
    }
}