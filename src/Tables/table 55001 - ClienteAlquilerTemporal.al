table 55001 "Cliente Alquiler Temporal" // Para poder mostrar en la factbox de videojuego
{
    DataClassification = ToBeClassified;
    Caption = 'Cliente Alquiler Temporal';

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Cliente';
        }
        field(2; "Customer Name"; Text[100])
        {
            Caption = 'Nombre Cliente';
        }
        field(3; "Veces alquilado"; Integer)
        {
            Caption = 'Veces alquilado';
        }
    }

    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }
}
