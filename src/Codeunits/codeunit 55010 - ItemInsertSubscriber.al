codeunit 55010 "Item Insert Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeItemInsert(var Rec: Record Item; RunTrigger: Boolean)
    begin
        if Rec."Item Category Code" = 'VIDEOJUEGO' then begin
            Rec."Esta Alquilado" := false; // Evita que se ponga automáticamente en true al importar
        end;
    end;
}
