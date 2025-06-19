page 55009 "Role Center Alquiler"
{
    Caption = 'MyRoleCenter';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            group(Group1)
            {
                part(part1; "Headline Bienvenida")
                {
                    ApplicationArea = All;
                }
                part(part2; "Alquiler ListPart")
                {
                    ApplicationArea = All;
                }
                part(part3; "Mis Clientes Listpart")
                {
                    ApplicationArea = All;
                }
                part(part4; "Alquiler Info FactBox")
                {
                    ApplicationArea = All;
                }
                part(part5; "Videojuego Info FactBox")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Abrir lista de alquileres")
            {
                ApplicationArea = All;
                Caption = 'Abrir Lista Alquiler';
                RunObject = Page "Alquiler List";
            }
            action("Abrir lista de clientes")
            {
                ApplicationArea = All;
                Caption = 'Abrir lista de clientes';
                Image = CustomerList;
                RunObject = page "Customer List";
            }
            action("Abrir lista de videojuegos")
            {
                ApplicationArea = All;
                Caption = 'Abrir lista de videojuegos';
                Image = List;
                RunObject = page "Lista de Videojuegos";
            }
            action("Actualizar clientes")
            {
                ApplicationArea = All;
                Caption = 'Importar Clientes';
                RunObject = Report "Importar Clientes Existentes";
                Image = Import;
            }
        }
    }
}

profile "Perfil Alquiler Videojuegos"
{
    ProfileDescription = 'Perfil de cliente para Alquiler de Videojuegos';
    RoleCenter = "Role Center Alquiler";
    Caption = 'Perfil Alquiler Videojuegos';
}