package board.dongeon.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class UpdateAuthDTO {
    String userid;
    String auth;
}
