package Controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;

import Controller.DatabaseConnection;

public class Crud {
    public static List<String[]> displayReservations(String username) throws ClassNotFoundException, SQLException {

    	Connection connection = DatabaseConnection.initializeDatabase();

        List<String[]> result = new ArrayList<>();

        if (connection != null) {
            try {
                PreparedStatement st = connection.prepareStatement("SELECT booking_id, date, time, location, vehicle_no, mileage, message FROM vehicle_service WHERE username = ?");
                st.setString(1, username);
                ResultSet rs = st.executeQuery();

                while (rs.next()) {
                	String booking_id=rs.getString("booking_id");
                    String date = rs.getString("date");
                    String time = rs.getString("time");
                    String location = rs.getString("location");
                    String vehicle_no = rs.getString("vehicle_no");
                    String mileage = rs.getString("mileage");
                    String message = rs.getString("message");

                    String[] rowData = { booking_id, date, time, location, vehicle_no, mileage, message };
                    result.add(rowData);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                connection.close();
            }
        }

        return result;
    }
}
