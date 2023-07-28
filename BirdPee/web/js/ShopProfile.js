let list = document.querySelectorAll("a .column");
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
        if (i === thispage) {
            newPage.classList.add("active");
        }
        newPage.setAttribute("onclick", "changePage(" + i + ")");
        document.querySelector(".listPage").appendChild(newPage);
    }
}

const headerSideBar = document.querySelector(".header__icon-mobile");
const headerButton = document.getElementById("mobile");
const shadow = document.querySelector(".shadow");
const closeSideBar = document.querySelector(
        ".header__icon-mobile .close-sidebar"
        );

headerButton.addEventListener("click", () => {
    headerSideBar.classList.add("open");
    shadow.style.display = "block";
});

closeSideBar.addEventListener("click", () => {
    headerSideBar.classList.remove("open");
    shadow.style.display = "none";
});

const filterButton = document.getElementById("filter-button");
const filterMobile = document.querySelector("main .main__filter");
const close = document.querySelector(".filter-close");

filterButton.addEventListener("click", () => {
    filterMobile.classList.add("open");
    shadow.style.display = "block";
});

close.addEventListener("click", () => {
    filterMobile.classList.remove("open");
    shadow.style.display = "none";
});
