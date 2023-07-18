package com.dbja.vo;

public class PostVO {
	private int postno;
	private String pcontent;
	private String hashtag1;
	private String hashtag2;
	private String hashtag3;
	private String p_pic;
	private int tno;
	private String id;

	public int getPostno() {
		return postno;
	}

	public void setPostno(int postno) {
		this.postno = postno;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getHashtag1() {
		return hashtag1;
	}

	public void setHashtag1(String hashtag1) {
		this.hashtag1 = hashtag1;
	}

	public String getHashtag2() {
		return hashtag2;
	}

	public void setHashtag2(String hashtag2) {
		this.hashtag2 = hashtag2;
	}

	public String getHashtag3() {
		return hashtag3;
	}

	public void setHashtag3(String hashtag3) {
		this.hashtag3 = hashtag3;
	}

	public String getP_pic() {
		return p_pic;
	}

	public void setP_pic(String p_pic) {
		this.p_pic = p_pic;
	}

	public int getTno() {
		return tno;
	}

	public void setTno(int tno) {
		this.tno = tno;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public PostVO(int postno, String pcontent, String hashtag1, String hashtag2, String hashtag3, String p_pic, int tno,
			String id) {
		super();
		this.postno = postno;
		this.pcontent = pcontent;
		this.hashtag1 = hashtag1;
		this.hashtag2 = hashtag2;
		this.hashtag3 = hashtag3;
		this.p_pic = p_pic;
		this.tno = tno;
		this.id = id;
	}

	public PostVO() {
		super();
		// TODO Auto-generated constructor stub
	}

}
