package com.dbja.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleVO {

	private int sno;
	private int tno;
	private String sdate;
	private String sname;
	private String stime;
	private String saddr;
	private String category;
	private int expect;

}
