<%-- 
    Document   : subefichero
    Created on : 20-oct-2019, 18:06:24
    Author     : fernando
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Utilidades.Constantes"%>
<%@page import="Clases.Usuario"%>
<%@page import="Utilidades.ConexionEstatica"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.FileItemFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    if (session != null && session.getAttribute("sesUsr") != null) {
    
        ConexionEstatica.abrirBD();

        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        List items = upload.parseRequest(request);
        Usuario user = (Usuario) session.getAttribute("sesUsr");

        // Se recorren todos los items, que son de tipo FileItem
        for (Object item : items) {
            FileItem uploaded = (FileItem) item;

            // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
            // subido donde nos interese.
            if (!uploaded.isFormField()) {
                // Es un campo fichero: guardamos el fichero en alguna carpeta (en este caso perfiles).
                //Si lo ponemos como sigue: el archivo se guardará en 'glassfish5/glassfish/domains/domain1/config/perfiles'.
                //Este directorio, por seguridad, luego no será accesible.
                String rutaDestino = "perfiles/";
                File fichero = new File(rutaDestino, user.getDni() + ".jpg"); //El archivo se guardará en 'glassfish5/glassfish/domains/domain1/config/perfiles'.

                uploaded.write(fichero);
                //Pasamos a binario la imagen para almacenarla en MySQL en el campo BLOB.
                byte[] icono = new byte[(int) fichero.length()];
                InputStream input = new FileInputStream(fichero);
                input.read(icono);
                user.setFotoBytes(icono);
                input.close();

                fichero.delete();
            }
        }

        String fechaHora = (new java.util.Date()).toString();
        ConexionEstatica.insertarLog(Constantes.cambiarImagen, fechaHora, user.getCorreo(), Constantes.strAdminAu);

        if (user.getIdRols().contains(Constantes.typeAdminge)) {
            ConexionEstatica.insertarLog(Constantes.cambiarImagen, fechaHora, user.getCorreo(), Constantes.strAdminGe);
        } else if (user.getIdRols().contains(Constantes.typeAdminau)) {
            ConexionEstatica.insertarLog(Constantes.cambiarImagen, fechaHora, user.getCorreo(), Constantes.strAdminAu);
        } else {
            ConexionEstatica.insertarLog(Constantes.cambiarImagen, fechaHora, user.getCorreo(), Constantes.strUsr);
        }

        ConexionEstatica.cambiarImagen(user);

        user = ConexionEstatica.existeUsuario(user.getCorreo());
        ArrayList<Integer> roles = ConexionEstatica.cargarRoles(user.getDni());

        user.setIdRols(roles);
        session.setAttribute("sesUsr", user);
    
        ConexionEstatica.cerrarBD();

        response.sendRedirect("../vistas/Interfaz de Usuario/profile.jsp");
    
    } else {
        %>
        <script>
            alert("Sesión expirada, vuelva a conectarse");
            location = '../index.jsp';
        </script>
        <%
    }

%>
