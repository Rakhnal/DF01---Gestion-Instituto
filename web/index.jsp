<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="shortcut icon" type="image/jpg" href="img/ifplogo.png" />
        <title>Iniciar Sesión</title>

        <script src="scripts/jquery-3.4.1.min.js"></script>

        <link rel="stylesheet" type="text/css" href="css/login.css">

        <script src="scripts/Inicio/index.js"></script>
    </head>
    <body>

        <%
            // Borramos la sesión
            session.invalidate();
        %>
        
        <div id="ppal">
            <form name="logForm" onsubmit="return comprobarCampos()" action="controladores/controlador.jsp" method="POST">

                <h1>Iniciar Sesión</h1>

                <p>Correo</p> 
                <input type='email' placeholder='usuario@dominio.xxx' name='correo' id = 'pass'/>

                <p>Contraseña</p> 
                <input type='password' placeholder='Contraseña' name='pass' id = 'pass'/>

                <a href="vistas/Registro/newUser.jsp">Registrar</a>

                <input type='submit' value = '' name = 'login'/>
            </form>
        </div>

        <footer>

            <div>Iconos realizados por <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> en <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
            </div>

        </footer>
    </body>
</html>
