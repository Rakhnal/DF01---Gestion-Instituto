/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {

    $("#cese").click(function () {
        window.location = "../../index.jsp";
    });

    $("#about").click(function () {
        window.location = "../Informacion/about.jsp";
    });

});

function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}