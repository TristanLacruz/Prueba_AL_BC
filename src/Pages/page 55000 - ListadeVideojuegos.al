page 55000 "Lista de Videojuegos"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Item; //Estandar
    SourceTableView = WHERE("Item Category Code" = FILTER('VIDEOJUEGO')); //Para que solo aparezcan los items con categoría de videojuego
    CardPageId = "Item Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ShowCaption = false; //No mostrar el título de la imagen
                    Caption = 'Foto del videojuego';
                    ToolTip = 'Foto del videojuego';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No. del artículo';
                    ToolTip = 'No. del artículo';

                    trigger OnDrillDown()
                    var
                        ItemCardPage: Page "Item Card";
                    begin
                        ItemCardPage.SetRecord(Rec);
                        ItemCardPage.RunModal();
                    end;
                }
                field("Nombre del videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                    Caption = 'Nombre del videojuego';
                    ToolTip = 'Nombre del videojuego';
                    // CaptionML = ENU = 'Name oq the videogame', ESP = 'Nombre del videojuego';
                    // ToolTipML = ENU = 'Name of the videogame', ESP = 'Nombre del videojuego';
                }
                field("Está disponible"; Rec."Esta Alquilado")
                {
                    ApplicationArea = All;
                    Caption = 'Está alquilado';
                    ToolTip = 'Indica si el videojuego está alquilado';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Caption = 'Descripción';
                    ToolTip = 'Descripción del videojuego';
                }
                field("Plataforma"; Rec."Plataforma")
                {
                    ApplicationArea = All;
                    Caption = 'Plataforma';
                    ToolTip = 'Plataforma de videojuegos';
                }
                field("Veces alquilado"; Rec."Veces alquilado")
                {
                    ApplicationArea = All;
                    Caption = 'Veces alquilado';
                    ToolTip = 'Número de veces que se ha alquilado el videojuego';

                    DrillDownPageId = "Alquiler List"; //Página a la que se redirige al hacer clic en el campo
                }
            }
        }

        area(FactBoxes)
        {
            part(VideojuegoInfo; "Videojuego Info FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."); // Esto permite que el FactBox se actualice con el registro seleccionado en la lista
            }
        }
    }

    /*------------------------------------------------------------
    | Actions
    *-----------------------------------------------------------*/
    actions
    {
        area(Processing)
        {
            action("Importar videojuegos")
            {
                ApplicationArea = All;
                Caption = 'Importar videojuegos';
                ToolTip = 'Importar videojuegos desde un archivo de Excel.';
                Image = Import;

                trigger OnAction()
                var
                    ImportVideojuegos: XmlPort "Importar Videojuegos";
                begin
                    ImportVideojuegos.Run();
                end;
            }
            action("Excel de videojuegos más alquilados")
            {
                Caption = 'Generar Excel Videojuegos más alquilados';
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "Videojuegos Mas Alquilados";
            }
        }
        area(Navigation)
        {
            action("Exportar videojuegos")
            {
                ApplicationArea = All;
                Caption = 'Exportar videojuegos';
                ToolTip = 'Exportar videojuegos a un archivo de Excel.';
                Image = Export;

                trigger OnAction()
                var
                    ExportVideojuegos: XmlPort "Exportar Videojuegos";
                begin
                    ExportVideojuegos.Run();
                end;
            }
        }
    }
}