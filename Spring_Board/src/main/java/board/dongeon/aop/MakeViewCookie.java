package board.dongeon.aop;

import lombok.extern.log4j.Log4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Aspect
@Log4j
@Component
public class MakeViewCookie {

//    @Before("execution(* board.dongeon.controller.post.BoardController.view(..))")
//    public void viewBefore(JoinPoint joinPoint) {
//        log.info("=======viewBefore=========");
//        System.out.println("=======logBefore Start=========");
//        Object[] signatureArgs = joinPoint.getArgs();
//        for (Object signatureArg: signatureArgs) {
//            System.out.println("Arg: " + signatureArg);
//        }
//        System.out.println("=======viewBefore End=========");
//    }

    @After("execution(* board.dongeon.controller.post.BoardController.view(..))")
    public void viewAfter(JoinPoint joinPoint) {
        log.info("=======viewAfter=========");
        System.out.println("======viewAfter Start======");
        Object[] signatureArgs = joinPoint.getArgs();
        for (Object signatureArg: signatureArgs) {
            System.out.println("Arg: " + signatureArg);
        }
        String pno = "[" + signatureArgs[0].toString() + "]"; // signatureArgs 0: pno, 1: postVO ..
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

        System.out.println("======viewAfter End======");
    }

//    @Around("execution(* board.dongeon.controller.post.BoardController.view(..))")
//    public Object viewAround(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
//        HttpServletRequest request =
//                ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
//                        .getRequest();
//        String pno = (String)request.getAttribute("pno");
//        System.out.println("==========viewAround==========" + pno);
//        return proceedingJoinPoint.proceed(proceedingJoinPoint.getArgs());
//    }
}
