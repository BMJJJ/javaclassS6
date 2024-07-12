package com.spring.javaclassS6.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS6.dao.MapandWeatherDAO;
import com.spring.javaclassS6.vo.KakaoAddressVO;

@Service
public class MapandWeatherServiceImpl implements MapandWeatherService {

	@Autowired
	MapandWeatherDAO mapandweatherDAO;

	@Override
	public KakaoAddressVO getKakaoAddressSearch(String address) {
		return mapandweatherDAO.getKakaoAddressSearch(address);
	}

	@Override
	public void setKakaoAddressInput(KakaoAddressVO vo) {
		mapandweatherDAO.setKakaoAddressInput(vo);
	}
}
