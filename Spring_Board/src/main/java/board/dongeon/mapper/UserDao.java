package board.dongeon.mapper;

import board.dongeon.domain.vo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.HashMap;
import java.util.Hashtable;

public interface UserDao {

    // User List
    public List<User> selectList();

    // User 가입
    public int insert(User user);

    // User 상세보기
    public User selectOne(int userNo);

    // User 정보 수정
    public int update(User user);

    // User 삭제
    public int delete(int userNo);

    // 비밀번호 확인
    public User exist(
            @Param("userID") String userID,
            @Param("userPassword") String userPassword
    );

}
