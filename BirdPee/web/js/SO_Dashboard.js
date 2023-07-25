const navBar = document.querySelector("nav"),
  menuBtns = document.querySelectorAll(".menu-icon"),
  overlay = document.querySelector(".overlay");

shadow = document.querySelector("main .shadow");

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

//   if (thispage != count) {
//     let next = document.createElement("li");
//     next.innerText = "NEXT";
//     next.setAttribute("onclick", "changePage(" + (thispage + 1) + ")");
//     document.querySelector(".listPage").appendChild(next);
//   }

// document.getElementById("span").addEventListener("click", () => {
//   document.querySelector('.des').classList.toggle('active')
// });

let uploadButton = document.getElementById("upload-button");
let chosenImage = document.getElementById("chosen-image");

uploadButton.addEventListener("change", function () {
  const image = this.files[0];
  console(image);
});

const optionMenu = document.querySelector(
    "main .main-container .order-status table tbody tr .select-menu"
  ),
  selectBtn = optionMenu.querySelector(
    "main .main-container .order-status table tbody tr .select-btn"
  ),
  options1 = optionMenu.querySelectorAll(
    "main .main-container .order-status table tbody tr .option"
  ),
  sBtn_text = optionMenu.querySelector(
    "main .main-container .order-status table tbody tr .sBtn-text"
  );
selectBtn.addEventListener("click", () =>
  optionMenu.classList.toggle("active")
);
options1.forEach((option1) => {
  option1.addEventListener("click", () => {
    let selectedOption = option1.querySelector(".option-text").innerText;
    sBtn_text.innerText = selectedOption;
    optionMenu.classList.remove("active");
  });
});
