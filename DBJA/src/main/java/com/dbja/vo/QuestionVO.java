package com.dbja.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionVO {
	private int qno;
	private String qtitle;
	private String qcontent;
	private String qpassword;
	private int secret;
	private String id;
}
