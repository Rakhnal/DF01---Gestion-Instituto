<%-- 
    Document   : roomAdmin
    Created on : 23-oct-2019, 11:05:29
    Author     : alvaro
--%>

<%@page import="Clases.Bitacora"%>
<%@page import="Utilidades.Auxiliar"%>
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
        <link rel="shortcut icon" type="image/jpg" href="../../img/ifplogo.png" />
        <title>Bitácora</title>
        
        <link rel="stylesheet" type="text/css" href="../../css/opPages.css">
        <link rel="stylesheet" type="text/css" href="../../css/sidenav.css">
        <script src="../../scripts/jquery-3.4.1.min.js"></script>
        <script src="../../scripts/headerscroll.js"></script>
        <script src="../../scripts/pagination.js"></script>
        <script src="../../scripts/header.js"></script>
    </head>
    <body>
        <%
            if (session != null && session.getAttribute("sesUsr") != null) {
                ConexionEstatica.abrirBD();
                
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
        
        <header id="header">
            
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
                            <li><a href="#">Bitácora</a></li>
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
        
        <div id = "ppalRoom">
            <div id = "rooms">
                
                <h1>Registro de acciones</h1>
                
                <div id="bitacoraTable">
                        
                        <%
                            ArrayList<Bitacora> logs = ConexionEstatica.obtenerLogs();
                            
                            if (null != logs && logs.size() > 0) {
                                
                        %>
                            <table role="table" id="tablePag">
                                <thead role="rowgroup">
                                  <tr role="row">
                                    <th role="columnheader">ACCIÓN</th>
                                    <th role="columnheader">FECHA Y HORA</th>
                                    <th role="columnheader">CORREO</th>
                                    <th role="columnheader">ROL</th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%
                            for (int i = 0; i < logs.size(); i++) {
                                
                            Bitacora log = logs.get(i);
                            
                            %>
                                <form name = "rowFormAulas" action="../../controladores/userControl.jsp" method="POST">
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" class="large transparent" readonly name="action" id="action" value="<%out.println(log.getAccion());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" style="width: 200px" class="transparent" readonly name="date" id="date" value="<%out.println(log.getFechaHora());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large transparent" readonly name="correo" id="correo" value="<%out.println(log.getCorreo());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large transparent" readonly name="rol" id="rol" value="<%out.println(log.getRol());%>">
                                        </td>
                                    </tr>
                                </form>
                            <%
                            }
                            %>
                                </tbody>
                            </table>
                        <%
                        }
                        %>
                    </div>
            </div>
        </div>
        
        <footer>
            <div>Álvaro Donoso Conde - 2º DAW - CIFP Virgen de Gracia Puertollano</div>
        </footer>
                    
        <%
        
            ConexionEstatica.cerrarBD();
        } else {
            response.sendRedirect("../../index.jsp");
        }
        %>
    </body>
</html>