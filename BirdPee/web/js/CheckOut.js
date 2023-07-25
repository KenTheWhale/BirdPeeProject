/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
const addButton = document.getElementById("CheckOut");
const popup = document.querySelector(".popup-success");

addButton.addEventListener("click", () => {
  popup.classList.add("show")
  setTimeout(closePopup, 3000)
});

function closePopup() {
  popup.classList.remove("show")
}

