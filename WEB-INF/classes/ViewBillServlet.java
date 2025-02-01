import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ViewBillServlet")
public class ViewBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String username = (String) session.getAttribute("username");

        String dbURL = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
        String dbUser = "root";
        String dbPass = "root";

        try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass)) {
            String query = "SELECT peak_hours, off_peak_hours, mid_peak_hours, super_off_peak_hours, status FROM users WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String peakHours = rs.getString("peak_hours");
                String offPeakHours = rs.getString("off_peak_hours");
                String midPeakHours = rs.getString("mid_peak_hours");
                String superOffPeakHours = rs.getString("super_off_peak_hours");
                String status = rs.getString("status");

                double peakRate = 7.50;
                double midPeakRate = 5.00;
                double offPeakRate = 3.00;
                double superOffPeakRate = 2.00;

                double peakHoursUsage = Double.parseDouble(peakHours);
                double midPeakHoursUsage = Double.parseDouble(midPeakHours);
                double offPeakHoursUsage = Double.parseDouble(offPeakHours);
                double superOffPeakHoursUsage = Double.parseDouble(superOffPeakHours);

                double billAmount = (peakHoursUsage * peakRate) + (midPeakHoursUsage * midPeakRate)
                        + (offPeakHoursUsage * offPeakRate) + (superOffPeakHoursUsage * superOffPeakRate);

                session.setAttribute("billAmount", billAmount);
                session.setAttribute("status", status);
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("view_bill.jsp");
    }
}