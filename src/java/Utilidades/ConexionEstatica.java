package Utilidades;

import Clases.Usuario;
import java.sql.*;
import java.util.ArrayList;
import javax.swing.JOptionPane;

/**
 *
 * @author adonoso
 */
public class ConexionEstatica {

    //********************* Atributos *************************
    private static java.sql.Connection Conex;
    //Atributo a través del cual hacemos la conexión física.
    private static java.sql.Statement Sentencia_SQL;
    //Atributo que nos permite ejecutar una sentencia SQL
    private static java.sql.ResultSet Conj_Registros;
    
    public static void abrirBD() {
        try {
            //Cargar el driver/controlador
            String controlador = "com.mysql.jdbc.Driver";
            Class.forName(controlador);

            String URL_BD = "jdbc:mysql://localhost/" + Constantes.BBDD;

            //Realizamos la conexión a una BD con un usuario y una clave.
            Conex = java.sql.DriverManager.getConnection(URL_BD, Constantes.usuario, Constantes.password);
            Sentencia_SQL = Conex.createStatement();
            System.out.println("Conexion realizada con éxito");
        } catch (Exception e) {
            System.err.println("Exception: " + e.getMessage());
        }
    }

    public static void cerrarBD() {
        try {
            // resultado.close();
            Conex.close();
            System.out.println("Desconectado de la Base de Datos"); // Opcional para seguridad
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error de Desconexion", JOptionPane.ERROR_MESSAGE);
        }
    }

    // Buscamos el usuario en la BBDD
    public static Usuario existeUsuario(String user) {
        Usuario existe = null;
        try {
            String sentencia = "SELECT * FROM usuarios WHERE user = '" + user + "'";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            if (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                //existe = new Usuario(Conj_Registros.getString("user"), Conj_Registros.getInt("edad"), Conj_Registros.getString("password"), Conj_Registros.getString("type"), Conj_Registros.getInt("contSesion"), Conj_Registros.getString("admin"));
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return existe;//Si devolvemos null el usuario no existe.
    }
    
    // Obtener todos los usuarios asociados al admin
    public static ArrayList<Usuario> obtenerUsuariosAdmin(String user) {
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        Usuario usu = null;
        try {
            String sentencia = "SELECT * FROM usuarios WHERE admin = '" + user + "' ORDER BY admin";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while(Conj_Registros.next()){
                
                //usu = new Usuario(Conj_Registros.getString("user"), Conj_Registros.getInt("edad"), Conj_Registros.getString("password"), Conj_Registros.getString("type"), Conj_Registros.getInt("contSesion"), Conj_Registros.getString("admin"));
                usuarios.add(usu);
            }
        } catch (SQLException ex) {
        }
        return usuarios;
    }

    // Obtener todos los usuarios (Super administrador)
    public static ArrayList<Usuario> obtenerUsuarios() {
        ArrayList<Usuario> usuarios = new ArrayList<Usuario>();
        Usuario usu = null;
        try {
            String sentencia = "SELECT * FROM usuarios ORDER BY admin";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while(Conj_Registros.next()){
                
                //usu = new Usuario(Conj_Registros.getString("user"), Conj_Registros.getInt("edad"), Conj_Registros.getString("password"), Conj_Registros.getString("type"), Conj_Registros.getInt("contSesion"), Conj_Registros.getString("admin"));
                usuarios.add(usu);
            }
        } catch (SQLException ex) {
        }
        return usuarios;
    }
    
    //----------------------------------------------------------
    public static void Modificar_Dato(String tabla,String campo, String valor, String user) throws SQLException {
        String Sentencia = "UPDATE " + tabla + " SET " + campo + " = '" + valor + "' WHERE user = '" + user + "'";
        ConexionEstatica.Sentencia_SQL.execute(Sentencia);
    }
    
    //----------------------------------------------------------
    public static void Modificar_Password(String tabla, String user, String pass) throws SQLException {
        String Sentencia = "UPDATE " + tabla + " SET password = '" + pass + "' WHERE user = '" + user + "'";
        ConexionEstatica.Sentencia_SQL.execute(Sentencia);
    }

    //----------------------------------------------------------
    public static void Insertar_Dato(String tabla, String user, String password, String type, String admin, int edad) throws SQLException {
        String Sentencia = "INSERT INTO " + tabla + " VALUES ('" + user + "','" + password + "','" + type + "','" + admin + "', " + edad + ")";
        ConexionEstatica.Sentencia_SQL.execute(Sentencia);
    }

    //----------------------------------------------------------
    public static void Borrar_Dato(String tabla, String user) throws SQLException {
        String Sentencia = "DELETE FROM " + tabla + " WHERE user = '" + user + "'";
        ConexionEstatica.Sentencia_SQL.execute(Sentencia);
    }

}
