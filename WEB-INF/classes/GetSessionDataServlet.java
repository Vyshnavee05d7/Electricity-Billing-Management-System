import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/getSessionData")
public class GetSessionDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user session attributes
        String username = (String) request.getSession().getAttribute("username");
        String email = (String) request.getSession().getAttribute("email");
        String phone_number = (String) request.getSession().getAttribute("phone_number");
        String service_number = (String) request.getSession().getAttribute("service_number");

        // Manually construct JSON string
        String json = String.format(
            "{\"username\":\"%s\", \"email\":\"%s\", \"phone_number\":\"%s\", \"service_number\":\"%s\"}",
            username != null ? username : "",
            email != null ? email : "",
            phone_number != null ? phone_number : "",
            service_number != null ? service_number : ""
        );

        // Set response content type and write JSON to response
        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}
