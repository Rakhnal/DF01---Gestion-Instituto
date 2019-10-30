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
        <title>Editar Perfil</title>
        
        <link rel="stylesheet" type="text/css" href="../../css/opPages.css">
        <script src="../../scripts/jquery-3.4.1.min.js"></script>
        <script src="../../scripts/headerscroll.js"></script>
        <script src="../../scripts/header.js"></script>
        <script src="../../scripts/Editar Perfil/perfil.js"></script>
    </head>
    <body>
        <%
            if (session != null && session.getAttribute("sesUsr") != null) {
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
            <a href="#">
                <img id ="userIcon" src="../../img/default.png" id = "profPic" alt = "Foto de perfil">
            </a>
            <%
            } else {
            %>
            <a href="#">
                <img id ="userIcon" src="<%= conectado.getFotoimgString()%>" id = "profPic" alt = "Foto de perfil">
            </a>
            <%
                }
            %>
        </header>
        
        <div id = "ppalRoom">
            <div id="changeProfilePic">
                <h1>Cambiar Foto</h1>
                
                <form action="../../controladores/subefichero.jsp" enctype="multipart/form-data" method="post"> 
                    <p>Resolución recomendada: 50x50 px</p>
                    <%
                    if (conectado.getFoto() == null) {
                    %>
                    <img src="../../img/default.png" id = "profPic" style="width: 30%" alt = "Foto de perfil">
                    <%
                    } else {
                    %>
                    <img src="<%= conectado.getFotoimgString()%>" id = "profPic" alt = "Foto de perfil">
                    <%
                    }
                    %>
                    <input type="file" name="file" id="file" onchange="cambiarImagen(this)" class="inputfile" />
                    <label for="file">Elige una imagen</label>
                    <input id = "submitImg" disabled type="submit" value=""/> 
                </form> 
                
            </div>
            <div id="changePass">
                <h1>Cambiar Contraseña</h1>
                
                <form name = "changePassForm" onsubmit="return validateFields()" action="../../controladores/userControl.jsp" method="POST">
                    <div>
                        <p>Contraseña anterior</p>
                        <input type="password" title="Contraseña anterior" placeholder="Contraseña anterior" name="passAnt" id="passAnt"/>
                    </div>

                    <div>
                        <p>Nueva contraseña</p>
                        <input type="password" title="Nueva contraseña" placeholder="Nueva contraseña" name="passAct" id="passAct"/>
                    </div>
                    
                    <input type="submit" value="" name="changePass" id = "changePassSubmit"/>
                </form>
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