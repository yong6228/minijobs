package kr.happyjob.study.community.model;

public class SubModel {
	
	//자료실ID
	private int supId;
	//제목
	private String supTitle;
	//내용
	private String supContent;
	//작성일
	private String supRegdate;
	//첨부파일명
	private String supFilename;
	//파일경로
	private String supFilepath;
	//파일사이즈
	private int supFilesize;
	//사용자ID
	private String loginID;
	//이름
	private String name;
	
	public int getSupId() {
		return supId;
	}
	public void setSupId(int supId) {
		this.supId = supId;
	}
	public String getSupTitle() {
		return supTitle;
	}
	public void setSupTitle(String supTitle) {
		this.supTitle = supTitle;
	}
	public String getSupContent() {
		return supContent;
	}
	public void setSupContent(String supContent) {
		this.supContent = supContent;
	}
	public String getSupRegdate() {
		return supRegdate;
	}
	public void setSupRegdate(String supRegdate) {
		this.supRegdate = supRegdate;
	}
	public String getSupFilename() {
		return supFilename;
	}
	public void setSupFilename(String supFilename) {
		this.supFilename = supFilename;
	}
	public String getSupFilepath() {
		return supFilepath;
	}
	public void setSupFilepath(String supFilepath) {
		this.supFilepath = supFilepath;
	}
	public int getSupFilesize() {
		return supFilesize;
	}
	public void setSupFilesize(int supFilesize) {
		this.supFilesize = supFilesize;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
