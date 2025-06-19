table 55005 "Temp Videojuegos Alquilados"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Número';
        }
        field(2; "Nombre Videojuego"; Text[100])
        {
            Caption = 'Nombre del videojuego';
        }
        field(3; "Veces alquilado"; Integer)
        {
            Caption = 'Veces alquilado';
        }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}
