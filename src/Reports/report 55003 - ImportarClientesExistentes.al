report 55003 "Importar Clientes Existentes"
{
    Caption = 'Importar Clientes Existentes';
    ProcessingOnly = true;
    ApplicationArea = All;

    trigger OnPreReport()
    var
        CustomerRec: Record Customer;
        MisClientesRec: Record "Mis Clientes";
        ContadorClientes: Integer;
    begin
        ContadorClientes := 0;

        CustomerRec.Reset();
        if CustomerRec.FindSet() then begin
            repeat
                ContadorClientes += 1;
                if not MisClientesRec.Get(CustomerRec."No.") then begin
                    MisClientesRec.Init();
                    MisClientesRec."ID Cliente" := CustomerRec."No.";
                    MisClientesRec."Nombre Cliente" := CustomerRec.Name;
                    MisClientesRec."Videojuegos Alquilados" := 0;
                    MisClientesRec.Insert();
                end;
            until CustomerRec.Next() = 0;
        end;

        Message('Clientes encontrados: %1. Proceso completado.', ContadorClientes);
    end;
}
