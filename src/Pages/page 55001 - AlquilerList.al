page 55001 "Alquiler List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Alquiler;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Foto; Rec."Foto videojuego")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'Image';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    DrillDownPageID = "Alquiler Card"; //Si pulsamos en el campo, nos llevará a la página de la tarjeta de alquiler
                }
                field("No. Tipo Alquiler"; Rec."Tipo Alquiler")
                {
                    ApplicationArea = All;

                    DrillDownPageID = "Configuracion Alquileres Card";
                }
                field("No. Cliente"; Rec."No. Cliente")
                {
                    ApplicationArea = All;
                }
                field("Nombre Cliente"; Rec."Nombre Cliente")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = EstiloTexto;
                }
                field("No. Videojuego"; Rec."No. Videojuego")
                {
                    ApplicationArea = All;
                }
                field("Nombre Videojuego"; Rec."Nombre Videojuego")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = EstiloTexto;
                }
                field("Fecha Alquiler"; Rec."Fecha Alquiler")
                {
                    ApplicationArea = All;
                    StyleExpr = EstiloTexto;
                }
                field("Fecha Devolucion"; Rec."Fecha Devolucion")
                {
                    ApplicationArea = All;
                    StyleExpr = EstiloTexto;
                }
                field(Estado; Rec.Estado)
                {
                    ApplicationArea = All;
                    StyleExpr = EstiloTexto;
                }
                field(Notas; Rec.Notas)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    /*------------------------------------------------------------
    | Acciones
    *------------------------------------------------------------*/
    actions
    {
        area(Navigation) //Botones de navegación
        {
            action("Ver Historico")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = History;

                trigger OnAction()
                var
                    HistoricoAlquileresList: Page "Historico Alquileres List";
                begin
                    HistoricoAlquileresList.Run(); //Ejecutar la página de historial de alquileres
                end;
            }
            action(New)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }

            action(Delete)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
            action("Devolver Videojuego")
            {
                Caption = 'Devolver Videojuego';
                Image = Return;
                Promoted = true; //Promocionado. Se muestra en la parte superior de la página
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Alquiler: Record Alquiler;
                begin
                    if Alquiler.Get(Rec."No.") then begin // Asegura que usas un registro fresco de BD
                        Alquiler.LockTable(); // Evita condiciones de carrera, es decir, que otros procesos no puedan modificar el mismo registro al mismo tiempo
                        Alquiler.DevolverVideojuego(); // Ya hace Modify internamente
                        Rec := Alquiler; // Refresca el Rec visible
                        CurrPage.Update();
                    end else
                        Error('No se ha podido encontrar el alquiler %1', Rec."No.");
                end;
            }
            action("Generar Recibo Cliente")
            {
                Caption = 'Generar Recibo Cliente';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    AlquilerFiltrado: Record Alquiler;
                begin
                    CurrPage.SetSelectionFilter(AlquilerFiltrado);
                    if AlquilerFiltrado.IsEmpty() then
                        Message('No se ha seleccionado ningún alquiler.')
                    else
                        Report.RunModal(Report::"Recibo Cliente", true, false, AlquilerFiltrado);
                    //Primer campo: Report::"Recibo Cliente"
                    //Segundo campo: true (imprimir en pantalla)
                    //Tercer campo: false (no imprimir en papel)
                    //Cuarto campo: AlquilerFiltrado (el alquiler filtrado que se ha seleccionado)
                end;
            }
            action("Generar Excel Alquileres")
            {
                Caption = 'Generar Excel Alquileres';
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "Alquileres Excel";
            }
        }

    }

    /*------------------------------------------------------------
    | Triggers
    *------------------------------------------------------------*/
    trigger OnOpenPage()
    begin
        Rec.SetFilter(Rec.Estado, '%1|%2', Rec.Estado::Activo, Rec.Estado::Caducado);
    end;

    trigger OnAfterGetRecord() //Después de obtener el registro, es decir
    begin
        Rec.CalcularEstado();
        ActualizarEstilo();
    end;

    /*------------------------------------------------------------
    | Funciones
    *------------------------------------------------------------*/
    local procedure ActualizarEstilo()
    begin
        if Rec.Estado = Rec.Estado::Activo then
            EstiloTexto := 'Favorable'
        else if Rec.Estado = Rec.Estado::Caducado then
            EstiloTexto := 'Unfavorable'
        else
            EstiloTexto := 'None';
    end;

    var
        EstiloTexto: Text;
}