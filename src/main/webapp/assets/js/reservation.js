function makeReservation(){
	document.getElementById("reservationForm").style.display = "block";
	document.getElementById("reservationDetails").style.display = "none";
}

function viewReservations(){
	document.getElementById("reservationDetails").style.display = "block";
	document.getElementById("reservationForm").style.display = "none";
}

function viewOldReservations(){
	document.getElementById("oldReservations").style.display = "block";
}

function closeOldReservations(){
	document.getElementById("oldReservations").style.display = "none";
}