/* global URL */

shadow = document.querySelector("main .shadow");

let icon = document.querySelectorAll("i.icon");

var popupProduct = document.getElementById("popup-product");

//icon.forEach((el) => {
//  el.addEventListener("click", () => {
//    popupProduct.classList.add("show");
//    shadow.style.display = "block";
//  });
//});

//var close = document.getElementById("close");
//close.addEventListener("click", () => {
//  popupProduct.classList.remove("show");
//  shadow.style.display = "none";
//});

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

let fileInput = document.getElementById("file-input");
let imageContainer = document.getElementById("images");
let numOfFiles = document.getElementById("num-of-files");



let img1 = document.getElementById("image1");
let img2 = document.getElementById("image2");
let img3 = document.getElementById("image3");
let img4 = document.getElementById("image4");

let file1 = document.getElementById("img1");
let file2 = document.getElementById("img2");
let file3 = document.getElementById("img3");
let file4 = document.getElementById("img4");

function previewBeforeUpload(id) {
    document.querySelector("#img" + id).addEventListener("change", function (e) {
        if (e.target.files.length === 0) {
            return;
        }
        let file = e.target.files[0];
        let url = URL.createObjectURL(file);
        document.querySelector("#image" + id).src = url;
        document.querySelector(".imgContainer #icon" + id).style.display = "none";
    });
}

previewBeforeUpload("1");
previewBeforeUpload("2");
previewBeforeUpload("3");
previewBeforeUpload("4");
