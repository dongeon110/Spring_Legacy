package board.dongeon.controller.post;


import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.dto.ReplyPageDTO;
import board.dongeon.domain.vo.ReplyVO;
import board.dongeon.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/replies")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {

    private ReplyService service;

    @PostMapping(value="/new",
            consumes = "application/json",
            produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
        log.info("ReplyVO: " + vo);

        int insertCount = service.register(vo);

        log.info("Reply INSERT COUNT: " + insertCount);

        return insertCount == 1?
                new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/pages/{pno}/{page}",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<ReplyPageDTO> getList(
            @PathVariable("page") int page,
            @PathVariable("pno") int pno) {

        SearchInfo searchInfo = new SearchInfo(page, 10);
        log.info("get Reply List pno: " + pno);
        log.info("searchInfo: " + searchInfo);

        return new ResponseEntity<>(service.getListPage(searchInfo, pno), HttpStatus.OK);
    }

    @GetMapping(value= "/{rno}",
            produces={MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_UTF8_VALUE })
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno) {
        log.info("get rno: " + rno);

        return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
    }

    @RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH },
            value = "/{rno}",
            consumes = "application/json",
            produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> modify(
            @RequestBody ReplyVO vo,
            @PathVariable("rno") int rno) {
        vo.setRno(rno);

        log.info("rno: " + rno);
        log.info("modify: " + vo);

        return service.modify(vo) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @DeleteMapping(value="/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE })
    public ResponseEntity<String> remove(@PathVariable("rno") int rno) {
        log.info("remove: " + rno);

        return service.remove(rno) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }


}
