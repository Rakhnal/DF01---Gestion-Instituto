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
        <link rel="shortcut icon" type="image/jpg" href="../img/ifplogo.png" />
        <title>Bitácora</title>
        
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
            <img id ="userIcon" src = "../img/default.png" alt = "Imagen perfil del usuario"/>
        </header>
        
        <div id = "ppalRoom">
            <div id = "rooms">
                
                <h1>Registro de acciones</h1>
                
                <div id="bitacoraTable">
                        
                        <%
                            ArrayList<Bitacora> logs = ConexionEstatica.obtenerLogs();
                            
                            if (null != logs && logs.size() > 0) {
                                
                        %>
                            <table role="table">
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
                                <form name = "rowFormAulas" action="../controladores/userControl.jsp" method="POST">
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
            response.sendRedirect("../index.jsp");
        }
        %>
    </body>
</html>