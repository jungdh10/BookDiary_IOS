package com.dh.bookdiary.Service;

import javax.servlet.http.HttpServletRequest;

import com.dh.bookdiary.domain.Reader;

//사용자의 요청을 처리하기 위한 메소드의 원형을 만드는 곳
//인터페이스에는 어노테이션을 들어가지 않습니다.
public interface ReaderService {
	
	//아이디 중복체크 메소드
	public String idCheck(String id);
	
	//회원가입 메소드
	public void joinMember(HttpServletRequest request);
	
	//로그인 처리 메소드
	public Reader login(HttpServletRequest request);
	
}
