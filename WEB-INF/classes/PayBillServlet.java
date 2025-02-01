import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PayBillServlet")
public class PayBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login.html");
            return;
        }

        String username = (String) session.getAttribute("username");
        String paymentMethod = request.getParameter("payment");

        // Connect to database and update bill status
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Update status to completed
            String updateSQL = "UPDATE users SET status = 'completed' WHERE username = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {
                pstmt.setString(1, username);
                pstmt.executeUpdate();
            }

            // Redirect to payment form page
            response.sendRedirect("payment_form.jsp?username=" + username + "&paymentMethod=" + paymentMethod + "&billAmount=" + request.getParameter("billAmount"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }
}
