<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link rel="shortcut icon" type="image/jpg" href="img/ifplogo.png" />
        <title>Iniciar Sesi�n</title>

        <script src="../scripts/jquery-3.4.1.min.js"></script>

        <link rel="stylesheet" type="text/css" href="css/login.css">

        <script>

            function comprobarCampos() {

                if ($('#correo').val() === "") {
                    $('#correo').css("border", "2px solid red");
                    return false;
                } else {
                    $('#correo').css("border", "1px solid black");
                }

                if ($('#pass').val() === "") {
                    $('#pass').css("border", "2px solid red");
                    return false;
                } else {
                    $('#pass').css("border", "1px solid black");
                }

            }

        </script>
    </head>
    <body>

        <%
        
            session.setAttribute("sesUsr", null);

        %>
        
        <div id="ppal">
            <form name="logForm" onsubmit="return comprobarCampos()" action="controladores/controlador.jsp" method="POST">

                <h1>Iniciar Sesi�n</h1>

                <p>Correo</p> 
                <input required type='email' placeholder='usuario@dominio.xxx' name='correo' id = 'correo'/>

                <p>Contrase�a</p> 
                <input required type='password' placeholder='Contrase�a' name='pass' id = 'pass'/>

                <a href="vistas/newUser.jsp">Registrar</a>

                <input type='submit' value = '' name = 'login'/>
            </form>
        </div>

        <footer>

            <div>Icons made by <a href="https://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
            </div>

        </footer>
    </body>
</html>
