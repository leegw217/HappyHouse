package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.NoticeDTO;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping(value="/noticelist")
	public String noticeList(Model model) {
		try {
			List<NoticeDTO> list = noticeService.listNotice();
			model.addAttribute("noticelist", list);
			return "notice/noticeList";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/noticedetail")
	public String noticeDetail(@RequestParam("no") int no, 
			@RequestParam(value="grade", defaultValue="1") int grade,
			@RequestParam("view") int view, Model model) {
		try {
			NoticeDTO noticeDTO = noticeService.getNotice(no);
			if(grade < 10) {
				noticeDTO.setView(view+1);
				noticeService.modifyNotice(noticeDTO);
			}
			model.addAttribute("notice", noticeDTO);
			return "notice/noticeDetail";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "공지사항 정보를 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/noticewrite")
	public String noticeWrite() {
		return "notice/noticeWriteForm";
	}
	
	@PostMapping(value="/noticewrite")
	public String noticeWrite(NoticeDTO noticeDTO, Model model) {
		try {
			noticeService.writeNotice(noticeDTO);
			return "redirect:noticelist";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "글작성중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value = "/noticemodify")
	public String noticeModify(@RequestParam("no") int no, Model model) {
		try {
			NoticeDTO noticeDTO = noticeService.getNotice(no);
			model.addAttribute("notice", noticeDTO);
			return "notice/noticeModifyForm";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "글수정 처리 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@PostMapping(value = "/noticemodify")
	public String noticeModify(NoticeDTO noticeDTO, Model model) {
		try {
			noticeService.modifyNotice(noticeDTO);
			return "redirect:noticelist";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "글수정중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/noticedelete")
	public String noticeDelete(@RequestParam("no") int no, Model model) {
		try {
			noticeService.deleteNotice(no);
			return "redirect:noticelist";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "공지사항 정보를 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
}
