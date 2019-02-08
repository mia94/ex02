package com.yi.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value="hello", method=RequestMethod.GET)
	public @ResponseBody String sayHello() { //@ResponseBody는 jsp로 가는게 아니라 응답하는 바디에 글자가 그대로 리턴
		return "Hello World";
	}
	
	@RequestMapping(value="test", method=RequestMethod.GET)
	public String test() {
		logger.info("test ------- get");
		return "test";
	}
	
	@RequestMapping(value="member", method=RequestMethod.GET)
	public String member() {
		logger.info("member ------- get");
		return "member";
	}
	
}























