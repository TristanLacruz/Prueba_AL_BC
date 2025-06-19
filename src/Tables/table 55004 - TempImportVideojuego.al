table 55004 TempImportVideojuego
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; "Nombre Videojuego"; Text[100]) { }
        field(3; Description; Text[100]) { }
        field(4; Plataforma; Enum "Plataformas") { }
        field(5; Categoria; Code[20]) { }
    }

    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}
