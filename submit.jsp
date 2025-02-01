<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String phoneNumber = request.getParameter("phone_number");
    String email = request.getParameter("email");
    String serviceNumber = request.getParameter("service_number");

    // JDBC driver name and database URL
    String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost/ElectricityBillingSystem";

    // Database credentials
    String USER = "root";
    String PASS = "root";
    Connection conn = null;
    PreparedStatement pstmt = null;

    // Generate random numbers for the four columns
    Random rand = new Random();
    int peakHours = rand.nextInt(100); // Random number between 0 and 99
    int offPeakHours = rand.nextInt(100);
    int midPeakHours = rand.nextInt(100);
    int superOffPeakHours = rand.nextInt(100);

    try {
        // Register JDBC driver
        Class.forName(JDBC_DRIVER);
        // Open a connection
        conn = DriverManager.getConnection(DB_URL, USER, PASS);

        // Create SQL query
        String sql = "INSERT INTO users (username, password, phone_number, email, service_number, peak_hours, off_peak_hours, mid_peak_hours, super_off_peak_hours, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'pending')";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        pstmt.setString(3, phoneNumber);
        pstmt.setString(4, email);
        pstmt.setString(5, serviceNumber);
        pstmt.setInt(6, peakHours);
        pstmt.setInt(7, offPeakHours);
        pstmt.setInt(8, midPeakHours);
        pstmt.setInt(9, superOffPeakHours);

        // Execute SQL query
        pstmt.executeUpdate();

        // Redirect to success page
        response.sendRedirect("login.html");

    } catch (SQLException se) {
        // Handle errors for JDBC
        se.printStackTrace();
        out.println("Error: " + se.getMessage());
    } catch (Exception e) {
        // Handle errors for Class.forName
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Finally block used to close resources
        try {
            if (pstmt != null) pstmt.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
        try {
            if (conn != null) conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }
%>
