package com.yi.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.yi.domain.ReplyVO;
import com.yi.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyDAO dao;

	@Override
	public List<ReplyVO> list(int bno) {
		// TODO Auto-generated method stub
		return dao.list(bno);
	}

	@Override
	public void create(ReplyVO vo) {
		// TODO Auto-generated method stub
		dao.create(vo);
		
	}

	@Override
	public void update(ReplyVO vo) {
		// TODO Auto-generated method stub
		dao.update(vo);
	}

	@Override
	public void delete(int rno) {
		// TODO Auto-generated method stub
		dao.delete(rno);
	}

}
