package board.dongeon.mapper;

import java.util.List;
import board.dongeon.domain.SearchInfo;
import board.dongeon.domain.vo.PostVO;

public interface PostDao {

    // 게시글 목록
//    public List<PostVO> searchList();
    public List<PostVO> searchList(SearchInfo searchInfo);

    public List<PostVO> adminSearchList(SearchInfo searchInfo);

    // 게시글 등록
    public int insert(PostVO postVO);
//    public int insertbyUser(PostVO postVO);

    // 게시글 보기
    public PostVO selectOne(int postNo);

    // ID, PWD 확인
//    public boolean checkPw(PostVO postVO);

    // 게시글 수정
    public int update(PostVO postVO);
//    public int updatebyUser(PostVO postVO);

    // 게시글 삭제
    public int delete(int postNo);

    public int restorePost(int postNo);

    // 답글 달기
    public int insertRepost(PostVO repostVO);
//    public int repostbyUser(PostVO repostVO);

    // 조회수 증가
    public int increaseViews(int postNo);

    // 게시글 총 개수
    public int getTotalCount(SearchInfo searchInfo);

    public int adminGetTotalCount(SearchInfo searchInfo);
}
