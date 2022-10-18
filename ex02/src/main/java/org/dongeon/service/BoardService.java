package org.dongeon.service;

import java.util.List;

import org.dongeon.domain.BoardVO;
import org.dongeon.domain.Criteria;

public interface BoardService {

    public void register(BoardVO board);

    public BoardVO get(Long bno);

    public boolean modify(BoardVO board);

    public boolean remove(long bno);

//    public List<BoardVO> getList();

    public List<BoardVO> getList(Criteria cri);

    public int getTotal(Criteria cri);
}
