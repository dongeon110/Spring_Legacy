package org.dongeon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.dongeon.domain.BoardVO;
import org.dongeon.domain.Criteria;

public interface BoardMapper {
	
//	@Select("SELECT * FROM tbl_board WHERE bno > 0")
	public List<BoardVO> getList();

	public List<BoardVO> getListWithPaging(Criteria cri);

	public void insert(BoardVO board);
	
	public Integer insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);

	public int delete(Long bno);

	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);
}
