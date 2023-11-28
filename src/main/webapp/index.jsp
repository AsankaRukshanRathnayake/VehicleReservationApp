<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%
	Properties properties = new Properties();
		
	try{
		InputStream inputstream = application.getResourceAsStream("/WEB-INF/classes/vehiclereservation.properties");
		properties.load(inputstream);
	}catch(IOException e){
		e.printStackTrace();
	}
%>


<!DOCTYPE html>
	<head>
		<meta charset="UTF-8">
		<title>Vehicle Reservation App</title>


	</head>
	
	
	<body>
		<div>
			<h1>Vehicle Reservation Application</h1>
			<button id="login">Login</button>
			
			<script>
				document.getElementById("login").addEventListener("click",function(){
					var authorizeEndpoint = '<%= properties.getProperty("authorizeEndpoint") %>';
				    var clientId = '<%= properties.getProperty("client_id") %>';
				    var redirectUri = encodeURIComponent('<%= properties.getProperty("baseurl") %>/VehicleReservationApp/login.jsp');
					var scope = '<%= properties.getProperty("scope") %>';
					
				    var redirectUrl = authorizeEndpoint + '?response_type=code' +'&client_id=' + clientId +'&scope='+scope+'&redirect_uri=' + redirectUri;

				    window.location.href = redirectUrl;
				});
			</script>
		</div>
		
	</body>
</html>