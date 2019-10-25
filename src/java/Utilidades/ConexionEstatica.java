package Utilidades;

import Clases.Aula;
import Clases.Franja;
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

    /**
     * Buscamos si existe un usuario en la BBDD, no puede tener el mismo DNI o el mismo correo
     * @param correo
     * @return 
     */
    public static Usuario existeUsuario(String correo) {
        Usuario existe = null;
        try {
            
            String sentencia = "SELECT * FROM usuarios WHERE correo = ?";
        
            PreparedStatement sentenciaPreparada = ConexionEstatica.Conex.prepareStatement(sentencia);
            sentenciaPreparada.setString(1, correo);
            
            ConexionEstatica.Conj_Registros = sentenciaPreparada.executeQuery();
            if (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                existe = new Usuario(Conj_Registros.getString("dni"), Conj_Registros.getString("correo"), Conj_Registros.getString("nombre"), Conj_Registros.getString("apellido"), Conj_Registros.getInt("edad"), Conj_Registros.getString("password"), Conj_Registros.getInt("numLogins"), Conj_Registros.getBlob("foto"), Conj_Registros.getBytes("foto"));
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return existe; //Si devolvemos null el usuario no existe.
    }
    
    /**
     * Carga todos los roles del usuario
     * @param dni
     * @return 
     */
    public static ArrayList<Integer> cargarRoles(String dni) {
        ArrayList<Integer> roles = new ArrayList<>();
        try {
            
            String sentencia = "SELECT * FROM roles WHERE dni = ?";
        
            PreparedStatement sentenciaPreparada = ConexionEstatica.Conex.prepareStatement(sentencia);
            sentenciaPreparada.setString(1, dni);
            
            ConexionEstatica.Conj_Registros = sentenciaPreparada.executeQuery();
            while (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                roles.add(Conj_Registros.getInt("idRol"));
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return roles; //Si devolvemos null no hay roles.
    }
    
    /**
     * Obtiene todas las aulas que haya en BBDD
     * @return 
     */
    public static ArrayList<Franja> obtenerFranjas() {
        ArrayList<Franja> franjas = new ArrayList<>();
        Franja franja = null;
        try {
            String sentencia = "SELECT * FROM franjas";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while(Conj_Registros.next()){
                franja = new Franja(Conj_Registros.getInt("idAula"), Conj_Registros.getString("frStart"), Conj_Registros.getString("frEnd"));
                franjas.add(franja);
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return franjas;
    }
    
    /**
     * Obtiene todas las aulas que haya en BBDD
     * @return 
     */
    public static ArrayList<Aula> obtenerAulas() {
        ArrayList<Aula> aulas = new ArrayList<>();
        Aula aula = null;
        try {
            String sentencia = "SELECT * FROM aulas";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while(Conj_Registros.next()){
                aula = new Aula(Conj_Registros.getInt("idAula"), Conj_Registros.getString("descripcion"));
                aulas.add(aula);
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return aulas;
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
    public static void Modificar_Dato(String tabla,String campo, String valor, String correo) throws SQLException {
        String Sentencia = "UPDATE " + tabla + " SET " + campo + " = '" + valor + "' WHERE correo = '" + correo + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }
    
    //----------------------------------------------------------
    public static void Modificar_Password(String tabla, String user, String pass) throws SQLException {
        String Sentencia = "UPDATE " + tabla + " SET password = '" + pass + "' WHERE user = '" + user + "'";
        ConexionEstatica.Sentencia_SQL.execute(Sentencia);
    }

    /**
     * Inserta un profesor en la tabla de usuarios
     * @param tabla
     * @param correo
     * @param dni
     * @param edad
     * @param pass
     * @param nombre
     * @param apellido
     * @throws SQLException 
     */
    public static void Insertar_Profesor(String tabla, String correo, String dni, int edad, String pass, String nombre, String apellido) throws SQLException {
        
        String sentencia = "INSERT INTO " + tabla + " VALUES (?,?,?,?,?,?,?,?,?)";
        
        PreparedStatement sentenciaPreparada = ConexionEstatica.Conex.prepareStatement(sentencia);
        sentenciaPreparada.setString(1, dni);
        sentenciaPreparada.setString(2, correo);
        sentenciaPreparada.setString(3, pass);
        sentenciaPreparada.setInt(4, 0);
        sentenciaPreparada.setString(5, nombre);
        sentenciaPreparada.setString(6, apellido);
        sentenciaPreparada.setInt(7, edad);
        sentenciaPreparada.setString(8, null);
        sentenciaPreparada.setInt(9, Constantes.inactive);
        
        sentenciaPreparada.executeUpdate();
        
        String sentenciaRoles = "INSERT INTO roles VALUES (?,?)";
        
        PreparedStatement sentenciaPrepRoles = ConexionEstatica.Conex.prepareStatement(sentenciaRoles);
        sentenciaPrepRoles.setString(1, dni);
        sentenciaPrepRoles.setInt(2, Constantes.typeUsr);
        
        sentenciaPrepRoles.executeUpdate();
        
    }

    //----------------------------------------------------------
    public static void Borrar_Dato(String tabla, String user) throws SQLException {
        String Sentencia = "DELETE FROM " + tabla + " WHERE user = '" + user + "'";
        ConexionEstatica.Sentencia_SQL.execute(Sentencia);
    }

}
