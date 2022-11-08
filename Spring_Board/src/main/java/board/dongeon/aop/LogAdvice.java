package board.dongeon.aop;

import board.dongeon.domain.vo.PostVO;
import lombok.extern.log4j.Log4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Aspect
@Log4j
@Component
public class LogAdvice {

//    @Before("execution(* board.dongeon.controller.post.BoardController.view(..))")
//    public void logBefore(JoinPoint joinPoint) {
//        log.info("=======logBefore=========");
//        System.out.println("=======logBefore Start=========");
//        Object[] signatureArgs = joinPoint.getArgs();
//        for (Object signatureArg: signatureArgs) {
//            System.out.println("Arg: " + signatureArg);
//        }
//        System.out.println("=======logBefore End=========");
//    }

    @After("execution(* board.dongeon.controller.post.BoardController.view(..))")
    public void logAfter(JoinPoint joinPoint) {
        log.info("=======logAfter=========");
        System.out.println("======logAfter Start======");
        Object[] signatureArgs = joinPoint.getArgs();
        for (Object signatureArg: signatureArgs) {
            System.out.println("Arg: " + signatureArg);
        }
        String pno = "[" + signatureArgs[0].toString() + "]";
        System.out.println("==========>>>>" + pno);


        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                        .getRequest();
        HttpServletResponse response =
                ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                        .getResponse();

        Cookie[] cookies = request.getCookies();
        Cookie cookie = new Cookie("viewcookie", pno);

        for (Cookie c: cookies) {
            Boolean isViewCookie = c.getName().equals("viewcookie");
            if (isViewCookie) {
                String cValue = c.getValue();
                Boolean isPnoView = cValue.contains(pno);
                if (!isPnoView) {
                    cookie.setValue(cValue + pno);
                }
            }
        }
        cookie.setMaxAge(60);

        response.addCookie(cookie);

        System.out.println("======logAfter End======");
    }

//    @Around("execution(* board.dongeon.controller.post.BoardController.view(..))")
//    public Object logAround(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
//        HttpServletRequest request =
//                ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
//                        .getRequest();
//        String pno = (String)request.getAttribute("pno");
//        System.out.println("==========logAround==========" + pno);
//        return proceedingJoinPoint.proceed(proceedingJoinPoint.getArgs());
//    }
}
