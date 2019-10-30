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
        <title>Editar Perfil</title>
        
        <link rel="stylesheet" type="text/css" href="../css/opPages.css">
        <script src="../scripts/jquery-3.4.1.min.js"></script>
        <script src="../scripts/headerscroll.js"></script>
        
        <script>
            
            var allOK = true;
            
            $(document).ready(function () {

                $("#cese").click(function () {
                    window.location = "../index.jsp";
                });

                $("#about").click(function () {
                    window.location = "about.jsp";
                });
                
                $("input").on('focusin', function () {
                    $("input").on("focusout", validateAll);
                });

            });
            
            function validateAll() {

                $("input").off("focusout", validateAll);

                if (this.id === 'passAnt') {
                    var passAnt = $('#passAnt').val();

                    if (passAnt === "") {
                        $('#passAnt').css("border", "1px solid red");
                        $('#passAnt').attr('title', 'Tienes que introducir la contraseña anterior');
                        allOK = false;
                    } else {
                        $('#passAnt').css("border", "1px solid #dcf2f1");
                        $('#passAnt').attr('title', '');
                        allOK = true;
                    }
                }
                
                if (this.id === 'passAct') {
                    var passAct = $('#passAct').val();

                    if (passAct === "") {
                        $('#passAct').css("border", "1px solid red");
                        $('#passAct').attr('title', 'Tienes que introducir la contraseña nueva');
                        allOK = false;
                    } else {
                        $('#passAct').css("border", "1px solid #dcf2f1");
                        $('#passAct').attr('title', '');
                        allOK = true;
                    }
                }
            }
            
            function validateFields() {
                if ($('#passAnt').val() !== "" && $('#passAnt').val() !== "") {
                    return true;
                } else {
                    return false;
                }
            }
            
            function cambiarImagen(input) {
                if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                  $('#profPic').attr('src', e.target.result);
                };
                reader.readAsDataURL(input.files[0]);
                $("#submitImg").prop("disabled",false);
              }
            }

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
            <div id="changeProfilePic">
                <h1>Cambiar Foto</h1>
                
                <form action="../controladores/subefichero.jsp" enctype="multipart/form-data" method="post"> 
                    <p>Resolución recomendada: 50x50 px</p>
                    <%
                    if (conectado.getFoto() == null) {
                    %>
                    <img src="../img/default.png" id = "profPic" alt = "Foto de perfil">
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
                
                <form name = "changePassForm" onsubmit="return validateFields()" action="../controladores/userControl.jsp" method="POST">
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
            response.sendRedirect("../index.jsp");
        }
        %>
    </body>
</html>