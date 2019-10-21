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

        <link rel="stylesheet" type="text/css" href="css/micss.css">
    </head>
    <body>
        
        <div id="ppal">
            <form name="logForm" action="controlador.jsp" method="POST">

                <h1>Iniciar Sesión</h1>

                <div>
                    <span>Usuario:</span> 
                    <input required type='text' type='email' placeholder='usuario@dominio.xxx' name='user' style="margin-left: 30px"/>
                    <br>
                </div>

                <div>
                    <span>Contraseña:</span> 
                    <input required type='password' placeholder='Contraseña' name='pass'  style="margin-left: 10px"/>
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
