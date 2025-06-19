xmlport 55000 "Importar Videojuegos"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    TextEncoding = UTF8;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                AutoSave = false;

                fieldelement(No; Item."No.") { }
                fieldelement(NombreVideojuego; Item."Nombre Videojuego") { }
                fieldelement(Descripcion; Item.Description) { }
                fieldelement(Plataforma; Item."Plataforma") { }
                fieldelement(Categoria; Item."Item Category Code") { }

                trigger OnBeforeInsertRecord()
                begin
                    Item.Insert();
                end;
            }
        }
    }
}
