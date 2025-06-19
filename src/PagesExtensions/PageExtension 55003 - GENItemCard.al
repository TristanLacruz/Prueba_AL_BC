pageextension 55003 "GENItem Card" extends "Item Card"
{
    layout
    {
        addafter("No.") // Añadir un campo adicional a la tarjeta de cliente después del campo "Nombre"
        {
            field("Nombre Videojuego"; Rec."Nombre Videojuego")
            {
                ApplicationArea = All;
                ToolTip = 'Nombre del videojuego';
            }
        }
        addafter(Description)
        {
            field("Plataforma"; Rec."Plataforma")
            {
                ApplicationArea = All;
                ToolTip = 'Plataforma de videojuegos';
            }
            field("Veces alquilado"; Rec."Veces alquilado")
            {
                ApplicationArea = All;
                ToolTip = 'Número de veces que se ha alquilado el videojuego';
            }
            field("Esta alquilado"; Rec."Esta Alquilado")
            {
                ApplicationArea = All;
                ToolTip = 'Indica si el videojuego está alquilado';
            }
        }
        addfirst(FactBoxes)
        {
            part(VideojuegoFactBox; "Videojuego FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No."); //Enlazar la tarjeta de cliente con la tarjeta de videojuego
            }
        }
    }
}