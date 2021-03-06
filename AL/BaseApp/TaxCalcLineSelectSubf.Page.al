page 17314 "Tax Calc. Line Select Subf"
{
    AutoSplitKey = true;
    Caption = 'Tax Calc. Line Select Subf';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Tax Calc. Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("Tax Diff. Amount (Tax)"; "Tax Diff. Amount (Tax)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax differences amount associated with the tax calculation line.';

                    trigger OnValidate()
                    begin
                        TaxDiffAmountTaxOnAfterValidat;
                    end;
                }
                field("Tax Diff. Amount (Base)"; "Tax Diff. Amount (Base)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the base tax differences amount associated with the tax calculation line.';

                    trigger OnValidate()
                    begin
                        TaxDiffAmountBaseOnAfterValida;
                    end;
                }
                field("Line Code"; "Line Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line code associated with the tax calculation line.';
                }
                field("Line Type"; "Line Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the line type associated with the tax calculation line.';
                }
                field("Sum Field No."; "Sum Field No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the sum field associated with the tax calculation line.';
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    Style = Strong;
                    StyleExpr = DescriptionEmphasize;
                    ToolTip = 'Specifies the line code description associated with the tax calculation line.';
                }
                field("Expression Type"; "Expression Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how the related tax calculation term is named, such as Plus/Minus, Multiply/Divide, and Compare.';
                }
                field("Link Register No."; "Link Register No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the link register number associated with the tax calculation line.';
                }
                field(Expression; Expression)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the expression of the related XML element.';
                }
                field("Selection Line Code"; "Selection Line Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the selection line code associated with the tax calculation line.';
                }
                field(Indentation; Indentation)
                {
                    ToolTip = 'Specifies the indentation of the line.';
                    Visible = false;
                }
                field(Bold; Bold)
                {
                    ToolTip = 'Specifies if you want the amounts in this line to be printed in bold.';
                    Visible = false;
                }
                field(Period; Period)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the period associated with the tax calculation line.';
                }
                field(DimFilters; DimFilters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions Filters';
                    DrillDown = false;
                    ToolTip = 'Specifies a filter for dimensions by which data is included.';

                    trigger OnAssistEdit()
                    begin
                        ShowDimensionsFilters;
                    end;
                }
                field(GLCorrDimFilters; GLCorrDimFilters)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Corr. Dimensions Filters';
                    DrillDown = false;
                    ToolTip = 'Specifies the dimensions by which data is shown.';

                    trigger OnAssistEdit()
                    begin
                        ShowGLCorrDimensionsFilters;
                    end;
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the field name associated with the tax calculation line.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DescriptionIndent := 0;
        CalcFields("Dimensions Filters", "G/L Corr. Dimensions Filters");
        if "Dimensions Filters" then
            DimFilters := Text1001
        else
            DimFilters := '';

        if "G/L Corr. Dimensions Filters" then
            GLCorrDimFilters := Text1001
        else
            GLCorrDimFilters := '';
        DescriptionOnFormat;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Expression Type" := "Expression Type"::SumField;
        GetDefaultSumField;
    end;

    var
        Text1001: Label 'Present';
        TaxCalcHeader: Record "Tax Calc. Header";
        DimFilters: Text[30];
        GLCorrDimFilters: Text[30];
        Text1002: Label '%1 should be used for this type of tax register.';
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;

    [Scope('OnPrem')]
    procedure ShowDimensionsFilters()
    var
        TemplateDimFilter: Record "Tax Calc. Dim. Filter";
        TemplateSection: Record "Tax Calc. Section";
        DimCodeFilter: Text[1024];
    begin
        CurrPage.SaveRecord;
        Commit();
        TaxCalcHeader.Get("Section Code", Code);
        if TaxCalcHeader."Table ID" = DATABASE::"Tax Calc. G/L Entry" then
            Error(Text1002, FieldCaption("G/L Corr. Dimensions Filters"));

        if ("Line No." <> 0) and ("Expression Type" = "Expression Type"::SumField) then begin
            TemplateSection.Get("Section Code");
            if (TemplateSection."Dimension 1 Code" <> '') or
               (TemplateSection."Dimension 2 Code" <> '') or
               (TemplateSection."Dimension 3 Code" <> '') or
               (TemplateSection."Dimension 4 Code" <> '')
            then begin
                TemplateDimFilter.FilterGroup(2);
                TemplateDimFilter.SetRange("Section Code", "Section Code");
                TemplateDimFilter.SetRange("Register No.", Code);
                TemplateDimFilter.SetRange(Define, TemplateDimFilter.Define::Template);
                if TemplateSection."Dimension 1 Code" <> '' then
                    DimCodeFilter := TemplateSection."Dimension 1 Code";
                if TemplateSection."Dimension 2 Code" <> '' then
                    DimCodeFilter := StrSubstNo('%1|%2', DimCodeFilter, TemplateSection."Dimension 2 Code");
                if TemplateSection."Dimension 3 Code" <> '' then
                    DimCodeFilter := StrSubstNo('%1|%2', DimCodeFilter, TemplateSection."Dimension 3 Code");
                if TemplateSection."Dimension 4 Code" <> '' then
                    DimCodeFilter := StrSubstNo('%1|%2', DimCodeFilter, TemplateSection."Dimension 4 Code");
                DimCodeFilter := DelChr(DimCodeFilter, '<', '|');
                TemplateDimFilter.SetFilter("Dimension Code", DimCodeFilter);
                TemplateDimFilter.FilterGroup(0);
                TemplateDimFilter.SetRange("Line No.", "Line No.");
                PAGE.RunModal(0, TemplateDimFilter);
            end;
        end;
        CurrPage.Update(false);
    end;

    [Scope('OnPrem')]
    procedure ShowGLCorrDimensionsFilters()
    var
        TaxDifGLCorrDimFilter: Record "Tax Diff. Corr. Dim. Filter";
    begin
        CurrPage.SaveRecord;
        Commit();
        TaxCalcHeader.Get("Section Code", Code);
        if (TaxCalcHeader."Table ID" = DATABASE::"Tax Calc. G/L Entry") and ("Line No." <> 0) then begin
            TaxDifGLCorrDimFilter.FilterGroup(2);
            TaxDifGLCorrDimFilter.SetRange("Section Code", "Section Code");
            TaxDifGLCorrDimFilter.SetRange("Tax Calc. No.", Code);
            TaxDifGLCorrDimFilter.SetRange(Define, TaxDifGLCorrDimFilter.Define::Template);
            TaxDifGLCorrDimFilter.SetRange("Line No.", "Line No.");
            TaxDifGLCorrDimFilter.FilterGroup(0);
            PAGE.RunModal(0, TaxDifGLCorrDimFilter);
        end else
            Error(Text1002, FieldCaption("Dimensions Filters"));
        CurrPage.Update(false);
    end;

    local procedure TaxDiffAmountTaxOnAfterValidat()
    begin
        CurrPage.Update;
    end;

    local procedure TaxDiffAmountBaseOnAfterValida()
    begin
        CurrPage.Update;
    end;

    local procedure DescriptionOnFormat()
    begin
        DescriptionIndent := Indentation;
        DescriptionEmphasize := Bold;
    end;
}

