package board.dongeon.mapper;

import board.dongeon.domain.vo.UserVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {

    // User List
    public List<UserVO> selectList();

    // User 가입
    public int insert(UserVO userVO);

    // User 상세보기
    public UserVO selectOne(int userNo);

    // User 정보 수정
    public int update(UserVO userVO);

    // User 삭제
    public int delete(int userNo);

    // 비밀번호 확인
    public UserVO exist(
            @Param("userID") String userID,
            @Param("userPassword") String userPassword
    );

}
