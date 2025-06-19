page 55003 "Alquiler Info FactBox"
{
    PageType = CardPart; // Para mostrar información en un panel lateral.
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Alquiler;
    Caption = 'Información del alquiler';

    layout
    {
        area(Content)
        {
            repeater("Grupo Detalles Alquiler")
            {
                Caption = 'Grupo de Detalles del alquiler';

                field("Foto Videojuego"; Rec."Foto videojuego")
                {
                    ApplicationArea = All;
                    ShowCaption = false; // No mostrar el título del campo, solo la imagen.
                    ToolTip = 'Foto del videojuego alquilado.';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el número del alquiler.';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::"Alquiler Card", Rec); //Cuando se aprete el campo 'No.', se abrirá la tarjeta del alquiler.
                    end;
                }
                field("No. Videojuego"; Rec."No. Videojuego")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el videojuego alquilado.';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(PAGE::"Item Card", Rec); //Cuando se aprete el campo 'No. Videojuego', se abrirá la tarjeta del videojuego.
                    end;
                }
                field("Fecha Alquiler"; Rec."Fecha Alquiler")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha del alquiler.';
                    Editable = false;
                }
                field("Fecha Devolucion"; Rec."Fecha Devolucion")
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica la fecha de devolución.';
                    Editable = false;
                }
                field("Estado"; Rec.Estado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Especifica el estado del alquiler.';
                    Editable = false;
                }
            }
        }
    }
}