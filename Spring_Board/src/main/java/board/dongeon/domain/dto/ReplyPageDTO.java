package board.dongeon.domain.dto;

import board.dongeon.domain.vo.ReplyVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

    private int replyCnt;
    private List<ReplyVO> list;
}
