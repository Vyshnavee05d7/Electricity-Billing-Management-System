import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PostNewsServlet")
public class PostNewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newsContent = request.getParameter("news");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ElectricityBillingSystem", "root", "root");

            String sql = "INSERT INTO news (content) VALUES (?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newsContent);
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("admin_dashboard.jsp");
    }
}
