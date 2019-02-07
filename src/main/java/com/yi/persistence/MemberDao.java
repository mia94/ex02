package com.yi.persistence;

import java.util.List;

import com.yi.domain.MemberVO;

public interface MemberDao {
	public String getTime();
	public void insertMember(MemberVO vo);
	public MemberVO readMember(String userid);
	
	public List<MemberVO> selectAll();
	public void deleteMember(MemberVO vo);
	public void updateMember(MemberVO vo);
}
