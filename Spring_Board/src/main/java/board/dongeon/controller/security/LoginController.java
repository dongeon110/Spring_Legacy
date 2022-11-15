package board.dongeon.controller.security;


import board.dongeon.domain.vo.MemberVO;
import board.dongeon.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@RequestMapping("/auth")
@AllArgsConstructor
public class LoginController {

    private MemberService service;

    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder passwordEncoder;

    @GetMapping("/all")
    public void doAll() {
        log.info("do all can access everybody");
    }

    @GetMapping("/member")
    public void doMember() {
        log.info("logined member");
    }

    @GetMapping("/admin")
    public void doAdmin() {
        log.info("admin only");
    }

    // Spring-Security with Annotation
    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MEMBER')")
    @GetMapping("/annoMember")
    public void doMemberAnno() {
        log.info("logined annotation member");
    }

    @Secured({"ROLE_ADMIN"})
    @GetMapping("/annoAdmin")
    public void doAdminAnno() {
        log.info("admin annotation only");
    }

    @GetMapping("/signup")
    @PreAuthorize("isAnonymous()")
    public void signup() {
    }

    @PostMapping("/signup")
    @PreAuthorize("isAnonymous()")
    public String signup(MemberVO memberVO, RedirectAttributes rttr) {
        log.info("/auth/signup post...");
        log.info("signup: " + memberVO);

        if(service.isDuplicated(memberVO.getUserid())) { // 중복값 있으면
            return "redirect:/auth/isduplicated";
        }

        memberVO.setUserpw(passwordEncoder.encode(memberVO.getUserpw()));
        log.info("passwordEncoder memberVO: " + memberVO);
        service.memberCreate(memberVO);
        rttr.addFlashAttribute("result", "success");
        return "redirect:/customLogin";
    }

    @GetMapping("/isduplicated")
    @PreAuthorize("isAnonymous()")
    public String isduplicated() {
        return "redirect:/auth/signup?duplicated";
    }


}
