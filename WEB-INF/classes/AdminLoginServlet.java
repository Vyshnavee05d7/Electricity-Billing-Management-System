import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Mock admin credentials check
        if ("admin".equals(username) && "admin123".equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", username);
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            response.sendRedirect("admin_login.html?error=invalid");
        }
    }
}
