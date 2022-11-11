package board.dongeon.controller.member;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.PageDTO;
import board.dongeon.domain.dto.UpdateAuthDTO;
import board.dongeon.domain.vo.AuthVO;
import board.dongeon.domain.vo.MemberVO;
import board.dongeon.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.Arrays;
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
        MemberVO memberVO = memberService.getMember(userid);
        model.addAttribute("memberVO", memberVO);

        List<AuthVO> authList = memberVO.getAuthList();
//        String memberAuth = "";
//        for (AuthVO authVO: authList) {
//            memberAuth += "[" + authVO.getAuth() + "]";
//        }

        ArrayList<String> memberAuth = new ArrayList<>();
        for (AuthVO authVO: authList) {
            memberAuth.add(authVO.getAuth());
        }
        model.addAttribute("memberAuth", memberAuth);
    }

    @PostMapping("/memberupdate")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String memberupdate(SearchInfo searchInfo, String userid, String[] originauth,
                               String[] auth, RedirectAttributes rttr) {

        log.info("--------memberupdate---------");

        // 기존 권한 다시 조회 -> memberAuth
        MemberVO memberVO = memberService.getMember(userid);
        List<AuthVO> authList = memberVO.getAuthList();
        ArrayList<String> memberAuth = new ArrayList<>();
        for (AuthVO authVO: authList) {
            memberAuth.add(authVO.getAuth());
        }

        // 새로운 권한 찾기
        for(String newauth: auth) {
            if(!memberAuth.contains(newauth)) { // 기존 권한에 없는 새 권한
                memberService.addAuth(new UpdateAuthDTO(userid, newauth));
            }
        }

        // 없어진 권한 찾기
        List<String> newauthList = new ArrayList<>(Arrays.asList(auth));
        for(String oldauth: memberAuth) {
            if(!newauthList.contains(oldauth)) { // 새 권한에 없는 기존 권한
                memberService.deleteAuth(new UpdateAuthDTO(userid, oldauth));
            }
        }

        rttr.addFlashAttribute("result", "success");
        return "redirect:/member/memberlist";
    }
}
