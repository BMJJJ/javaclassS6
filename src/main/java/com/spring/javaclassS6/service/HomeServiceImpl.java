package com.spring.javaclassS6.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS6.dao.HomeDAO;
import com.spring.javaclassS6.vo.WebChattingVO;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Autowired
	HomeDAO homeDAO;

	@Override
	public int setMsgInput(WebChattingVO vo) {
		return homeDAO.setMsgInput(vo);
	}

}
