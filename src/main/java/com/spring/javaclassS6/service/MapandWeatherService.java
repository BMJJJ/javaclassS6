package com.spring.javaclassS6.service;

import java.util.List;

import com.spring.javaclassS6.vo.KakaoAddressVO;

public interface MapandWeatherService{

	public KakaoAddressVO getKakaoAddressSearch(String address);

	public void setKakaoAddressInput(KakaoAddressVO vo);

	public List<KakaoAddressVO> getKakaoAddressList();

}
