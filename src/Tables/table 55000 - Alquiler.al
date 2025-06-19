table 55000 Alquiler
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No. alquiler';
        }
        field(2; "No. Cliente"; Code[20])
        {
            Caption = 'No. cliente';
            TableRelation = Customer;

            trigger OnValidate() //Cuando se valida el campo, se añade automáticamente el nombre del cliente
            var
                cliente: Record "Customer";
            begin
                if ("No. Cliente" <> '') then begin
                    cliente.Get("No. Cliente");
                    Rec."Nombre Cliente" := cliente."Name";
                end;
            end;
        }
        field(3; "Nombre Cliente"; Text[50])
        {
            Caption = 'Nombre del cliente';
            Editable = false;

            trigger OnValidate() //El campo "Nombre Cliente" no puede estar vacío
            begin
                if "Nombre Cliente" = '' then
                    Error(EsteCampoNoPuedeEstarVacioErr + ' (:' + "Nombre Cliente" + ')');
            end;
        }
        field(4; "No. Videojuego"; Code[20])
        {
            Caption = 'No. videojuego';
            TableRelation = Item WHERE("Item Category Code" = CONST('VIDEOJUEGO')); //De todos los productos de la tabla Item, solo aparecerán los que tengan la categoría 'VIDEOJUEGO'

            trigger OnValidate()
            var
                itemVideojuego: Record Item;
                tenantmedia: Record "Tenant Media"; //Para obtener la imagen del videojuego. Tenant Media es una tabla que contiene todas las imágenes de los productos
                inStr: InStream; //Para leer flujos de datos, en este caso para leer la imagen del videojuego
            begin
                if "No. Videojuego" <> '' then begin
                    itemVideojuego.Get("No. Videojuego");
                    if itemVideojuego."Esta Alquilado" = true then
                        Error('El videojuego %1 ya está alquilado.', itemVideojuego."Nombre Videojuego");
                    Rec."Nombre Videojuego" := itemVideojuego."Nombre Videojuego"; //Se añade automáticamente el nombre del videojuego
                    if Tenantmedia.Get(itemVideojuego.Picture.Item(1)) then begin //Usa el primer elemento del campo Picture. Picture es un campo de tipo MediaSet, que contiene la imagen del videojuego
                        Tenantmedia.CalcFields(Content); //Calcula los campos de Tenant Media (BLOB)
                        Tenantmedia.Content.CreateInStream(inStr); //Crea un flujo de datos para leer la imagen. Content es un campo de tipo BLOB que contiene la imagen del videojuego
                        Rec."Foto videojuego".ImportStream(inStr, itemVideojuego."Nombre Videojuego"); //Importa la imagen del videojuego al campo "Foto videojuego"
                    end;
                end
            end;
        }
        field(5; "Nombre Videojuego"; Text[50])
        {
            Caption = 'Nombre del videojuego';
            Editable = false;
        }
        field(6; "Foto videojuego"; MediaSet)
        {
            Caption = 'Foto del videojuego';
            Editable = false;
            TableRelation = Item.Picture; //Relación con la tabla Item, campo Picture.
        }
        field(7; "Tipo Alquiler"; Code[20])
        {
            Caption = 'Tipo de alquiler';
            TableRelation = "Configuracion Alquiler"."No. Serie Alquiler"; //Relación con la tabla Configuración Alquiler, campo No. Serie Alquiler

            trigger OnValidate()
            begin
                CalcularFechaDevolucion();
            end;
        }
        field(8; "Fecha Alquiler"; DateTime)
        {
            Caption = 'Fecha de alquiler';

            trigger OnValidate()
            begin
                CalcularFechaDevolucion();
            end;
        }
        field(9; "Fecha Devolucion"; DateTime)
        {
            Caption = 'Fecha de devolución';
            Editable = false;

            trigger OnValidate()
            begin
                CalcularEstado();
            end;
        }
        field(10; Estado; Option)
        {
            Caption = 'Estado';
            OptionMembers = Activo,Devuelto,Caducado;
        }
        field(11; Notas; Text[250])
        {
            Caption = 'Notas';
        }
    }


    /*------------------------------------------------------------
    | Keys
    |------------------------------------------------------------*/
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    /*------------------------------------------------------------
    | Triggers
    |------------------------------------------------------------*/
    trigger OnInsert()
    var
        ConfigAlquiler: Record "Configuracion Alquiler";
        CantAlquileresCliente: Record "Customer";
        AlquilerActivo: Record Alquiler;
        MaxAlquileres: Integer;
        isHandled: Boolean;
        itemVideojuego: Record Item;
        MisClientes: Record "Mis Clientes";
    begin
        isHandled := false;
        OnBeforeOnInsert(Rec, isHandled, Rec);
        if not isHandled then begin
            Rec."No." := "No.";
        end;

        "Fecha Alquiler" := CurrentDateTime;
        "Estado" := Estado::Activo;

        // if "Tipo Alquiler" <> '' then begin
        //     if ConfigAlquiler.Get("Tipo Alquiler") then
        //         MaxAlquileres := ConfigAlquiler."Máximos Alquileres en Activo"
        //     else
        //         MaxAlquileres := 0;
        //     Message('No se ha encontrado la configuración de alquiler para el tipo de alquiler seleccionado.');
        // end else
        //     MaxAlquileres := 0;
        // Message('No se ha seleccionado un tipo de alquiler.');

        // AlquilerActivo.Reset();
        // AlquilerActivo.SetRange("No. Cliente", Rec."No. Cliente");
        // AlquilerActivo.SetRange(Estado, Estado::Activo);
        // if (MaxAlquileres > 0) and (AlquilerActivo.Count >= MaxAlquileres) then
        //     Error('El cliente no puede tener más de %1 alquileres activos.', MaxAlquileres)
        // else
        //     Message('El cliente %1 tiene %2 alquileres activos.', Rec."No. Cliente", AlquilerActivo.Count);

        if "Tipo Alquiler" <> '' then
            CalcularFechaDevolucion();

        // Marcar el videojuego como alquilado si el estado es Activo o Caducado
        if ("Estado" = "Estado"::Activo) or ("Estado" = "Estado"::Caducado) then begin
            if "No. Videojuego" <> '' then begin
                itemVideojuego.LockTable();
                itemVideojuego.Get("No. Videojuego");

                if itemVideojuego."Esta Alquilado" then
                    Error('El videojuego %1 ya está alquilado y no está disponible', itemVideojuego."Nombre Videojuego");

                itemVideojuego."Esta Alquilado" := true;
                itemVideojuego.Modify();
            end;
        end;

        if MisClientes.Get("No. Cliente") then begin
            MisClientes."Videojuegos Alquilados" += 1;
            MisClientes.Modify();
        end;
    end;

    trigger OnModify()
    var
        itemVideojuego: Record Item;
    begin
        if "Fecha Alquiler" <> 0DT then
            CalcularFechaDevolucion();

        // Actualizar el estado del videojuego si el estado del alquiler cambia
        if ("Estado" = "Estado"::Activo) or ("Estado" = "Estado"::Caducado) then begin
            if "No. Videojuego" <> '' then begin
                itemVideojuego.LockTable();
                itemVideojuego.Get("No. Videojuego");
                itemVideojuego."Esta Alquilado" := true;
                itemVideojuego.Modify();
            end;
        end else if "Estado" = "Estado"::Devuelto then begin
            if "No. Videojuego" <> '' then begin
                itemVideojuego.LockTable();
                itemVideojuego.Get("No. Videojuego");
                itemVideojuego."Esta Alquilado" := false;
                itemVideojuego.Modify();
            end;
        end;
    end;

    trigger OnDelete()
    var
        itemVideojuego: Record Item;
        MisClientes: Record "Mis Clientes";
        AlquilerRec: Record Alquiler;
    begin
        // Verificar si el videojuego tiene otros alquileres activos
        if "No. Videojuego" <> '' then begin
            AlquilerRec.SetRange("No. Videojuego", "No. Videojuego");
            AlquilerRec.SetRange(Estado, AlquilerRec.Estado::Activo);
            AlquilerRec.SetFilter("No.", '<>%1', "No."); // Excluimos el alquiler que vamos a borrar

            if AlquilerRec.IsEmpty() then begin
                // No tiene más alquileres activos, podemos liberarlo
                itemVideojuego.Get("No. Videojuego");
                itemVideojuego."Esta Alquilado" := false;
                itemVideojuego.Modify();
            end;
        end;

        // Actualizar contador de videojuegos alquilados
        if MisClientes.Get("No. Cliente") then begin
            MisClientes."Videojuegos Alquilados" -= 1;
            MisClientes.Modify();
        end;
    end;


    /*------------------------------------------------------------
    | Functions
    |------------------------------------------------------------*/
    procedure CalcularFechaDevolucion()
    var
        ConfigAlquiler: Record "Configuracion Alquiler"; //Obtener la configuración del alquiler
        DuracionPrestamoText: Text; //Texto que representa la duración del préstamo
        DuracionPrestamo: Duration; //Duration es un tipo de datos que representa un intervalo de tiempo
    begin
        if "Tipo Alquiler" <> '' then begin
            ConfigAlquiler.Get("Tipo Alquiler"); //Obtener la configuración del alquiler

            DuracionPrestamoText := Format(ConfigAlquiler."Duración Prestamo Defecto") + 'D'; // Convertir el número de días a texto con formato duración (ejemplo: '10D' para 10 días)

            Evaluate(DuracionPrestamo, DuracionPrestamoText); // Convertir el texto a tipo Duration. Evaluate es una función que evalúa una expresión y la asigna a una variable

            "Fecha Devolucion" := "Fecha Alquiler" + DuracionPrestamo; //Calcular la fecha
        end
        else
            "Fecha Devolucion" := 0DT;
    end;

    procedure CalcularEstado()
    begin
        if Estado <> Estado::Devuelto then begin
            if "Fecha Devolucion" = 0DT then
                Estado := Estado::Activo // Si aún no hay fecha, lo dejamos en Activo
            else if "Fecha Devolucion" < CurrentDateTime then
                Estado := Estado::Caducado
            else
                Estado := Estado::Activo;
        end;
    end;


    procedure DevolverVideojuego()
    var
        itemVideojuego: Record Item;
    begin
        if Estado = Estado::Activo then begin
            Estado := Estado::Devuelto;
            Modify();

            if "No. Videojuego" <> '' then begin
                itemVideojuego.Get("No. Videojuego");
                itemVideojuego."Esta Alquilado" := false;
                itemVideojuego.Modify();
            end;
        end;
    end;

    local procedure CampoVacio(Campo: Text[50]) // Validar si un campo está vacío
    begin
        if Campo = '' then
            Error(EsteCampoNoPuedeEstarVacioErr + ' (:' + Campo + ')');
    end;

    /*------------------------------------------------------------
    | Variables
    |------------------------------------------------------------*/
    var
        EsteCampoNoPuedeEstarVacioErr: Label 'Este campo no puede dejarse en blanco.';

    /*------------------------------------------------------------
    | Eventos
    |------------------------------------------------------------*/
    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var Alquiler: Record Alquiler; var IsHandled: Boolean; xRecAlquiler: Record Alquiler)
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnBeforeAlquilarVideojuego(var "No. Videojuego": Code[20]; var IsHandled: Boolean)
    begin
    end;
}

























