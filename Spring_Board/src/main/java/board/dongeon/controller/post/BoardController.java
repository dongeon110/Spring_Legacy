package board.dongeon.controller.post;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.PageDTO;
import board.dongeon.domain.vo.PostVO;
import board.dongeon.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

    private BoardService service;

    @GetMapping("/list")
    public void list(SearchInfo searchInfo, Model model) {
        
        // 삭제되지 않은 게시물들
        log.info("list searchInfo: " + searchInfo);
        List<PostVO> postVOs = service.getList(searchInfo);

        model.addAttribute("postVOs", postVOs);

        // 삭제되지 않은 총 게시물 수
        int total = service.getTotal(searchInfo);
        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(searchInfo, total));

//        // 원글 삭제 표시
//        if (searchInfo.getType() == null) {
//            // ROW NUMBER 1~10
//            // UNION ALL -> ORDER BY
//            // DEPTH -1 ORDER가 있으면
//
//        }
    }

    @GetMapping("/adminlist")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public void adminlist(SearchInfo searchInfo, Model model) { // 관리자 페이지
        log.info("searchInfo: " + searchInfo);
        List<PostVO> postVOs = service.adminGetList(searchInfo);

        model.addAttribute("postVOs", postVOs);

        int total = service.adminGetTotal(searchInfo);
        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(searchInfo, total));
    }



    @GetMapping("/add")
    @PreAuthorize("isAuthenticated()")
    public void add() {

    }

    @PostMapping("/add")
    @PreAuthorize("isAuthenticated()")
    public String add(PostVO postVO, RedirectAttributes rttr) {
        log.info("==========================");
        log.info("add: " + postVO);

        log.info("==========================");
        service.add(postVO);
        rttr.addFlashAttribute("result", postVO.getPostNo());
        return "redirect:/board/list";
    }



    @GetMapping("/view")
    public void view(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo,
                     Model model, @CookieValue(value="viewcookie", defaultValue = "0", required = true) String cookievalue) {
        log.info("/view");
        PostVO viewPost = service.get(pno);
        model.addAttribute("postVO", viewPost);
        log.info("postVO" + service.get(pno));

        /* 조회수 */
        log.info("viewcookie: " + cookievalue);

        if (!cookievalue.contains("[" + pno + "]")) { // 쿠키에 pno 없으면
            if (viewPost.isEnabled()) { // Enabled True면 (삭제 플래그 True)
                service.increaseViews(pno); // 조회수 증가
            }
        }
        /* 조회수 end */
    }


    @GetMapping("/update")
    public void update(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo,
                        Model model) {
        log.info("/update");
        model.addAttribute("postVO", service.get(pno));
        log.info("update postVO: " + service.get(pno));
    }



    @PreAuthorize("(principal.username == #postVO.posterName) OR (hasRole('ROLE_ADMIN'))")
    @PostMapping("/update")
//    public String update(PostVO postVO, @ModelAttribute("searchInfo") SearchInfo searchInfo, RedirectAttributes rttr) {
    public String update(PostVO postVO, SearchInfo searchInfo, RedirectAttributes rttr) {
        log.info("update: " + postVO);

        if(service.modify(postVO)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + searchInfo.getListLink();
    }

    @PreAuthorize("(principal.username == #posterName) OR (hasRole('ROLE_ADMIN'))") // #을 앞에 붙이면 파라미터에 접근할 수 있음
    @PostMapping("/remove")
//    public String remove(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo, RedirectAttributes rttr) {
    public String remove(@RequestParam("postNo") int pno, SearchInfo searchInfo, RedirectAttributes rttr, String posterName) {
        log.info("remove..." + pno);
        if (service.remove(pno)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + searchInfo.getListLink();
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("/restore")
    public String restore(@RequestParam("postNo") int pno, SearchInfo searchInfo, RedirectAttributes rttr) {
        log.info("restore..." + pno);
        if (service.restore(pno)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/adminlist" + searchInfo.getListLink();
    }

    @GetMapping("/addrepost")
    @PreAuthorize("isAuthenticated()")
    public void addrepost(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo, Model model) {
        log.info("/addrepost");
        model.addAttribute("originpostVO", service.get(pno));
        log.info("originpostVO" + service.get(pno));
    }

    @PostMapping("/addrepost")
    @PreAuthorize("isAuthenticated()")
    public String addrepost(PostVO postVO, int originpost, RedirectAttributes rttr, Model model) {
        log.info("==========================");
        log.info("add repost: " + postVO);

//        String originpostNoStr = (String)model.getAttribute("originpost");
//        int originpostNo = Integer.parseInt(originpostNoStr);
        postVO.setReparent(originpost);

        // 파일 업로드
//        if (postVO.getAttachList() != null) {
//            postVO.getAttachList().forEach(attach -> log.info(attach));
//        }

        log.info("==========================");
        service.addRepost(postVO);
        rttr.addFlashAttribute("result", postVO.getPostNo());
        return "redirect:/board/list";
    }


    @GetMapping("/errortest")
    public String test(Model model) {
        int i = 1/0; // 0으로 나눠서 500 에러
        model.addAttribute("i", i);
        return "home";
    }

    @PostMapping("/errortest2") // GET요청시 405 에러
    public String test2(Model model) {
        return "home";
    }
}
