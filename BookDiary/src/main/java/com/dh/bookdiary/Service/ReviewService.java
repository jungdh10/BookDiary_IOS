package com.dh.bookdiary.Service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

//사용자의 요청을 처리하기 위한 메소드의 모양을 선언
public interface ReviewService {
	//전체 데이터 보기를 처리해주는 메소드
	public Map<String, Object> reviewlist(HttpServletRequest request);
	
	//상세보기를 위한 메소드
	public Map<String, Object> reviewdetail(HttpServletRequest request);
	
	//데이터 삭제를 위한 메소드
	public Map<String, Object> reviewdelete(HttpServletRequest request);
	
	//데이터 삭입을 위한 메소드
	//파일을 저장해야 하기 때문에 MultipartHttpServletRequest 사용
	public Map<String, Object> reviewinsert(MultipartHttpServletRequest request);

}
