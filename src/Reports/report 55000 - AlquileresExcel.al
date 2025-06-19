report 55000 "Alquileres Excel"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    Caption = 'Videojuegos alquilados y clientes';
    ExcelLayout = 'src/Reports/Layouts/VideojuegosAlquilados.xlsx'; //Ruta

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = WHERE("Item Category Code" = FILTER('VIDEOJUEGO'), "Esta Alquilado" = CONST(true));
            RequestFilterFields = "No."; //Filtro para que se muestre el campo No.

            column(No_Videojuego; "No.")
            {
                IncludeCaption = true;
            }
            column(Nombre_Videojuego; "Nombre Videojuego")
            {
                IncludeCaption = true;
            }
            column(Plataforma; Plataforma)
            {
                IncludeCaption = true;
            }
            column(Veces_Alquilado; "Veces alquilado")
            {
                IncludeCaption = true;
            }
            column(Esta_Alquilado; "Esta Alquilado")
            {
                IncludeCaption = true;
            }

            dataitem(Alquiler; Alquiler) //Para que se muestren los datos de la tabla Alquiler
            {
                DataItemLink = "Nombre Videojuego" = field("Nombre Videojuego"); //Para que se muestren los datos de la tabla Alquiler que coincidan con el campo Nombre Videojuego. DataItemLink = "Nombre Videojuego" = field("Nombre Videojuego") es como un JOIN en SQL

                column(No_Cliente; "No. Cliente")
                {
                    IncludeCaption = true;
                }
                column(Nombre_Cliente; "Nombre Cliente")
                {
                    IncludeCaption = true;
                }
                column(Fecha_Alquiler; "Fecha Alquiler")
                {
                    IncludeCaption = true;
                }
                column(Fecha_Devolucion; "Fecha Devolucion")
                {
                    IncludeCaption = true;
                }
                column(Estado; Estado)
                {
                    IncludeCaption = true;
                }
                column(Notas; Notas)
                {
                    IncludeCaption = true;
                }
            }
        }
    }
}