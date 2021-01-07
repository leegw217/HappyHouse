package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.QnaDTO;
import com.ssafy.happyhouse.model.service.QnaBoardService;

@Controller
@RequestMapping("/qnaboard")
public class QnaBoardController {
	
	@Autowired
	private QnaBoardService boardService;
	
	// QnA 게시판 리스트 출력
	@GetMapping(value="/qnalist")
	public String qnaList(Model model) {
		try {
			List<QnaDTO> list = boardService.listQna();
			model.addAttribute("qnalist", list);
			return "qnaboard/qnaList";
		} catch (Exception e) {
			model.addAttribute("msg", "목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	// QnA 게시글 상세보기
	@GetMapping(value="/qnadetail")
	public String qnaDetail(@RequestParam("no") int no, Model model) {
		try {
			QnaDTO qna = boardService.getQna(no);
			model.addAttribute("qna",qna);
			return "qnaboard/qnaDetail";
		} catch (Exception e) {
			model.addAttribute("msg", "게시판 내용을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	// QnA 게시글 작성 페이지로 이동
	@GetMapping(value="/qnawrite")
	public String qnaWrite() {
		return "qnaboard/qnaWriteForm";
	}
	// QnA 게시글 작성
	@PostMapping(value="/qnawrite")
	public String qnaWrite(@RequestParam Map<String, String> map, Model model) {
		try {
			boolean secret = false;
			QnaDTO qna = new QnaDTO();
			if (map.containsKey("secret") &&map.get("secret").equals("on"))
				secret = true;
			qna.setTitle(map.get("title"));
			qna.setWriter(map.get("writer"));
			qna.setContent(map.get("content"));
			qna.setSecret(secret);
			
			boardService.writeQna(qna);
			return "redirect:qnalist";
		} catch (Exception e) {
			model.addAttribute("msg", "글 추가 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	// QnA 게시글 수정
	@PostMapping(value="/qnamodify")
	public String qnaModify(@RequestParam Map<String, String> map, Model model) {
		try {
			System.out.println(map);
			boolean secret = false;
			QnaDTO qna = new QnaDTO();
			if (map.containsKey("secret") &&map.get("secret").equals("on"))
				secret = true;
			int no = Integer.parseInt(map.get("no"));
			qna.setNo(no);
			qna.setTitle(map.get("title"));
			qna.setWriter(map.get("writer"));
			qna.setContent(map.get("content"));
			qna.setSecret(secret);
			boardService.modifyQna(qna);
			System.out.println(qna);
			return "redirect:qnadetail?no="+no;
		} catch (Exception e) {
			model.addAttribute("msg", "글 수정 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	// QnA 게시글 삭제
	@GetMapping(value="/qnadelete")
	public String qnaDelete(@RequestParam("no") int no, Model model) {
		try {
			boardService.deleteQna(no);
			return "redirect:qnalist";
		} catch (Exception e) {
			model.addAttribute("msg", "글 삭제 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	// QnA 게시글에 답변 달기
	@PostMapping(value="/qnacomment")
	public String qnaComment(@RequestParam Map<String, String> map, Model model) {
		try {
			QnaDTO qna = boardService.getQna(Integer.parseInt(map.get("no")));
			String comment = map.get("comment");
			if(comment.equals("")) qna.setComment(null);
			else qna.setComment(comment);
			boardService.writeComment(qna);
			return "redirect:qnalist";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "댓글 작성 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
}