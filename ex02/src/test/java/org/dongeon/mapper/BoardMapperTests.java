package org.dongeon.mapper;

import org.dongeon.domain.BoardVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글");
		board.setBcontent("새로 작성하는 내용");
		board.setWriter("newbie");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글SelectKey");
		board.setBcontent("새로 작성하는 내용 SelectKey");
		board.setWriter("newbie");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		BoardVO board = mapper.read(5L);
		
		log.info(board);
	}

	@Test
	public void testDelete() {

		log.info("DELETE COUNT: " + mapper.delete(3L));
	}

	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();

		// 실행 전 존재하는 번호인지 확인
		board.setBno(5L);
		board.setTitle("수정된 제목");
		board.setBcontent("수정된 내용");
		board.setWriter("user00");

		int count = mapper.update(board);
		log.info("UPDATE COUNT: " + count);
	}
}
