/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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