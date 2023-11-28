package com.vehiclereservation.secure;

import java.lang.*;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class Reservation {
	java.lang.String dbUrl;
    java.lang.String dbUser;
    java.lang.String dbPassword;

    public Reservation(){
            this.dbUrl = "jdbc:mysql://localhost:3306/isec_assessment2";
            this.dbUser = "root";
            this.dbPassword = "";
    }
    
    public List<String> viewCurrentReservations(String username) throws ClassNotFoundException, SQLException {
        List<String> futureReservations = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            String query = "SELECT time, date, venue FROM reservation WHERE username = ? AND date > CURRENT_DATE";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {

                        String time = resultSet.getString("time");
                        String date = resultSet.getString("date");
                        String venue = resultSet.getString("venue");

                        String result = "Time: " + time + ", Date: " + date + ", Venue: " + venue;
                        futureReservations.add(result);
                    }
                }
            }
        }

        return futureReservations;
    }

    public List<String> viewOldReservations(String username) throws ClassNotFoundException, SQLException {
        List<String> oldReservations = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            String query = "SELECT time, date, venue FROM reservation WHERE username = ? AND date <= CURRENT_DATE";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {

                        String time = resultSet.getString("time");
                        String date = resultSet.getString("date");
                        String venue = resultSet.getString("venue");

                        String result = "Time: " + time + ", Date: " + date + ", Venue: " + venue;
                        oldReservations.add(result);
                    }
                }
            }
        }

        return oldReservations;
    }
    
    

    public int deleteReservation(int bookingId, String username) throws ClassNotFoundException {
        int rowsDeleted = 0;

        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
            String query = "DELETE FROM reservation WHERE booking_id = ? AND username = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, bookingId);
                preparedStatement.setString(2, username);

                rowsDeleted = preparedStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rowsDeleted;
    }

    public int insertReservation(String location, int mileage, String vehicle_no, String message,
            String userName, java.sql.Date date, java.sql.Time time) throws ParseException, ClassNotFoundException {
    			int rowsInserted = 0;

    			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    			java.util.Date parsedDate = dateFormat.parse(date + " " + time);
    			java.sql.Timestamp timestamp = new java.sql.Timestamp(parsedDate.getTime());

    			try (Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
    				String query = "INSERT INTO vehicle_service (location, mileage, vehicle_no, message, username, date, time) " +
    								"VALUES (?, ?, ?, ?, ?, ?, ?)";

    				try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
    					preparedStatement.setString(1, location);
						preparedStatement.setInt(2, mileage);
						preparedStatement.setString(3, vehicle_no);
						preparedStatement.setString(4, message);
						preparedStatement.setString(5, userName);
						preparedStatement.setTimestamp(6, timestamp);
						preparedStatement.setTime(7, time);

						rowsInserted = preparedStatement.executeUpdate();
					}
    			} catch (SQLException e) {
    					e.printStackTrace();
    			}

    			return rowsInserted;
    }
}
