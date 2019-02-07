package com.yi.persistence;

import java.util.List;

import com.yi.domain.Criteria;
import com.yi.domain.ReplyVO;

public interface ReplyDAO {
	
	public List<ReplyVO> list(int bno);
	public void create(ReplyVO vo);
	public void update(ReplyVO vo);
	public void delete(int rno);
	public List<ReplyVO> listPage(Criteria cri, int bno);//bno�� ������ ���ؼ� �Ű�����2��
	public int totalCount(int bno);
}
