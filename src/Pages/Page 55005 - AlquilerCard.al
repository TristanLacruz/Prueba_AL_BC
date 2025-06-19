page 55005 "Alquiler Card"
{
    ApplicationArea = All;
    Caption = 'Alquiler Card';
    PageType = Card;
    SourceTable = Alquiler;

    layout
    {
        area(Content)
        {
            group(General) //General = Grupo principal
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. alquiler';
                    ToolTip = 'Número de alquiler';
                }
                field("Nombre del cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del cliente';
                    ToolTip = 'Nombre del cliente que alquila el videojuego';
                }
                field("No. Videojuego"; Rec."No. Videojuego")
                {
                    ApplicationArea = All;
                    Caption = 'No. Videojuego';
                    ToolTip = 'Número de videojuego alquilado';
                }
                field("Nombre Videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre Videojuego';
                    Editable = false;
                    ToolTip = 'Nombre del videojuego alquilado';
                }
                field("Tipo Alquiler"; Rec."Tipo Alquiler")
                {
                    ApplicationArea = All;
                    Caption = 'Tipo de alquiler';
                    ToolTip = 'Tipo de alquiler';

                    DrillDownPageID = "Configuracion Alquileres Card";
                }
                field("Fecha Alquiler"; Rec."Fecha Alquiler")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de alquiler';
                    ToolTip = 'Fecha de alquiler';
                }
                field("Fecha Devolucion"; Rec."Fecha Devolucion")
                {
                    ApplicationArea = All;
                    Caption = 'Fecha de devolución';
                    ToolTip = 'Fecha de devolución';
                }
                field("Estado"; Rec.Estado)
                {
                    ApplicationArea = All;
                    Caption = 'Estado';
                    ToolTip = 'Estado del alquiler';
                    Editable = false;
                }
                field("Foto Videojuego"; Rec."Foto videojuego")
                {
                    ApplicationArea = All;
                    Caption = 'Foto del videojuego';
                    ToolTip = 'Foto del videojuego alquilado';
                }
            }
        }
    }

    /*-------------------------------------------------------------
    | Triggers
    |-------------------------------------------------------------*/
    trigger OnAfterGetRecord()
    begin
        Rec.CalcularEstado();
    end;
}