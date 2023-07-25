let uploadButton = document.getElementById("upload-button");
let chosenImage = document.getElementById("chosen-image");
let fileName = document.getElementById("file-name");
let datePickerId = document.getElementById("datePickerId");
var sName = document.getElementById('_showName');
uploadButton.onchange = () => {
    let reader = new FileReader();
    reader.readAsDataURL(uploadButton.files[0]);
    console.log(uploadButton.files[0]);
    reader.onload = () => {
        chosenImage.setAttribute("src", reader.result);    
    }
}

const maxDate = new Date(); 
maxDate.setFullYear(maxDate.getFullYear() - 5); 
datePickerId.max = maxDate.toISOString().split("T")[0];