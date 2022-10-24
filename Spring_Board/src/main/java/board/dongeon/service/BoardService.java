package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.PostVO;

import java.util.List;

public interface BoardService {

    public List<PostVO> getList(SearchInfo searchInfo); // 게시물 리스트

    public PostVO get(int pno); // 게시물 보기

    public int getTotal(SearchInfo searchInfo); // 게시물 총 개수
    
    public void add(PostVO postVO); // 게시물 추가
    
    public boolean modify(PostVO postVO); // 게시물 수정
    
    public boolean remove(int pno); // 게시물 삭제
}
