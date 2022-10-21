package board.dongeon.controller.post;

import board.dongeon.domain.SearchInfo;
import board.dongeon.mapper.PostDao;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardListController {

    @Setter(onMethod_ = @Autowired)
    private PostDao postDao;

    @GetMapping("/list.do")
    public void list(SearchInfo searchInfo, Model model) {
        log.info("list: " + searchInfo);
        model.addAttribute("list", postDao.searchList(searchInfo));

        // searchInfo기반한 gettotal
        int total = postDao.getTotalCount(searchInfo);

        log.info("total: " + total);

    }
}
