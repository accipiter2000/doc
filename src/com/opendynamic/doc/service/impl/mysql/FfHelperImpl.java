package com.opendynamic.doc.service.impl.mysql;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdConfig;
import com.opendynamic.OdUtils;
import com.opendynamic.ff.service.FfHelper;
import com.opendynamic.ff.service.FfService;
import com.opendynamic.om.service.OmService;
import com.opendynamic.om.vo.PosiEmp;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)

public class FfHelperImpl implements FfHelper {
    @Autowired
    private OmService omService;

    @Override
    public String getUserName(String userId) {
        if (userId.equals(FfService.USER_FF_SYSTEM)) {
            return "系统";
        }

        PosiEmp posiEmp = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setPosiEmpId(userId).queryForObject();
        if (posiEmp != null) {
            return posiEmp.getEmpName();
        }

        return null;
    }

    @Override
    public List<String> getAllUserIdList(String userId) {
        PosiEmp posiEmp = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setPosiEmpId(userId).queryForObject();
        if (posiEmp != null) {
            List<PosiEmp> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setEmpId(posiEmp.getEmpId()).queryForObjectList();
            return OdUtils.collectFromBean(posiEmpList, "posiEmpId", String.class);
        }

        return Arrays.asList(userId);
    }
}
