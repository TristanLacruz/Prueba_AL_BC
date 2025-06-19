table 55002 "Configuracion Alquiler"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No. Serie Alquiler"; Code[20])
        {
            Caption = 'No. Serie del Alquiler';
        }
        field(2; "Nombre Alquiler"; Code[20])
        {
            Caption = 'Nombre del Alquiler';
        }
        field(3; "Duración Prestamo Defecto"; Integer)
        {
            Caption = 'Duración del Prestamo por Defecto';
        }
        field(4; "Máximos Alquileres en Activo"; Integer)
        {
            Caption = 'Máximos Alquileres en Activo';
        }
    }

    /*-------------------------------------------------------------
    / Keys
    /------------------------------------------------------------*/
    keys
    {
        key(PK; "No. Serie Alquiler")
        {
            Clustered = true;
        }
    }

    /*-------------------------------------------------------------
    / Triggers  
    /------------------------------------------------------------*/
    trigger OnInsert()
    var
        ConfiguracionAlquileres: Record "Configuracion Alquiler";
        isHandled: Boolean;
    begin
        isHandled := false;
        OnBeforeOnInsert(Rec, isHandled, Rec); //Para añadir el número de serie
        if not isHandled then begin
            Rec."No. Serie Alquiler" := "No. Serie Alquiler";
        end;
    end;

    /*---------------------------------------------------------------------
    / Eventos
    /---------------------------------------------------------------------*/
    [IntegrationEvent(false, false)]
    local procedure OnBeforeOnInsert(var ConfAlquiler: Record "Configuracion Alquiler"; var IsHandled: Boolean; xRecConfAlquiler: Record "Configuracion Alquiler")
    begin
    end;

}