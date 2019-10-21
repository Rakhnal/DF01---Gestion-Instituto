<%-- 
    Document   : index
    Created on : 17-oct-2019, 9:49:31
    Author     : alvaro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/jpg" href="../img/ifplogo.png" />
        <title>Selección de Area</title>
        
        <link rel="stylesheet" type="text/css" href="css/ppal.css">
    </head>
    <body>
        <header>
            <input type="button" value="" id="cese">
            <input type="button" value="" id="about">
            <img id ="userIcon" src = "img/usuarios/adonoso@gmail.com.jpg" alt = "Imagen perfil del usuario"/>
        </header>
        
        <div id="ppal">
            <form name="logForm" action="../controladores/controlador.jsp" method="POST">

                <h1>Selecciona el modo de entrar a la plataforma:</h1>

                <select type = 'text' name = 'selType'>
                    <option value = 'admin' default>Administrador</option>
                    <option value = 'user'>Usuario</option>
                </select>
                <br><br>
                <input type="submit" name = 'acceder' value="Acceder" />
                <input type="submit" name = 'boton' value="Volver" />
            </form>
        </div>
    </body>
</html>
