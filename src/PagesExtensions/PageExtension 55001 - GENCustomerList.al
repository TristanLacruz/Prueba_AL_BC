pageextension 55001 "GENCustomer List" extends "Customer List"
{
    layout
    {
        modify(Name) // Cambiar el estilo de texto de la columna "Nombre"
        {
            StyleExpr = EstiloTexto;
        }
        addafter(Name) // Añadir dos campos adicionales a la lista de clientes después del campo "Nombre"
        {
            field("Videojuegos alquilados"; Rec."NumVideojuegosAlquilados")
            {
                ApplicationArea = All;
                StyleExpr = EstiloTexto;
            }
            field("Tiene alquiler caducado"; Rec.TieneAlquilerCaducado)
            {
                ApplicationArea = All;
                ToolTip = 'Indica si el cliente tiene al menos un alquiler caducado';
                Editable = false;
                StyleExpr = EstiloTexto;
            }
            field("Alquileres activos"; Rec."Alquileres Activos")
            {
                ApplicationArea = All;
                ToolTip = 'Número de alquileres activos del cliente';
                Editable = false;
                StyleExpr = EstiloTexto;
                DrillDown = true; // Habilitar la opción de DrillDown
                trigger OnDrillDown()
                var
                    AlquilerRec: Record Alquiler;
                begin
                    // Filtrar alquileres activos del cliente actual
                    AlquilerRec.SetRange("No. Cliente", Rec."No.");
                    AlquilerRec.SetRange(Estado, AlquilerRec.Estado::Activo);

                    // Abrir la página "Alquiler List" con el filtro aplicado
                    PAGE.RUNMODAL(PAGE::"Alquiler List", AlquilerRec);
                end;
            }
        }
    }


    /*------------------------------------------------------------
    | Triggers
    -------------------------------------------------------------*/
    trigger OnAfterGetRecord() //Después de obtener un registro se actualiza el estilo de texto
    begin
        ActualizarEstilo();
    end;

    local procedure ActualizarEstilo()
    begin
        if Rec.TieneAlquilerCaducado then
            EstiloTexto := 'Unfavorable' // Rojo
        else
            EstiloTexto := 'None'; // Sin estilo especial
    end;


    /*-------------------------------------------------------------
    | Variables
    -------------------------------------------------------------*/
    var
        EstiloTexto: Text;
}
