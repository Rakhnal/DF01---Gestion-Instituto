/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author alvaro
 */
public class Usuario {

    private String dni;
    private String correo;
    private String nombre;
    private String apellido;
    private int edad;
    private String pass;
    private ArrayList<Integer> idRols;
    private int numLogins;
    private Blob foto;
    private byte [] fotoBytes;
    private int activo;

    public Usuario(String dni, String correo, String nombre, String apellido, int edad, String pass, int numLogins, Blob foto, byte [] fotoBytes, int activo) {
        this.dni = dni;
        this.correo = correo;
        this.nombre = nombre;
        this.apellido = apellido;
        this.edad = edad;
        this.pass = pass;
        this.numLogins = numLogins;
        this.foto = foto;
        this.fotoBytes = fotoBytes;
        this.idRols = new ArrayList<>();
        this.activo = activo;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }
    
    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public ArrayList<Integer> getIdRols() {
        return idRols;
    }

    public void setIdRols(ArrayList<Integer> idRols) {
        this.idRols = idRols;
    }

    public int getNumLogins() {
        return numLogins;
    }

    public void setNumLogins(int numLogins) {
        this.numLogins = numLogins;
    }

    public Blob getFoto() {
        return foto;
    }

    public void setFoto(Blob foto) {
        this.foto = foto;
    }

    public byte[] getFotoBytes() {
        return fotoBytes;
    }

    public void setFotoBytes(byte[] fotoBytes) {
        this.fotoBytes = fotoBytes;
    }

    // Enviamos un correo al usuario para informar del reestablecimiento de la contraseña
    public boolean sendEmail() {

        boolean result = false;

        String de = "auxiliardaw2@gmail.com";
        String clave = "Chubaca20";
        String para = this.correo;
        String mensaje= "Se ha reestablecido la contraseña de su cuenta, si no ha sido usted consulte con el administrador";
        String asunto = "Contraseña reestablecida";
        
        try{
            
                String host = "smtp.gmail.com";
                
                Properties prop = System.getProperties();
                
                prop.put("mail.smtp.starttls.enable","true");
                prop.put("mail.smtp.host", host);
                prop.put("mail.smtp.user",de);
                prop.put("mail.smtp.password", clave);
                prop.put("mail.smtp.port",587);
                prop.put("mail.smtp.auth","true");
                
                Session sesion = Session.getInstance(prop,null);
                
                MimeMessage message = new MimeMessage(sesion);
                
                message.setFrom(new InternetAddress(de));

                
                message.setRecipient(Message.RecipientType.TO, new InternetAddress(para));
                
                message.setSubject(asunto);
                message.setText(mensaje);
                
                Transport transport = sesion.getTransport("smtp");
                
                transport.connect(host,de,clave);
                
                transport.sendMessage(message, message.getAllRecipients());
                
                transport.close();
                
                result = true;
            }catch(Exception e){
                e.printStackTrace();
                result = false;
            }
        
        return result;
    }
}
