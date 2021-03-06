table 12400 "G/L Correspondence"
{
    Caption = 'G/L Correspondence';

    fields
    {
        field(1; "Debit Account No."; Code[20])
        {
            Caption = 'Debit Account No.';
            TableRelation = "G/L Account";
        }
        field(2; "Debit Account Name"; Text[100])
        {
            CalcFormula = Lookup ("G/L Account".Name WHERE("No." = FIELD("Debit Account No.")));
            Caption = 'Debit Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Debit Totaling"; Text[250])
        {
            Caption = 'Debit Totaling';
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5; "Credit Account No."; Code[20])
        {
            Caption = 'Credit Account No.';
            TableRelation = "G/L Account";
        }
        field(6; "Credit Account Name"; Text[100])
        {
            CalcFormula = Lookup ("G/L Account".Name WHERE("No." = FIELD("Credit Account No.")));
            Caption = 'Credit Account Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Credit Totaling"; Text[250])
        {
            Caption = 'Credit Totaling';
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(9; Amount; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum ("G/L Correspondence Entry".Amount WHERE("Debit Account No." = FIELD("Debit Account No."),
                                                                       "Debit Account No." = FIELD(FILTER("Debit Totaling")),
                                                                       "Credit Account No." = FIELD("Credit Account No."),
                                                                       "Credit Account No." = FIELD(FILTER("Credit Totaling")),
                                                                       "Debit Global Dimension 1 Code" = FIELD("Debit Global Dim. 1 Filter"),
                                                                       "Debit Global Dimension 2 Code" = FIELD("Debit Global Dim. 2 Filter"),
                                                                       "Credit Global Dimension 1 Code" = FIELD("Credit Global Dim. 1 Filter"),
                                                                       "Credit Global Dimension 2 Code" = FIELD("Credit Global Dim. 2 Filter"),
                                                                       "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                       "Posting Date" = FIELD("Date Filter"),
                                                                       "Debit Source Type" = FIELD("Debit Source Type Filter"),
                                                                       "Credit Source Type" = FIELD("Credit Source Type Filter"),
                                                                       "Debit Source No." = FIELD("Debit Source No. Filter"),
                                                                       "Credit Source No." = FIELD("Credit Source No. Filter")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(16; "Business Unit Filter"; Code[20])
        {
            Caption = 'Business Unit Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(17; "Debit Global Dim. 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1,Debit ';
            Caption = 'Debit Global Dim. 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Debit Global Dim. 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2,Debit ';
            Caption = 'Debit Global Dim. 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(20; "Amount (ACY)"; Decimal)
        {
            CalcFormula = Sum ("G/L Correspondence Entry"."Amount (ACY)" WHERE("Debit Account No." = FIELD("Debit Account No."),
                                                                               "Debit Account No." = FIELD(FILTER("Debit Totaling")),
                                                                               "Credit Account No." = FIELD("Credit Account No."),
                                                                               "Credit Account No." = FIELD(FILTER("Credit Totaling")),
                                                                               "Debit Global Dimension 1 Code" = FIELD("Debit Global Dim. 1 Filter"),
                                                                               "Debit Global Dimension 2 Code" = FIELD("Debit Global Dim. 2 Filter"),
                                                                               "Credit Global Dimension 1 Code" = FIELD("Credit Global Dim. 1 Filter"),
                                                                               "Credit Global Dimension 2 Code" = FIELD("Credit Global Dim. 2 Filter"),
                                                                               "Business Unit Code" = FIELD("Business Unit Filter"),
                                                                               "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Credit Global Dim. 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1,Credit ';
            Caption = 'Credit Global Dim. 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Credit Global Dim. 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2,Credit ';
            Caption = 'Credit Global Dim. 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(23; "Debit Source Type Filter"; Option)
        {
            Caption = 'Debit Source Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Customer,Vendor,Bank Account,FA';
            OptionMembers = " ",Customer,Vendor,"Bank Account",FA;
        }
        field(24; "Credit Source Type Filter"; Option)
        {
            Caption = 'Credit Source Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Customer,Vendor,Bank Account,FA';
            OptionMembers = " ",Customer,Vendor,"Bank Account",FA;
        }
        field(25; "Debit Source No. Filter"; Code[20])
        {
            Caption = 'Debit Source No. Filter';
            FieldClass = FlowFilter;
        }
        field(26; "Credit Source No. Filter"; Code[20])
        {
            Caption = 'Credit Source No. Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Debit Account No.", "Credit Account No.")
        {
            Clustered = true;
        }
        key(Key2; "Credit Account No.", "Debit Account No.")
        {
        }
    }

    fieldgroups
    {
    }
}

