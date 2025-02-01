import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/CalculateBillServlet")
public class CalculateBillServlet extends HttpServlet {

    private static final double PEAK_RATE = 7.50;
    private static final double MID_PEAK_RATE = 5.00;
    private static final double OFF_PEAK_RATE = 3.00;
    private static final double SUPER_OFF_PEAK_RATE = 2.00;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.html");
            return;
        }

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        double amountDue = 0.0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ElectricityBillingSystem", "root", "root");

            String sql = "SELECT * FROM users WHERE username = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Retrieve user details from database
                String email = resultSet.getString("email");
                String phoneNumber = resultSet.getString("phone_number");
                String serviceNumber = resultSet.getString("service_number");
                String peakHours = resultSet.getString("peak_hours");
                String midPeakHours = resultSet.getString("mid_peak_hours");
                String offPeakHours = resultSet.getString("off_peak_hours");
                String superOffPeakHours = resultSet.getString("super_off_peak_hours");

                // Log retrieved data for debugging
                System.out.println("Fetched user data:");
                System.out.println("Username: " + username);
                System.out.println("Email: " + email);
                System.out.println("Phone Number: " + phoneNumber);
                System.out.println("Service Number: " + serviceNumber);
                System.out.println("Peak Hours: " + peakHours);
                System.out.println("Mid-Peak Hours: " + midPeakHours);
                System.out.println("Off-Peak Hours: " + offPeakHours);
                System.out.println("Super Off-Peak Hours: " + superOffPeakHours);

                // Calculate the bill amount
                int peakHoursInt = parseIntOrZero(peakHours);
                int midPeakHoursInt = parseIntOrZero(midPeakHours);
                int offPeakHoursInt = parseIntOrZero(offPeakHours);
                int superOffPeakHoursInt = parseIntOrZero(superOffPeakHours);

                amountDue = (peakHoursInt * PEAK_RATE) +
                            (midPeakHoursInt * MID_PEAK_RATE) +
                            (offPeakHoursInt * OFF_PEAK_RATE) +
                            (superOffPeakHoursInt * SUPER_OFF_PEAK_RATE);

                // Set attributes for JSP
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phoneNumber", phoneNumber);
                request.setAttribute("serviceNumber", serviceNumber);
                request.setAttribute("peakHours", peakHours);
                request.setAttribute("midPeakHours", midPeakHours);
                request.setAttribute("offPeakHours", offPeakHours);
                request.setAttribute("superOffPeakHours", superOffPeakHours);
                request.setAttribute("amountDue", String.format("%.2f", amountDue));

                // Forward to JSP
                request.getRequestDispatcher("print_receipt.jsp").forward(request, response);
            } else {
                System.err.println("No user found with username: " + username);
                response.sendRedirect("login.html");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private int parseIntOrZero(String value) {
        try {
            return Integer.parseInt(value != null && !value.isEmpty() ? value : "0");
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
