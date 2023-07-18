package com.dbja.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class InformationVO {
	private int ino;
	private String iname;
	private String addr;
	private String icontent;
	private int click;
	private String ipic;
	private String longitude;
	private String latitude;
	private double grade;
	private String review;
}
