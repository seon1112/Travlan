package com.dbja.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ExpenseVO {
	private int ano;
	private String id;
	private int sno;
	private int tno;   //여행번호
	private String adate;
	private String category;
	private int expect;
	private int real;
	private String payment;
	private String memo;
	public ExpenseVO(String category, int real) {
		super();
		this.category = category;
		this.real = real;
	}
	
	
}
