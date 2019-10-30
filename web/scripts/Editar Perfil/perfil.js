/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var allOK = true;

$(document).ready(function () {

    $("input").on('focusin', function () {
        $("input").on("focusout", validateAll);
    });

});

function validateAll() {

    $("input").off("focusout", validateAll);

    if (this.id === 'passAnt') {
        var passAnt = $('#passAnt').val();

        if (passAnt === "") {
            $('#passAnt').css("border", "1px solid red");
            $('#passAnt').attr('title', 'Tienes que introducir la contraseña anterior');
            allOK = false;
        } else {
            $('#passAnt').css("border", "1px solid #dcf2f1");
            $('#passAnt').attr('title', '');
            allOK = true;
        }
    }

    if (this.id === 'passAct') {
        var passAct = $('#passAct').val();

        if (passAct === "") {
            $('#passAct').css("border", "1px solid red");
            $('#passAct').attr('title', 'Tienes que introducir la contraseña nueva');
            allOK = false;
        } else {
            $('#passAct').css("border", "1px solid #dcf2f1");
            $('#passAct').attr('title', '');
            allOK = true;
        }
    }
}

function validateFields() {
    if ($('#passAnt').val() !== "" && $('#passAnt').val() !== "") {
        return true;
    } else {
        return false;
    }
}

function cambiarImagen(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#profPic').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
        $("#submitImg").prop("disabled", false);
    }
}