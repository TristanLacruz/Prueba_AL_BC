codeunit 55004 "Evento NoSerie Cliente"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsert', '', false, false)]
    local procedure DatabaseCustomerOnBeforeInsert(var Customer: Record Customer; var IsHandled: Boolean)
    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "No. Series";
        CodigoSerieCliente: Code[20];
    begin
        if Customer."No." = '' then begin
            InventorySetup.Get();
            CodigoSerieCliente := 'VID-CLIENTE';
            Customer."No." := NoSeriesMgt.GetNextNo(CodigoSerieCliente, Today, true);
        end;
    end;
}
