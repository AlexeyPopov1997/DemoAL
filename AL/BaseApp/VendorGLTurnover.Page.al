page 12407 "Vendor G/L Turnover"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Vendor G/L Turnover';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = Vendor;
    SourceTableView = SORTING("Vendor Type");
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(PeriodType; PeriodType)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View by';
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';
                    ToolTip = 'Specifies by which period amounts are displayed.';

                    trigger OnValidate()
                    begin
                        FindPeriod('');
                        CurrPage.Update;
                    end;
                }
            }
            repeater(Control5)
            {
                Editable = false;
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the related record.';
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s market type to link business transactions made for the vendor with the appropriate account in the general ledger.';
                    Visible = false;
                }
                field("G/L Starting Balance"; "G/L Starting Balance")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Caption = 'Starting Balance';
                    ToolTip = 'Specifies the general ledger starting balance associated with the vendor.';
                }
                field("G/L Debit Amount"; "G/L Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankNumbers = BlankZero;
                    Caption = 'Debit Amount (LCY)';
                    ToolTip = 'Specifies the general ledger debit amount associated with the vendor.';
                }
                field("G/L Credit Amount"; "G/L Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    BlankNumbers = BlankZero;
                    Caption = 'Credit Amount (LCY)';
                    ToolTip = 'Specifies the general ledger credit amount associated with the vendor.';
                }
                field("G/L Balance to Date"; "G/L Balance to Date")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Caption = 'Ending Balance';
                    ToolTip = 'Specifies the general ledger balance to date associated with the vendor.';
                }
                field("G/L Net Change"; "G/L Net Change")
                {
                    BlankZero = true;
                    Caption = 'Net Change (LCY)';
                    ToolTip = 'Specifies the general ledger net change associated with the vendor.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Vendor")
            {
                Caption = '&Vendor';
                Image = Vendor;
                action(Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction()
                    begin
                        Vendor.Copy(Rec);
                        case "Vendor Type" of
                            "Vendor Type"::Vendor:
                                PAGE.Run(PAGE::"Vendor Card", Vendor);
                            "Vendor Type"::"Resp. Employee":
                                PAGE.Run(PAGE::"Resp. Employee Card", Vendor);
                            "Vendor Type"::"Tax Authority":
                                PAGE.Run(PAGE::"Tax Authority/Fund Card", Vendor);
                            "Vendor Type"::Person:
                                PAGE.Run(PAGE::"Person Vendor Card", Vend);
                        end;
                    end;
                }
                action("A&greements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&greements';
                    Image = Agreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor G/L Turnover Agr.";
                    RunPageLink = "Vendor No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD(FILTER("Global Dimension 1 Filter")),
                                  "Global Dimension 2 Filter" = FIELD(FILTER("Global Dimension 2 Filter")),
                                  "Date Filter" = FIELD(FILTER("Date Filter")),
                                  "G/L Account Filter" = FIELD(FILTER("G/L Account Filter")),
                                  "G/L Starting Date Filter" = FIELD(FILTER("G/L Starting Date Filter"));
                    ShortCutKey = 'Shift+F11';
                }
            }
        }
        area(processing)
        {
            action("Previous Period")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Previous Period';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Period';

                trigger OnAction()
                begin
                    FindPeriod('<=');
                end;
            }
            action("Next Period")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Next Period';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Period';

                trigger OnAction()
                begin
                    FindPeriod('>=');
                end;
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("G/L Turnover")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Turnover';
                    Image = Turnover;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ToolTip = 'Analyze the turnover compared with vendor or customer account balances.';

                    trigger OnAction()
                    begin
                        Vend.Copy(Rec);
                        REPORT.RunModal(REPORT::"Vendor G/L Turnover", true, false, Vend);
                    end;
                }
                action("Accounting Card")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Card';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Vend.Reset();
                        Vend.CopyFilters(Rec);
                        REPORT.RunModal(REPORT::"Vendor Accounting Card", true, false, Vend);
                    end;
                }
            }
        }
        area(reporting)
        {
        }
    }

    trigger OnOpenPage()
    begin
        DateFilter := GetFilter("Date Filter");
        if DateFilter = '' then begin
            if PeriodType = PeriodType::"Accounting Period" then
                FindPeriodUser('')
            else
                FindPeriod('');
        end else
            SetRange("G/L Starting Date Filter", GetRangeMin("Date Filter") - 1);
    end;

    var
        Vend: Record Vendor;
        UserPeriods: Record "User Setup";
        Vendor: Record Vendor;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        DateFilter: Text;

    local procedure FindPeriod(SearchText: Code[10])
    var
        Calendar: Record Date;
        PeriodFormManagement: Codeunit PeriodFormManagement;
    begin
        if GetFilter("Date Filter") <> '' then begin
            Calendar.SetFilter("Period Start", GetFilter("Date Filter"));
            if not PeriodFormManagement.FindDate('+', Calendar, PeriodType) then
                PeriodFormManagement.FindDate('+', Calendar, PeriodType::Day);
            Calendar.SetRange("Period Start");
        end;
        PeriodFormManagement.FindDate(SearchText, Calendar, PeriodType);
        SetRange("Date Filter", Calendar."Period Start", Calendar."Period End");
        if GetRangeMin("Date Filter") = GetRangeMax("Date Filter") then
            SetRange("Date Filter", GetRangeMin("Date Filter"));
        SetRange("G/L Starting Date Filter", GetRangeMin("Date Filter") - 1);
    end;

    local procedure FindPeriodUser(SearchText: Code[10])
    var
        Calendar: Record Date;
        PeriodFormManagement: Codeunit PeriodFormManagement;
    begin
        if UserPeriods.Get(UserId) then begin
            SetRange("Date Filter", UserPeriods."Allow Posting From", UserPeriods."Allow Posting To");
            if GetRangeMin("Date Filter") = GetRangeMax("Date Filter") then
                SetRange("Date Filter", GetRangeMin("Date Filter"));
        end else begin
            if GetFilter("Date Filter") <> '' then begin
                Calendar.SetFilter("Period Start", GetFilter("Date Filter"));
                if not PeriodFormManagement.FindDate('+', Calendar, PeriodType) then
                    PeriodFormManagement.FindDate('+', Calendar, PeriodType::Day);
                Calendar.SetRange("Period Start");
            end;
            PeriodFormManagement.FindDate(SearchText, Calendar, PeriodType);
            SetRange("Date Filter", Calendar."Period Start", Calendar."Period End");
            if GetRangeMin("Date Filter") = GetRangeMax("Date Filter") then
                SetRange("Date Filter", GetRangeMin("Date Filter"));
        end;
    end;
}

