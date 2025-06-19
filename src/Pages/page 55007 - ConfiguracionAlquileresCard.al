page 55007 "Configuracion Alquileres Card"
{
    ApplicationArea = All;
    Caption = 'Configuración Alquileres Card';
    PageType = Card;
    SourceTable = "Configuracion Alquiler";

    layout
    {
        area(Content)
        {
            group(General) //La diferencia entre 'area(Content)' y 'group(General)' es que 'group(General)' permite agrupar los campos como un 'div' en HTML
            {
                Caption = 'General';

                field("No. Serie Alquiler"; Rec."No. Serie Alquiler")
                {
                    ApplicationArea = All;
                }
                field("Nombre Alquiler"; Rec."Nombre Alquiler")
                {
                    ApplicationArea = All;
                }
                field("Duración Prestamo Defecto"; Rec."Duración Prestamo Defecto")
                {
                    ApplicationArea = All;
                }
                field("Máximos Alquileres en Activo"; Rec."Máximos Alquileres en Activo")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
