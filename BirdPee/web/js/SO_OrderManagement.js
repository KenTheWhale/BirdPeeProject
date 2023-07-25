const button = document.querySelectorAll("span.icon");
const popup = document.getElementById("popup");
const close = document.getElementById("close");
const shadow = document.querySelector(".shadow");

//button.forEach((el) => {
//  el.addEventListener("click", () => {
//    popup.classList.add("show");
//    shadow.style.display = "block";
//  });
//});
//
//close.addEventListener("click", () => {
//  popup.classList.remove("show");
//  shadow.style.display = "none";
//});

console.log(button);

const navBar = document.querySelector("nav"),
  menuBtns = document.querySelectorAll(".menu-icon"),
  overlay = document.querySelector(".overlay");

menuBtns.forEach((menuBtn) => {
  menuBtn.addEventListener("click", () => {
    navBar.classList.toggle("open");
    shadow.style.display = "block";
  });
});

overlay.addEventListener("click", () => {
  navBar.classList.remove("open");
  shadow.style.display = "none";
});
