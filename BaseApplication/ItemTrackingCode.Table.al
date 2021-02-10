table 6502 "Item Tracking Code"
{
    Caption = 'Item Tracking Code';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Item Tracking Codes";
    LookupPageID = "Item Tracking Codes";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Warranty Date Formula"; DateFormula)
        {
            Caption = 'Warranty Date Formula';
        }
        field(5; "Man. Warranty Date Entry Reqd."; Boolean)
        {
            Caption = 'Man. Warranty Date Entry Reqd.';
        }
        field(6; "Man. Expir. Date Entry Reqd."; Boolean)
        {
            Caption = 'Man. Expir. Date Entry Reqd.';

            trigger OnValidate()
            begin
                if (not "Use Expiration Dates") and "Man. Expir. Date Entry Reqd." then
                    Validate("Use Expiration Dates", true);
            end;
        }
        field(8; "Strict Expiration Posting"; Boolean)
        {
            Caption = 'Strict Expiration Posting';

            trigger OnValidate()
            begin
                if (not "Use Expiration Dates") and "Strict Expiration Posting" then
                    Validate("Use Expiration Dates", true);
            end;
        }
        field(9; "Use Expiration Dates"; Boolean)
        {
            Caption = 'Use Expiration Dates';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Use Expiration Dates" then
                    exit;

                ValidateUseExpirationDates;
            end;
        }
        field(11; "SN Specific Tracking"; Boolean)
        {
            Caption = 'SN Specific Tracking';

            trigger OnValidate()
            begin
                if "SN Specific Tracking" = xRec."SN Specific Tracking" then
                    exit;

                if "SN Specific Tracking" then begin
                    TestSetSpecific(FieldCaption("SN Specific Tracking"));

                    "SN Purchase Inbound Tracking" := true;
                    "SN Purchase Outbound Tracking" := true;
                    "SN Sales Inbound Tracking" := true;
                    "SN Sales Outbound Tracking" := true;
                    "SN Pos. Adjmt. Inb. Tracking" := true;
                    "SN Pos. Adjmt. Outb. Tracking" := true;
                    "SN Neg. Adjmt. Inb. Tracking" := true;
                    "SN Neg. Adjmt. Outb. Tracking" := true;
                    "SN Transfer Tracking" := true;
                    "SN Manuf. Inbound Tracking" := true;
                    "SN Manuf. Outbound Tracking" := true;
                    "SN Assembly Inbound Tracking" := true;
                    "SN Assembly Outbound Tracking" := true;
                end else begin
                    TestRemoveSpecific(FieldCaption("SN Specific Tracking"));
                    "SN Warehouse Tracking" := false;
                end;
            end;
        }
        field(13; "SN Info. Inbound Must Exist"; Boolean)
        {
            Caption = 'SN Info. Inbound Must Exist';
        }
        field(14; "SN Info. Outbound Must Exist"; Boolean)
        {
            Caption = 'SN Info. Outbound Must Exist';
        }
        field(15; "SN Warehouse Tracking"; Boolean)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'SN Warehouse Tracking';

            trigger OnValidate()
            begin
                if "SN Warehouse Tracking" then begin
                    TestField("SN Specific Tracking", true);
                    TestSetSpecific(FieldCaption("SN Warehouse Tracking"));
                end else
                    TestRemoveSpecific(FieldCaption("SN Warehouse Tracking"));

                TestNoWhseEntriesExist(FieldCaption("SN Warehouse Tracking"));
            end;
        }
        field(21; "SN Purchase Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'SN Purchase Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(22; "SN Purchase Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            Caption = 'SN Purchase Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(23; "SN Sales Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'SN Sales Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(24; "SN Sales Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'SN Sales Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(25; "SN Pos. Adjmt. Inb. Tracking"; Boolean)
        {
            Caption = 'SN Pos. Adjmt. Inb. Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(26; "SN Pos. Adjmt. Outb. Tracking"; Boolean)
        {
            Caption = 'SN Pos. Adjmt. Outb. Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(27; "SN Neg. Adjmt. Inb. Tracking"; Boolean)
        {
            Caption = 'SN Neg. Adjmt. Inb. Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(28; "SN Neg. Adjmt. Outb. Tracking"; Boolean)
        {
            Caption = 'SN Neg. Adjmt. Outb. Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(29; "SN Transfer Tracking"; Boolean)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'SN Transfer Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(30; "SN Manuf. Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'SN Manuf. Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(31; "SN Manuf. Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'SN Manuf. Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(32; "SN Assembly Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'SN Assembly Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(33; "SN Assembly Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'SN Assembly Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("SN Specific Tracking", false);
            end;
        }
        field(41; "Lot Specific Tracking"; Boolean)
        {
            Caption = 'Lot Specific Tracking';

            trigger OnValidate()
            begin
                if "Lot Specific Tracking" = xRec."Lot Specific Tracking" then
                    exit;

                if "Lot Specific Tracking" then begin
                    TestSetSpecific(FieldCaption("Lot Specific Tracking"));

                    "Lot Purchase Inbound Tracking" := true;
                    "Lot Purchase Outbound Tracking" := true;
                    "Lot Sales Inbound Tracking" := true;
                    "Lot Sales Outbound Tracking" := true;
                    "Lot Pos. Adjmt. Inb. Tracking" := true;
                    "Lot Pos. Adjmt. Outb. Tracking" := true;
                    "Lot Neg. Adjmt. Inb. Tracking" := true;
                    "Lot Neg. Adjmt. Outb. Tracking" := true;
                    "Lot Transfer Tracking" := true;
                    "Lot Manuf. Inbound Tracking" := true;
                    "Lot Manuf. Outbound Tracking" := true;
                    "Lot Assembly Inbound Tracking" := true;
                    "Lot Assembly Outbound Tracking" := true;
                end else begin
                    TestRemoveSpecific(FieldCaption("Lot Specific Tracking"));
                    "Lot Warehouse Tracking" := false;
                end;
            end;
        }
        field(43; "Lot Info. Inbound Must Exist"; Boolean)
        {
            Caption = 'Lot Info. Inbound Must Exist';
        }
        field(44; "Lot Info. Outbound Must Exist"; Boolean)
        {
            Caption = 'Lot Info. Outbound Must Exist';
        }
        field(45; "Lot Warehouse Tracking"; Boolean)
        {
            Caption = 'Lot Warehouse Tracking';

            trigger OnValidate()
            begin
                if "Lot Warehouse Tracking" then begin
                    TestField("Lot Specific Tracking", true);
                    TestSetSpecific(FieldCaption("Lot Warehouse Tracking"));
                end else
                    TestRemoveSpecific(FieldCaption("Lot Warehouse Tracking"));

                TestNoWhseEntriesExist(FieldCaption("Lot Warehouse Tracking"));
            end;
        }
        field(51; "Lot Purchase Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lot Purchase Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(52; "Lot Purchase Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lot Purchase Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(53; "Lot Sales Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Lot Sales Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(54; "Lot Sales Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Lot Sales Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(55; "Lot Pos. Adjmt. Inb. Tracking"; Boolean)
        {
            Caption = 'Lot Pos. Adjmt. Inb. Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(56; "Lot Pos. Adjmt. Outb. Tracking"; Boolean)
        {
            Caption = 'Lot Pos. Adjmt. Outb. Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(57; "Lot Neg. Adjmt. Inb. Tracking"; Boolean)
        {
            Caption = 'Lot Neg. Adjmt. Inb. Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(58; "Lot Neg. Adjmt. Outb. Tracking"; Boolean)
        {
            Caption = 'Lot Neg. Adjmt. Outb. Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(59; "Lot Transfer Tracking"; Boolean)
        {
            Caption = 'Lot Transfer Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(60; "Lot Manuf. Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'Lot Manuf. Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(61; "Lot Manuf. Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "Production Order" = R;
            Caption = 'Lot Manuf. Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(62; "Lot Assembly Inbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'Lot Assembly Inbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(63; "Lot Assembly Outbound Tracking"; Boolean)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'Lot Assembly Outbound Tracking';

            trigger OnValidate()
            begin
                TestField("Lot Specific Tracking", false);
            end;
        }
        field(14900; "CD Tracking Exists"; Boolean)
        {
            CalcFormula = Exist("CD Tracking Setup" WHERE("Item Tracking Code" = FIELD(Code)));
            Caption = 'CD Tracking Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14910; "CD Specific Tracking"; Boolean)
        {
            Caption = 'CD Specific Tracking';

            trigger OnValidate()
            begin
                if "CD Specific Tracking" = xRec."CD Specific Tracking" then
                    exit;

                if "CD Specific Tracking" then begin
                    TestSetSpecific(FieldCaption("CD Specific Tracking"));
                end else begin
                    TestRemoveSpecific(FieldCaption("CD Specific Tracking"));
                    "CD Warehouse Tracking" := false;
                end;
            end;
        }
        field(14913; "CD Warehouse Tracking"; Boolean)
        {
            Caption = 'CD Warehouse Tracking';

            trigger OnValidate()
            begin
                if "CD Warehouse Tracking" then begin
                    TestField("CD Specific Tracking", true);
                    TestSetSpecific(FieldCaption("CD Warehouse Tracking"));
                end else
                    TestRemoveSpecific(FieldCaption("CD Warehouse Tracking"));

                TestNoWhseEntriesExist(FieldCaption("CD Warehouse Tracking"));
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestDelete;
    end;

    var
        Text000: Label 'Entries exist for item %1. The field %2 cannot be changed.';
        Item: Record Item;
        Text001: Label '%1 is %2 for item %3. The field %4 cannot be changed.';
        Text002: Label 'You cannot delete %1 %2 because it is used on one or more items.';
        IgnoreExpirationDateErr: Label 'You cannot stop using expiration dates because item ledger entries with expiration dates exist for item %1.', Comment = '%1 is the item number';
        ExpDateCalcSetOnItemsQst: Label 'You cannot stop using expiration dates because they are set up for %1 item(s). Do you want to see a list of these items, and decide whether to remove the expiration dates?', Comment = '%1 is the number of items';
        ExpDateCalcSetOnItemsErr: Label 'You cannot stop using expiration dates because they are set up for %1 item(s).', Comment = '%1 is the number of items';
        IgnoreButManExpirDateReqdErr: Label 'You cannot stop using expiration dates if you require manual expiration date entry on the item tracking code.';
        IgnoreButStrictExpirationPostingErr: Label 'You cannot stop using expiration dates if you require strict expiration posting on the item tracking code.';
        WhseEntriesExistErr: Label 'You cannot change %1 because there are one or more warehouse entries for item %2.', Comment = '%1: Changed field name; %2: Item No.';

    local procedure EnsureNoExpirationDatesExistInRelatedItemLedgerEntries()
    var
        ItemsWithExpirationDate: Query "Items With Expiration Date";
    begin
        // find items using this tracking code
        ItemsWithExpirationDate.SetRange(Item_Tracking_Code, Code);

        // join with item ledger entries for these items that have an expiration date
        ItemsWithExpirationDate.SetFilter(Expiration_Date, '<>%1', 0D);
        if ItemsWithExpirationDate.Open then
            if ItemsWithExpirationDate.Read then // found some problematic data
                Error(IgnoreExpirationDateErr, ItemsWithExpirationDate.Item_No);
    end;

    local procedure EnsureRelatedItemsHaveNoExpirationDate()
    var
        EmptyDateFormula: DateFormula;
    begin
        Item.SetRange("Item Tracking Code", Code);
        Item.SetFilter("Expiration Calculation", '<>%1', EmptyDateFormula);
        if Item.FindSet then begin
            if GuiAllowed then
                if Confirm(StrSubstNo(ExpDateCalcSetOnItemsQst, Item.Count)) then begin
                    PAGE.RunModal(PAGE::"Item List", Item);
                    Validate("Use Expiration Dates");
                    exit;
                end;

            Error(ExpDateCalcSetOnItemsErr, Item.Count);
        end;
    end;

    procedure TestSetSpecific(CurrentFieldname: Text[100])
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        Item.Reset();
        Item.SetRange("Item Tracking Code", Code);
        if Item.Find('-') then
            repeat
                ItemLedgEntry.SetRange("Item No.", Item."No.");
                if not ItemLedgEntry.IsEmpty then
                    Error(
                      Text000,
                      Item."No.", CurrentFieldname);
            until Item.Next = 0;
    end;

    procedure TestRemoveSpecific(CurrentFieldname: Text[100])
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        Item.Reset();
        Item.SetRange("Item Tracking Code", Code);
        if Item.Find('-') then
            repeat
                if Item."Costing Method" = Item."Costing Method"::Specific then
                    Error(
                      Text001,
                      Item.FieldCaption("Costing Method"),
                      Item."Costing Method", Item."No.", CurrentFieldname);
                ItemLedgEntry.SetRange("Item No.", Item."No.");
                if not ItemLedgEntry.IsEmpty then
                    Error(
                      Text000,
                      Item."No.", CurrentFieldname);
            until Item.Next = 0;
    end;

    local procedure TestDelete()
    begin
        Item.Reset();
        Item.SetRange("Item Tracking Code", Code);
        if not Item.IsEmpty then
            Error(Text002, TableCaption, Code);
    end;

    local procedure ValidateUseExpirationDates()
    begin
        // 1. check if it is possible to ignore expiration dates
        EnsureNoExpirationDatesExistInRelatedItemLedgerEntries;

        // 2. Check for inconsistencies that may be fixed
        // a. Items with expiration calculation not empty, suggesting these items expire
        EnsureRelatedItemsHaveNoExpirationDate;

        // b. Manual expiration date entry is required, which implies items using this tracking code should expire
        if "Man. Expir. Date Entry Reqd." then
            Error(IgnoreButManExpirDateReqdErr);

        // c. Strict expiration posting, which implies expiration dates matter
        if "Strict Expiration Posting" then
            Error(IgnoreButStrictExpirationPostingErr);
    end;

    procedure IsSpecific(): Boolean
    begin
        exit("SN Specific Tracking" or "Lot Specific Tracking" or "CD Specific Tracking");
    end;

    procedure IsWarehouseTracking(): Boolean
    begin
        exit("SN Warehouse Tracking" or "Lot Warehouse Tracking" or "CD Warehouse Tracking");
    end;
    
    local procedure TestNoWhseEntriesExist(CurrentFieldName: Text)
    var
        TrackedItem: Record Item;
        WarehouseEntry: Record "Warehouse Entry";
    begin
        TrackedItem.SetRange("Item Tracking Code", Code);
        if TrackedItem.FindSet() then
            repeat
                WarehouseEntry.SetRange("Item No.", TrackedItem."No.");
                if not WarehouseEntry.IsEmpty() then
                    Error(WhseEntriesExistErr, CurrentFieldName, TrackedItem."No.");
            until TrackedItem.Next() = 0;
    end;
}
