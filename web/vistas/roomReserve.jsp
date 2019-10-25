<%-- 
    Document   : roomReserve
    Created on : 23-oct-2019, 11:03:22
    Author     : alvaro
--%>

<%@page import="Utilidades.Auxiliar"%>
<%@page import="Clases.Reserva"%>
<%@page import="Clases.Franja"%>
<%@page import="Utilidades.ConexionEstatica"%>
<%@page import="Clases.Aula"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Utilidades.Constantes"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservar Aulas</title>
        
        <link rel="stylesheet" type="text/css" href="../css/reserve.css">
        <script src="../scripts/jquery-3.4.1.min.js"></script>
        
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
                Usuario conectado = (Usuario) session.getAttribute("sesUsr");
        %>
        
        <header>
            
            <nav>
                <ul>
                    <%                    
                        if (conectado.getIdRols().contains(Constantes.typeAdminau)) {
                    %>
                    <li><a href="#">Administrador de Aulas</a>
                        <ul>
                            <li><a href="roomReserve.jsp">Reserva de Aulas</a></li>
                            <li><a href="roomAdmin.jsp">Administración de aulas</a></li>
                        </ul>
                    </li>

                    <%
                        }

                        if (conectado.getIdRols().contains(Constantes.typeAdminge)) {
                    %>
                    <li><a href="#">Administrador General</a>
                        <ul>
                            <li><a href="userAdmin.jsp">Administración usuarios</a></li>
                            <li><a href="bitacora.jsp">Bitácora</a></li>
                        </ul>
                    </li>
                    <%
                        }

                        if (conectado.getIdRols().contains(Constantes.typeUsr)) {
                    %>
                    <li><a href="roomReserve.jsp">Profesor</a></li>
                    <%
                        }
                    %>
                </ul>
            </nav>
            
            <input type="button" value="" id="cese">
            <input type="button" value="" id="about">
            <img id ="userIcon" src = "../img/default.png" alt = "Imagen perfil del usuario"/>
        </header>
        
        <div id = "ppal">
            <div id = "reservar">
                <form name = "indexForm" action="../controladores/userControl.jsp" method="POST">
                    <div id="divFecha">
                        <p>Fecha</p>
                        <input type = "date" id = "fecha" name="fecha"/>
                    </div>
                    <div id="divAula">
                        <p>Aula</p>
                        <select type = 'text' name = 'selType'>

                            <%

                            ConexionEstatica.abrirBD();

                            ArrayList<Aula> aulas = ConexionEstatica.obtenerAulas();

                            for (int i = 0; i < aulas.size(); i++) {
                                Aula aula = aulas.get(i);
                                %>
                                <option value = '<%out.print(aula.getIdAula());%>'><%out.print(aula.getIdAula());%> - <%out.print(aula.getDescripcion());%></option>
                                <%
                            }
                            %>
                        </select>
                    </div>
                    <div id="divBoton">
                        <input type='submit' value = '' name = 'checkAula' id="checkAula"/>
                    </div>

                    <div id="aulas" style="grid-column: span 3">
                        
                        <%
                        
                        if (session.getAttribute("reservas") != null) {
                            
                            ArrayList<Reserva> reservas = (ArrayList<Reserva>) session.getAttribute("reservas");
                        
                        %>
                            <table role="table">
                                <thead role="rowgroup">
                                  <tr role="row">
                                      <th role="columnheader">NUM. FRANJA</th>
                                    <th role="columnheader">HORA COMIENZO</th>
                                    <th role="columnheader">HORA FINAL</th>
                                    <th role="columnheader">RESERVADO</th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%

                            ArrayList<Franja> franjas = ConexionEstatica.obtenerFranjas();

                            for (int i = 0; i < franjas.size(); i++) {

                            %>
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" readonly name="idfranja" id="idfranja" value="<%out.println(franjas.get(i).getIdFranja());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" readonly name="frstart" id="frstart" value="<%out.println(franjas.get(i).getFrStart());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" readonly name="frend" id="frend" value="<%out.println(franjas.get(i).getFrEnd());%>">
                                        </td>
                                        <%
                                        if (Auxiliar.isReserved(reservas, franjas.get(i).getIdFranja())) {
                                        %>
                                        <td role="cell">
                                            <input type="submit" value="Reservado" name="buttonReserve" disabled id="<%=i%>"/>
                                        </td>
                                        <%
                                        } else {
                                        %>
                                        <td role="cell">
                                            <input type="submit" value="Libre" name="buttonReserve" id="<%=i%>"/>
                                        </td> 
                                        <%
                                        }
                                        %>
                                    </tr>
                            <%
                            }
                            %>
                                </tbody>
                            </table>
                        <%
                        
                        }

                        %>
                    </div>
                </form>
            </div>
            
            <div id = "reservas">
                
                
                
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
