<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>

<%@ page import="com.vehiclereservation.secure.*" %>

<%
    try {
        Reservation reservation = new Reservation();
        int rowsInserted = 0;

        if (request.getParameter("submit") != null) {
            String location = request.getParameter("location");
            String mileageStr = request.getParameter("mileage");
            int mileage = 0;

            try {
                mileage = Integer.parseInt(mileageStr);
            } catch (NumberFormatException e) {
                out.println("Invalid mileage format");
                return;
            }

            String vehicleNo_part1 = request.getParameter("reg1");
            String vehicleNo_part2 = request.getParameter("reg2");
            String vehicleNo_part3 = request.getParameter("reg3");
            String vehicle = vehicleNo_part1 + "-" + vehicleNo_part2 + "-" + vehicleNo_part3;

            String message = request.getParameter("message");
            String userName = request.getParameter("usernameField");

            String dateStr = request.getParameter("date");
            String timeStr = request.getParameter("time");

            if (dateStr != null && !dateStr.isEmpty() && timeStr != null && !timeStr.isEmpty()) {
                try {
                    java.sql.Date date = java.sql.Date.valueOf(dateStr);
                    java.sql.Time time = java.sql.Time.valueOf(timeStr);

                    try {
                        rowsInserted = reservation.insertReservation(location, mileage, vehicle, message, userName, date, time);
                    } catch (Exception e) {
                        out.println(e + " Insertion Query failed");
                    }

                } catch (IllegalArgumentException e) {
                    out.println("Invalid date or time format: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                // Handle the case when date or time is empty
                out.println("Date and time are required fields");
            }
        }
    } catch (Exception e) {
        out.println(e.getMessage());
    }
%>

<% 	

Properties properties = new Properties();


try {
	 InputStream inputStream = application.getResourceAsStream("/WEB-INF/classes/vehiclereservation.properties");
	 properties.load(inputStream);
	} catch (IOException e) {
	    e.printStackTrace();
	}
		
%>



<!DOCTYPE html>
	<head>
		<meta charset="UTF-8">
		<title>Home</title>

		<link href="../css/styles.css" type="text/css" rel="stylesheet">
		<link href="../css/reservation.css" type="text/css" rel="stylesheet">
		
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<script type="text/javascript">
	//set the globle parameters for authentication
			const infoUrl = '<%= properties.getProperty("userinfoEndpoint") %>';
			const client_Id = '<%= properties.getProperty("client_id") %>';
			const client_secret = '<%= properties.getProperty("client_secret") %>';
			const postLogoutRedirectUri = '<%= properties.getProperty("baseurl") %>' + '/DriveCareXpress/index.jsp';
			const introspectionEndpointUrl ='<%= properties.getProperty("introspectionEndpoint") %>';
		</script>
		<script type="text/javascript"  src="../js/userInfo.js"></script>
	</head>

	<body>



	<section>
		<h2>Vehicle Reservation App</h2>

		<table>
			<tr>
				<td>User Name :</td>
				<td></td>
			</tr>
			<tr>
				<td>Email     :</td>
				<td></td>
			</tr>
			<tr>
				<td>Phone     :</td>
				<td></td>
			</tr>
			<tr>
				<td>Country   :</td>
				<td></td>
			</tr>
		</table>


  	  	<form id="logout-form" action="<%= properties.getProperty("logoutEndpoint") %>" method="POST">
       		<input type="hidden" id="client-id" name="client_id" value="">
        	<input type="hidden" id="post-logout-redirect-uri" name="post_logout_redirect_uri" value="">
        	<input type="hidden" id="state" name="state" value="">
        	
			<button type="submit" id="logout" >Logout</button>
    	</form>
	</section>


	<button onclick="viewReservations()">Reservation Details</button>
	<button onclick="makeReservation()">Make A Reservation</button>

	<section id="reservationForm">

	    <%
			String message = (String) request.getAttribute("successMessage");
	        //System.out.println(message);
	        if(message!=null){
		%>

		<div class="success-message"><%= message %></div>
				    
		<script>
				document.addEventListener('DOMContentLoaded', function() {
					var successMessage = '<%= message %>';
					    alert(successMessage);
					}
				);
			</script>
		<% } %>

	    <h3>Make A Reservation</h3>

			<form method="post" id="contactForm" name="contactForm">
				<table>
					<tr>
						<td><label>Vehicle Number</label></td>
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
						<td><label for="location">Location</label></td>
						<td>	                  
							<select class="custom-select" id="location" name="location" required>
						    	<option selected></option>				            
								<option value="Ampara">Ampara</option>
								<option value="Anuradhapura">Anuradhapura</option>
								<option value="Badulla">Badulla</option>
								<option value="Batticaloa">Batticaloa</option>
						    	<option value="Colombo">Colombo</option>
								<option value="Galle">Galle</option>
								<option value="Gampaha">Gampaha</option>
								<option value="Hambantota">Hambantota</option>
								<option value="Jaffna">Jaffna</option>
								<option value="Kalutara">Kalutara</option>
								<option value="Kandy">Kandy</option> 
								<option value="Kegalle">Kegalle</option>
								<option value="Kilinochchi">Kilinochchi</option>
								<option value="Kurunegala">Kurunegala</option>
								<option value="Mannar">Mannar</option>
								<option value="Matale">Matale</option>
								<option value="Matara">Matara</option>
								<option value="Monaragala">Monaragala</option>
								<option value="Mullaitivu">Mullaitivu</option>
								<option value="Nuwara Eliya">Nuwara Eliya</option>
								<option value="Polonnaruwa">Polonnaruwa</option>
								<option value="Puttalam">Puttalam</option>
								<option value="Ratnapura">Ratnapura</option>
								<option value="Trincomalee">Trincomalee</option>
								<option value="Vavuniya">Vavuniya</option> 				           
							</select>
						</td>
					</tr>
								
					<tr>
						<td><label for="date">Date</label></td>
						<td>
							<input type="date" id="date" name="date" min="<%= java.time.LocalDate.now() %>" required>
						</td>
					</tr>

					<tr>
						<td><label for="time">Reservation Time</label></td>
						<td>
							<select id="time" name="time" required>
								<option selected></option>
								<option value="10:00 AM">10:00 AM</option>
								<option value="11:00 AM">11:00 AM</option>
								<option value="12:00 PM">12:00 PM</option>
							</select>
						</td>
					</tr>

					<tr>
						<td><label for="" class="col-form-label">Mileage</label></td>
						<td>
							<input type="number" step="1" min="1" max="99999" pattern="\d+" name="mileage" id="mileage"  placeholder="Enter the total mileage" required>
						</td>
					</tr>
								
					<tr>
						<td><label for="message">Message</label></td>
						<td>
							<textarea class="form-control" name="message" id="message" cols="30" rows="4"  placeholder="Write your message"></textarea>
						</td>
					</tr>

				</table>

	            <input type="hidden" id="usernameField" name="usernameField" value="" >

	            <input type="submit" value="Submit" id="submit" name="submit" class="btn btn-primary rounded-0 py-2 px-4">

	        </form>
	</section>



<!--</section>-->

	<section id="reservationDetails">
		<h2>My Reservations</h2>
		
		<table class="table" id="futureTable">
        	<tr>
        		<th>Booking ID</th>
				<th>Date</th>
            	<th>Time</th>
				<th>Location</th>
				<th>Vehicle Number</th>
            	<th>Mileage</th>
           		<th>Message</th>
            	<th></th>
        	</tr>
    	</table>

		<button onclick="viewOldReservations()">View Old Reservations</button>

		<div id="oldReservations">
			<table class="table" id="pastTable">
    			<tr>
        			<th>Booking ID</th>
					<th>Date</th>
            		<th>Time</th>
					<th>Location</th>
					<th>Vehicle Number</th>
            		<th>Mileage</th>
           			<th>Message</th>
    			</tr>
			</table>

			<button onclick="closeOldReservations()">View Old Reservations</button>
		</div>

	</section>


<script type="text/javascript"  src="js/reservation.js"></script>


</body>


</html>