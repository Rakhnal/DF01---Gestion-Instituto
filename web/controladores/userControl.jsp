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
        
        
        
        ConexionEstatica.cerrarBD();
    }
%>
