package com.dbja.vo;

public class TravelListVO {
	private int tno;
	private String tname;
	private int budget;
	private String tstart;
	private String tend;
	private String tpic;

	public TravelListVO(int tno, String tname, int budget, String tstart, String tend, String tpic) {
		super();
		this.tno = tno;
		this.tname = tname;
		this.budget = budget;
		this.tstart = tstart;
		this.tend = tend;
		this.tpic = tpic;
	}

	public TravelListVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getTno() {
		return tno;
	}

	public void setTno(int tno) {
		this.tno = tno;
	}

	public String getTname() {
		return tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	public int getBudget() {
		return budget;
	}

	public void setBudget(int budget) {
		this.budget = budget;
	}

	public String getTstart() {
		return tstart;
	}

	public void setTstart(String tstart) {
		this.tstart = tstart;
	}

	public String getTend() {
		return tend;
	}

	public void setTend(String tend) {
		this.tend = tend;
	}

	public String getTpic() {
		return tpic;
	}

	public void setTpic(String tpic) {
		this.tpic = tpic;
	}

}
