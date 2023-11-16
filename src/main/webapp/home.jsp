<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="Controller.Crud" %>

<html>
	<head>
		<link href="css/reservation.css" type="text/css" rel="stylesheet">
	</head>
	
	<body>
		<h1 align="center">VehicleReservationApp</h1>
		<h2 align="center">Home</h2>
		
		<br><br>
		<form action="logout" method="get">
    		<input type="submit" value="Logout">
		</form>
		
		<button onclick="openform2()">Reservation Details</button>
		<button onclick="openform()">Make A Reservation</button>
		
		<section>
			<div class="" id="reservationDetails">
				 <h1>Reservations</h1>
				 
				 <%-- 

    <%
        try {
            List<String[]> myList = Crud.displayReservations("user1");

            // Check if myList is not null and not empty
            if (myList != null && !myList.isEmpty()) {
    %>
    
    --%>
    <table border="1">
        <tr>
        	<th>Booking ID</th>
            <th>Date</th>
            <th>Time</th>
            <th>Location</th>
            <th>Vehicle Number</th>
            <th>Mileage</th>
            <th>Message</th>
        </tr>
        
        <%-- 
        <%
            for (String[] array : myList) {
        %>
        <tr>
            <td><%= array[0] %></td>
            <td><%= array[1] %></td>
            <td><%= array[2] %></td>
            <td><%= array[3] %></td>
            <td><%= array[4] %></td>
            <td><%= array[5] %></td>
            <td><%= array[6] %></td>
        </tr>
        <%
            }
        %>
        
        --%>
    </table>
    
    <%-- 
    <%
            } else {
    %>
    <p>No reservations found for this user.</p>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
    %>
    <p>An error occurred while retrieving reservations.</p>
    <%
        }
    %>
    
    --%>
			</div>
		</section>
		
		<section>
			<div class="reservation" id="reservationForm">
				<form action="ReservationServlet" method="POST">
					<h2>Make A Reservation</h2>
					
					<table>
						<tr>
							<td><label for="reservationDate">Reservation Date</label></td>
							<td><input type="date" name="reservationDate" required></td>
						</tr>
						<tr>
							<td><label for="reservationTime">Reservation Time</label></td>
							<td>
								<input type="radio" name="reservationTime" value="10:00" required>10.00AM
								<input type="radio" name="reservationTime" value="11:00" required>11.00AM
								<input type="radio" name="reservationTime" value="12:00" required>12.00PM
							</td>
						</tr>
						<tr>
							<td><label for="district">District</label></td>
							<td>
								<select name="district">
									<option>Colombo</option>
									<option>Gampaha</option>
									<option>Kaluthara</option>
									<option>Kandy</option>
									<option>Mathale</option>
									<option>NuwaraEliya</option>
									<option>Galle</option>
									<option>Mathara</option>
									<option>Hambanthota</option>
									<option>Jaffna</option>
									<option>Kilinochchi</option>
									<option>Vauniya</option>
									<option>Mulathiv</option>
									<option>Mannar</option>
									<option>Batticloa</option>
									<option>Ampara</option>
									<option>Trincomalee</option>
									<option>Kurunegala</option>
									<option>Puththalam</option>
									<option>Anuradhapura</option>
									<option>Polonnaruwa</option>
									<option>Badulla</option>
									<option>Monaragala</option>
									<option>Rathnapura</option>
									<option>Kegalle</option>
								</select>
							</td>
						</tr>
						
						<tr>
							<td><label for="">Registration No</label></td>
							<td>
								<select name="reg1" required>
									<option>WP</option>
									<option>CP</option>
									<option>SP</option>
									<option>NP</option>
									<option>EP</option>
									<option>NW</option>
									<option>NC</option>
									<option>UP</option>
									<option>SB</option>
								</select>
								
								<input type="text" name="reg2" maxlength="3" required> - <input type="text" name="reg3" maxlength="4" required>
							</td>
						</tr>
						<tr>
							<td><label for="mileage">Current Mileage</label></td>
							<td>
								<input type="number" name="mileage" min="0" max="999999">
							</td>
						</tr>
						<tr>
							<td><label for="message">Message</label></td>
							<td>
								<textarea name="message" rows="5" cols="50" maxlength="1000" required></textarea>
							</td>
						</tr>
					</table>
					
					<input type="hidden" name="username" value="user1">
					
					<input type="submit" value="Add">
				</form>
				
			</div>
		</section>
		
		<script src="js/script.js"></script>
		
	</body>
</html>