package com.dh.bookdiary.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
	@Autowired
	private SqlSession sqlSession;

	//전체 데이터 개수를 가져오는 메소드-데이터개수는 정수로 리턴되니까
	public int reviewcount() {
		return sqlSession.selectOne("review.reviewcount");
	}
	
	//전체 데이터 목록을 가져오는 메소드
	public List<Map<String, Object>> reviewlist(){
		return sqlSession.selectList("review.reviewlist");
	}
	
	//reviewid를 가져와서 하나의 데이터를 찾아오는 메소드 매개변수 넣어줘야 할것 주의
	public Map<String, Object> reviewdetail(int reviewid){
		return sqlSession.selectOne("review.reviewdetail", reviewid);
	}
	
	//Map으로 파라미터를 저장해서 데이터를 추가하는 메소드
	public int reviewinsert(Map<String, Object> map) {
		return sqlSession.insert("review.reviewinsert", map);
	}
	
	//reviewid를 파라미터로 저장해서 데이터를 삭제하는 메소드
	public int reviewdelete(int reviewid) {
		return sqlSession.delete("review.reviewdelete", reviewid);
	}
}
