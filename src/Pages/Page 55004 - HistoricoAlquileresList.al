page 55004 "Historico Alquileres List"
{
    ApplicationArea = All;
    Caption = 'Historico Alquileres List';
    PageType = List;
    SourceTable = Alquiler;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("No. Cliente"; Rec."No. Cliente")
                {
                    ApplicationArea = All;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                }
                field("No. Videojuego"; Rec."No. Videojuego")
                {
                    ApplicationArea = All;
                }
                field("Nombre Videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                }
                field("Fecha Alquiler"; Rec."Fecha Alquiler")
                {
                    ApplicationArea = All;
                }
                field("Fecha Devolucion"; Rec."Fecha Devolucion")
                {
                    ApplicationArea = All;
                }
                field("Estado"; Rec."Estado")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    /*------------------------------------------------------------
    | Actions
    *-----------------------------------------------------------*/
    actions
    {
        area(navigation)
        {
            group(Detalles)
            {
                action("Ver detalles del registro")
                {
                    ApplicationArea = All;
                    Caption = 'Ver Detalles';
                    Image = ViewDetails;
                    Promoted = true; //Promocionado. Se muestra en la parte superior de la página
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Alquiler Card"; // Para ver/editar un alquiler
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    /*------------------------------------------------------------
    | Triggers
    ------------------------------------------------------------*/
    trigger OnOpenPage()
    begin
        Rec.SetRange(Rec.Estado, Rec.Estado::Devuelto);
    end;

}


