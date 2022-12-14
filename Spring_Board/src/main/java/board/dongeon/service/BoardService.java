package board.dongeon.service;

import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.PostVO;

import java.util.List;

public interface BoardService {

    public List<PostVO> getList(SearchInfo searchInfo); // 게시물 리스트

    public List<PostVO> adminGetList(SearchInfo searchInfo); // 관리자페이지 게시물리스트
    
    public PostVO get(int pno); // 게시물 보기
    
    public void increaseViews(int pno); // 게시물 조회수 증가

    public int getTotal(SearchInfo searchInfo); // 게시물 총 개수
    
    public int adminGetTotal(SearchInfo searchInfo); // 관리자페이지 게시물 총 개수
    
    public void add(PostVO postVO); // 게시물 추가
    
    public boolean modify(PostVO postVO); // 게시물 수정
    
    public boolean remove(int pno); // 게시물 삭제

    public boolean restore(int pno); // 게시물 복구
    
    public void addRepost(PostVO postVO); // 답글 추가
}
