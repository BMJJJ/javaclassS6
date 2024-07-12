package com.spring.javaclassS6.service;

import com.spring.javaclassS6.vo.KakaoAddressVO;

public interface MapandWeatherService{

	KakaoAddressVO getKakaoAddressSearch(String address);

	void setKakaoAddressInput(KakaoAddressVO vo);

}
