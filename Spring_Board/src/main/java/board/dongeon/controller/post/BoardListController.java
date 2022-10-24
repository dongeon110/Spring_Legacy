package board.dongeon.controller.post;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.PageDTO;
import board.dongeon.domain.vo.PostVO;
import board.dongeon.mapper.PostDao;
import board.dongeon.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardListController {

    private BoardService service;

    @GetMapping("/list")
    public void list(SearchInfo searchInfo, Model model) {
        log.info("postVOs: " + searchInfo);
        model.addAttribute("postVOs", service.getList(searchInfo));

        // 총 게시물 수
        int total = service.getTotal(searchInfo);
        log.info("total: " + total);
        model.addAttribute("pageMaker", new PageDTO(searchInfo, total));
    }

    @PostMapping("/add")
    public String add(PostVO postVO, RedirectAttributes rttr) {
        log.info("add: " + postVO);
        service.add(postVO);
        rttr.addFlashAttribute("result", postVO.getPostNo());
        return "redirect:/board/list";
    }

    @GetMapping({"/view", "/update"})
    public void view(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo, Model model) {
        log.info("/view");
        model.addAttribute("postVO", service.get(pno));
    }

    @PostMapping("/update")
    public String update(PostVO postVO, @ModelAttribute("searchInfo") SearchInfo searchInfo, RedirectAttributes rttr) {
        log.info("update: " + postVO);

        if(service.modify(postVO)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + searchInfo.getListLink();
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("pno") int pno, @ModelAttribute("searchInfo") SearchInfo searchInfo, RedirectAttributes rttr) {
        log.info("remove..." + pno);
        if (service.remove(pno)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + searchInfo.getListLink();
    }

    @GetMapping("/add")
    public void add() {

    }
}
