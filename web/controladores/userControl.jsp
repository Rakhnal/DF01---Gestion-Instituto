<%-- 
    Document   : controlador
    Created on : 04-oct-2019, 13:09:29
    Author     : alvaro
--%>

<%@page import="Clases.Reserva"%>
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
        
        Usuario user = (Usuario) session.getAttribute("sesUsr");
        
        if (request.getParameter("checkAula") != null) {
            
            String fecha = String.valueOf(request.getParameter("fecha"));
            int idAula = Integer.parseInt(request.getParameter("selType"));
            
            session.setAttribute("idAula", idAula);
            session.setAttribute("fecha", fecha);
            
            // Recuperamos las reservas de esa aula en esa fecha
            ArrayList<Reserva> reservas = ConexionEstatica.obtenerReservas(fecha, idAula);
            
            // Ponemos las reservas en la sesión para usarlo en la página
            session.setAttribute("reservas", reservas);
            
            response.sendRedirect("../vistas/roomReserve.jsp");
        }
        
        if (request.getParameter("buttonReserve") != null) {
            
            int idAula = (Integer) session.getAttribute("idAula");
            int idFranja = Integer.parseInt(request.getParameter("idfranja"));
            String fecha = (String) session.getAttribute("fecha");
            
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.reservarAula, fechaHora, user.getCorreo(), Constantes.strAdminAu);
            ConexionEstatica.Insertar_Reserva(Constantes.reservarAula, user.getDni(), idAula, idFranja, fecha);
            
            // Recuperamos las reservas de esa aula en esa fecha
            ArrayList<Reserva> reservas = ConexionEstatica.obtenerReservas(fecha, idAula);
            
            // Ponemos las reservas en la sesión para usarlo en la página
            session.setAttribute("reservas", reservas);
            
            response.sendRedirect("../vistas/roomReserve.jsp");
            
        }
        
        if (request.getParameter("cancel") != null) {
            
            int idAula = Integer.parseInt(request.getParameter("idAula"));
            int idFranja = Integer.parseInt(request.getParameter("idFranja"));
            String fecha = request.getParameter("fechaReser");
            
            String fechaHora = (new java.util.Date()).toString();

            if (user.getIdRols().contains(Constantes.typeAdminge)) {
                ConexionEstatica.insertarLog(Constantes.cancelarReserva, fechaHora, user.getCorreo(), Constantes.strAdminGe);
            } else if (user.getIdRols().contains(Constantes.typeAdminau)) {
                ConexionEstatica.insertarLog(Constantes.cancelarReserva, fechaHora, user.getCorreo(), Constantes.strAdminAu);
            } else {
                ConexionEstatica.insertarLog(Constantes.cancelarReserva, fechaHora, user.getCorreo(), Constantes.strUsr);
            }
            
            ConexionEstatica.Borrar_Reserva(Constantes.reservas, user.getDni(), idAula, idFranja, fecha);
            
            // Si ha buscado una aula recargamos las reservas por si la reserva cancelada está en la tabla
            if (session.getAttribute("idAula") != null && session.getAttribute("fecha") != null) {
                
                int idAulaRec = (Integer) session.getAttribute("idAula");
                String fechaRec = (String) session.getAttribute("fecha");
                
                // Recuperamos las reservas de esa aula en esa fecha
                ArrayList<Reserva> reservas = ConexionEstatica.obtenerReservas(fechaRec, idAulaRec);

                // Ponemos las reservas en la sesión para usarlo en la página
                session.setAttribute("reservas", reservas);

                response.sendRedirect("../vistas/roomReserve.jsp");
            }
        }
        
        if (request.getParameter("modifyAula") != null) {
            
            String descripcion = String.valueOf(request.getParameter("aulaDesc"));
            int idAula = Integer.parseInt(request.getParameter("aulaName"));
            
            // Modificamos el aula en BBDD
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.modificarAula, fechaHora, user.getCorreo(), Constantes.strAdminAu);
            ConexionEstatica.modificarAula(idAula, descripcion);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        if (request.getParameter("deleteAula") != null) {
            
            int idAula = Integer.parseInt(request.getParameter("aulaName"));
            
            // Borramos el aula en BBDD
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.borrarAula, fechaHora, user.getCorreo(), Constantes.strAdminAu);
            ConexionEstatica.borrarAula(idAula);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        if (request.getParameter("addAula") != null) {
            
            String descripcion = String.valueOf(request.getParameter("aulaDesc"));
            int idAula = Integer.parseInt(request.getParameter("aulaName"));
            
            // Insertamos el aula en BBDD
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.aniadirAula, fechaHora, user.getCorreo(), Constantes.strAdminAu);
            ConexionEstatica.insertarAula(idAula, descripcion);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        if (request.getParameter("modifyFranja") != null) {
            
            String frStart = request.getParameter("frStart");
            String frEnd = request.getParameter("frEnd");
            int idFranja = Integer.parseInt(request.getParameter("idFranja"));
            
            // Modificamos la franja en BBDD
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.modificarFranja, fechaHora, user.getCorreo(), Constantes.strAdminAu);
            ConexionEstatica.modificarFranja(idFranja, frStart, frEnd);
            
            response.sendRedirect("../vistas/franjasAdmin.jsp");
        }
        
        if (request.getParameter("profesor") != null) {
            
            String dni = request.getParameter("dni");
            
            // Si tenemos que quitarle el rol o ponerselo
            if (request.getParameter("profesor").equals(Constantes.dropProfesor)) {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.dropProfesorLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.borrarRol(dni, Constantes.typeUsr);
            } else {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.riseProfesorLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.insertarRol(dni, Constantes.typeUsr);
            }
            
            response.sendRedirect("../vistas/userAdmin.jsp");
        }
        
        if (request.getParameter("adminAulas") != null) {
            
            String dni = request.getParameter("dni");
            
            // Si tenemos que quitarle el rol o ponerselo
            if (request.getParameter("adminAulas").equals(Constantes.dropAdminAu)) {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.dropAdminAuLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.borrarRol(dni, Constantes.typeAdminau);
            } else {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.riseAdminAuLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.insertarRol(dni, Constantes.typeAdminau);
            }
            
            response.sendRedirect("../vistas/userAdmin.jsp");
        }
        
        if (request.getParameter("adminGen") != null) {
            
            String dni = request.getParameter("dni");
            
            // Si tenemos que quitarle el rol o ponerselo
            if (request.getParameter("adminGen").equals(Constantes.dropAdminGe)) {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.dropAdminGeLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.borrarRol(dni, Constantes.typeAdminge);
            } else {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.riseAdminGeLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.insertarRol(dni, Constantes.typeAdminge);
            }
            
            response.sendRedirect("../vistas/userAdmin.jsp");
        }
        
        if (request.getParameter("confUser") != null) {
            
            String dni = request.getParameter("dni");
            
            // Si tenemos que actibar el usuario o desactivarlo
            if (request.getParameter("confUser").equals(Constantes.strDeactivate)) {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.strDeactivateLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.cambiarEstado(dni, Constantes.inactive);
            } else {
                String fechaHora = (new java.util.Date()).toString();
                ConexionEstatica.insertarLog(Constantes.strActivateLog, fechaHora, user.getCorreo(), Constantes.strAdminGe);
                ConexionEstatica.cambiarEstado(dni, Constantes.active);
            }
            
            response.sendRedirect("../vistas/userAdmin.jsp");
        }
        
        if (request.getParameter("modifyUser") != null) {
            
            String dni = request.getParameter("dni");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            int edad = Integer.parseInt(request.getParameter("edad"));
            
            // Modificamos el usuario en BBDD
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.modificarUser, fechaHora, user.getCorreo(), Constantes.strAdminGe);
            ConexionEstatica.modificarUsuario(dni, nombre, apellido, edad);
            
            response.sendRedirect("../vistas/userAdmin.jsp");
        }
        
        if (request.getParameter("deleteUser") != null) {
            
            String dni = request.getParameter("dni");
            String correo = request.getParameter("correo");
            
            // Borramos al usuario en BBDD, automaticamente se borran las reservas que tenga hechas y los roles
            String fechaHora = (new java.util.Date()).toString();
            ConexionEstatica.insertarLog(Constantes.borrarUser, fechaHora, user.getCorreo(), Constantes.strAdminGe);
            ConexionEstatica.borrarUsuario(dni, correo);
            
            response.sendRedirect("../vistas/userAdmin.jsp");
        }
        
        ConexionEstatica.cerrarBD();
    } else {
        response.sendRedirect("../index.jsp");
    }
%>
