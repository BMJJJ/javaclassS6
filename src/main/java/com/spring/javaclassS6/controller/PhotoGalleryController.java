package com.spring.javaclassS6.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS6.service.PhotoGalleryService;
import com.spring.javaclassS6.vo.PhotoGalleryVO;

@Controller
@RequestMapping("/photoGallery")
public class PhotoGalleryController {

    @Autowired
    private PhotoGalleryService photoGalleryService;

    @RequestMapping(value = "/photoGalleryList", method = RequestMethod.GET)
    public String getPhotoGalleryList(PhotoGalleryVO vo,
            @RequestParam(value = "pag", defaultValue = "1") int pag,
            @RequestParam(value = "pageSize", defaultValue = "16") int pageSize,
            @RequestParam(value = "part", defaultValue = "전체") String part,
            @RequestParam(value = "choice", defaultValue = "최신순") String choice,
            Model model) {

        int startIndexNo = (pag - 1) * pageSize;

        String imsiChoice;
        switch (choice) {
            case "추천순":
                imsiChoice = "goodCount";
                break;
            case "조회순":
                imsiChoice = "readNum";
                break;
            case "댓글순":
                imsiChoice = "replyCnt";
                break;
            default:
                imsiChoice = choice;
        }

        List<PhotoGalleryVO> vos = photoGalleryService.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);

        model.addAttribute("vo", vo);
        model.addAttribute("vos", vos);
        model.addAttribute("part", part);
        model.addAttribute("choice", choice);

        return "photoGallery/photoGalleryList"; 
    }
    @RequestMapping(value = "/photoGalleryInput", method = RequestMethod.GET)
    public String photoGalleryInputGet(Model model,
            @RequestParam(name="part", defaultValue = "전체", required = false) String part) {
        model.addAttribute("part", part);
        return "photoGallery/photoGalleryInput";
    }
    
    @RequestMapping(value = "/photoGalleryInput", method = RequestMethod.POST)
    public String photoGalleryInputPost(PhotoGalleryVO vo) {
  		// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/board'폴더로 복사처리)
  		if(vo.getContent().indexOf("src=\"/") != -1) photoGalleryService.imgCheck(vo.getContent());
  		
  		// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 photo폴더 경로로 변경처리한다.
  		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/photoGallery/"));

  		vo.setPhotoCount(vo.getContent().split("<img ").length - 1);
  		
  		//<p><img src="/javaclassS6/data/photoGallery/240716153428_flower.png" style="height:503px; width:512px" /></p>
  		//01234567890123456789012345678901234567890123456789
  		String temp = vo.getContent().substring(44);
  		temp = temp.substring(0,temp.indexOf("\""));
  		// 3. 썸네일 추출
  		vo.setThumbnail(photoGalleryService.setThumbnail(temp));
  		
  		// 3.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
  		int res = photoGalleryService.setPhotoGalleryInput(vo);
  		
  		if(res != 0) return "redirect:/message/photoGalleryInputOk";
  		else  return "redirect:/message/photoGalleryInputNo";
  	}
    
    @RequestMapping(value = "/photoGallerContent", method = RequestMethod.GET)
    public String photoGalleryContent(
        @RequestParam(name = "idx", defaultValue = "0") int photoIdx,
        PhotoGalleryVO vo,
        HttpSession session,
        Model model) {
    // 게시글 조회수 1씩 증가시키기(중복방지)
    ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
    if (contentReadNum == null) {
        contentReadNum = new ArrayList<>();
    }
    String imsiContentReadNum = "photoGallery" + photoIdx;
    if (!contentReadNum.contains(imsiContentReadNum)) {
        photoGalleryService.setPhotoGalleryReadNumPlus(photoIdx);
        contentReadNum.add(imsiContentReadNum);
    }
    session.setAttribute("sContentIdx", contentReadNum);

    // 조회자료 1건 담아서 내용보기로 보낼 준비
    vo = photoGalleryService.getPhotoGalleryIdxSearch(photoIdx);
    model.addAttribute("vo", vo);

    // 댓글 처리
    ArrayList<PhotoGalleryVO> replyVos = photoGalleryService.getPhotoGalleryReply(photoIdx);
    model.addAttribute("replyVos", replyVos);

    // 세션에서 필요한 정보 가져오기
    String sMid = (String) session.getAttribute("sMid");
    String sNickName = (String) session.getAttribute("sNickName");
    int sLevel = (int) session.getAttribute("sLevel");

    model.addAttribute("sMid", sMid);
    model.addAttribute("sNickName", sNickName);
    model.addAttribute("sLevel", sLevel);
    return "photoGallery/photoGallerContent";
}
    @ResponseBody
    @RequestMapping(value = "/photoGalleryGoodCheck", method = RequestMethod.POST)
    public String photoGalleryGoodCheckPost(int idx, HttpSession session) {
        // 현재 로그인한 사용자의 ID를 세션에서 가져옵니다.
        String sMid = (String) session.getAttribute("sMid");
        
        if (sMid == null) {
            return "0"; // 로그인되지 않은 경우
        }
        
        // 이미 좋아요를 눌렀는지 확인
        boolean alreadyLiked = photoGalleryService.checkIfAlreadyLiked(idx, sMid);
        
        if (alreadyLiked) {
            // 이미 좋아요를 눌렀다면 좋아요 취소
            boolean cancelSuccess = photoGalleryService.cancelGood(idx, sMid);
            if (cancelSuccess) {
                return "2"; // 좋아요 취소 성공
            } else {
                return "0"; // 좋아요 취소 실패
            }
        } else {
            // 좋아요를 누르지 않았다면 좋아요 추가
            boolean addSuccess = photoGalleryService.addGood(idx, sMid);
            if (addSuccess) {
                return "1"; // 좋아요 추가 성공
            } else {
                return "0"; // 좋아요 추가 실패
            }
        }
    }
    	
}
