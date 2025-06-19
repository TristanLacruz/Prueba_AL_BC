codeunit 55000 "Evento NoSerie Videojuego"
{
    SingleInstance = true; //Singleton, una sola instancia por cada sesion de usuario

    //teventsubwaldo --> snippet

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeOnInsert', '', false, false)]
    local procedure DatabaseItemOnBeforeOnInsert(var Item: Record Item; var IsHandled: Boolean; xRecItem: Record Item)
    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "No. Series";
        CodigoSerieVideojuego: Code[20];
    begin
        if Item."No." = '' then begin
            InventorySetup.Get();
            // InventorySetup.TestField(x); //TestField es un campo de la tabla Inventory Setup
            CodigoSerieVideojuego := 'VID-JUEGO';
            IsHandled := true;
            Item."No." := NoSeriesMgt.GetNextNo(CodigoSerieVideojuego, Today, true);
        end;
    end;
}
