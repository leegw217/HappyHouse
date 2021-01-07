package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping(value = "/list")
	public String list() {
		return "member/userList";
	}

	@PostMapping(value = "/join")
	public String join(MemberDTO member, Model model) {
		try {
			userService.userRegister(member);
		} catch (Exception e) {
			model.addAttribute("msg", "아이디가 중복됩니다.");
			return "member/userLogin";
		}
		return "member/userLogin";
	}

	@GetMapping(value = "/mypage")
	public String mypage() {
		return "member/userMyPage";
	}

	@GetMapping(value = "/confirm")
	public String confirm(String id, Model model) {
		model.addAttribute("user", userService.userInfo(id));
		return "member/userConfirm";
	}

	@GetMapping(value = "/modify")
	public String modify(String id, Model model) {
		model.addAttribute("user", userService.userInfo(id));
		return "member/userModifyForm";
	}

	@PostMapping(value = "/modify")
	public String modify(MemberDTO member, HttpSession session) {
		userService.userModify(member);
		session.setAttribute("member", member);
		return "member/userMyPage";
	}

	@GetMapping(value = "/delete")
	public String delete(String id, HttpSession session) {
		userService.userDelete(id);
		session.invalidate();
		return "index";
	}

	@GetMapping(value = "/findpw")
	@ResponseBody
	public String findpw(MemberDTO member, Model model) {
		String pw = null;
		try {
			MemberDTO temp = userService.userInfo(member.getId());
			if (temp.getName().equals(member.getName()) && temp.getEmail().equals(member.getEmail())) {
				pw = temp.getPw();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pw;
	}
	
	@GetMapping(value = "/likelist")
	   public String likelist() {
	      return "member/userLikeList";
	}
	   
}