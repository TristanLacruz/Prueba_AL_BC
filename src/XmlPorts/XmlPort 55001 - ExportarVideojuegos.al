xmlport 55001 "Exportar Videojuegos"
{
    Direction = Export;
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
                SourceTableView = WHERE("Item Category Code" = FILTER('VIDEOJUEGO')); //SourceTableView sirve para filtrar los registros que se van a exportar. En este caso, se filtran los registros de la tabla Item que tienen el campo "Item Category Code" igual a 'VIDEOJUEGO'.

                fieldelement(No; Item."No.")
                {
                }
                fieldelement(NombreVideojuego; Item."Nombre Videojuego")
                {
                }
                fieldelement(Descripcion; Item.Description)
                {
                }
                fieldelement(Plataforma; Item."Plataforma")
                {
                }
                fieldelement(Categoria; Item."Item Category Code")
                {
                }
                fieldelement(VecesAlquilado; Item."Veces alquilado")
                {
                }
            }
        }
    }
}