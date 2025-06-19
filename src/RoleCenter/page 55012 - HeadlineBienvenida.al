page 55012 "Headline Bienvenida"
{
    Caption = 'Bienvenido a Business Central';
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control)
            {
                ShowCaption = false;
                field(WelcomeText; WelcomeMessage)
                {
                    ApplicationArea = All;
                    Caption = 'Mensaje de Bienvenida';
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        WelcomeMessage := '¡Bienvenido a Business Central!';
    end;

    var
        WelcomeMessage: Text;
}
