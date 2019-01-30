package com.yi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.yi.domain.SampleVO;

@RestController
@RequestMapping("/sample/*")
public class SampleController {//@RestController는 @ResponseBody없이 jsp로 이동없이 내용만 리턴
	
	@RequestMapping("/hello")
	public String sayHello() {
		return "hello World";
	}
	
	@RequestMapping("/sendVO")
	public SampleVO sendVO() {
		SampleVO vo = new SampleVO();
		vo.setMno(1234);
		vo.setFirstName("길동");
		vo.setLastName("홍");
		return vo;
	}
	
	@RequestMapping("/sendList")
	public List<SampleVO> sendList(){
		List<SampleVO> list = new ArrayList<>();
		
		for(int i=0;i<10;i++) {
			SampleVO vo = new SampleVO();
			vo.setMno(i);
			vo.setFirstName("길동"+i);
			vo.setLastName("홍");
			list.add(vo);
		}
		
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<String, SampleVO> sendMap(){
		Map<String, SampleVO> map = new HashMap<>();
		
		for(int i=0;i<10;i++) {
			SampleVO vo = new SampleVO();
			vo.setMno(i);
			vo.setFirstName("길동"+i);
			vo.setLastName("홍");
			map.put(""+i, vo);
		}
		return map;
	}
	
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		return new ResponseEntity<>(HttpStatus.BAD_REQUEST);//400에러 유발
	}
	
	@RequestMapping("/sendMapStatus")
	public ResponseEntity<Map<String, SampleVO>> sendMapStatus(){
		Map<String, SampleVO> map = new HashMap<>();
		
		for(int i=0;i<10;i++) {
			SampleVO vo = new SampleVO();
			vo.setMno(i);
			vo.setFirstName("길동"+i);
			vo.setLastName("홍");
			map.put(""+i, vo);
		}
		
		ResponseEntity<Map<String, SampleVO>> res = new ResponseEntity<Map<String,SampleVO>>(map, HttpStatus.NOT_FOUND);
		return res;
	}
}



























