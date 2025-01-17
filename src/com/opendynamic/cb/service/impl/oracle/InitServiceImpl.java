package com.opendynamic.cb.service.impl.oracle;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.opendynamic.cb.service.InitService;
import com.opendynamic.doc.service.DocService;
import com.opendynamic.doc.service.FfOmService;
import com.opendynamic.ff.service.FfHelper;
import com.opendynamic.ff.service.FfService;

@Service
public class InitServiceImpl implements InitService {
    @Autowired
    private FfService ffService;
    @Autowired
    private FfHelper ffHelper;
    @Autowired
    private FfOmService ffOmService;
    @Autowired
    private DocService docService;

    @PostConstruct
    public void initFfServiceExternalService() {
        ffService.addExternalService("ffHelper", ffHelper);
        ffService.addExternalService("ffOmService", ffOmService);
        ffService.addExternalService("docService", docService);
    }

    @PostConstruct
    public void initAsposeLicense() {
        // InputStream is = this.getClass().getResourceAsStream("/Aspose.Total.Java.lic"); // license.xml应放在..\WebRoot\WEB-INF\classes路径下
        // License aposeLic = new License();
        // aposeLic.setLicense(is);
        // is.close();
    }
}
