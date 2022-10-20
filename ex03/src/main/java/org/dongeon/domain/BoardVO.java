package org.dongeon.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String bcontent;
	private String writer;
	private Date regdate;
	private Date updateDate;
}
