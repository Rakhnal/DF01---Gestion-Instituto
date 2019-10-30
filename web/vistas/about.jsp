<%-- 
    Document   : roomAdmin
    Created on : 23-oct-2019, 11:05:29
    Author     : alvaro
--%>

<%@page import="Clases.Franja"%>
<%@page import="Clases.Aula"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Utilidades.ConexionEstatica"%>
<%@page import="Clases.Usuario"%>
<%@page import="Utilidades.Constantes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/jpg" href="../img/ifplogo.png" />
        <title>Administración de aulas</title>
        
        <link rel="stylesheet" type="text/css" href="../css/opPages.css">
        <script src="../scripts/jquery-3.4.1.min.js"></script>
        <script src="../scripts/headerscroll.js"></script>
        
        <script>
            
            $(document).ready(function () {

                $("#cese").click(function () {
                    window.location = "../index.jsp";
                });

                $("#about").click(function () {
                    window.location = "about.jsp";
                });

            });

        </script>
    </head>
    <body>
        <%
            if (session != null) {
                ConexionEstatica.abrirBD();
                
                Usuario conectado = (Usuario) session.getAttribute("sesUsr");
        %>
        
        <header id="header">
            
            <nav>
                <ul>
                    <%                    
                        if (conectado.getIdRols().contains(Constantes.typeAdminau)) {
                    %>
                    <li><a href="#">Administrador de Aulas</a>
                        <ul>
                            <li><a href="franjasAdmin.jsp">Administrar franjas</a></li>
                            <li><a href="roomAdmin.jsp">Administrar aulas</a></li>
                        </ul>
                    </li>

                    <%
                        }

                        if (conectado.getIdRols().contains(Constantes.typeAdminge)) {
                    %>
                    <li><a href="#">Administrador General</a>
                        <ul>
                            <li><a href="userAdmin.jsp">Administrar usuarios</a></li>
                            <li><a href="bitacora.jsp">Bitácora</a></li>
                        </ul>
                    </li>
                    <%
                        }

                        if (conectado.getIdRols().contains(Constantes.typeUsr)) {
                    %>
                    <li><a href="roomReserve.jsp">Reserva de aulas</a></li>
                    <%
                        }
                    %>
                </ul>
            </nav>
            
            <form name = "buttonForm" action="../controladores/controlador.jsp" method="POST">
                <input type="submit" name="back" value="" id="cese">
            </form>
            <input type="button" value="" id="about">
            <%
                if (conectado.getFoto() == null) {
            %>
            <a href="profile.jsp">
                <img id ="userIcon" src="../img/default.png" id = "profPic" alt = "Foto de perfil">
            </a>
            <%
            } else {
            %>
            <a href="profile.jsp">
                <img id ="userIcon" src="<%= conectado.getFotoimgString()%>" id = "profPic" alt = "Foto de perfil">
            </a>
            <%
                }
            %>
        </header>
        
        <div id = "ppalRoom">
            <div id = "rooms">
                
                <h1>Información de la página</h1>
                
                <div id="aboutDiv">
                    
                    <h2 class="double">DESAFIO 01</h2>
                    
                    <h2>Realizado por: Álvaro Donoso Conde</h2>
                    
                    <h2>Desarrollado en: CIFP Virgen de Gracia, Puertollano</h2>
                    
                    <h2>2º Desarrollo de Aplicaciones Web</h2>
                    
                    <h2>Iconos realizados por <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> en <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></h2>
                </div>
            </div>
        </div>
        
        <footer>
            <div>Álvaro Donoso Conde - 2º DAW - CIFP Virgen de Gracia Puertollano</div>
        </footer>
                    
        <%
        
            ConexionEstatica.cerrarBD();
        } else {
            response.sendRedirect("../index.jsp");
        }
        %>
    </body>
</html>