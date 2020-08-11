package com.dh.bookdiary.Service;

import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dh.bookdiary.dao.ReaderDAO;
import com.dh.bookdiary.domain.Reader;

@Service
public class ReaderServiceImpl implements ReaderService {
	
	@Autowired
	private ReaderDAO readerDAO;

	//아이디 중복체크
	@Override
	public String idCheck(String id) {
		return readerDAO.idCheck(id);
	}

	//회원가입
	@Override
	public void joinMember(HttpServletRequest request) {
		//파라미터 읽기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String image = request.getParameter("image");
		String nickname = request.getParameter("nickname");
		
		//데이터베이스 작업
		Reader reader = new Reader();
		try {
			reader.setId(id);
			reader.setPassword(BCrypt.hashpw(password,BCrypt.gensalt()));
			reader.setEmail(email);
			reader.setImage(image);
			reader.setNickname(nickname);
			//데이터베이스 메소드 호출
			readerDAO.joinMember(reader);
			}catch(Exception e) {
				e.printStackTrace();
				}
		}

	//로그인 처리
	@Override
	public Reader login(HttpServletRequest request) {
		//필요한 데이터(파라미터) 읽어오기
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		//작업이 있으면 필요한작업을 수행하고
		//DAO의 파라미터만들기
		Reader reader = new Reader();
		reader.setId(id);
		reader.setPassword(password);
					
		//DAO 메소드를 호출하고 결과를 컨트롤러한테 보내주기
		//selectOne은 데이터가 없으면 null을 리턴
		return readerDAO.login(reader);	
		}
	}
