package com.ssafy.happyhouse.controller;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.NaverProfile;
import com.ssafy.happyhouse.model.service.LoginService;
import com.ssafy.happyhouse.model.service.NaverService;
import com.ssafy.happyhouse.model.service.UserService;
import com.ssafy.happyhouse.model.NaverToken;

@Controller
@RequestMapping("/social")
public class SocialLoginController {
	
	@Autowired
	private NaverService naverService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private LoginService loginService;
	
	@Value("${kakaologin.key}")
	private String kakao_pw;
	
	@Value("${naverlogin.key}")
	private String naver_pw;
	
	@PostMapping("/kakao/login")
	@ResponseBody
	public int kakaoLogin(@RequestParam("id") int id,
			@RequestParam("name") String name,
			@RequestParam("email") String email, Model model, HttpSession session, HttpServletResponse response) {
		String kakaoId = Integer.toString(id)+"_"+name;
		MemberDTO member = userService.userInfo(kakaoId);
		if(member == null) {
			member = new MemberDTO();
			member.setId(kakaoId);
			member.setPw(kakao_pw);
			member.setName(name);
			member.setEmail(email);
			member.setGrade(1);
			member.setProvider("kakao");
			userService.userRegister(member);
			userService.providerModify(member);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", member.getId());
		map.put("pw", member.getPw());
		try {
			MemberDTO temp = loginService.login(map);
    		if(temp != null) {
    			session.setAttribute("member", temp);
            
	    		Cookie cookie = new Cookie("id", temp.getId());
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
		}
		return 1;
	}
	
	@GetMapping("/naver/call")
	@ResponseBody
	public String naverCall() {
		SecureRandom random = new SecureRandom();
	    String status = new BigInteger(130, random).toString(32);
	    String url = "https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=MPvkgO4ohChxb_eiLLvU&redirect_uri=http://localhost:8000/happyhouse/social/naver/callback&state=";
	    url += status;
	    return url;
	}

	@GetMapping("/naver/callback")
	public String naverCallback(String code, Model model, HttpSession session, HttpServletResponse response) {
		NaverToken naverToken = null;
		try {
			naverToken = naverService.getToken(code);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "네이버 토큰을 받아오는 중 문제가 발생했습니다.");
			return "error/error";
		}
		session.setAttribute("naverRefreshToken", naverToken.getRefresh_token());
		NaverProfile naverProfile = null;
		try {
			naverProfile = naverService.getProfile(naverToken);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "네이버 회원정보를 받아오는 중 문제가 발생했습니다.");
			return "error/error";
		}
		// 회원가입
		String naverId = naverProfile.getResponse().getId()+"_"+naverProfile.getResponse().getName();
		MemberDTO member = userService.userInfo(naverId);
		if(member == null) {
			member = new MemberDTO();
			member.setId(naverId);
			member.setPw(naver_pw);
			member.setName(naverProfile.getResponse().getName());
			member.setEmail(naverProfile.getResponse().getEmail());
			member.setGrade(1);
			member.setProvider("naver");
			
			userService.userRegister(member);
			userService.providerModify(member);
		}
		// 네이버 로그인
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", member.getId());
		map.put("pw", member.getPw());
		try {
			MemberDTO temp = loginService.login(map);
    		if(temp != null) {
    			session.setAttribute("member", temp);
            
	    		Cookie cookie = new Cookie("id", temp.getId());
	            cookie.setPath("/");
	            if("saveok".equals(map.get("idsave"))) {
	               cookie.setMaxAge(60 * 60 * 24 * 365 * 40);//40년간 저장.
	            } else {
	               cookie.setMaxAge(0);
	            }
	            response.addCookie(cookie);
            
    		} else {
    			model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
    			return "error/error";
    		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("loginState","네이버 로그인 성공");
		
		return "member/userLogin";
	}
	
	@GetMapping("/naver/delete")
	public String naverDelete(String id, Model model, HttpSession session) {
		// 1. 리프레쉬 토큰으로 접근 토큰 갱신하기
		String token = (String) session.getAttribute("naverRefreshToken");
		NaverToken naverToken = null;
		try {
			naverToken = naverService.refreshToken(token);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "토큰 갱신 중 문제가 발생했습니다.");
			return "error/error";
		}
		// 2. 접근 토큰으로 연동해제 요청
		String result = null;
		try {
			result = naverService.deleteToken(naverToken.getAccess_token());
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "토큰 삭제 중 문제가 발생했습니다.");
			return "error/error";
		}
		// 연동 해제 완료
		if(result.equals("success")) {
			// 3. DB에 사용자 삭제
			userService.userDelete(id);
			// 4. session.invalidate();
			session.invalidate();
		}
		return "redirect:/";
	}
}
