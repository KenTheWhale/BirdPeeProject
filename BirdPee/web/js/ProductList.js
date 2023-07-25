let list = document.querySelectorAll(".column");
let thispage = 1;
let limit = 9;

console.log(list.length);

function loadItem() {
  let beginGet = limit * (thispage - 1);
  let endGet = limit * thispage - 1;

  list.forEach((item, key) => {
    if (key >= beginGet && key <= endGet) {
      item.style.display = "block";
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

// document.getElementById("span").addEventListener("click", () => {
//   document.querySelector('.des').classList.toggle('active')
// });

