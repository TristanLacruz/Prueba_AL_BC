pageextension 55002 "GENCustomer Card" extends "Customer Card"
{
    layout
    {
        addafter(Name) // Añadir un campo adicional a la tarjeta de cliente después del campo "Nombre"
        {
            field("NumVideojuegosAlquilados"; Rec.NumVideojuegosAlquilados)
            {
                ApplicationArea = All;
                ToolTip = 'Número de videojuegos alquilados por el cliente';
                Editable = false;
            }
            field("TieneAlquilerCaducado"; Rec.TieneAlquilerCaducado)
            {
                ApplicationArea = All;
                ToolTip = 'Indica si el cliente tiene al menos un alquiler caducado';
                Editable = false;
            }
            field("Alquileres activos"; Rec."Alquileres activos")
            {
                ApplicationArea = All;
                ToolTip = 'Número de alquileres activos del cliente';
                Editable = false;
            }
        }
        addfirst(FactBoxes)
        {
            part(RentalInfo; "Alquiler Info FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No. Cliente" = FIELD("No."); //Esto hace que se muestre la información de alquileres del cliente seleccionado
            }
        }
    }

    /*------------------------------------------------------------
    | Acciones
    -------------------------------------------------------------*/
    actions
    {
        addfirst(Creation)
        {
            action("Crear Alquileres")
            {
                Caption = 'Crear Alquileres';
                ToolTip = 'Crear un nuevo alquiler para el cliente';
                ApplicationArea = All;
                Image = "Event";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Alquiler List"; //Abrir la página "Alquiler List"
                RunPageLink = "No. Cliente" = field("No."); //Pasamos el número de cliente a la página "Alquiler List"
            }
        }
    }
}