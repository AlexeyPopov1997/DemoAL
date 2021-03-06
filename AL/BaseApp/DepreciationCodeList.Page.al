page 12485 "Depreciation Code List"
{
    Caption = 'Depreciation Code List';
    Editable = false;
    PageType = List;
    SourceTable = "Depreciation Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the unique identification code for this depreciation code.';
                }
                field(Name; Name)
                {
                    ApplicationArea = FixedAssets;
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ToolTip = 'Specifies the name of the depreciation code.';
                }
                field("Depreciation Group"; "Depreciation Group")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the code for the depreciation group to apply to this code.';
                }
                field("Service Life"; "Service Life")
                {
                    ApplicationArea = FixedAssets;
                    ToolTip = 'Specifies the projected service life for this fixed asset for use in calculating depreciation.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        NameIndent := 0;
        NameOnFormat;
    end;

    var
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;

    local procedure NameOnFormat()
    begin
        NameIndent := Indentation * 440;
        if "Code Type" = "Code Type"::Header then
            NameEmphasize := true;
    end;
}

