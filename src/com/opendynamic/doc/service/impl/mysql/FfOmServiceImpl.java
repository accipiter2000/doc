package com.opendynamic.doc.service.impl.mysql;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.OdConfig;
import com.opendynamic.doc.service.FfOmService;
import com.opendynamic.doc.vo.ExtUser;
import com.opendynamic.ff.vo.FfUser;
import com.opendynamic.om.service.OmService;
import com.opendynamic.om.vo.Org;
import com.opendynamic.om.vo.PosiEmp;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class FfOmServiceImpl implements FfOmService {
    @Autowired
    private OmService omService;

    @Override
    public List<FfUser> loadPosiEmp(String posiEmpId) {
        PosiEmp posiEmp = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setPosiEmpId(posiEmpId).queryForObject();
        List<FfUser> userList = new ArrayList<>();
        userList.add(new ExtUser(posiEmp));

        return userList;
    }

    @Override
    public List<FfUser> selectPosiEmp(String withinOrgId, String dutyCode, String posiCode, String posiEmpTag) {
        List<String> dutyCodeList = new ArrayList<>();
        if (StringUtils.isNotEmpty(dutyCode)) {
            dutyCodeList.addAll(Arrays.asList(dutyCode.split(",")));
        }
        List<String> posiCodeList = new ArrayList<>();
        if (StringUtils.isNotEmpty(posiCode)) {
            posiCodeList.addAll(Arrays.asList(posiCode.split(",")));
        }

        List<PosiEmp> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setWithinOrgId(withinOrgId).setDutyCodeList(dutyCodeList).setPosiCodeList(posiCodeList).setPosiEmpTag(posiEmpTag).queryForObjectList();

        List<FfUser> userList = new ArrayList<>();
        for (PosiEmp posiEmp : posiEmpList) {
            userList.add(new ExtUser(posiEmp));
        }

        return userList;
    }

    @Override
    public List<FfUser> selectOrgLeader(String orgId, String orgLeaderTypeLists) {
        List<String> orgLeaderTypeList = new ArrayList<>();
        if (StringUtils.isEmpty(orgLeaderTypeLists)) {
            orgLeaderTypeList.add("1");
        }
        else {
            orgLeaderTypeList.addAll(Arrays.asList(orgLeaderTypeLists.split(",")));
        }
        List<PosiEmp> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId(orgId).setOrgLeaderTypeList(orgLeaderTypeList).queryForObjectList();

        List<FfUser> userList = new ArrayList<>();
        for (PosiEmp posiEmp : posiEmpList) {
            userList.add(new ExtUser(posiEmp));
        }

        return userList;
    }

    @Override
    public List<Org> selectOrg(String withinOrgId, String orgCode, String orgName, String orgTag) {
        return omService.createOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setWithinOrgId(withinOrgId).setOrgCode(orgCode).setOrgName(orgName).setOrgTag(orgTag).queryForObjectList();
    }
}