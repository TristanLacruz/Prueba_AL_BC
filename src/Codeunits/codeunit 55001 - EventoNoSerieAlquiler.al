codeunit 55001 "Evento NoSerie Alquiler"
{
    SingleInstance = true; //Singleton, una sola instancia de este objeto por sesión

    [EventSubscriber(ObjectType::Table, Database::Alquiler, 'OnBeforeOnInsert', '', false, false)] //Evento que se dispara antes de insertar un registro en la tabla Alquiler
    local procedure OnBeforeOnInsert(var Alquiler: Record Alquiler; var IsHandled: Boolean; xRecAlquiler: Record Alquiler) //Parámetros del evento
    var
        InventorySetup: Record "Inventory Setup"; //Para almacenar el registro de configuración de inventario
        NoSeriesMgt: Codeunit "No. Series"; //Para obtener el siguiente número de serie
        CodigoSerieAlquiler: Code[20]; //Código de la serie de alquiler
    begin
        if Alquiler."No." = '' then begin
            InventorySetup.Get(); //Obtener el registro de configuración de inventario
            CodigoSerieAlquiler := 'VID-ALQUILER'; //Código de la serie de alquiler
            IsHandled := true; //Indica que el evento ha sido manejado
            Alquiler."No." := NoSeriesMgt.GetNextNo(CodigoSerieAlquiler, Today, true); //Obtener el siguiente número de serie
        end
    end;
}
