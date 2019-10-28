<%-- 
    Document   : roomAdmin
    Created on : 23-oct-2019, 11:05:29
    Author     : alvaro
--%>

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
        <title>Administración de usuarios</title>
        
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
                
                <h1>Usuarios registrados</h1>
                
                <div id="userAdmin">
                        
                        <%
                            ArrayList<Usuario> usuarios = ConexionEstatica.obtenerUsuarios();
                            
                            if (null != usuarios && usuarios.size() > 0) {
                                
                                ArrayList<Usuario> usuariosRoles = Auxiliar.obtenerRoles(usuarios);
                        %>
                            <table role="table">
                                <thead role="rowgroup">
                                  <tr role="row">
                                    <th role="columnheader">DNI</th>
                                    <th role="columnheader">CORREO</th>
                                    <th role="columnheader">NOMBRE</th>
                                    <th role="columnheader">APELLIDO</th>
                                    <th role="columnheader">EDAD</th>
                                    <th role="columnheader">ROLES</th>
                                    <th role="columnheader">ESTADO</th>
                                    <th role="columnheader" class="transparent"></th>
                                    <th role="columnheader" class="transparent"></th>
                                  </tr>
                                </thead>
                                <tbody role="rowgroup">
                            <%
                            for (int i = 0; i < usuariosRoles.size(); i++) {
                                
                            Usuario user = usuariosRoles.get(i);
                            
                            %>
                                <form name = "rowFormAulas" action="../controladores/userControl.jsp" method="POST">
                                    <tr role="row">
                                        <td role="cell">
                                            <input type="text" class="large transparent" readonly name="dni" id="dni" value="<%out.println(user.getDni());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large transparent" readonly name="correo" id="correo" value="<%out.println(user.getCorreo());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large" name="nombre" id="nombre<%=user.getDni()%>" value="<%out.println(user.getNombre());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" class="large" name="apellido" id="apellido<%=user.getDni()%>" value="<%out.println(user.getApellido());%>">
                                        </td>
                                        <td role="cell">
                                            <input type="text" name="edad" id="edad<%=user.getDni()%>" value="<%out.println(user.getEdad());%>">
                                        </td>
                                        <td role="cell">
                                            <%
                                            if(user.getIdRols().contains(Constantes.typeUsr)) {
                                            %>
                                            <input type="submit" class="especiales large" value="<%=Constantes.dropProfesor%>" name="profesor" id="profesor"/>
                                            <%
                                            } else {
                                            %>
                                                <input type="submit" class="especiales large" value="<%=Constantes.riseProfesor%>" name="profesor" id="profesor"/>
                                            <%
                                            }
                                            
                                            if(user.getIdRols().contains(Constantes.typeAdminau)) {
                                            %>
                                                <input type="submit" class="especiales large" value="<%=Constantes.dropAdminAu%>" name="adminAulas" id="adminAulas"/>
                                            <%
                                            } else {
                                            %>
                                                <input type="submit" class="especiales large" value="<%=Constantes.riseAdminAu%>" name="adminAulas" id="adminAulas"/>
                                            <%
                                            }
                                            
                                            if(user.getIdRols().contains(Constantes.typeAdminge)) {
                                            %>
                                                <input type="submit" class="especiales large" value="<%=Constantes.dropAdminGe%>" name="adminGen" id="adminGen"/>
                                            <%
                                            } else {
                                            %>
                                                <input type="submit" class="especiales large" value="<%=Constantes.riseAdminGe%>" name="adminGen" id="adminGen"/>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <td role="cell">
                                            <%
                                            if (user.getActivo() == Constantes.active) {
                                            %>
                                                <input type="submit" class="especiales" value="<%=Constantes.strDeactivate%>" name="confUser" id="confUser"/>
                                            <%
                                            } else {
                                            %>
                                                <input type="submit" class="especiales" value="<%=Constantes.strActivate%>" name="confUser" id="confUser"/>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="modifyUser" id="modifyUser"/>
                                        </td>
                                        <td role="cell" class="transparent">
                                            <input type="submit" value="" name="deleteUser" id="deleteUser"/>
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