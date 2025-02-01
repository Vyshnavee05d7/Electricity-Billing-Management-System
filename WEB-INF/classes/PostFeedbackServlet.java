import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PostFeedbackServlet")
public class PostFeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String feedback = request.getParameter("feedback");
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ElectricityBillingSystem", "root", "root");
            String sql = "INSERT INTO feedback (feedback) VALUES (?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, feedback);
            pstmt.executeUpdate();
            response.sendRedirect("feedback.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("feedback.jsp?success=false");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
