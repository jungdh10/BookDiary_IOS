package com.dh.bookdiary;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dh.bookdiary.Service.ReviewService;

@RestController
//위의 어노테이션을 쓸 때는 스프링버전이 4.0 이상인지 확인
//jackson-databind 라이브러리가 포함되어 있는지 확인
public class ReviewRestController {
	//실제 서비스되는 프로젝트의 경우에는 여러개의 서비스 객체가 포함되는 경우가 많습니다.
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value="review/reviewlist", method=RequestMethod.GET)
	public Map<String, Object> reviewList(HttpServletRequest request){
		return reviewService.reviewlist(request);
	}
	
	@RequestMapping(value="review/reviewdetail", method=RequestMethod.GET)
	public Map<String, Object> reviewdetail(HttpServletRequest request){
		return reviewService.reviewdetail(request);
	}
	
	@RequestMapping(value="review/reviewdelete", method=RequestMethod.POST)
	public Map<String,Object> reviewdelete(HttpServletRequest request){
		return reviewService.reviewdelete(request);
	}
	
	@RequestMapping(value="review/reviewinsert", method=RequestMethod.POST)
	public Map<String,Object> reviewinsert(MultipartHttpServletRequest request){
	//System.out.println("클라이언트 요청");
		return reviewService.reviewinsert(request);
	}
	
}
