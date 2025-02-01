import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection parameters
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        double billAmount = Double.parseDouble(request.getParameter("billAmount"));
        String paymentMethod = request.getParameter("payment");

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Insert payment details into the receipts table
                String insertSQL = "INSERT INTO receipts (username, amount, payment_mode) VALUES (?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertSQL)) {
                    pstmt.setString(1, username);
                    pstmt.setDouble(2, billAmount);
                    pstmt.setString(3, paymentMethod);
                    pstmt.executeUpdate();
                }

                // Redirect to view_bill.jsp
                response.sendRedirect("view_bill.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }
}
