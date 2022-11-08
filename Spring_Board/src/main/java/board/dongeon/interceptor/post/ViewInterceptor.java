package board.dongeon.interceptor.post;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewInterceptor extends HandlerInterceptorAdapter {

    protected Log log = LogFactory.getLog(ViewInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

//        String pno = (String)request.getAttribute("pno");
//        Cookie[] cookies = request.getCookies();
//        Cookie cookie = new Cookie("viewcookie", "[" + pno + "]");
//        for(Cookie c: cookies) {
//            if(c.getName().equals("viewcookie")) {
//                String cookieValue = c.getValue() + "[" + pno + "]";
//                cookie = new Cookie("viewcookie", cookieValue);
//            }
//        }
//        cookie.setMaxAge(60);
//        response.addCookie(cookie);
        super.postHandle(request, response, handler, modelAndView);
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

        super.afterCompletion(request, response, handler, ex);
    }
}
