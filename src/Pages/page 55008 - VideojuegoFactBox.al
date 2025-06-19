page 55008 "Videojuego FactBox"
{
    ApplicationArea = All;
    Caption = 'Información del videojuego';
    PageType = CardPart;
    SourceTable = Item;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Detalles del videojuego';

                field("Nombre Videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre del videojuego';
                }
                field("Total veces alquilado"; Rec."Veces alquilado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Número total de veces que se ha alquilado';
                }
            }

            repeater(ClienteAlquiler)
            {
                Caption = 'Alquileres por Cliente';

                field("Customer Name"; ClienteAlquilerRec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Veces alquilado"; ClienteAlquilerRec."Veces alquilado")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    /*-------------------------------------------------------------
    | Triggers
    |-------------------------------------------------------------*/
    trigger OnAfterGetRecord()
    begin
        CargarClientesAlquiler();
    end;

    local procedure CargarClientesAlquiler()
    begin
        ClienteAlquilerRec.DeleteAll(); //Limpiar la tabla temporal. Esta tabla se utiliza para almacenar temporalmente los clientes que han alquilado el videojuego actual.

        AlquilerRec.Reset(); //Buscar todos los alquileres para el videojuego actual.
        AlquilerRec.SetRange("No. Videojuego", Rec."No.");

        if AlquilerRec.FindSet() then begin
            repeat
                if not ClienteAlquilerRec.Get(AlquilerRec."No. Cliente") then begin //Comprobar si el cliente ya está en la tabla temporal.
                    ClienteAlquilerRec.Init(); //'Init' inicializa la tabla temporal.
                    ClienteAlquilerRec."Customer No." := AlquilerRec."No. Cliente";
                    if CustomerRec.Get(AlquilerRec."No. Cliente") then
                        ClienteAlquilerRec."Customer Name" := CustomerRec.Name; //Si el cliente existe, copiar el nombre del cliente.
                    ClienteAlquilerRec."Veces alquilado" := 1;
                    ClienteAlquilerRec.Insert(); //Insertar el cliente en la tabla temporal.
                end else begin
                    ClienteAlquilerRec."Veces alquilado" += 1; //Incrementar el número de veces que el cliente ha alquilado el videojuego.
                    ClienteAlquilerRec.Modify();
                end;
            until AlquilerRec.Next() = 0;
        end;
    end;

    var
        ClienteAlquilerRec: Record "Cliente Alquiler Temporal" temporary; //'temporary' indica que la tabla se utiliza solo en la página actual y no se almacena en la base de datos.
        AlquilerRec: Record Alquiler;
        CustomerRec: Record Customer;
}