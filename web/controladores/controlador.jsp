<%-- 
    Document   : controlador
    Created on : 04-oct-2019, 13:09:29
    Author     : alvaro
--%>

<%@page import="java.sql.Date"%>
<%@page import="Utilidades.Codificar"%>
<%@page import="Clases.Bitacora"%>
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

            String correo = request.getParameter("correo");

            Usuario userObj = ConexionEstatica.existeUsuario(correo);

            if (userObj != null) {

                if (userObj.getPass().equals(Codificar.codifica(request.getParameter("pass")))) {
                    
                    if (userObj.getActivo() == Constantes.active) {
                        ArrayList<Integer> roles = ConexionEstatica.cargarRoles(userObj.getDni());

                        userObj.setIdRols(roles);

                        session.setAttribute("sesUsr", userObj);

                        // Sumamos 1 al contador de inicio de sesión del usuario
                        int cont = userObj.getNumLogins() + 1;
                        ConexionEstatica.Modificar_Dato(Constantes.usuarios, "numLogins", Integer.toString(cont), userObj.getCorreo());
                        String fechaHora = (new java.util.Date()).toString();

                        if (userObj.getIdRols().contains(Constantes.typeAdminge)) {
                            ConexionEstatica.insertarLog(Constantes.login, fechaHora, userObj.getCorreo(), Constantes.strAdminGe);
                        } else if (userObj.getIdRols().contains(Constantes.typeAdminau)) {
                            ConexionEstatica.insertarLog(Constantes.login, fechaHora, userObj.getCorreo(), Constantes.strAdminAu);
                        } else {
                            ConexionEstatica.insertarLog(Constantes.login, fechaHora, userObj.getCorreo(), Constantes.strUsr);
                        }
                        
                        
                        if (userObj.getIdRols().contains(Constantes.typeAdminge) || userObj.getIdRols().contains(Constantes.typeAdminau)) {
                            response.sendRedirect("../vistas/pagPpal.jsp");
                        } else {
                            response.sendRedirect("../vistas/roomReserve.jsp");
                        }
                    } else {
                        %>
                        <script>
                            alert("El usuario está desactivado, consulte con un administrador general");
                            location = '../index.jsp';
                        </script>
                        <%
                    }
                } else {
                    %>
                    <script>
                        alert("Usuario/Contraseña incorrectos, intentalo de nuevo");
                        location = '../index.jsp';
                    </script>
                    <%
                }
            } else {
                %>
                <script>
                    alert("Usuario/Contraseña incorrectos, intentalo de nuevo");
                    location = '../index.jsp';
                </script>
                <%
            }
        }
        
        
        if (request.getParameter("back") != null) {
            if (session.getAttribute("sesUsr") != null) {
                Usuario user = (Usuario) session.getAttribute("sesUsr");
                String fechaHora = (new java.util.Date()).toString();

                if (user.getIdRols().contains(Constantes.typeAdminge)) {
                    ConexionEstatica.insertarLog(Constantes.logout, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                } else if (user.getIdRols().contains(Constantes.typeAdminau)) {
                    ConexionEstatica.insertarLog(Constantes.logout, fechaHora, user.getCorreo(), Constantes.strAdminAu);
                } else {
                    ConexionEstatica.insertarLog(Constantes.logout, fechaHora, user.getCorreo(), Constantes.strUsr);
                }
            }
                
            session.setAttribute("sesUsr", null);

            response.sendRedirect("../index.jsp");

        }

        // --------------- Ventana Nuevo Usuario
        if (request.getParameter("register") != null) {
            
            String correo = request.getParameter("correo");
            String dni = request.getParameter("dni");
            int edad = Integer.parseInt(request.getParameter("edad"));
            String pass = Codificar.codifica(request.getParameter("pass"));
            String nombre = (String) request.getParameter("nombre");
            String apellido = (String) request.getParameter("apellido");

            Usuario userObj = ConexionEstatica.existeUsuario(correo);
            
            if (userObj == null) {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.logout, fechaHora, correo, Constantes.strAdminGe);
                ConexionEstatica.Insertar_Profesor(Constantes.usuarios, correo, dni, edad, pass, nombre, apellido);
                response.sendRedirect("../vistas/newUser.jsp");
                            
            } else {
            
                %>
                <script>
                    alert("El usuario ya ha sido dado de alta en la base de datos");
                    location = '../vistas/newUser.jsp';
                </script>
                <%
            }
        }

        ConexionEstatica.cerrarBD();

    // Si la sesión no está activa redirigimos a la página principal
    } else {
        
        %>
        <script>
            alert("Sesión expirada, vuelva a conectarse");
            location = '../index.jsp';
        </script>
        <%

    }
%>
