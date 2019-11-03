/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var allOK = true;
var idFailed = [];

$(document).ready(function () {
    $("input[type=text]").on('focusin', function () {
        $("input[type=text]").on("focusout", validateField);
    });
});

function validateForm() {
    if (allOK) {
        return true;
    } else {
        alert("Hay errores en el formulario, revísalo");
        return false;
    }
}

function validateField() {

    $("input[type=text]").off("focusout", validateField);

    var valor = $('#' + this.id).val();

    if (valor === "") {
        $('#' + this.id).css("border", "1px solid red");
        idFailed.push(this.id);
        allOK = false;
    } else {
        $('#' + this.id).css("border", "1px solid #dcf2f1");
        
        if (idFailed.indexOf(this.id) !== -1) {
            idFailed.splice(idFailed.indexOf(this.id), 1);
            if (idFailed.length <= 0) {
                allOK = true;
            }
        }
    }
}
