permissionset 55000 PermissionesAlquiler
{
    Assignable = true; // Indica que el permiso puede ser asignado a un usuario
    Caption = 'Permissions', MaxLength = 30;
    Permissions =
        tabledata "Configuracion Alquiler" = RMID,
        tabledata Alquiler = RMID;
}
