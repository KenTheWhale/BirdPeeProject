let OSBCtitle_1 = document.getElementById("OSBCstatus_1"); 
let OSBCtitle_2 = document.getElementById("OSBCstatus_2");
let OSBCtitle_3 = document.getElementById("OSBCstatus_3");
let OSBCtitle_4 = document.getElementById("OSBCstatus_4");
let OSBCtitle_5 = document.getElementById("OSBCstatus_5");

let OSBCdata_1 = document.getElementById("OSBCdata_1");
let OSBCdata_2 = document.getElementById("OSBCdata_2");
let OSBCdata_3 = document.getElementById("OSBCdata_3");
let OSBCdata_4 = document.getElementById("OSBCdata_4");
let OSBCdata_5 = document.getElementById("OSBCdata_5");

if(OSBCtitle_1 === null) OSBCtitle_1 = " ";
if(OSBCtitle_2 === null) OSBCtitle_2 = " ";
if(OSBCtitle_3 === null) OSBCtitle_3 = " ";
if(OSBCtitle_4 === null) OSBCtitle_4 = " ";
if(OSBCtitle_5 === null) OSBCtitle_5 = " ";

if(OSBCdata_1 === null) OSBCdata_1 = 0;
if(OSBCdata_2 === null) OSBCdata_2 = 0;
if(OSBCdata_3 === null) OSBCdata_3 = 0;
if(OSBCdata_4 === null) OSBCdata_4 = 0;
if(OSBCdata_5 === null) OSBCdata_5 = 0;

const data2 = {
  labels: [
      OSBCtitle_1.value,
      OSBCtitle_2.value,
      OSBCtitle_3.value,
      OSBCtitle_4.value,
      OSBCtitle_5.value
  ],
  datasets: [
    {
      label: "Status",
      data: [
          OSBCdata_1.value,
          OSBCdata_2.value,
          OSBCdata_3.value,
          OSBCdata_4.value,
          OSBCdata_5.value
      ],
      backgroundColor: [
        "rgb(227, 25, 55)",
        "rgb(255, 235, 0)",
        "rgb(121, 116, 112)",
        "rgb(51, 24, 120)",
        "rgb(121, 180, 101)"
      ],
      hoverOffset: 4
    }
  ]
};

const config2 = {
  type: "pie",
  data: data2
};

var myChart = new Chart(document.getElementById("order-status"), config2);
