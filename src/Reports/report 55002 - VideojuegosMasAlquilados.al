report 55002 "Videojuegos Mas Alquilados"
{
    Caption = 'Videojuegos más alquilados';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'src/Reports/Layouts/VideojuegosMasAlquilados.xlsx';

    dataset
    {
        dataitem(TempVideojuegos; "Temp Videojuegos Alquilados")
        {
            column(No_Videojuego; TempVideojuegos."No.")
            {
            }
            column(Nombre_Videojuego; TempVideojuegos."Nombre Videojuego")
            {
            }
            column(Veces_Alquilado; TempVideojuegos."Veces alquilado")
            {
            }

            trigger OnPreDataItem() // Se ejecuta antes de que se carguen los datos
            var
                ItemRec: Record Item;
                HasData: Boolean; // Variable para verificar si hay datos
            begin
                HasData := false;
                ItemRec.Reset(); // Reinicia el registro
                ItemRec.SetRange("Item Category Code", 'VIDEOJUEGO'); // Filtra por categoría de videojuegos

                if ItemRec.FindSet() then begin // Encuentra el primer registro
                    repeat
                        ItemRec.CalcFields("Veces alquilado"); // Calcula el campo "Veces alquilado" (FlowField)

                        if ItemRec."Veces alquilado" >= MinAlquileres then begin // Verifica si cumple el mínimo de veces
                            TempVideojuegos.Init(); // Inicializa el registro temporal, esto es importante para evitar errores
                            TempVideojuegos."No." := ItemRec."No."; // Asigna el número de videojuego
                            TempVideojuegos."Nombre Videojuego" := ItemRec."Nombre Videojuego"; // Asigna el nombre del videojuego
                            TempVideojuegos."Veces alquilado" := ItemRec."Veces alquilado"; // Asigna el número de veces alquilado
                            TempVideojuegos.Insert(); // Inserta el registro en la tabla temporal
                            HasData := true;
                        end;
                    until ItemRec.Next() = 0;
                end;

                if not HasData then
                    Error('No hay videojuegos alquilados que cumplan el mínimo de veces especificado.');

                // Orden descendente
                TempVideojuegos.SetCurrentKey("Veces alquilado");
                TempVideojuegos.Ascending(false);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Group)
                {
                    field(MinAlquileres; MinAlquileres)
                    {
                        ApplicationArea = All;
                        Caption = 'Mínimo de veces alquilado';
                        ToolTip = 'Filtrar videojuegos alquilados al menos este número de veces.';
                    }
                }
            }
        }
    }

    var
        MinAlquileres: Integer; // Variable para el mínimo de veces alquilado (Sería algo así como el MIN_INTEGER)
}
