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
        <link rel="shortcut icon" type="image/jpg" href="../../img/ifplogo.png" />
        <link rel="stylesheet" type="text/css" href="../../css/registro.css">

        <title>Nuevo Profesor</title>

        <script src="../../scripts/jquery-3.4.1.min.js"></script>
        <script src="../../scripts/Registro/registro.js"></script>
    </head>
    <body>

        <header>
            <h1>Datos del nuevo profesor</h1>
        </header>

        <div id="ppal">

            <form name="newForm" onsubmit="return validateForm()" action="../../controladores/controlador.jsp" method="POST">

                <div>
                    <label>
                        <p>Nombre:</p>
                    </label>
                    <label class = 'left'>
                        <input type='text' name='nombre' placeholder='Nombre' id = 'nombre'/>
                        <img id = 'imgNombre' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>

                <div>
                    <label>
                        <span>Apellido:</span> 
                    </label>
                    <label class = 'left'>
                        <input type='text' name='apellido' placeholder='Primer Apellido' id='apellido'/>
                        <img id = 'imgApellido' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Correo usuario:</span>
                    </label>
                    <label class = 'left'>
                        <input type='email' placeholder='usuario@xxxxxxx.xxx' name='correo' id='correo'/>
                        <img id = 'imgCorreo' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Constraseña:</span> 
                    </label>
                    <label class = 'left'>
                        <input type='password' placeholder='Contraseña' name='pass' id='pass'/>
                        <img id = 'imgPass' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Repite la contraseña:</span>
                    </label>
                    <label class = 'left'>
                        <input type='password' placeholder='Contraseña' name='passVal' id = 'passVal'/>
                        <img id = 'imgPassVal' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>DNI:</span>
                    </label>
                    <label class = 'left'>
                        <input type='text' placeholder='DNI' maxlength="9" name='dni' id='dni'/>
                        <img id = 'imgDni' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                <div>
                    <label>
                        <span>Edad:</span> 
                    </label>
                    <label class = 'left'>
                        <input type='number' min = "18" max = "99" maxlength="3" name='edad' id='edad'/>
                        <img id = 'imgEdad' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                
                <div>
                    <label>
                        <input type='text' disabled name='captcha' value = "" id='captcha'/>
                    </label>
                    <label class = 'left'>
                        <input type='text' placeholder='Introduce el Captcha' name='captchaRes' id='captchaRes'/>
                        <img id = 'imgCaptcha' src="../../img/warning.png" alt="error"/>
                    </label>
                </div>
                
                <input type='submit' value = '' name = 'register' id="register"/>
                <input type='button' value = '' onclick='window.location = "../../index.jsp"' name = 'backRegister' id="back"/>
            </form>
        </div>
    </body>
</html>
