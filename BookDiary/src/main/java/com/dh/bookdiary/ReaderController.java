package com.dh.bookdiary;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dh.bookdiary.Service.ReaderService;
import com.dh.bookdiary.domain.Reader;   

@RestController
public class ReaderController {
	@Autowired
	private ReaderService readerService;
	
	//회원가입
	@RequestMapping(value="reader/joinmember", method=RequestMethod.POST)
	public void joinMember(HttpServletRequest request) {	
		readerService.joinMember(request);	
	}
	
	
	//로그인 처리
	//Service가 여러 개가 될 것같으면 주소에 reader/
	//reader로 저장했으니까 불러올 때도 book에서 reader로 읽어야한다.(BookServiceImpl)
	@RequestMapping(value="reader/login", method=RequestMethod.GET)
	public Map<String, Object> login(HttpServletRequest request){
		Map<String, Object>map = new HashMap<String, Object>();
		//결과 받아오기
		Reader reader = readerService.login(request);
		//로그인 실패
		if(reader == null) {
			reader = new Reader();
			reader.setId("NULL");
		}
		//결과를 저장
		map.put("result", reader);
		
		return map;
	}
}
