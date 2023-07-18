package com.dbja.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DetailPostVO {
	private int budget;
	private String tstart;
	private String tend;
	private int postno;
	private String pcontent;
	private String hashtag1;
	private String hashtag2;
	private String hashtag3;
	private String p_pic;
	private int tno;
	private String id;
	private String name;
	private String tname;
}
