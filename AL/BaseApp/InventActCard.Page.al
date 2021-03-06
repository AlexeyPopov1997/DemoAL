page 14910 "Invent. Act Card"
{
    Caption = 'Invent. Act Card';
    PageType = Document;
    SourceTable = "Invent. Act Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnAssistEdit()
                    begin
                        AssistEdit;
                    end;
                }
                field("Act Date"; "Act Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the inventory act date, and is filled with the work date.';
                }
                field("Inventory Date"; "Inventory Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date of inventory, and is filled with the work date.';
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the status of the inventory act.';
                }
                field("Reason Document Type"; "Reason Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of reason document.';
                }
                field("Reason Document No."; "Reason Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the reason document number.';
                }
                field("Reason Document Date"; "Reason Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date of the reason document.';
                }
            }
            part(Control1210014; "Invent. Act Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Act No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Act)
            {
                Caption = 'Act';
                action("Employee Si&gnatures")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Si&gnatures';
                    Image = Signature;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Document Signatures";
                    RunPageLink = "Table ID" = CONST(14908),
                                  "Document No." = FIELD("No.");
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                Image = "Action";
                action("Suggest Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Suggest Lines';
                    Ellipsis = true;
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ToolTip = 'Use a function to fill in lines for auditing of the fixed asset inventory in accordance with legal requirements.';

                    trigger OnAction()
                    var
                        InventActHeader: Record "Invent. Act Header";
                    begin
                        TestStatus;
                        InventActHeader := Rec;
                        InventActHeader.SetRecFilter;
                        REPORT.RunModal(REPORT::"Create Invent. Act Lines", true, false, InventActHeader);
                    end;
                }
                separator(Action1210020)
                {
                }
                action(Release)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Enable the record for the next stage of processing. ';

                    trigger OnAction()
                    begin
                        Release;
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen';
                    Image = ReOpen;
                    ToolTip = 'Open the closed or released record.';

                    trigger OnAction()
                    begin
                        Reopen;
                    end;
                }
                group(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    action("Invent. Act INV-17")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invent. Act INV-17';
                        Promoted = true;
                        PromotedCategory = "Report";
                        ToolTip = 'View an inventory of contractor payables and receivables.';

                        trigger OnAction()
                        var
                            InventActHeader: Record "Invent. Act Header";
                        begin
                            InventActHeader := Rec;
                            InventActHeader.SetRecFilter;
                            REPORT.Run(REPORT::"Invent. Act INV-17", true, false, InventActHeader);
                        end;
                    }
                    action("Supplement to INV-17")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Supplement to INV-17';
                        Promoted = true;
                        PromotedCategory = "Report";
                        ToolTip = 'View an inventory of contractor payables and receivables.';

                        trigger OnAction()
                        var
                            InventActHeader: Record "Invent. Act Header";
                        begin
                            InventActHeader := Rec;
                            InventActHeader.SetRecFilter;
                            REPORT.Run(REPORT::"Supplement to INV-17", true, false, InventActHeader);
                        end;
                    }
                }
            }
        }
    }
}

