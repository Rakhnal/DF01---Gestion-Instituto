/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var veces = 0;

function comprobarLogin() {

    if (getCookie("estado") !== "") {
        
        if (getCookie("estado") === "inactiva") {
            alert("Se sobrepaso el limite de intentos de inicio de sesion, espere unos segundos");
            $("#correo").attr("disabled", "disabled");
            $("#pass").attr("disabled", "disabled");
            veces = 0;
        } else {
            if (veces >= 3) {
                document.cookie = "estado=inactiva;max-age=30";

                veces = 0;
                alert("Se sobrepaso el limite de intentos de inicio de sesion");
                $("#correo").attr("disabled", "disabled");
                $("#pass").attr("disabled", "disabled");
            } else {
                $("#correo").attr("enabled", "enabled");
                $("#pass").attr("enabled", "enabled");
            }
        }
    } else {
        $("#correo").attr("enabled", "enabled");
        $("#pass").attr("enabled", "enabled");
        document.cookie = "estado=activa;max-age=100";
    }
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) === 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function comprobarCampos() {

    comprobarLogin();

    if ($('#correo').val() === "") {
        $('#correo').css("border", "1px solid red");
        veces++;
        return false;
    } else {
        $('#correo').css("border", "1px solid black");
    }

    if ($('#pass').val() === "") {
        $('#pass').css("border", "1px solid red");
        veces++;
        return false;
    } else {
        $('#pass').css("border", "1px solid black");
    }
}