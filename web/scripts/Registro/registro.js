/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var allOK = false;
var ctSvd = "";

$(document).ready(function () {
    
    $("#captcha").val(valorRandom());
    
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
            $('#imgNombre').css("visibility", "visible");
            $('#imgNombre').attr('title', 'Tienes que introducir un nombre');
            allOK = false;
        } else {
            $('#nombre').css("border", "1px solid black");
            $('#imgNombre').css("visibility", "hidden");
            $('#imgNombre').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'apellido') {
        var apellido = $('#apellido').val();

        if (apellido === "") {
            $('#apellido').css("border", "2px solid red");
            $('#imgApellido').css("visibility", "visible");
            $('#imgApellido').attr('title', 'Tienes que introducir un apellido');
            allOK = false;
        } else {
            $('#apellido').css("border", "1px solid black");
            $('#imgApellido').css("visibility", "hidden");
            $('#imgApellido').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'dni') {
        var dni = $('#dni').val();

        if (dni === "") {
            $('#dni').css("border", "2px solid red");
            $('#imgDni').css("visibility", "visible");
            $('#imgDni').attr('title', 'Tienes que introducir un DNI');
            allOK = false;
        } else if (!nif(dni)) {
            $('#dni').css("border", "2px solid red");
            $('#imgDni').css("visibility", "visible");
            $('#imgDni').attr('title', 'Tienes que introducir un DNI válido');
            allOK = false;
        } else {
            $('#dni').css("border", "1px solid black");
            $('#imgDni').css("visibility", "hidden");
            $('#imgDni').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'correo') {
        var correo = $('#correo').val();
        var res = validateEmail(correo);

        if (correo === "") {
            $('#correo').css("border", "2px solid red");
            $('#imgCorreo').css("visibility", "visible");
            $('#imgCorreo').attr('title', 'Tienes que introducir un correo');
            allOK = false;
        } else if (!validateEmail(correo)) {
            $('#correo').css("border", "2px solid red");
            $('#imgCorreo').css("visibility", "visible");
            $('#imgCorreo').attr('title', 'Tienes que introducir un correo válido');
            allOK = false;
        } else {
            $('#correo').css("border", "1px solid black");
            $('#imgCorreo').css("visibility", "hidden");
            $('#imgCorreo').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'pass') {
        var pass = $('#pass').val();

        if (pass === "") {
            $('#pass').css("border", "2px solid red");
            $('#imgPass').css("visibility", "visible");
            $('#imgPass').attr('title', 'Tienes que introducir una contraseña');
            allOK = false;
        } else {
            $('#pass').css("border", "1px solid black");
            $('#imgPass').css("visibility", "hidden");
            $('#imgPass').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'passVal') {

        var passVal = $('#passVal').val();
        var pass = $('#pass').val();

        if (passVal === "") {
            $('#passVal').css("border", "2px solid red");
            $('#imgPassVal').css("visibility", "visible");
            $('#imgPassVal').attr('title', 'Tienes que introducir una contraseña');
            allOK = false;
        } else if (pass !== passVal) {
            $('#passVal').css("border", "2px solid red");
            $('#imgPassVal').css("visibility", "visible");
            $('#imgPassVal').attr('title', 'Tienes que introducir la misma contraseña');
            allOK = false;
        } else {
            $('#passVal').css("border", "1px solid black");
            $('#imgPassVal').css("visibility", "hidden");
            $('#imgPassVal').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'edad') {
        var edad = $('#edad').val();

        if (edad === "") {
            $('#edad').css("border", "2px solid red");
            $('#imgEdad').css("visibility", "visible");
            $('#imgEdad').attr('title', 'Tienes que seleccionar la edad');
            allOK = false;
        }else if (edad >= 100) {
            $('#edad').css("border", "2px solid red");
            $('#imgEdad').css("visibility", "visible");
            $('#imgEdad').attr('title', 'Tienes que introducir una edad válida, menor de 100');
            allOK = false;
        } else {
            $('#edad').css("border", "1px solid black");
            $('#imgEdad').css("visibility", "hidden");
            $('#imgEdad').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'captchaRes') {

        var captcha = $('#captchaRes').val();

        if (captcha === "") {
            $('#captchaRes').css("border", "2px solid red");
            $('#imgCaptcha').css("visibility", "visible");
            $('#imgCaptcha').attr('title', 'Introduce el captcha de la izquierda');
            allOK = false;
        } else if (captcha !== ctSvd) {
            $('#captchaRes').css("border", "2px solid red");
            $('#imgCaptcha').css("visibility", "visible");
            $('#imgCaptcha').attr('title', 'Captcha incorrecto');
            allOK = false;
        } else {
            $('#captchaRes').css("border", "1px solid black");
            $('#imgCaptcha').css("visibility", "hidden");
            $('#imgCaptcha').attr('title', '');
            allOK = true;
        }
    }

}

function validateForm() {
    if (allOK) {
        return true;
    } else {
        alert("Hay errores en el formulario, revísalo");
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

function valorRandom() {
    
    var result = "";
    var chars = ["A", "v", "8", "&", "Y", "I", "7", "@", "Ñ", "#", "3", "i", "1", "ñ", "%", "2", "w"];
    
    for (var i = 0; i < 6; i++) {
        result += chars[Math.floor((Math.random() * (chars.length)))];
    }
    
    ctSvd = result;
    return result;
}
