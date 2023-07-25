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

var options = {
  series: [
    {
      name: "sales",
      data: [
        {
          x: "2019/01/01",
          y: 400,
        },
        {
          x: "2019/04/01",
          y: 430,
        },
        {
          x: "2019/07/01",
          y: 448,
        },
        {
          x: "2019/10/01",
          y: 470,
        },
        {
          x: "2020/01/01",
          y: 540,
        },
        {
          x: "2020/04/01",
          y: 580,
        },
        {
          x: "2020/07/01",
          y: 690,
        },
        {
          x: "2020/10/01",
          y: 690,
        },
      ],
    },
  ],
  chart: {
    type: "bar",
    height: 380,
  },
  xaxis: {
    type: "category",
    labels: {
      formatter: function (val) {
        return "Q" + dayjs(val).quarter();
      },
    },
    group: {
      style: {
        fontSize: "10px",
        fontWeight: 700,
      },
      groups: [
        { title: "2019", cols: 4 },
        { title: "2020", cols: 4 },
      ],
    },
  },
  title: {
    text: "Grouped Labels on the X-axis",
  },
  tooltip: {
    x: {
      formatter: function (val) {
        return "Q" + dayjs(val).quarter() + " " + dayjs(val).format("YYYY");
      },
    },
  },
};

var chart = new ApexCharts(document.querySelector("#chart"), options);
chart.render();

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
