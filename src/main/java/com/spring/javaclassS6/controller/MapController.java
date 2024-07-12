package com.spring.javaclassS6.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS6.service.MapandWeatherService;
import com.spring.javaclassS6.vo.KakaoAddressVO;

@Controller
@RequestMapping("mapandweather")
public class MapController {

	@Autowired
	MapandWeatherService mapandweatherService;
	
	@RequestMapping(value = "/mapandweather1", method = RequestMethod.GET)
		public String mapandweather1(Model model,
				@RequestParam(name="address", defaultValue = "", required = false) String address
				) {
		
			KakaoAddressVO vo = new KakaoAddressVO();
		
			List<KakaoAddressVO> addressVos = mapandweatherService.getKakaoAddressList();
			vo = mapandweatherService.getKakaoAddressSearch(address);
				model.addAttribute("address", address);
				model.addAttribute("addressVos", addressVos);
				model.addAttribute("vo", vo);
		return "mapandweather/mapandweather1";
	}
	
	@RequestMapping(value = "/mapPlus", method = RequestMethod.GET)
	public String MapPlusGet(Model model,
			@RequestParam(name="address", defaultValue = "", required = false) String address
		) {
		model.addAttribute("address", address);
		return "mapandweather/mapPlus";
	}
	
//카카오맵 마커표시/저장 처리
	@ResponseBody
	@RequestMapping(value = "/mapPlus", method = RequestMethod.POST)
	public String mapPlusPost(KakaoAddressVO vo) {
		KakaoAddressVO searchVO = mapandweatherService.getKakaoAddressSearch(vo.getAddress());
		if(searchVO != null) return "0";
		mapandweatherService.setKakaoAddressInput(vo);
		
		return "1";
	}
}
