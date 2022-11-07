package board.dongeon.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;


@ControllerAdvice
public class ErrorController {

    private Logger logger = LoggerFactory.getLogger(ErrorController.class);

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model) {
        logger.error("Exception 발생 : {}", ex.getMessage());
        model.addAttribute("msg", "에러가 발생했습니다.");
        return "error/error";
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public String handle404(NoHandlerFoundException ex, Model model) {
        logger.error("404 Error", ex.getRequestURL());
        model.addAttribute("msg", "그런 페이지는 없습니다.(404 Error)");
        return "error/error";
    }
}
