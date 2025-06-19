codeunit 55003 "Alquiler VJ Event Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::"Alquiler", 'OnBeforeAlquilarVideojuego', '', false, false)]
    local procedure ManejarValidacionAlquiler(var "No. Videojuego": Code[20]; var IsHandled: Boolean)
    var
        itemVideojuego: Record Item;
    begin
        if "No. Videojuego" <> '' then begin
            itemVideojuego.LockTable();
            itemVideojuego.Get("No. Videojuego");

            if itemVideojuego."Esta Alquilado" then begin
                Error('El videojuego %1 ya está alquilado y no está disponible', itemVideojuego."Nombre Videojuego");
                IsHandled := true;
            end;
            itemVideojuego."Esta Alquilado" := true; // Marcar el videojuego como alquilado
            itemVideojuego.Modify();
            IsHandled := true;
        end;
    end;
}