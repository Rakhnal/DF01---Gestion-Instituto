/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var veces = 0;

function comprobarLogin() {
    
    if (getCookie("cookie") !== null) {
        
        var a = leercookie();
        
        if (a === "inactiva") {
            alert("Se sobrepaso el limite de intentos de inicio de sesion, espere unos segundos");
            $("#correo").attr("disabled", "disabled");
            $("#pass").attr("disabled", "disabled");
        } else {
            if (veces >= 3) {
                document.cookie = "nombre=inactiva;max-age=30";
                localStorage.setItem("cookie", document.cookie);

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
        document.cookie = "nombre=activa;max-age=400";
        localStorage.setItem("cookie", document.cookie);
    }
}

function leercookie() {
    
    var ca = getCookie("cookie").split('=');
    var c = ca[1];

    return c;
}

function getCookie(c_name) {
    return localStorage.getItem(c_name);
}

function comprobarCampos() {

    if ($('#correo').val() === "") {
        $('#correo').css("border", "1px solid red");
        veces++;
        var res = comprobarLogin();
        return false;
    } else {
        $('#correo').css("border", "1px solid black");
    }

    if ($('#pass').val() === "") {
        $('#pass').css("border", "1px solid red");
        veces++;
        var res = comprobarLogin();
        return false;
    } else {
        $('#pass').css("border", "1px solid black");
    }
}