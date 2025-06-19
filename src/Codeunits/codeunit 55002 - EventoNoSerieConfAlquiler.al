codeunit 55002 "Evento NoSerie ConfAlquiler"
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Table, Database::"Configuracion Alquiler", 'OnBeforeOnInsert', '', false, false)]
    local procedure MyProcedure(var ConfAlquiler: Record "Configuracion Alquiler"; var IsHandled: Boolean; xRecConfAlquiler: Record "Configuracion Alquiler")
    var
        InventorySetup: Record "Inventory Setup"; //Invetory Setup es una tabla que contiene la configuración de inventario, en este caso se usará para obtener el número de serie
        NoSeriesMgt: Codeunit "No. Series"; //Codeunit que contiene la función GetNextNo para obtener el siguiente número de serie
        CodigoSerieConfAlquiler: Code[20];
    begin
        if ConfAlquiler."No. Serie Alquiler" = '' then begin
            InventorySetup.Get();
            CodigoSerieConfAlquiler := 'VID-CONF-ALQUILER';
            IsHandled := true;
            ConfAlquiler."No. Serie Alquiler" := NoSeriesMgt.GetNextNo(CodigoSerieConfAlquiler, Today, true); // Obtener el siguiente número de serie para alquiler
        end
    end;
}
