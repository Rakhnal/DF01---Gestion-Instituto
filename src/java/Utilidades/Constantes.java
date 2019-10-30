/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utilidades;

/**
 *
 * @author adonoso
 */
public class Constantes {
    
    // Bitacora
    public static String registered = "Registrado";
    public static String login = "Iniciar Sesion";
    public static String logout = "Cerrar Sesion";
    public static String dropProfesorLog = "Quitar Rol Profesor";
    public static String riseProfesorLog = "Poner Rol Profesor";
    public static String dropAdminAuLog = "Quitar Rol Admin Aulas";
    public static String riseAdminAuLog = "Poner Rol Admin Aulas";
    public static String dropAdminGeLog = "Quitar Rol Admin Gen.";
    public static String riseAdminGeLog = "Poner Rol Admin Gen.";
    public static String strActivateLog = "Activar Usuario";
    public static String strDeactivateLog = "Desactivar Usuario";
    public static String reservarAula = "Aula reservada";
    public static String cancelarReserva = "Reserva cancelada";
    public static String modificarUser = "Modificar Usuario";
    public static String borrarUser = "Borrar Usuario";
    public static String newUser = "Nuevo Usuario";
    public static String aniadirAula = "Añadir Aula";
    public static String borrarAula = "Borrar Aula";
    public static String modificarAula = "Modificar Aula";
    public static String modificarFranja = "Modificar Franja";
    public static String cambiarImagen = "Cambiar imagen de perfil";
    public static String cambiarPass = "Contraseña cambiada";
    
    // Administración de usuarios
    public static String dropProfesor = "Quitar Profesor";
    public static String riseProfesor = "Poner Profesor";
    public static String dropAdminAu = "Quitar Admin Aulas";
    public static String riseAdminAu = "Poner Admin Aulas";
    public static String dropAdminGe = "Quitar Admin Gen.";
    public static String riseAdminGe = "Poner Admin Gen.";
    public static String strActivate = "Activar";
    public static String strDeactivate = "Desactivar";
    
    // Utilidades
    public static String ficheroBitacora = "bitacora.txt";
    public static int active = 1;
    public static int inactive = 0;
    public static int maxSessionTime = 300;
    
    // Tipos Roles
    public static String strUsr = "Profesor";
    public static String strAdminAu = "Administrador de Aulas";
    public static String strAdminGe = "Administrador General";
    public static int typeAdminge = 2;
    public static int typeAdminau = 1;
    public static int typeUsr = 0;
    
    // Conexión BBDD
    public static String BBDD = "gestioninst";
    public static String usuario = "adminServer";
    public static String password = "Chubaca2019";
    
    // Tablas BBDD
    public static String usuarios = "usuarios";
    public static String roles = "roles";
    public static String reservas = "reservas";
    public static String franjas = "franjas";
    public static String aulas = "aulas";
}
