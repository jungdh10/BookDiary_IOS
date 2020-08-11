package com.dh.bookdiary.domain;

public class Reader {
	private String id;
	private String password;
	private String email;
	private String image;
	private String nickname;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	@Override
	public String toString() {
		return "Reader [id=" + id + ", password=" + password + ", email=" + email + ", image=" + image + ", nickname="
				+ nickname + "]";
	}
	
	
}
