package com.yi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.Criteria;
import com.yi.domain.PageMaker;
import com.yi.domain.ReplyVO;
import com.yi.service.ReplyService;

@RestController
@RequestMapping("/replies/*")
public class ReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Autowired
	private ReplyService service;
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){
		ResponseEntity<String> entity = null;
		logger.info("reply create------------"+vo);
		try {
			service.create(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);//400에러
		}
		
		return entity;
	}
	
	//@PathVariable("bno")는 : 주소에 있는 url변수를 내 매개변수에 대입시켜준다.
	@RequestMapping(value="/all/{bno}", method=RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") int bno){
		ResponseEntity<List<ReplyVO>> entity = null;
		
		try {
			List<ReplyVO> list = service.list(bno);
			entity = new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);//List<ReplyVO>로 보내야 하나, 보낼수없을때는HttpStatus만 보냄
		}
		
		return entity;
	}
	
	//페이지
	@RequestMapping(value="/{bno}/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno")int bno,@PathVariable("page") int page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			//리스트정보
			List<ReplyVO> list = service.listPage(cri, bno);
			//페이지정보
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			int count = service.totalCount(bno);
			pageMaker.setTotalCount(count);
			//리스트정보와 페이지정보를 같이 보내기위해 map에 저장
			HashMap<String, Object> map = new HashMap<>();
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			//정상적으로 되면 ok가 나올것
			entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	
	//put과 post는 바디에, get과 delete는 주소줄에 실어보냄
	@RequestMapping(value="{rno}", method=RequestMethod.PUT)
	public ResponseEntity<String> update(@PathVariable("rno") int rno,@RequestBody ReplyVO vo){
		ResponseEntity<String> entity = null;
		try {
			vo.setRno(rno);
			service.update(vo);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	@RequestMapping(value="{rno}", method=RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rno") int rno){
		ResponseEntity<String> entity = null;
		
		try {
			service.delete(rno);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
















