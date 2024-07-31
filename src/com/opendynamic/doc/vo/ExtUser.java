package com.opendynamic.doc.vo;

import com.opendynamic.ff.vo.FfUser;
import com.opendynamic.om.vo.PosiEmp;

public class ExtUser extends FfUser {
    private static final long serialVersionUID = 1L;

    public ExtUser() {
        super();
    }

    public ExtUser(PosiEmp posiEmp) {
        super();

        super.setId(posiEmp.getPosiEmpId());
        super.setUserId(posiEmp.getEmpId());
        super.setUserCode(posiEmp.getEmpCode());
        super.setUserName(posiEmp.getEmpName());
        super.setRoleId(posiEmp.getPosiId());
        super.setRoleCode(posiEmp.getPosiCode());
        super.setRoleName(posiEmp.getPosiName());
        super.setOrgId(posiEmp.getOrgId());
        super.setOrgCode(posiEmp.getOrgCode());
        super.setOrgName(posiEmp.getOrgName());
    }
}
