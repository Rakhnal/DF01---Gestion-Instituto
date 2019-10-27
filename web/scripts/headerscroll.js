/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

window.onscroll = function() {
    scrollFunction()
};

function scrollFunction() {
  if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
    document.getElementById("header").style.minHeight  = "0px";
    document.getElementById("header").style.visibility  = "hidden";
  } else {
    document.getElementById("header").style.minHeight  = "50px";
    document.getElementById("header").style.visibility  = "visible";
  }
}
