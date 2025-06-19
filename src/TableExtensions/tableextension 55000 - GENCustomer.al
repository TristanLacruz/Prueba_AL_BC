tableextension 55000 "GENCustomer" extends Customer
{
    fields
    {
        field(56000; "NumVideojuegosAlquilados"; Integer)
        {
            Caption = 'Número de videojuegos alquilados';
            FieldClass = FlowField;
            /* 
            1- Tipo de cálculo: Sum, Count, Min, Max, Average, Exist
            2- Tabla de origen: De la cual se va a sacar la información
            3- Campo objetivo (solo para Sum, Min, Max, Average): Campo de la tabla de origen que se va a calcular i.e "Amount"
            4- Filtro WHERE: Vínculo entre la tabla actual y la otra tabla
            4.1- Campo de la tabla de origen: Campo de la tabla de origen que se va a filtrar i.e "No. Cliente"
            4.2- Campo de la tabla actual: Campo de la tabla actual que se va a filtrar i.e "No." 
            
            Otro ejemplo de CalcFormula:
            CalcFormula = Exist("Sales Header" WHERE("Sell-to Customer No." = FIELD("No."), "Document Type" = CONST(Order)));

            */
            CalcFormula = count("Alquiler" where("No. Cliente" = field("No."))); //Contar todos los alquileres del cliente
            // Where el campo "No. Cliente" de la tabla Alquiler es igual al campo "No." de la tabla Customer
            Editable = false;
        }
        field(56001; "TieneAlquilerCaducado"; Boolean)
        {
            Caption = 'Tiene alquiler caducado';
            FieldClass = FlowField;
            CalcFormula = exist("Alquiler" where("No. Cliente" = field("No."), Estado = const(Caducado))); //Comprobar si el cliente tiene al menos un alquiler caducado
            Editable = false;
        }
        field(56002; "Alquileres activos"; Integer)
        {
            Caption = 'Alquileres activos';
            FieldClass = FlowField;
            CalcFormula = count("Alquiler" where("No. Cliente" = field("No."), Estado = const(Activo))); //Contar todos los alquileres activos del cliente
            Editable = false;
        }
    }

    /*------------------------------------------------------------
    | Triggers
    -------------------------------------------------------------*/
    trigger OnDelete()
    var
        AlquilerRec: Record "Alquiler";
        ItemRec: Record Item;
    begin
        AlquilerRec.Reset(); //Esto hace que se borren los filtros, 
        AlquilerRec.SetRange("No. Cliente", Rec."No."); // Filtro para buscar alquileres del cliente, SetRange es equivalente a un WHERE en SQL

        if AlquilerRec.FindSet() then begin
            repeat
                if (AlquilerRec.Estado = AlquilerRec.Estado::Activo) or
                   (AlquilerRec.Estado = AlquilerRec.Estado::Caducado) then begin

                    if Confirm('El cliente tiene alquileres activos o caducados. ¿Desea eliminarlo y devolver los videojuegos?', true) then begin

                        if AlquilerRec."No. Videojuego" <> '' then begin //Marcar videojuego como disponible (no alquilado)
                            if ItemRec.Get(AlquilerRec."No. Videojuego") then begin
                                ItemRec."Esta Alquilado" := false;
                                ItemRec.Modify();
                            end;
                        end;

                        AlquilerRec.Delete(); //Borrar el cliente
                    end else begin
                        Error('No se ha eliminado el cliente porque tiene alquileres activos o caducados.');
                    end;
                end;
            until AlquilerRec.Next() = 0;
        end;
    end;

}