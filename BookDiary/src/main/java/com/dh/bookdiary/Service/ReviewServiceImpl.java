package com.dh.bookdiary.Service;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dh.bookdiary.dao.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private ReviewDAO reviewDAO;

	@Override
	public Map<String, Object> reviewlist(HttpServletRequest request) {
		//전체 데이터 개수 가져오기
		int reviewcount = reviewDAO.reviewcount();
		//전체 데이터 목록 가져오기
		List<Map<String, Object>> list = reviewDAO.reviewlist();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reviewcount", reviewcount);
		map.put("reviews", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> reviewdetail(HttpServletRequest request){
		//reviewid라는 파라미터를 만들어서 정수로 변환
		int reviewid = Integer.parseInt(request.getParameter("reviewid"));
		 Map<String, Object> map = reviewDAO.reviewdetail(reviewid);
		 return map;
	}
	
	@Override
	public Map<String, Object> reviewdelete(HttpServletRequest request) {
		//파라미터 읽어오기
		int reviewid = Integer.parseInt(request.getParameter("reviewid"));
		//데이터베이스에 삽입, 삭제, 갱신 작업을 수행하면 영향받은 행의 개수 리턴
		//0이 리턴되면 잘못된 것이 아니고 조건에 맞는 데이터는 데이터가 없는 것입니다.
		int r = reviewDAO.reviewdelete(reviewid);
		Map<String, Object> map = new HashMap<String, Object>();
		if(r >= 0) {
			map.put("result", "success");
		}else {
			map.put("result", "fail");
		}
		return map;
	}
	
	public Map<String, Object> reviewinsert(MultipartHttpServletRequest request){
		//System.out.println("클라이언트 요청 도달");
		String bookname = request.getParameter("bookname");
		String writer = request.getParameter("writer");
		String writing = request.getParameter("writing");
		//파라미터로 전달된 파일 찾아오기
		MultipartFile image = request.getFile("image");
		
		//파일을 업로드 할 프로젝트 내의 실제 경로 찾아오기
		//서블릿 3.0 이상을 사용하면 request 대신에 request.getServletContext() 사용
		String uploadPath = request.getRealPath("/reviewimage");
		//자바에서 랜덤한 64글자를 만들어 줄 수 있는 객체 생성-유효아이디
		UUID uid = UUID.randomUUID();
		//원본 파일 이름 찾아오기
		String filename = image.getOriginalFilename();
		//DAO에 데이터베이스 수행 메소드에 전달할 파라미터 생성
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			//업로드할 파일이 있다면
			if(filename.length() > 0) {
				//랜덤한 문자열과 파일의 확장자를 연결해서 새로운 파일이름 만들기(.의 위치를 구해서)
				int idx = filename.lastIndexOf(".");
				String filepath = uid + filename.substring(idx);
				//업로드할 파일 경로 만들기
				String upload = uploadPath + "/" + filepath;
				File f = new File(upload);
				//파일 업로드
				image.transferTo(f);
				map.put("image", filepath);
			}else {
				map.put("image", "");
			}
			map.put("bookname", bookname);
			map.put("writer", writer);
			map.put("writing", writing);
			//오늘 날짜 및 시간을 yyyy-MM-dd h:m:s의 형식의 문자열로 만들기
			//현재 날짜를 가장 정확하게 가지고 있는건 캘린더
			Calendar cal = Calendar.getInstance();
			//월은 하나 적게 나오기 때문에 +1
			String regdate = cal.get(Calendar.YEAR) +"-" +
			(cal.get(Calendar.MONTH)+1) + "-" + 
			cal.get(Calendar.DAY_OF_MONTH) + " " + 
			cal.get(Calendar.HOUR) + ":" + 
			cal.get(Calendar.MINUTE) + ":" + 
			cal.get(Calendar.SECOND);
			//Date 와 DateFormatter 의 조합으로 가능
			map.put("regdate", regdate);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		System.out.println("파라미터:" + map);
		
		int r = reviewDAO.reviewinsert(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(r >= 0)
			resultMap.put("result", "success");
		else
			resultMap.put("result", "fail");
		System.out.println("결과:" + resultMap);
		return resultMap;
	}
	

}
