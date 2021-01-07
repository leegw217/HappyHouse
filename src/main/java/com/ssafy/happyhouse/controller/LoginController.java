package com.ssafy.happyhouse.controller;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.service.LoginService;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	@GetMapping(value = "/login")
	public String login() {
		return "member/userLogin";
    }
   
    @PostMapping(value = "/login")
    public String login(@RequestParam Map<String, String> map, Model model, HttpSession session, HttpServletResponse response) {
    	try {
    		MemberDTO member = loginService.login(map);
    		if(member != null) {
    			session.setAttribute("member", member);
            
    		Cookie cookie = new Cookie("id", member.getId());
            cookie.setPath("/");
            if("saveok".equals(map.get("idsave"))) {
               cookie.setMaxAge(60 * 60 * 24 * 365 * 40);//40년간 저장.
            } else {
               cookie.setMaxAge(0);
            }
            response.addCookie(cookie);
            
    		} else {
    			model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    		model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
    		return "error/error";
    	}
    	return "index";
    }
   
    @GetMapping(value = "/logout")
    public String logout(HttpSession session) {
    	session.invalidate();
    	return "redirect:/";
    }
}
