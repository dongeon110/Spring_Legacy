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

import javax.servlet.http.Cookie;
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
        log.info("postVOs: " + searchInfo);
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


    @GetMapping("/add")
    @PreAuthorize("isAuthenticated()")
    public void add() {

    }

    @PostMapping("/add")
    @PreAuthorize("isAuthenticated()")
    public String add(PostVO postVO, RedirectAttributes rttr) {
        log.info("==========================");
        log.info("add: " + postVO);

        // 파일 업로드
//        if (postVO.getAttachList() != null) {
//            postVO.getAttachList().forEach(attach -> log.info(attach));
//        }

        log.info("==========================");
        service.add(postVO);
        rttr.addFlashAttribute("result", postVO.getPostNo());
        return "redirect:/board/list";
    }

    @GetMapping({"/view", "/update"})
    public void view(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo,
                     Model model, @CookieValue(value="viewcookie", defaultValue = "0", required = true) String cookievalue) {
        log.info("/view");
        model.addAttribute("postVO", service.get(pno));
        log.info("postVO" + service.get(pno));

//        /* 조회수 */
        service.increaseViews(pno);
//        String pnoValue = "[" + pno + "]";
//        boolean isView = cookievalue.contains(pnoValue);
//        if(!isView) {
//            cookievalue += pnoValue;
//            Cookie cookie = new Cookie("viewcookie", cookievalue);
//            cookie.setMaxAge(60); // second
//            response.addCookie(cookie);
//        }

//        /* 조회수 end */
    }



    @PreAuthorize("(principal.username == #posterName) OR (hasRole('ROLE_ADMIN'))")
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


    @GetMapping("/addrepost")
    @PreAuthorize("isAuthenticated()")
    public void addrepost(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo, Model model) {
        log.info("/addrepost");
        model.addAttribute("originpostVO", service.get(pno));
        log.info("originpostVO" + service.get(pno));
    }

    @PostMapping("/addrepost")
    @PreAuthorize("isAuthenticated()")
    public String addrepost(PostVO postVO, RedirectAttributes rttr) {
        log.info("==========================");
        log.info("add repost: " + postVO);

        // 파일 업로드
//        if (postVO.getAttachList() != null) {
//            postVO.getAttachList().forEach(attach -> log.info(attach));
//        }

        log.info("==========================");
        service.addRepost(postVO);
        rttr.addFlashAttribute("result", postVO.getPostNo());
        return "redirect:/board/list";
    }

}
