package com.ssafy.happyhouse.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.FreeCommentDTO;
import com.ssafy.happyhouse.model.FreeDTO;
import com.ssafy.happyhouse.model.service.FreeBoardService;
@CrossOrigin(origins = {"*"}, maxAge = 6000)
@Controller
@RequestMapping("/freeboard")
public class FreeBoardController {
	
	@Autowired
	private FreeBoardService boardService;
	// 게시판
	@GetMapping(value="/freelist")
	public String freeboardList(Model model) {
		try {
			List<FreeDTO> list = boardService.listFreeBoard();
			List<Integer> commentCnt = new ArrayList<Integer>();
			for(int i=0; i<list.size(); i++) commentCnt.add(boardService.countComment(list.get(i).getNo()));
			model.addAttribute("freeboardlist", list);
			model.addAttribute("commentcnt", commentCnt);
			return "freeboard/freeList";
		} catch (Exception e) {
			model.addAttribute("msg", "목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/freedetail")
	public String freeboardDetail(@RequestParam("no") int no,
			@RequestParam(value="grade", defaultValue="1") int grade,
			@RequestParam(value="view", defaultValue="-1") int view, Model model) {
		try {
			FreeDTO free = boardService.getFreeBoard(no);
			if(grade < 10 && view != -1) {
				free.setView(view+1);
				boardService.modifyFreeBoard(free);
			}
			model.addAttribute("free", free);
			return "freeboard/freeDetail";
		} catch (Exception e) {
			model.addAttribute("msg", "게시판 내용을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/freewrite")
	public String freeboardWrite() {
		return "freeboard/freeWriteForm";
	}
	
	@PostMapping(value="/freewrite")
	public String freeboardWrite(FreeDTO free, Model model) {
		try {
			boardService.writeFreeBoard(free);
			return "redirect:freelist";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "글 추가 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@PostMapping(value="/freemodify")
	public String freeboardModify(FreeDTO free, Model model) {
		try {
			boardService.modifyFreeBoard(free);
			return "redirect:freedetail?no="+free.getNo();
		} catch (Exception e) {
			model.addAttribute("msg", "글 수정 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	@GetMapping(value="/freedelete")
	public String freeboardDelete(@RequestParam("no") int no, Model model) {
		try {
			boardService.deleteFreeBoard(no);
			return "redirect:freelist";
		} catch (Exception e) {
			model.addAttribute("msg", "글 삭제 중 문제가 발생했습니다.");
			return "error/error";
		}
	}
	
	// 댓글
	@GetMapping(value="/commentlist")
	@ResponseBody
	public List<FreeCommentDTO> commentList(@RequestParam("bno") int bno) throws Exception {
		return boardService.listComment(bno);
	}
	
	@PostMapping(value="/commentwrite")
	@ResponseBody
	public int commentWrite(@RequestParam("bno") int bno,
			@RequestParam("content") String content,
			@RequestParam("writer") String writer) throws Exception {
		FreeCommentDTO comment = new FreeCommentDTO();
		comment.setBno(bno);
		comment.setContent(content);
		comment.setWriter(writer);
		return boardService.writeComment(comment);
	}
	
	@PostMapping(value="/commentmodify")
	@ResponseBody
	public int commentModify(@RequestParam("no") int no, @RequestParam("content") String content) throws Exception {
		FreeCommentDTO comment = new FreeCommentDTO();
		comment.setNo(no);
		comment.setContent(content);
		return boardService.modifyComment(comment);
	}
	
	@GetMapping(value="/commentdelete")
	@ResponseBody
	public int commentDelete(@RequestParam("no") int no) throws Exception {
		return boardService.deleteComment(no);
	}
}
