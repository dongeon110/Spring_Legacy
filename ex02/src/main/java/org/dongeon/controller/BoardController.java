package org.dongeon.controller;

import org.dongeon.domain.BoardVO;
import org.dongeon.domain.Criteria;
import org.dongeon.domain.PageDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.dongeon.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

    private BoardService service;

//    @GetMapping("/list")
//    public void list(Model model) {
//        log.info("list");
//
//        model.addAttribute("list", service.getList());
//    }

    @GetMapping("/list")
    public void list(Criteria cri, Model model) {
        log.info("list: " + cri);
        model.addAttribute("list", service.getList(cri));

        int total = service.getTotal(cri);

        log.info("total: " + total);

        model.addAttribute("pageMaker", new PageDTO(cri, total));
    }

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr) {
        log.info("register: " + board);
        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

//    @GetMapping("/get")
//    public void get(@RequestParam("bno") Long bno, Model model) {
//
//        log.info("/get");
//        model.addAttribute("board", service.get(bno));
//    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
        log.info("/get or modify");
        model.addAttribute("board", service.get(bno));
    }

    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
        log.info("modify: " + board);

        if (service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }

//        cri.getListLink()??? ??????
//        rttr.addAttribute("pageNum", cri.getPageNum());
//        rttr.addAttribute("amount", cri.getAmount());
//        rttr.addAttribute("type", cri.getType());
//        rttr.addAttribute("keyword", cri.getKeyword());
        if (service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/list" + cri.getListLink();
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {

        log.info("remove..." + bno);
        if (service.remove(bno)) {
            rttr.addFlashAttribute("result", "success");
        }
//        cri.getListLink(()??? ??????
//        rttr.addAttribute("pageNum", cri.getPageNum());
//        rttr.addAttribute("amount", cri.getAmount());
//        rttr.addAttribute("type", cri.getType());
//        rttr.addAttribute("keyword", cri.getKeyword());

        return "redirect:/board/list" + cri.getListLink();
    }

    @GetMapping("/register")
    public void register() {

    }
}

