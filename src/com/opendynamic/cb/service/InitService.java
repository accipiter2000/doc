package com.opendynamic.cb.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface InitService {
    public void initFfServiceExternalService();

    /**
     * 初始化aspose license。
     */
    public void initAsposeLicense();
}