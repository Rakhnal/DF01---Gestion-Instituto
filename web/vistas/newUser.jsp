<%-- 
    Document   : newUser
    Created on : 01-oct-2019, 9:17:23
    Author     : alvaro
--%>

<%@page import="Clases.Usuario"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/jpg" href="../img/ifplogo.png" />
        <link rel="stylesheet" type="text/css" href="../css/micss.css">

        <title>Nuevo Profesor</title>

        <script src="jquery-3.4.1.min.js"></script>

        <script>

            $(document).ready(function () {
                $("#register").click(function () {
                    alert("JS");
                });
            });

            function validateForm() {
                alert("JS");
                return false;
            }

        </script>
    </head>
    <body>

        <header>
            <h1>Datos del nuevo profesor</h1>
        </header>
        
        <div id="ppal">
            
            <form name="newForm" onsubmit="return validateForm()" action="../controladores/controlador.jsp" method="POST">

                <div>
                    <label>
                        <p>Nombre:</p>
                    </label>
                    <label class = 'left'>
                        <input type='text' name='nombre' placeholder='Nombre' id = 'nombre'/>
                    </label>
                </div>

                <div>
                    <label>
                        <span>Apellido:</span> 
                    </label>
                    <label class = 'left'>
                        <input type='text' name='apellido' placeholder='Primer Apellido' id='apellido'/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Correo usuario:</span>
                    </label>
                    <label class = 'left'>
                        <input type='email' placeholder='usuario@xxxxxxx.xxx' name='user' id='user'/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Constraseña:</span> 
                    </label>
                    <label class = 'left'>
                        <input type='password' placeholder='Contraseña' name='pass' id='pass'/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Repite la contraseña:</span>
                    </label>
                    <label class = 'left'>
                        <input type='password' placeholder='Contraseña' name='passVal' id = 'passVal'/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>DNI:</span>
                    </label>
                    <label class = 'left'>
                        <input type='text' placeholder='DNI' maxlength="9" name='dni' id='dni'/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Edad:</span> 
                    </label>
                    <label class = 'left'>
                        <input type='number' min = "18" max = "99" name='edad' id='edad'/>
                    </label>
                </div>
                
                <div id = 'botones'>
                    <input type='submit' value = 'Aceptar' name = 'register' id="register"/>
                    <input type='submit' value = 'Volver' name = 'boton' id="back"/>
                </div>
            </form>
        </div>
    </body>
</html>
