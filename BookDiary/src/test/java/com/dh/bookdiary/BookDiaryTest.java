package com.dh.bookdiary;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dh.bookdiary.dao.ReaderDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class BookDiaryTest {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ReaderDAO readerDAO;
	

	
	@Test
	public void connectTest() {
		//System.out.println(sqlSession);
		//System.out.println(sqlSession.selectOne("reader.login", "dahye")+"");
		
		//DAO test
		//System.out.println(readerDAO.login("dahye"));

		
	}

}
