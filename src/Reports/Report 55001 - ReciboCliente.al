report 55001 "Recibo Cliente"
{
    Caption = 'Recibo Cliente';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = 'src/Reports/ReciboCliente.docx';

    dataset
    {
        dataitem(Alquiler; "Alquiler")
        {
            column(Nombre_Videojuego; "Nombre Videojuego")
            {
            }
            column(No_Videojuego; "No. Videojuego")
            {
            }
            column(Imagen; "Foto videojuego")
            {
            }
            column(Nombre_Cliente; "Nombre Cliente")
            {
            }
            column(ID_Alquiler; "No.")
            {
            }
            column(Fecha_Alquiler; "Fecha Alquiler")
            {
            }
            column(Fecha_Devolucion; "Fecha Devolucion")
            {
            }
        }
    }
}