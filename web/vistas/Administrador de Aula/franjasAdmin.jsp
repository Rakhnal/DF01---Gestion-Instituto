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
        <link rel="shortcut icon" type="image/jpg" href="../../img/ifplogo.png" />
        <title>Administración de aulas</title>
        
        <link rel="stylesheet" type="text/css" href="../../css/opPages.css">
        <link rel="stylesheet" type="text/css" href="../../css/sidenav.css">
        <script src="../../scripts/jquery-3.4.1.min.js"></script>
        <script src="../../scripts/headerscroll.js"></script>
        <script src="../../scripts/header.js"></script>
        <script src="../../scripts/Administrador de Aula/franjasAdmin.js"></script>
        
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
                            <li><a href="#">Administrar franjas</a></li>
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
        
        <div id = "ppalRoom">
            <div id = "rooms">
                
                <h1>Franjas Horarias</h1>
                
                <div id="franjasAdmin">
                        
                        <%
                            ArrayList<Franja> franjas = ConexionEstatica.obtenerFranjas();
                            
                            if (null != franjas && franjas.size() > 0) {
                        %>
                            <table role="table">
                                <thead role="rowgroup">
                                  <tr role="row">
                                    <th role="columnheader">NUM. FRANJA</th>
                                    <th role="columnheader">HORA COMIENZO</th>
                                    <th role="columnheader">HORA FINAL</th>
                                    <th role="columnheader" class="transparent"></th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%
                            for (int i = 0; i < franjas.size(); i++) {
                                
                            %>
                                <form name = "rowFormAulas" onsubmit = "return validateForm()" action="../../controladores/userControl.jsp" method="POST">
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" readonly name="idFranja" id="idFranja<%=franjas.get(i).getIdFranja()%>" value="<%out.println(franjas.get(i).getIdFranja());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large editable" maxlength="5" name="frStart" id="frStart<%=franjas.get(i).getIdFranja()%>1" value="<%out.println(franjas.get(i).getFrStart());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large editable" maxlength="5" name="frEnd" id="frEnd<%=franjas.get(i).getIdFranja()%>2" value="<%out.println(franjas.get(i).getFrEnd());%>">
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="modifyFranja" id="modifyFranja"/>
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