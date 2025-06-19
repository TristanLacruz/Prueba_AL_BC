page 55011 "Mis Clientes Listpart"
{
    ApplicationArea = All;
    Caption = 'Mis Clientes';
    PageType = ListPart;
    SourceTable = "Mis Clientes";
    SourceTableView = where("Videojuegos Alquilados" = filter(> 0));

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("ID cliente"; Rec."ID Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'ID del Cliente';
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    ToolTip = 'Nombre del Cliente';
                }
                field("Videojuegos Alquilados"; Rec."Videojuegos Alquilados")
                {
                    ApplicationArea = All;
                    ToolTip = 'Número de videojuegos alquilados por el cliente';
                }
            }
        }
    }
}
