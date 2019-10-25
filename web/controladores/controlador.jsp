<%-- 
    Document   : controlador
    Created on : 04-oct-2019, 13:09:29
    Author     : alvaro
--%>

<%@page import="Utilidades.Codificar"%>
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

            String correo = request.getParameter("correo");

            Usuario userObj = ConexionEstatica.existeUsuario(correo);

            if (userObj != null) {

                if (userObj.getPass().equals(Codificar.codifica(request.getParameter("pass")))) {
                    
                    ArrayList<Integer> roles = ConexionEstatica.cargarRoles(userObj.getDni());
                    
                    userObj.setIdRols(roles);
                    
                    session.setAttribute("sesUsr", userObj);
                    
                    // Sumamos 1 al contador de inicio de sesión del usuario
                    int cont = userObj.getNumLogins() + 1;
                    ConexionEstatica.Modificar_Dato(Constantes.usuarios, "numLogins", Integer.toString(cont), userObj.getCorreo());
                    
                    if (userObj.getIdRols().contains(Constantes.typeAdminge) || userObj.getIdRols().contains(Constantes.typeAdminau)) {
                        response.sendRedirect("../vistas/pagPpal.jsp");
                    } else {
                        response.sendRedirect("../vistas/roomReserve.jsp");
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

        if (request.getParameter("backRegister") != null) {
            if (session.getAttribute("sesUsr") != null) {
                Usuario user = (Usuario) session.getAttribute("sesUsr");
                Bitacora.escribirBitacora("El usuario " + user.getCorreo() + " ha cerrado sesión");
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

        // --------- Ventana elegir modo acceso
        if (request.getParameter("acceder") != null) {
            
            if (Integer.parseInt(request.getParameter("selType")) == Constantes.typeAdminau || Integer.parseInt(request.getParameter("selType")) == Constantes.typeAdminge) {
                        
                response.sendRedirect("vistas/crud.jsp");
                        
            } else {
                        
                response.sendRedirect("vistas/mosca.jsp");
                        
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

                // usuarios = ConexionEstatica.obtenerUsuariosAdmin(admin.getCorreo());

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
                    if (admin.getIdRols().contains(Constantes.typeAdminge) && request.getParameter("userRelated") != null) {
                        
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
            location = '../index.jsp';
        </script>
        <%

    }
%>
