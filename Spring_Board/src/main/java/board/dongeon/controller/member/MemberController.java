package board.dongeon.controller.member;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.PageDTO;
import board.dongeon.domain.vo.MemberVO;
import board.dongeon.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

    MemberService memberService;

    @GetMapping("/memberlist")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public void memberlist(SearchInfo searchInfo, Model model) {

        log.info("memberlist searchInfo: " + searchInfo);
        List<MemberVO> memberVOList = memberService.getMemberList(searchInfo);

        model.addAttribute("memberVOList", memberVOList);

        int total = memberService.getTotal(searchInfo);
        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(searchInfo, total));
    }

    @GetMapping("/memberdetail")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public void memberdetail(@RequestParam("userid") String userid,
                             @ModelAttribute("searchInfo") SearchInfo searchInfo,
                             Model model) {
        log.info("/memberdetail id: " + userid);
        model.addAttribute("memberVO", memberService.getMember(userid));
    }
}
