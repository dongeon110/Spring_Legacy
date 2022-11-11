package board.dongeon.domain.dto;
import board.dongeon.domain.SearchInfo;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

    private int startPage;
    private int endPage;
    private boolean prev, next;

    private int total;
    private SearchInfo searchInfo;

    public PageDTO(SearchInfo searchInfo, int total) {
        this.searchInfo = searchInfo;
        this.total = total;

//        this.endPage = (int) (Math.ceil(searchInfo.getPageNum() / (searchInfo.getAmount() * 1.0))) * searchInfo.getAmount();
        this.endPage = (int) (Math.ceil(searchInfo.getPageNum() / 10.0)) * 10;
        this.startPage = this.endPage - 9;

        int realEnd = (int) (Math.ceil((total * 1.0) / searchInfo.getAmount()));

        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }
}
