package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.PostVO;
import board.dongeon.mapper.PostDao;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
    
    // Spring 4.3 이상에서 자동 처리
    @Setter(onMethod_ = @Autowired)
    private PostDao postDao;

    @Override
    public List<PostVO> getList(SearchInfo searchInfo) { // 게시물 리스트
        log.info("getList with searchInfo: " + searchInfo);
        return postDao.searchList(searchInfo);
    }

    @Override
    public PostVO get(int pno) { // 게시물 보기
        log.info("BoardServiceImpl get pno: " + pno);
        return postDao.selectOne(pno);
    }

    @Override
    public int getTotal(SearchInfo searchInfo) { // 게시물 총 개수
        log.info("BoardServiceImpl getTotal count");
        return postDao.getTotalCount(searchInfo);
    }

    @Override
    public void add(PostVO postVO){ // 게시물 추가
        log.info("BoardServiceImpl add postVO: " + postVO);
        postDao.insert(postVO);
    }

    @Override
    public boolean modify(PostVO postVO) { // 게시물 수정
        log.info("BoardServiceImpl modify postVO: " + postVO);
        return postDao.update(postVO) == 1;
    }

    @Override
    public boolean remove(int pno) { // 게시물 삭제
        log.info("BoardServiceImpl remove pno: " + pno);
        return postDao.delete(pno) == 1;
    }

    @Override
    public void addRepost(PostVO postVO) { // 답글 추가
        log.info("BoardServiceImpl addRepost postVO: " + postVO);
        postDao.insertRepost(postVO);
    }
}
