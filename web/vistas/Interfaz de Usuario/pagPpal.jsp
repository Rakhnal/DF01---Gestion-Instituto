<%-- 
    Document   : index
    Created on : 17-oct-2019, 9:49:31
    Author     : alvaro
--%>

<%@page import="Utilidades.Constantes"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/jpg" href="../../img/ifplogo.png" />
        <title>Página de Administración</title>

        <link rel="stylesheet" type="text/css" href="../../css/ppal.css">
        <link rel="stylesheet" type="text/css" href="../../css/sidenav.css">
        <script src="../../scripts/jquery-3.4.1.min.js"></script>
        <script src="../../scripts/header.js"></script>
    </head>
    <body>

        <%
            if (session != null && session.getAttribute("sesUsr") != null) {
            
            Usuario conectado = (Usuario) session.getAttribute("sesUsr");
        %>
        
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <%
                if (conectado.getIdRols().contains(Constantes.typeAdminau)) {
            %>
            <a href="../Administrador de Aula/franjasAdmin.jsp">Administrar franjas</a>
            <a href="../Administrador de Aula/roomAdmin.jsp">Administrar aulas</a>
            <%
                }

                if (conectado.getIdRols().contains(Constantes.typeAdminge)) {
            %>
            <a href="../Administrador General/userAdmin.jsp">Administrar usuarios</a>
            <a href="../Administrador General/bitacora.jsp">Bitácora</a>
            <%
                }

                if (conectado.getIdRols().contains(Constantes.typeUsr)) {
            %>
            <a href="../Profesor/roomReserve.jsp">Reserva de aulas</a>
            <%
                }
            %>
        </div>
        
        <header>
            
            <span id = "sidenav" onclick="openNav()">&#9776;</span>
            
            <nav>
                <ul>
                    <%
                        if (conectado.getIdRols().contains(Constantes.typeAdminau)) {
                    %>
                    <li><a href="#">Administrador de Aulas</a>
                        <ul>
                            <li><a href="../Administrador de Aula/franjasAdmin.jsp">Administrar franjas</a></li>
                            <li><a href="../Administrador de Aula/roomAdmin.jsp">Administrar aulas</a></li>
                        </ul>
                    </li>

                    <%
                        }

                        if (conectado.getIdRols().contains(Constantes.typeAdminge)) {
                    %>
                    <li><a href="#">Administrador General</a>
                        <ul>
                            <li><a href="../Administrador General/userAdmin.jsp">Administrar usuarios</a></li>
                            <li><a href="../Administrador General/bitacora.jsp">Bitácora</a></li>
                        </ul>
                    </li>
                    <%
                        }

                        if (conectado.getIdRols().contains(Constantes.typeUsr)) {
                    %>
                    <li><a href="../Profesor/roomReserve.jsp">Reserva de aulas</a></li>
                        <%
                            }
                        %>
                </ul>
            </nav>

            <form name = "buttonForm" action="../../controladores/controlador.jsp" method="POST">
                <input type="submit" name="back" value="" id="cese">
            </form>

            <input type="button" value="" id="about">

            <%
                if (conectado.getFoto() == null) {
            %>
            <a href="../Interfaz de Usuario/profile.jsp">
                <img id ="userIcon" src="../../img/default.png" id = "profPic" alt = "Foto de perfil">
            </a>
            <%
            } else {
            %>
            <a href="../Interfaz de Usuario/profile.jsp">
                <img id ="userIcon" src="<%= conectado.getFotoimgString()%>" id = "profPic" alt = "Foto de perfil">
            </a>
            <%
                }
            %>
            
        </header>

        <div id = 'content'>

            <div>
                <h1>Bienvenido</h1>
                <h1><%=conectado.getNombre()%> <%=conectado.getApellido()%></h1>
            </div>
            <img src="../../img/ifplogo.png" alt="Logo del instituto"/>

        </div>
            
        <%
        
        } else {
            response.sendRedirect("../../index.jsp");
        }
        %>
    </body>
</html>
