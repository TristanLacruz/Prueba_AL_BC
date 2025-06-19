table 55003 "Mis Clientes"
{
    Caption = 'Mis Clientes';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID Cliente"; Code[50])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'ID Cliente';
            TableRelation = Customer."No.";
            ValidateTableRelation = false;
        }
        field(2; "Nombre Cliente"; Text[100])
        {
            Caption = 'Nombre Cliente';
            Editable = false;
        }
        field(3; "Videojuegos Alquilados"; Integer)
        {
            Caption = 'Videojuegos Alquilados';
            FieldClass = FlowField;
            CalcFormula = count(Alquiler where("No. Cliente" = field("ID Cliente")));
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "ID Cliente")
        {
            Clustered = true;
        }
        key(Key2; "Nombre Cliente")
        {
        }
    }
}
