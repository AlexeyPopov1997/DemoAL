page 17307 "Tax Diff. Ledger Entries"
{
    Caption = 'Tax Diff. Ledger Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Tax Diff. Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the related document.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the description associated with the tax differences ledger entry.';
                }
                field("Tax Diff. Category"; "Tax Diff. Category")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax differences category associated with the tax differences ledger entry.';
                }
                field("Tax Diff. Code"; "Tax Diff. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an identifying income or expense code that defines the source of the tax difference associated with this entry.';
                }
                field("Tax Diff. Type"; "Tax Diff. Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax differences type associated with the tax differences ledger entry.';
                }
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the source type that applies to the source number that is shown in the Source No. field.';
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the source document that the entry originates from.';
                }
                field("Tax Diff. Posting Group"; "Tax Diff. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax differences posting group associated with the tax differences ledger entry.';
                }
                field("Tax Amount"; "Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax amount associated with the tax differences ledger entry.';
                }
                field("Asset Tax Amount"; "Asset Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the asset tax amount associated with the tax differences ledger entry.';
                }
                field("Liability Tax Amount"; "Liability Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the liability tax amount associated with the tax differences ledger entry.';
                }
                field("Disposal Tax Amount"; "Disposal Tax Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax amount that is written off at the disposal of an item.';
                }
                field("DTA Starting Balance"; "DTA Starting Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the deferred tax asset (DTA) starting balance associated with the tax differences ledger entry.';
                }
                field("DTL Starting Balance"; "DTL Starting Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the disposal tax liability (DTL) starting balance associated with the tax differences ledger entry.';
                }
                field("DTA Ending Balance"; "DTA Ending Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the deferred tax asset (DTA) ending balance associated with the tax differences ledger entry.';
                }
                field("DTL Ending Balance"; "DTL Ending Balance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the disposal tax liability (DTL) ending balance associated with the tax differences ledger entry.';
                }
                field("Disposal Mode"; "Disposal Mode")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if you want to write down the tax difference or transform it into a constant difference.';
                }
                field("Disposal Date"; "Disposal Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date of the item''s disposal.';
                }
                field("Tax Factor"; "Tax Factor")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the profit tax rate that is used to calculate tax differences.';
                }
                field("Amount (Base)"; "Amount (Base)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the expense amount, based on book accounting transactions, associated with the tax differences ledger entry.';
                }
                field("Amount (Tax)"; "Amount (Tax)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the expense amount, based on accounting tax transactions, associated with the tax differences ledger entry.';
                }
                field(Difference; Difference)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the difference between the book accounting and tax accounting transactions.';
                }
                field("YTD Amount (Base)"; "YTD Amount (Base)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the year-to-date base amount associated with the tax differences ledger entry.';
                }
                field("YTD Amount (Tax)"; "YTD Amount (Tax)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the year-to-date expense amount, based on accounting tax transactions.';
                }
                field("YTD Difference"; "YTD Difference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the year-to-date difference associated with the tax differences ledger entry.';
                }
                field("Jurisdiction Code"; "Jurisdiction Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the jurisdiction code associated with the tax differences ledger entry.';
                }
                field("Norm Code"; "Norm Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the norm code associated with the tax differences ledger entry.';
                }
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the transaction number associated with the tax differences ledger entry.';
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action(Dimensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to journal lines to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Find entries...';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}

