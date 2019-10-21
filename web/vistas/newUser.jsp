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
        <link rel="stylesheet" type="text/css" href="../css/registro.css">

        <title>Nuevo Profesor</title>

        <script src="../scripts/jquery-3.4.1.min.js"></script>

        <script>

            $(document).ready(function () {

                var allOK = true;


                $("input").on('focusin', function () {
                    $("input").on("focusout", validateAll);
                });
            });

            function validateAll() {

                $("input").off("focusout", validateAll);

                if (this.id === 'nombre') {
                    var nombre = $('#nombre').val();

                    if (nombre === "") {
                        $('#nombre').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#nombre').css("border", "1px solid black");
                        allOK = true;
                    }
                }

                if (this.id === 'apellido') {
                    var apellido = $('#apellido').val();

                    if (apellido === "") {
                        $('#apellido').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#apellido').css("border", "1px solid black");
                        allOK = true;
                    }
                }

                if (this.id === 'dni') {
                    var dni = $('#dni').val();

                    if (dni === "") {
                        $('#dni').css("border", "2px solid red");
                        allOK = false;
                    } else if (!nif(dni)) {
                        $('#dni').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#dni').css("border", "1px solid black");
                        allOK = true;
                    }
                }

                if (this.id === 'correo') {
                    var correo = $('#correo').val();
                    var res = validateEmail(correo);

                    if (correo === "") {
                        $('#correo').css("border", "2px solid red");
                        allOK = false;
                    } else if (!validateEmail(correo)) {
                        $('#correo').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#correo').css("border", "1px solid black");
                        allOK = true;
                    }
                }

                if (this.id === 'pass') {
                    var pass = $('#pass').val();

                    if (pass === "") {
                        $('#pass').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#pass').css("border", "1px solid black");
                        allOK = true;
                    }
                }

                if (this.id === 'passVal') {
                    var passVal = $('#passVal').val();

                    if (passVal === "") {
                        $('#passVal').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#passVal').css("border", "1px solid black");
                        allOK = true;
                    }
                }

                if (this.id === 'edad') {
                    var edad = $('#edad').val();

                    if (edad === "") {
                        $('#edad').css("border", "2px solid red");
                        allOK = false;
                    } else {
                        $('#edad').css("border", "1px solid black");
                        allOK = true;
                    }
                }

            }

            function validateForm() {
                if (allOK) {
                    return true;
                } else {
                    return false;
                }
            }

            function validateEmail(email) {
                var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(String(email).toLowerCase());
            }

            function validateDni(dni) {
                var re = /^(([X-Z]{1})([-]?)(\d{7})([-]?)([A-Z]{1}))|((\d{8})([-]?)([A-Z]{1})$/;
                return re.test(String(dni).toLowerCase());
            }

            function esNumero(num) {
                if (isNaN(num)) {
                    document.getElementById("tlf").value = "";
                }
            }

            function nif(dni) {
                var numero;
                var letr;
                var letra;
                var expresion_regular_dni;

                expresion_regular_dni = /^\d{8}[a-zA-Z]$/;

                if (expresion_regular_dni.test(dni) === true) {
                    numero = dni.substr(0, dni.length - 1);
                    letr = dni.substr(dni.length - 1, 1);
                    numero = numero % 23;
                    letra = 'TRWAGMYFPDXBNJZSQVHLCKET';
                    letra = letra.substring(numero, numero + 1);
                    if (letra !== letr.toUpperCase()) {
                        return false;
                    } else {
                        return true;
                    }
                } else {
                    return false;
                }
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
                        <input type='email' placeholder='usuario@xxxxxxx.xxx' name='correo' id='correo'/>
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
