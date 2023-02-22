package kr.happyjob.study.community.model;

public class FreeBoardModel {

	private Long freeId;
	private String freeTitle;
	private String freeContent;
	private String freeRegdate;
	private String loginID;
	private String name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getFreeId() {
		return freeId;
	}
	public void setFreeId(Long freeId) {
		this.freeId = freeId;
	}
	public String getFreeTitle() {
		return freeTitle;
	}
	public void setFreeTitle(String freeTitle) {
		this.freeTitle = freeTitle;
	}
	public String getFreeContent() {
		return freeContent;
	}
	public void setFreeContent(String freeContent) {
		this.freeContent = freeContent;
	}
	public String getFreeRegdate() {
		return freeRegdate;
	}
	public void setFreeRegdate(String freeRegdate) {
		this.freeRegdate = freeRegdate;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
}
