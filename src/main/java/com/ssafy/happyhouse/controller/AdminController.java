package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.MemberDTO;
import com.ssafy.happyhouse.model.service.AdminService;


@RestController
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	
	@RequestMapping(value = "/user", method = RequestMethod.GET, headers = { "Content-type=application/json" })
	public List<MemberDTO> userList() {
		return adminService.userList();
	}
	
	@RequestMapping(value = "/user", method = RequestMethod.PUT, headers = { "Content-type=application/json" })
	public List<MemberDTO> userModify(@RequestBody MemberDTO memberDto) {
		adminService.userModify(memberDto);
		return adminService.userList();
	}
	

}
