const ctx2 = document.getElementById("topproducts");

let HPBCtitle_1 = document.getElementById("HPBCname_1"); 
let HPBCtitle_2 = document.getElementById("HPBCname_2");
let HPBCtitle_3 = document.getElementById("HPBCname_3");
let HPBCtitle_4 = document.getElementById("HPBCname_4");
let HPBCtitle_5 = document.getElementById("HPBCname_5");
let HPBCtitle_6 = document.getElementById("HPBCname_6"); 
let HPBCtitle_7 = document.getElementById("HPBCname_7");
let HPBCtitle_8 = document.getElementById("HPBCname_8");
let HPBCtitle_9 = document.getElementById("HPBCname_9");
let HPBCtitle_10 = document.getElementById("HPBCname_10");

let HPBCdata_1 = document.getElementById("HPBCdata_1");
let HPBCdata_2 = document.getElementById("HPBCdata_2");
let HPBCdata_3 = document.getElementById("HPBCdata_3");
let HPBCdata_4 = document.getElementById("HPBCdata_4");
let HPBCdata_5 = document.getElementById("HPBCdata_5");
let HPBCdata_6 = document.getElementById("HPBCdata_6");
let HPBCdata_7 = document.getElementById("HPBCdata_7");
let HPBCdata_8 = document.getElementById("HPBCdata_8");
let HPBCdata_9 = document.getElementById("HPBCdata_9");
let HPBCdata_10 = document.getElementById("HPBCdata_10");

if(HPBCtitle_1 === null) HPBCtitle_1 = " ";
if(HPBCtitle_2 === null) HPBCtitle_2 = " ";
if(HPBCtitle_3 === null) HPBCtitle_3 = " ";
if(HPBCtitle_4 === null) HPBCtitle_4 = " ";
if(HPBCtitle_5 === null) HPBCtitle_5 = " ";
if(HPBCtitle_6 === null) HPBCtitle_6 = " ";
if(HPBCtitle_7 === null) HPBCtitle_7 = " ";
if(HPBCtitle_8 === null) HPBCtitle_8 = " ";
if(HPBCtitle_9 === null) HPBCtitle_9 = " ";
if(HPBCtitle_10 === null) HPBCtitle_10 = " ";

if(HPBCdata_1 === null) HPBCdata_1 = 0;
if(HPBCdata_2 === null) HPBCdata_2 = 0;
if(HPBCdata_3 === null) HPBCdata_3 = 0;
if(HPBCdata_4 === null) HPBCdata_4 = 0;
if(HPBCdata_5 === null) HPBCdata_5 = 0;
if(HPBCdata_6 === null) HPBCdata_6 = 0;
if(HPBCdata_7 === null) HPBCdata_7 = 0;
if(HPBCdata_8 === null) HPBCdata_8 = 0;
if(HPBCdata_9 === null) HPBCdata_9 = 0;
if(HPBCdata_10 === null) HPBCdata_10 = 0;

new Chart(ctx2, {
  type: "bar",
  data: {
    labels: [
        HPBCtitle_1.value,
        HPBCtitle_2.value,
        HPBCtitle_3.value,
        HPBCtitle_4.value,
        HPBCtitle_5.value,
        HPBCtitle_6.value,
        HPBCtitle_7.value,
        HPBCtitle_8.value,
        HPBCtitle_9.value,
        HPBCtitle_10.value
    ],
    datasets: [
      {
        label: "Sold Product",
        data: [
            HPBCdata_1.value, 
            HPBCdata_2.value, 
            HPBCdata_3.value, 
            HPBCdata_4.value, 
            HPBCdata_5.value, 
            HPBCdata_6.value, 
            HPBCdata_7.value, 
            HPBCdata_8.value, 
            HPBCdata_9.value, 
            HPBCdata_10.value 
        ],
        backgroundColor: [
            'red',
            'red',
            'red',
            'red',
            'red',
            'red'
        ],
        borderWidth: 1,
      },
    ],
  },
  options: {
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  },
});
