const ctx = document.getElementById("soldproduct");

let PSBCtitle_1 = document.getElementById("PSBCdate_1"); 
let PSBCtitle_2 = document.getElementById("PSBCdate_2");
let PSBCtitle_3 = document.getElementById("PSBCdate_3");
let PSBCtitle_4 = document.getElementById("PSBCdate_4");
let PSBCtitle_5 = document.getElementById("PSBCdate_5");

let PSBCdata_1 = document.getElementById("PSBCdata_1");
let PSBCdata_2 = document.getElementById("PSBCdata_2");
let PSBCdata_3 = document.getElementById("PSBCdata_3");
let PSBCdata_4 = document.getElementById("PSBCdata_4");
let PSBCdata_5 = document.getElementById("PSBCdata_5");

if(PSBCtitle_1 === null) PSBCtitle_1 = " ";
if(PSBCtitle_2 === null) PSBCtitle_2 = " ";
if(PSBCtitle_3 === null) PSBCtitle_3 = " ";
if(PSBCtitle_4 === null) PSBCtitle_4 = " ";
if(PSBCtitle_5 === null) PSBCtitle_5 = " ";

if(PSBCdata_1 === null) PSBCdata_1 = 0;
if(PSBCdata_2 === null) PSBCdata_2 = 0;
if(PSBCdata_3 === null) PSBCdata_3 = 0;
if(PSBCdata_4 === null) PSBCdata_4 = 0;
if(PSBCdata_5 === null) PSBCdata_5 = 0;

new Chart(ctx, {
  type: "bar",
  data: {
    labels: [PSBCtitle_5.value, PSBCtitle_4.value, PSBCtitle_3.value, PSBCtitle_2.value, PSBCtitle_1.value],
    datasets: [
      {
        label: "Sold order",
        data: [PSBCdata_5.value, PSBCdata_4.value, PSBCdata_3.value, PSBCdata_2.value, PSBCdata_1.value],
        backgroundColor: [
            '#0090e7',
            '#0090e7',
            '#0090e7',
            '#0090e7',
            '#0090e7',
            '#0090e7'
        ],
        borderWidth: 1
      }
    ]
  },
  options: {
    scales: {
      y: {
        beginAtZero: true
      }
    }
  }
});
