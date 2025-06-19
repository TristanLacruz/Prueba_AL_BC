page 55010 "Alquiler ListPart"
{
    PageType = ListPart;
    SourceTable = Alquiler;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                }
                field("Nombre Videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter(Rec.Estado, '%1|%2', Rec.Estado::Activo, Rec.Estado::Caducado);
    end;
}
