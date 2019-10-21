<%-- 
    Document   : controlador
    Created on : 04-oct-2019, 13:09:29
    Author     : alvaro
--%>

<%@page import="Utilidades.Bitacora"%>
<%@page import="Utilidades.Constantes"%>
<%@page import="Utilidades.ConexionEstatica"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    // Si la sesión sigue activa
    if (session != null) {
        
        ConexionEstatica.abrirBD();
        
        // --------------- Ventana Login
        if (request.getParameter("login") != null) {

            String user = request.getParameter("user");

            Usuario userObj = ConexionEstatica.existeUsuario(user);

            if (userObj != null) {

                if (userObj.getPass().equals(request.getParameter("pass"))) {

                    session.setAttribute("sesUsr", userObj);
                    
                    // Sumamos 1 al contador de inicio de sesión del usuario
                    int cont = userObj.getNumLogins() + 1;
                    ConexionEstatica.Modificar_Dato(Constantes.usuarios, "contSesion", Integer.toString(cont), userObj.getCorreo());
                    
                    if (userObj.getIdRol() == Constantes.typeAdminge || userObj.getIdRol() == Constantes.typeAdminau) {
                        response.sendRedirect("vistas/selectMode.jsp");
                    } else {
                        response.sendRedirect("vistas/mosca.jsp");
                    }

                } else {
                    %>
                    <script>
                        alert("Usuario/Contraseña incorrectos, intentalo de nuevo");
                        location = 'index.jsp';
                    </script>
                    <%
                }
            } else {
                %>
                <script>
                    alert("Usuario/Contraseña incorrectos, intentalo de nuevo");
                    location = 'index.jsp';
                </script>
                <%
            }
        }

        if (request.getParameter("boton") != null) {
            // --------------- Cualquier botón Volver te devuelve al index.jsp
            if (request.getParameter("boton").equals("Volver")) {

                if (session.getAttribute("sesUsr") != null) {
                    Usuario user = (Usuario) session.getAttribute("sesUsr");
                    Bitacora.escribirBitacora("El usuario " + user.getCorreo() + " ha cerrado sesión");
                }

                session.setAttribute("sesFromCrud", null);
                session.setAttribute("sesUsr", null);

                response.sendRedirect("index.jsp");

            }
        }

        // --------------- Ventana Nuevo Usuario
        if (request.getParameter("register") != null) {
            
                %>
                <script>
                    alert("JSP");
                </script>
                <%
        }

        // --------- Ventana elegir modo acceso
        if (request.getParameter("acceder") != null) {
            
            if (Integer.parseInt(request.getParameter("selType")) == Constantes.typeAdminau || Integer.parseInt(request.getParameter("selType")) == Constantes.typeAdminge) {
                        
                response.sendRedirect("vistas/crud.jsp");
                        
            } else {
                        
                response.sendRedirect("vistas/mosca.jsp");
                        
            }
        }

        // -------- Ventana cambiar contraseña
        if (request.getParameter("saveNew") != null) {
            
            String oldPass = request.getParameter("pass");
            String newPass = request.getParameter("newPass");
            String usr = request.getParameter("user");

            Usuario userObj = ConexionEstatica.existeUsuario(usr);

            if (userObj != null) {

                // Comprobamos que las contraseñas no coincidan
                if (!oldPass.equals(newPass)) {

                    boolean res;

                    ConexionEstatica.Modificar_Password(Constantes.usuarios, userObj.getCorreo(), newPass);

                    // Mandamos el correo al usuario
                    res = userObj.sendEmail();

                    if (res) {
                        %>
                        <script>
                            alert("Contraseña cambiada");
                            location = 'vistas/resetPassword.jsp';
                        </script>
                        <%
                    } else {
                        %>
                        <script>
                            alert("Se ha producido un error, consulte con el administrador");
                            location = 'vistas/resetPassword.jsp';
                        </script>
                        <%
                    }
                } else {

                    %>
                    <script>
                        alert("Las contraseñas coinciden, la nueva contraseña no puede ser igual que la anterior");
                        location = 'vistas/resetPassword.jsp';
                    </script>
                    <%
                }
            }
        }

        // ---------- Ventana CRUD
        if (request.getParameter("boton") != null) {
            
            // ---------- Registrar nuevo usuario
            if (request.getParameter("boton").equals("Registrar")) {

                session.setAttribute("sesFromCrud", true);
                response.sendRedirect("vistas/newUser.jsp");

            }

            // ---------- Elimina al usuario de la BBDD
            if (request.getParameter("boton").equals("X")) {

                Usuario admin = (Usuario) session.getAttribute("sesUsr");

                ArrayList<Usuario> usuarios;

                String userName = request.getParameter("user");
                int edad = Integer.parseInt(request.getParameter("edad"));

                usuarios = ConexionEstatica.obtenerUsuariosAdmin(admin.getCorreo());

                ConexionEstatica.Borrar_Dato(Constantes.usuarios, userName);
                response.sendRedirect("vistas/crud.jsp");
            }

            // ---------- Modifica los datos del usuario
            if (request.getParameter("boton").equals("V")) {

                Usuario admin = (Usuario) session.getAttribute("sesUsr");

                ArrayList<Usuario> usuarios;
                String userName = request.getParameter("user");
                int edad = Integer.parseInt(request.getParameter("edad"));

                Usuario modifyUser = ConexionEstatica.existeUsuario(userName);
                
                if (modifyUser != null) {
                    ConexionEstatica.Modificar_Dato(Constantes.usuarios, "edad", Integer.toString(edad), userName);
                    
                    // Si es Super Admin modificará también, si lo ha indicado el administrador al cargo de ese usuario
                    if (admin.getIdRol() == Constantes.typeAdminge && request.getParameter("userRelated") != null) {
                        
                        String adminRelated = request.getParameter("userRelated");
                        ConexionEstatica.Modificar_Dato(Constantes.usuarios, "admin", adminRelated, modifyUser.getCorreo());
                        
                    }
                    
                    response.sendRedirect("vistas/crud.jsp");
                }
            }
        }

        if (request.getParameter("raise") != null) {
            
            String usr = request.getParameter("user");

            //ConexionEstatica.Modificar_Dato(Constantes.usuarios, "type", Constantes.typeAdmin, usr);
            response.sendRedirect("vistas/crud.jsp");

        }

        if (request.getParameter("drop") != null) {
            
            String usr = request.getParameter("user");

            //ConexionEstatica.Modificar_Dato(Constantes.usuarios, "type", Constantes.typeUsr, usr);
            response.sendRedirect("vistas/crud.jsp");

        }

        ConexionEstatica.cerrarBD();

    // Si la sesión no está activa redirigimos a la página principal
    } else {
        
        %>
        <script>
            alert("Sesión expirada, vuelva a conectarse");
            location = 'index.jsp';
        </script>
        <%

    }
%>
