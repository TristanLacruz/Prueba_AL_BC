page 55006 "Videojuego Info FactBox"
{
    ApplicationArea = All;
    Caption = 'Videojuego Info FactBox';
    PageType = CardPart;
    SourceTable = Item;
    SourceTableView = WHERE("Item Category Code" = FILTER('VIDEOJUEGO'));

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    ToolTip = 'Foto del videojuego';
                    Editable = false;
                }
                field("Nombre del videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre del videojuego';

                    trigger OnDrillDown()
                    begin
                        PAGE.Run(Page::"Item Card", Rec); //Abrir la página "Item Card" con el cliente seleccionado

                    end;
                }
                field("Plataforma"; Rec."Plataforma")
                {
                    ApplicationArea = All;
                    ToolTip = 'Plataforma de videojuegos';
                }
                field("Veces alquilado"; Rec."Veces alquilado")
                {
                    ApplicationArea = All;
                    ToolTip = 'Número de veces que se ha alquilado el videojuego';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        TempVideojuego: Record Item; // Variable para almacenar el registro temporal
        Total: Integer; // Total de videojuegos
        Index: Integer; // Índice aleatorio
        i: Integer; // Contador
    begin
        TempVideojuego.SetRange("Item Category Code", 'VIDEOJUEGO');
        if TempVideojuego.FindSet() then begin
            Total := TempVideojuego.Count; // Contar el total de videojuegos
            if Total > 0 then begin
                Index := Random(Total) + 1; // índice entre 1 y Total
                i := 1;
                repeat
                    if i = Index then begin
                        Rec := TempVideojuego;
                        exit;
                    end;
                    i += 1;
                until TempVideojuego.Next() = 0;
            end;
        end;
    end;
}