package com.yi.ex02;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yi.domain.ReplyVO;
import com.yi.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ReplyDaoTest {
	
	@Autowired
	ReplyDAO dao;
	
	//@Test
	public void test01create() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(2049);
		vo.setReplyer("user06");
		vo.setReplytext("´ñ±Û¾µ²¨¾ä È÷È÷È÷È÷");
		dao.create(vo);
	}
	
	@Test
	public void test02list() {
		dao.list(2049);
	}
	
	@Test
	public void test03update() {
		ReplyVO vo = new ReplyVO();
		vo.setRno(5);
		vo.setReplytext("´ñ±Û¼öÁ¤ÇÒ²¨¾ä È÷È÷È÷È÷");
		dao.update(vo);
	}
	
	@Test
	public void test04delete() {
		dao.delete(6);
	}
	
}

















