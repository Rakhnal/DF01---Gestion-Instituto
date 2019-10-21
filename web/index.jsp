<%-- 
    Document   : index
    Created on : 01-oct-2019, 9:18:13
    Author     : alvaro
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Clases.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/jpg" href="img/ifplogo.png" />
        <title>Iniciar Sesión</title>

        <script src="../scripts/jquery-3.4.1.min.js"></script>
        
        <link rel="stylesheet" type="text/css" href="css/login.css">
        
        <script>
            
            function comprobarCampos() {
                
                if ($('correo').val() === "") {
                    
                    return false;
                }
                
            }
            
        </script>
    </head>
    <body>
        
        <div id="ppal">
            <form name="logForm" onsubmit="return comprobarCampos()" action="controlador.jsp" method="POST">

                <h1>Iniciar Sesión</h1>

                <div>
                    <span>Correo:</span> 
                    <input required type='text' type='email' placeholder='usuario@dominio.xxx' name='correo' id = 'correo'/>
                    <br>
                </div>

                <div>
                    <span>Contraseña:</span> 
                    <input required type='password' placeholder='Contraseña' name='pass' id = 'pass' name='pass'/>
                    <br>
                </div>

                <br>

                <a href="vistas/newUser.jsp">Registrar</a>
                <a href="vistas/resetPassword.jsp">Cambiar contraseña</a>

                <br>
                <input type='submit' value = 'Acceder' name = 'login'/>
            </form>
        </div>
    </body>
</html>
