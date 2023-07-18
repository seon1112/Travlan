package com.dbja.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentsVO {
	private int cno;
	private int postno;
	private String c_content;
	private String id;
}
