let list = document.querySelectorAll(".comment-section .row");
let thispage = 1;
let limit = 3;

console.log(list.length);

function loadItem() {
  let beginGet = limit * (thispage - 1);
  let endGet = limit * thispage - 1;

  list.forEach((item, key) => {
    if (key >= beginGet && key <= endGet) {
      item.style.display = "flex";
    } else {
      item.style.display = "none";
    }
  });
  listPage();
}

loadItem();

function listPage() {
  let count = Math.ceil(list.length / limit);
  document.querySelector(".listPage").innerHTML = "";

  // if(this.page != 1) {

  // }

  for (i = 1; i <= count; i++) {
    let newPage = document.createElement("li");
    newPage.innerText = i;
    if (i == thispage) {
      newPage.classList.add("active");
    }
    newPage.setAttribute("onclick", "changePage(" + i + ")");
    document.querySelector(".listPage").appendChild(newPage);
  }

  //   if (thispage != count) {
  //     let next = document.createElement("li");
  //     next.innerText = "NEXT";
  //     next.setAttribute("onclick", "changePage(" + (thispage + 1) + ")");
  //     document.querySelector(".listPage").appendChild(next);
  //   }
}

function changePage(i) {
  thispage = i;
  loadItem();
}

document.getElementById("span").addEventListener("click", () => {
  document.querySelector(".des").classList.toggle("active");
});

var mainImg = document.getElementById("main-img");
var smallImg = document.querySelectorAll(".small-img");

smallImg.forEach((el) => {
  el.addEventListener("click", () => (mainImg.src = el.src));
  el.addEventListener("mouseover", () => (mainImg.src = el.src));
});

const addButton = document.getElementById("addToCart");
const popup = document.querySelector(".popup-success");

addButton.addEventListener("click", () => {
  popup.classList.add("show")
  setTimeout(closePopup, 10000)
});

function closePopup() {
  popup.classList.remove("show")
}

//getting all required elements
const gallery = document.querySelectorAll(".small-img"),
  previewBox = document.querySelector(".preview-box"),
  previewImg = previewBox.querySelector(".preview-box .image-box img"),
  closeIcon = previewBox.querySelector(".preview-box .details .icon"),
  currentImg = previewBox.querySelector(
    ".preview-box .details .title .current-img"
  ),
  totalImg = previewBox.querySelector(
    ".preview-box .details .title .total-img"
  ),
  shadow = document.querySelector("main .shadow");

window.onload = () => {
  for (let i = 0; i < gallery.length; i++) {
    totalImg.textContent = gallery.length; //passing total img length to totalImg variable
    let newIndex = i; //passing i value to newIndex variable
    let clickedImgIndex; //creating new variable

    gallery[i].onclick = () => {
      clickedImgIndex = i; //passing cliked image index to created variable (clickedImgIndex)
      function preview() {
        currentImg.textContent = newIndex + 1; //passing current img index to currentImg varible with adding +1
        let imageURL = gallery[newIndex].src; //getting user clicked img url
        previewImg.src = imageURL; //passing user clicked img url in previewImg src
      }
      preview(); //calling above function

      const prevBtn = document.querySelector(
        ".preview-box .image-box .slide.prev"
      );
      const nextBtn = document.querySelector(
        ".preview-box .image-box .slide.next"
      );
      if (newIndex == 0) {
        //if index value is equal to 0 then hide prevBtn
        prevBtn.style.display = "none";
      }
      if (newIndex >= gallery.length - 1) {
        //if index value is greater and equal to gallery length by -1 then hide nextBtn
        nextBtn.style.display = "none";
      }
      prevBtn.onclick = () => {
        newIndex--; //decrement index
        if (newIndex == 0) {
          preview();
          prevBtn.style.display = "none";
        } else {
          preview();
          nextBtn.style.display = "block";
        }
      };
      nextBtn.onclick = () => {
        newIndex++; //increment index
        if (newIndex >= gallery.length - 1) {
          preview();
          nextBtn.style.display = "none";
        } else {
          preview();
          prevBtn.style.display = "block";
        }
      };
      document.querySelector("body").style.overflow = "hidden";
      previewBox.classList.add("show");
      shadow.style.display = "block";
      closeIcon.onclick = () => {
        newIndex = clickedImgIndex; //assigning user first clicked img index to newIndex
        prevBtn.style.display = "block";
        nextBtn.style.display = "block";
        previewBox.classList.remove("show");
        shadow.style.display = "none";
        document.querySelector("body").style.overflow = "scroll";
      };
    };
  }
};

// smallImg[0].onclick = function () {
//   mainImg.src = smallImg[0].src;
// };
// smallImg[1].onclick = function () {
//   mainImg.src = smallImg[1].src;
// };
// smallImg[2].onclick = function () {
//   mainImg.src = smallImg[2].src;
// };
// smallImg[3].onclick = function () {
//   mainImg.src = smallImg[3].src;
// };
// smallImg[4].onclick = function () {
//   mainImg.src = smallImg[4].src;
// };
// smallImg[5].onclick = function () {
//   mainImg.src = smallImg[5].src;
// };
