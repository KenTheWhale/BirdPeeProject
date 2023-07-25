let RBCtitle_1 = document.getElementById("RBCdate_1"); 
let RBCtitle_2 = document.getElementById("RBCdate_2");
let RBCtitle_3 = document.getElementById("RBCdate_3");
let RBCtitle_4 = document.getElementById("RBCdate_4");
let RBCtitle_5 = document.getElementById("RBCdate_5");

let RBCdata_1 = document.getElementById("RBCdata_1");
let RBCdata_2 = document.getElementById("RBCdata_2");
let RBCdata_3 = document.getElementById("RBCdata_3");
let RBCdata_4 = document.getElementById("RBCdata_4");
let RBCdata_5 = document.getElementById("RBCdata_5");

if(RBCtitle_1 === null) RBCtitle_1 = " ";
if(RBCtitle_2 === null) RBCtitle_2 = " ";
if(RBCtitle_3 === null) RBCtitle_3 = " ";
if(RBCtitle_4 === null) RBCtitle_4 = " ";
if(RBCtitle_5 === null) RBCtitle_5 = " ";

if(RBCdata_1 === null) RBCdata_1 = 0;
if(RBCdata_2 === null) RBCdata_2 = 0;
if(RBCdata_3 === null) RBCdata_3 = 0;
if(RBCdata_4 === null) RBCdata_4 = 0;
if(RBCdata_5 === null) RBCdata_5 = 0;

const labels = [RBCtitle_5.value, RBCtitle_4.value, RBCtitle_3.value, RBCtitle_2.value, RBCtitle_1.value];
const data = {
  labels: labels,
  datasets: [
    {
      label: "Revenue",
      data: [RBCdata_5.value, RBCdata_4.value, RBCdata_3.value, RBCdata_2.value, RBCdata_1.value],
      fill: false,
      borderColor: "rgb(75, 192, 192)",
      tension: 0.1
    }
  ]
};

const config = {
  type: "line",
  data: data
};

var myChart = new Chart(document.getElementById('revenuechart'), config);

