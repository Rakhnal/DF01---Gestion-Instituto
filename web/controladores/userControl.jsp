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
            
            // Recuperamos las reservas de esa aula en esa fecha
            ArrayList<Reserva> reservas = ConexionEstatica.obtenerReservas(fecha, idAula);
            
            // Ponemos las reservas en la sesión para usarlo en la página
            session.setAttribute("reservas", reservas);
            
            response.sendRedirect("../vistas/roomReserve.jsp");
        }
        
        ConexionEstatica.cerrarBD();
    } else {
        response.sendRedirect("../index.jsp");
    }
%>
