package Fliter;

import javax.servlet.*;
import java.io.IOException;

public class FilterTest implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        // 在这里面进行 doGet 和 doPost 这种类似的
    }

    @Override
    public void destroy() {

    }
}
