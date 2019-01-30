package com.yi.service;

import java.util.List;

import com.yi.domain.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> list(int bno);
	public void create(ReplyVO vo);
	public void update(ReplyVO vo);
	public void delete(int rno);
}
