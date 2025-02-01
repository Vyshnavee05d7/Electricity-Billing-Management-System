import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/ElectricityBillingSystem";
    private static final String USER = "root";
    private static final String PASS = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.html");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            String sql = "SELECT username, email, phone_number, service_number FROM users WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            String email = "";
            String phone_number = "";
            String service_number = "";
            if (rs.next()) {
                email = rs.getString("email");
                phone_number = rs.getString("phone_number");
                service_number = rs.getString("service_number");
            }

            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone_number", phone_number);
            request.setAttribute("service_number", service_number);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
}
