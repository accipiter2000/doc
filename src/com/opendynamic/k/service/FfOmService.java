package com.opendynamic.k.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opendynamic.ff.vo.FfUser;
import com.opendynamic.om.vo.Org;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface FfOmService {
    public List<FfUser> loadPosiEmp(String posiEmpId);

    /**
     * 查询岗位人员
     * 
     * @param withinOrgId
     *        在指定的机构范围内查询
     * @param dutyCode
     *        职务编码
     * @param posiCode
     *        岗位编码
     * @param posiEmpTag
     *        岗位人员标签
     * @return
     */
    public List<FfUser> selectPosiEmp(String withinOrgId, String dutyCode, String posiCode, String posiEmpTag);

    /**
     * 查询部门领导
     * 
     * @param orgId
     * @param orgLeaderTypeLists
     *        机构职级.为逗号分割的字符串，默认值为1
     * @return
     */
    public List<FfUser> selectOrgLeader(String orgId, String orgLeaderTypeLists);

    /**
     * 查询部门
     * 
     * @param withinOrgId
     * @param orgCode
     * @param orgName
     * @param orgTag
     * @return
     */
    public List<Org> selectOrg(String withinOrgId, String orgCode, String orgName, String orgTag);
}