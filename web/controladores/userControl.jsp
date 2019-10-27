<%-- 
    Document   : controlador
    Created on : 04-oct-2019, 13:09:29
    Author     : alvaro
--%>

<%@page import="Clases.Reserva"%>
<%@page import="java.sql.Date"%>
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
            
            Usuario user = (Usuario) session.getAttribute("sesUsr");
            int idAula = (Integer) session.getAttribute("idAula");
            int idFranja = Integer.parseInt(request.getParameter("idfranja"));
            String fecha = (String) session.getAttribute("fecha");
            
            ConexionEstatica.Insertar_Reserva(Constantes.reservas, user.getDni(), idAula, idFranja, fecha);
            
            // Recuperamos las reservas de esa aula en esa fecha
            ArrayList<Reserva> reservas = ConexionEstatica.obtenerReservas(fecha, idAula);
            
            // Ponemos las reservas en la sesión para usarlo en la página
            session.setAttribute("reservas", reservas);
            
            response.sendRedirect("../vistas/roomReserve.jsp");
            
        }
        
        if (request.getParameter("cancel") != null) {
            
            Usuario user = (Usuario) session.getAttribute("sesUsr");
            int idAula = Integer.parseInt(request.getParameter("idAula"));
            int idFranja = Integer.parseInt(request.getParameter("idFranja"));
            String fecha = request.getParameter("fechaReser");
            
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
            ConexionEstatica.modificarAula(idAula, descripcion);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        if (request.getParameter("deleteAula") != null) {
            
            int idAula = Integer.parseInt(request.getParameter("aulaName"));
            
            // Borramos el aula en BBDD
            ConexionEstatica.borrarAula(idAula);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        if (request.getParameter("addAula") != null) {
            
            String descripcion = String.valueOf(request.getParameter("aulaDesc"));
            int idAula = Integer.parseInt(request.getParameter("aulaName"));
            
            // Insertamos el aula en BBDD
            ConexionEstatica.insertarAula(idAula, descripcion);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        if (request.getParameter("modifyFranja") != null) {
            
            String frStart = request.getParameter("frStart");
            String frEnd = request.getParameter("frEnd");
            int idFranja = Integer.parseInt(request.getParameter("idFranja"));
            
            // Modificamos la franja en BBDD
            ConexionEstatica.modificarFranja(idFranja, frStart, frEnd);
            
            response.sendRedirect("../vistas/roomAdmin.jsp");
        }
        
        ConexionEstatica.cerrarBD();
    } else {
        response.sendRedirect("../index.jsp");
    }
%>
