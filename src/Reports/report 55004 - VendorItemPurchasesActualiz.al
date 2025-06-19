report 55004 "Vendor/Item Purchases-Actualiz"
{
    // DefaultLayout = RDLC;
    // RDLCLayout = './VendorItemPurchasesUpdate.rdlc';
    // Caption = 'Vendor/Item Purchases actualizado';
    // AdditionalSearchTerms = 'vendor priority';
    // ApplicationArea = Basic, Suite;
    // UsageCategory = ReportsAndAnalysis;






    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    Caption = 'Vendor/Item Purchases actualizado';
    ExcelLayout = './VendorItemPurchasesUpdate.xlsx';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Vendor Posting Group";
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(STRSUBSTNO___1___2__Vendor_TABLECAPTION_VendFilter_; StrSubstNo('%1: %2', TableCaption, VendFilter))
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(STRSUBSTNO___1___2___Value_Entry__TABLECAPTION_ItemLedgEntryFilter_; StrSubstNo('%1: %2', "Value Entry".TableCaption, ItemLedgEntryFilter))
            {
            }
            column(ItemLedgEntryFilter; ItemLedgEntryFilter)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__Phone_No__; "Phone No.")
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(Value_Entry__Item_No__Caption; "Value Entry".FieldCaption("Item No."))
            {
            }
            column(Value_Entry__Invoiced_Quantity_Caption; "Value Entry".FieldCaption("Invoiced Quantity"))
            {
            }
            column(Value_Entry__Cost_Amount__Actual__Caption; "Value Entry".FieldCaption("Cost Amount (Actual)"))
            {
            }
            column(Value_Entry__Discount_Amount_Caption; "Value Entry".FieldCaption("Discount Amount"))
            {
            }
            column(Vendor__Phone_No__Caption; FieldCaption("Phone No."))
            {
            }
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Source No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("Source Type", "Source No.", "Item No.", "Posting Date") WHERE("Source Type" = CONST(Vendor), "Expected Cost" = CONST(false));
                RequestFilterFields = "Posting Date", "Item No.", "Inventory Posting Group";
                column(Value_Entry__Item_No__; "Item No.")
                {
                }
                column(Item_Description; Item.Description)
                {
                }
                column(Value_Entry__Invoiced_Quantity_; InvoicedQuantity)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
                {
                }
                column(Value_Entry___Cost_Amount__Actual__; CostAmountActual)
                {
                }
                column(Value_Entry___Discount_Amount_; DiscountAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if not Item.Get("Item No.") then
                        Item.Init();

                    if ResetItemTotal then begin
                        ResetItemTotal := false;
                        InvoicedQuantity := "Invoiced Quantity";
                        CostAmountActual := "Cost Amount (Actual)";
                        DiscountAmount := "Discount Amount";
                    end else begin
                        InvoicedQuantity += "Invoiced Quantity";
                        CostAmountActual += "Cost Amount (Actual)";
                        DiscountAmount += "Discount Amount";
                    end;

                    if not (ValueEntry.Next() = 0) then begin
                        if ValueEntry."Item No." = "Item No." then
                            CurrReport.Skip();
                        ResetItemTotal := true
                    end
                end;

                trigger OnPreDataItem()
                begin
                    ResetItemTotal := true;
                    ValueEntry.SetCurrentKey("Source Type", "Source No.", "Item No.", "Posting Date");
                    ValueEntry.CopyFilters("Value Entry");
                    if ValueEntry.FindSet then;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if PrintOnlyOnePerPage then
                    PageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Vendor';
                        ToolTip = 'Specifies if each vendor''s information is printed on a new page if you have chosen two or more vendors to be included in the report.';
                    }
                    field(UpdateItemVendor; UpdateItemVendorOption)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Update Products x Vendor';
                        OptionCaption = 'No, Actualizar, Reemplazar';
                        ToolTip = 'Specifies how to update the Item Vendor table: No (do not update), Update (add new records), Replace (delete old records and add new ones)';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        ReportNameLabel = 'Vendor/Item Purchases';
        PageLabel = 'Page';
        AllAmountsinLCYLabel = 'All amounts are in LCY';
        DescriptionLabel = 'Description';
        UnitOfMeasureLabel = 'Unit of Measure';
        TotalLabel = 'Total';
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin
        VendFilter := FormatDocument.GetRecordFiltersWithCaptions(Vendor);
        ItemLedgEntryFilter := "Value Entry".GetFilters;
        PeriodText := "Value Entry".GetFilter("Posting Date");
    end;


    trigger OnPostReport()
    var
        VendorItem: Record "Item Vendor";
        VendorProcessed: Record Vendor;
        ItemProcessed: Record Item;
    begin
        if UpdateItemVendorOption = UpdateItemVendorOption::No then
            exit;

        VendorProcessed.CopyFilters(Vendor);
        if VendorProcessed.FindSet() then
            repeat
                // For Replace option, delete existing records first
                if UpdateItemVendorOption = UpdateItemVendorOption::Reemplazar then begin
                    VendorItem.Reset();
                    VendorItem.SetRange("Vendor No.", VendorProcessed."No.");
                    if not VendorItem.IsEmpty() then
                        VendorItem.DeleteAll();
                end;

                // Process items for this vendor
                ValueEntry.Reset();
                ValueEntry.CopyFilters("Value Entry");
                ValueEntry.SetRange("Source No.", VendorProcessed."No.");
                if ValueEntry.FindSet() then
                    repeat
                        // Check if item exists and is not already linked to this vendor
                        if Item.Get(ValueEntry."Item No.") then begin
                            VendorItem.Reset();
                            VendorItem.SetRange("Vendor No.", VendorProcessed."No.");
                            VendorItem.SetRange("Item No.", ValueEntry."Item No.");
                            if not VendorItem.FindFirst() then begin
                                VendorItem.Init();
                                VendorItem."Vendor No." := VendorProcessed."No.";
                                VendorItem."Item No." := ValueEntry."Item No.";
                                VendorItem."Vendor Item No." := Item."Vendor Item No."; // Or leave blank
                                VendorItem.Insert(true);
                            end;
                        end;
                    until ValueEntry.Next() = 0;
            until VendorProcessed.Next() = 0;
    end;

    var
        Text000: Label 'Period: %1';
        Item: Record Item;
        ValueEntry: Record "Value Entry";
        VendFilter: Text;
        ItemLedgEntryFilter: Text;
        PeriodText: Text;
        PrintOnlyOnePerPage: Boolean;
        PageGroupNo: Integer;
        ResetItemTotal: Boolean;
        InvoicedQuantity: Decimal;
        CostAmountActual: Decimal;
        DiscountAmount: Decimal;
        UpdateItemVendorOption: Option No,Actualizar,Reemplazar;
        ItemVendor: Record "Item Vendor";

    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
    end;
}

