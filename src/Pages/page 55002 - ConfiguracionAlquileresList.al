page 55002 "Configuracion Alquileres List"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Configuracion Alquiler";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No. Serie Alquiler"; Rec."No. Serie Alquiler")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::"Configuracion Alquileres Card", Rec); //Abrir la tarjeta de configuración de alquileres
                    end;
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