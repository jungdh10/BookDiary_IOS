                                                                                                                                                                                                                                           package com.dh.bookdiary.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dh.bookdiary.domain.Reader;

@Repository
public class ReaderDAO {
	//동일한 자료형의 bean이 있으면 자동으로 대입해주는 어노테이션
	@Autowired
	private SqlSession sqlSession;
	
	//id 중복체크
	public String idCheck(String id) {
		return sqlSession.selectOne("reader.idCheck", id);
	}
	
	//회원가입
	public void joinMember(Reader reader) {
		sqlSession.insert("reader.joinMember", reader);
	}
	
	//로그인 처리
	public Reader login(Reader reader) {
		return sqlSession.selectOne("reader.login", reader);
	}
	

}
