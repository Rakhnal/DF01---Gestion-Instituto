<%-- 
    Document   : roomAdmin
    Created on : 23-oct-2019, 11:05:29
    Author     : alvaro
--%>

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
            <img id ="userIcon" src = "../img/default.png" alt = "Imagen perfil del usuario"/>
        </header>
        
        <div id = "ppalRoom">
            <div id = "rooms">
                
                <h1>Aulas disponibles</h1>
                
                <div id="aulasAdmin">
                        
                        <%
                            ArrayList<Aula> aulas = ConexionEstatica.obtenerAulas();
                            
                            if (null != aulas && aulas.size() > 0) {
                        %>
                            <table role="table">
                                <thead role="rowgroup">
                                  <tr role="row">
                                    <th role="columnheader">NOMBRE</th>
                                    <th role="columnheader">DESCRIPCIÓN</th>
                                    <th role="columnheader" class="transparent"></th>
                                    <th role="columnheader" class="transparent"></th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%
                            for (int i = 0; i < aulas.size(); i++) {
                                
                            %>
                                <form name = "rowFormAulas" action="../controladores/userControl.jsp" method="POST">
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" readonly name="aulaName" id="aula<%=aulas.get(i).getIdAula()%>" value="<%out.println(aulas.get(i).getIdAula());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large editable" name="aulaDesc" id="aulaDesc<%=aulas.get(i).getIdAula()%>" value="<%out.println(aulas.get(i).getDescripcion());%>">
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="modifyAula" id="modifyAula"/>
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="deleteAula" id="deleteAula"/>
                                        </td>
                                    </tr>
                                </form>
                            <%
                            }
                            %>
                            
                                <form name = "rowFormAdd" action="../controladores/userControl.jsp" method="POST">
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" class="editable"name="aulaName" id="aulaName" value="">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large editable" name="aulaDesc" id="aulaDesc" value="">
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="addAula" id="addAula"/>
                                        </td>
                                    </tr>
                                </form>
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
