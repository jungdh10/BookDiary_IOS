package com.dh.bookdiary;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dh.bookdiary.dao.ReviewDAO;


@Controller
public class HomeController {
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		//System.out.println(reviewDAO.reviewcount());
		//System.out.println(reviewDAO.reviewlist());
		//System.out.println(reviewDAO.reviewdetail(1));
		//System.out.println(reviewDAO.reviewdelete(7));
		/*
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("readerid","dahye");
		map.put("bookname", "책");
		map.put("writer", "작가");
		map.put("writing", "감상문");
		map.put("image", "img.png");
		map.put("regdate", "2018-12-04");
		//System.out.println(reviewDAO.reviewinsert(map));
		*/
		return "home";
	}
	
	@RequestMapping(value = "review/reviewinsert", method = RequestMethod.GET)
	public String insert(Locale locale, Model model) {
		return "review/reviewinsert";
	}
	
}
