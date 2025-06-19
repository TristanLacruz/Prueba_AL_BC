codeunit 55005 "Cliente Event Subscriber"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Name', false, false)]
    local procedure OnAfterValidateName(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        Alquiler: Record Alquiler;
        ConfirmMessage: Label '¿Desea crear un nuevo alquiler para el cliente %1?', Comment = '%1 = Nombre del cliente';
    begin
        if Rec.Name <> xRec.Name then begin
            if Confirm(ConfirmMessage, false, Rec.Name) then begin
                Alquiler.Init(); //Crear e insertar el alquiler
                Alquiler."No. Cliente" := Rec."No.";
                Alquiler."Nombre Cliente" := Rec.Name;
                Alquiler.Insert(true); // Insertar en la base de datos
                PAGE.Run(PAGE::"Alquiler Card", Alquiler); // Abrir página Card con el alquiler guardado
            end;
        end;
    end;
}
