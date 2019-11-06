<%-- 
    Document   : roomReserve
    Created on : 23-oct-2019, 11:03:22
    Author     : alvaro
--%>

<%@page import="Clases.Reservado"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Calendar"%>
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
        <link rel="shortcut icon" type="image/jpg" href="../../img/ifplogo.png" />
        <title>Reservar Aulas</title>
        
        <link rel="stylesheet" type="text/css" href="../../css/opPages.css">
        <link rel="stylesheet" type="text/css" href="../../css/sidenav.css">
        <script src="../../scripts/jquery-3.4.1.min.js"></script>
        <script src="../../scripts/headerscroll.js"></script>
        <script src="../../scripts/header.js"></script>
        
    </head>
    <body>
        
        <%
            // Si la sesión sigue activa
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
        
        <header id="header">
            
            <span id = "sidenav" onclick="openNav()">&#9776;</span>
            
            <nav>
                <ul>
                    <%
                        // Formamos el menú según los roles que tenga el usuario
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
                    <li><a href="#">Reserva de aulas</a></li>
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
                // Si el usuario no tiene foto le ponemos una por defecto, si tiene cargamos la suya
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
        
        <div id = "ppal">
            <div id = "reservar">
                <form name = "indexForm" action="../../controladores/userControl.jsp" method="POST">
                    
                    <%
                    // Si ya se ha buscado una fecha al volver a la página cargamos esa fecha
                    if (session.getAttribute("fecha") != null) {
                        String fecha = (String) session.getAttribute("fecha");
                    %>
                    
                    <div class = "bluestyle" id="divFecha">
                        <p>Fecha</p>
                        <input type = "date" id = "fecha" name="fecha" value="<%=fecha%>"/>
                    </div>
                    <%
                    } else {
                        // Si no, ponemos en el campo fecha la fecha de hoy
                        Calendar now = Calendar.getInstance();
                        int dayOfMonth = now.get(Calendar.DAY_OF_MONTH);
                        int month = now.get(Calendar.MONTH) + 1;

                        String strDayMonth = String.valueOf(dayOfMonth);

                        if (strDayMonth.length() == 1) {
                            strDayMonth = 0 + strDayMonth;
                        }

                        String monthStr = ((month < 10) ? "0" : "") + month;
                        String fecha = now.get(Calendar.YEAR) + "-" + monthStr + "-" + strDayMonth;
                    %>
                    <div class = "bluestyle" id="divFecha">
                        <p>Fecha</p>
                        <input type = "date" id = "fecha" name="fecha" value="<%=fecha%>"/>
                    </div>
                    <%
                    }
                    %>
                    <div class = "bluestyle" id="divAula">
                        <p>Aula</p>
                        <select type = 'text' name = 'selType'>

                            <%

                            ConexionEstatica.abrirBD();
                            
                            // Obtengo todas las aulas de la BBDD
                            ArrayList<Aula> aulas = ConexionEstatica.obtenerAulas();
                            
                            // Cargamos las aulas en el select
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
                        
                        // Si ya le hemos dado al botón buscar, cargamos la tabla con las franjas y el estado de justo esa franja en esa fecha y el aula buscada
                        if (session.getAttribute("reservas") != null) {
                            
                            ArrayList<Reserva> reservas = (ArrayList<Reserva>) session.getAttribute("reservas");
                        
                        %>
                            <table role="table">
                                <thead role="rowgroup">
                                  <tr role="row">
                                    <th role="columnheader">NUM. FRANJA</th>
                                    <th role="columnheader">HORA COMIENZO</th>
                                    <th role="columnheader">HORA FINAL</th>
                                    <th role="columnheader">ESTADO</th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%

                            ArrayList<Franja> franjas = ConexionEstatica.obtenerFranjas();

                            for (int i = 0; i < franjas.size(); i++) {

                            %>
                                <form name = "rowForm" action="../../controladores/userControl.jsp" method="POST">
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
                                        // Si la franja de esa aula en esa fecha está reservada cambiamos el valor del botón inhabilitandolo
                                        // Si está libre se podrá pulsar
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
                </form>
            </div>
            
            <div id = "reservas">
                
                <h1>Reservas del usuario</h1>
                
                <div id="aulasUser">
                        
                        <%
                            // Cargamos las reservas del usuario, se podrán cancelar
                            ArrayList<Reservado> reservas = ConexionEstatica.obtenerReservas(conectado.getDni());
                            
                            if (null != reservas && reservas.size() > 0) {
                        %>
                            <table role="table">
                                <thead role="rowgroup">
                                  <tr role="row">
                                    <th role="columnheader">FECHA RESERVA</th>
                                    <th role="columnheader">NUM. FRANJA</th>
                                    <th role="columnheader">HORA COMIENZO</th>
                                    <th role="columnheader">HORA FINAL</th>
                                    <th role="columnheader">AULA</th>
                                    <th role="columnheader">DESCRIPCIÓN</th>
                                    <th role="columnheader" class="transparent"></th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%
                            for (int i = 0; i < reservas.size(); i++) {
                                
                            %>
                                <form name = "rowFormReserved" action="../../controladores/userControl.jsp" method="POST">
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" readonly name="fechaReser" id="fechaReser" value="<%out.println(reservas.get(i).getFecha());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" readonly name="idFranja" id="idFranja" value="<%out.println(reservas.get(i).getIdFranja());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" readonly name="frStart" id="frStart" value="<%out.println(reservas.get(i).getFrStart());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" readonly name="frEnd" id="frEnd" value="<%out.println(reservas.get(i).getFrEnd());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" readonly name="idAula" id="idAula" value="<%out.println(reservas.get(i).getIdAula());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large" readonly name="descripcion" id="descripcion" value="<%out.println(reservas.get(i).getDescripcion());%>">
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="cancel" id="cancel"/>
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
