tableextension 55001 "GENItem" extends Item
{
    fields
    {
        field(56000; "Nombre Videojuego"; Text[100])
        {
            Caption = 'Nombre del videojuego';
            DataClassification = ToBeClassified;
        }
        field(56001; "Plataforma"; Enum "Plataformas")
        {
            Caption = 'Plataforma de videojuegos';
            DataClassification = ToBeClassified;
            InitValue = "Otro";
        }
        field(56002; "Veces alquilado"; Integer)
        {
            Caption = 'Número de veces alquilado';
            FieldClass = FlowField;
            CalcFormula = Count(Alquiler WHERE("No. Videojuego" = FIELD("No.")));
        }
        field(56004; "Esta Alquilado"; Boolean)
        {
            Caption = 'Está Alquilado';
            DataClassification = ToBeClassified;
            InitValue = true;
        }
    }

    /*------------------------------------------------------------
    | Triggers
    *-----------------------------------------------------------*/
    trigger OnInsert()
    begin
        "Esta Alquilado" := false; // Solo marcamos como alquilado si es parte de un alquiler, no al crear el videojuego
    end;

}