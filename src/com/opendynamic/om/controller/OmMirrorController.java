package com.opendynamic.om.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.om.service.OmMirrorService;
import com.opendynamic.om.vo.OrgnChange;

@Controller
public class OmMirrorController extends OdController {
    @Autowired
    private OmMirrorService omMirrorService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmMirrorPullOrgnSetSync")
    public String manageOmMirrorPullOrgnSetSync(Map<String, Object> operator) {
        return "om/Mirror/manageMirrorPullOrgnSetSync";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "pullCopyOmMainServerOrgnSet")
    @ResponseBody
    public Map<String, Object> pullCopyOmMainServerOrgnSet(Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omMirrorService.pullCopyMainServerOrgnSet(OdConfig.getOrgnSetId(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "pullCompareOmMainServerOrgnSet")
    @ResponseBody
    public Map<String, Object> pullCompareOmMainServerOrgnSet(Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        OrgnChange orgnChange = omMirrorService.pullCompareMainServerOrgnSet(OdConfig.getOrgnSetId(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgnChange", orgnChange);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "pullReplaceOmMainServerOrgnSet")
    @ResponseBody
    public Map<String, Object> pullReplaceOmMainServerOrgnSet(@RequestParam(value = "INSERT_ORG_ID_LIST", required = false) List<String> INSERT_ORG_ID_LIST, @RequestParam(value = "UPDATE_ORG_ID_LIST", required = false) List<String> UPDATE_ORG_ID_LIST, @RequestParam(value = "DELETE_ORG_ID_LIST", required = false) List<String> DELETE_ORG_ID_LIST, @RequestParam(value = "INSERT_DUTY_ID_LIST", required = false) List<String> INSERT_DUTY_ID_LIST, @RequestParam(value = "UPDATE_DUTY_ID_LIST", required = false) List<String> UPDATE_DUTY_ID_LIST, @RequestParam(value = "DELETE_DUTY_ID_LIST", required = false) List<String> DELETE_DUTY_ID_LIST, @RequestParam(value = "INSERT_POSI_ID_LIST", required = false) List<String> INSERT_POSI_ID_LIST,
            @RequestParam(value = "UPDATE_POSI_ID_LIST", required = false) List<String> UPDATE_POSI_ID_LIST, @RequestParam(value = "DELETE_POSI_ID_LIST", required = false) List<String> DELETE_POSI_ID_LIST, @RequestParam(value = "INSERT_EMP_ID_LIST", required = false) List<String> INSERT_EMP_ID_LIST, @RequestParam(value = "UPDATE_EMP_ID_LIST", required = false) List<String> UPDATE_EMP_ID_LIST, @RequestParam(value = "DELETE_EMP_ID_LIST", required = false) List<String> DELETE_EMP_ID_LIST, @RequestParam(value = "INSERT_POSI_EMP_ID_LIST", required = false) List<String> INSERT_POSI_EMP_ID_LIST, @RequestParam(value = "UPDATE_POSI_EMP_ID_LIST", required = false) List<String> UPDATE_POSI_EMP_ID_LIST,
            @RequestParam(value = "DELETE_POSI_EMP_ID_LIST", required = false) List<String> DELETE_POSI_EMP_ID_LIST, @RequestParam(value = "INSERT_EMP_RELATION_ID_LIST", required = false) List<String> INSERT_EMP_RELATION_ID_LIST, @RequestParam(value = "UPDATE_EMP_RELATION_ID_LIST", required = false) List<String> UPDATE_EMP_RELATION_ID_LIST, @RequestParam(value = "DELETE_EMP_RELATION_ID_LIST", required = false) List<String> DELETE_EMP_RELATION_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omMirrorService.pullReplaceMainServerOrgnSet(OdConfig.getOrgnSetId(), INSERT_ORG_ID_LIST, UPDATE_ORG_ID_LIST, DELETE_ORG_ID_LIST, INSERT_DUTY_ID_LIST, UPDATE_DUTY_ID_LIST, DELETE_DUTY_ID_LIST, INSERT_POSI_ID_LIST, UPDATE_POSI_ID_LIST, DELETE_POSI_ID_LIST, INSERT_EMP_ID_LIST, UPDATE_EMP_ID_LIST, DELETE_EMP_ID_LIST, INSERT_POSI_EMP_ID_LIST, UPDATE_POSI_EMP_ID_LIST, DELETE_POSI_EMP_ID_LIST, INSERT_EMP_RELATION_ID_LIST, UPDATE_EMP_RELATION_ID_LIST, DELETE_EMP_RELATION_ID_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}