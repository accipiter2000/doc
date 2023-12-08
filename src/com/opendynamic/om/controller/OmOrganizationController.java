package com.opendynamic.om.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;

@Controller
public class OmOrganizationController extends OdController {
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmOrganization")
    public String manageOmOrganization() {
        return "om/Organization/manageOrganization";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmOrgOrganization")
    public String manageOmOrgOrganization() {
        return "om/Organization/manageOrgOrganization";
    }
}