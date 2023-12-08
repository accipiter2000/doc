package com.opendynamic.om.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.om.service.OmServerService;
import com.opendynamic.om.vo.OrgnChange;

@Controller
public class OmServerController extends OdController {
    @Autowired
    private OmServerService omServerService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmServerPushOrgnSetSync")
    public String manageOmServerPushOrgnSetSync(Map<String, Object> operator) {
        return "om/Server/manageServerPushOrgnSetSync";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "pushCopyOmMirrorServerOrgnSet")
    @ResponseBody
    public Map<String, Object> pushCopyOmMirrorServerOrgnSet(String MIRROR_SERVER_ID_, String ORGN_SET_ID_, Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omServerService.pushCopyMirrorServerOrgnSet(MIRROR_SERVER_ID_, ORGN_SET_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "pushCompareOmMirrorServerOrgnSet")
    @ResponseBody
    public Map<String, Object> pushCompareOmMirrorServerOrgnSet(String MIRROR_SERVER_ID_, String ORGN_SET_ID_, Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        OrgnChange orgnChange = omServerService.pushCompareMirrorServerOrgnSet(MIRROR_SERVER_ID_, ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgnChange", orgnChange);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "pushReplaceOmMirrorServerOrgnSet")
    @ResponseBody
    public Map<String, Object> pushReplaceOmMirrorServerOrgnSet(String MIRROR_SERVER_ID_, String ORGN_SET_ID_, @RequestParam(value = "INSERT_ORG_ID_LIST", required = false) List<String> INSERT_ORG_ID_LIST, @RequestParam(value = "UPDATE_ORG_ID_LIST", required = false) List<String> UPDATE_ORG_ID_LIST, @RequestParam(value = "DELETE_ORG_ID_LIST", required = false) List<String> DELETE_ORG_ID_LIST, @RequestParam(value = "INSERT_DUTY_ID_LIST", required = false) List<String> INSERT_DUTY_ID_LIST, @RequestParam(value = "UPDATE_DUTY_ID_LIST", required = false) List<String> UPDATE_DUTY_ID_LIST, @RequestParam(value = "DELETE_DUTY_ID_LIST", required = false) List<String> DELETE_DUTY_ID_LIST, @RequestParam(value = "INSERT_POSI_ID_LIST", required = false) List<String> INSERT_POSI_ID_LIST,
            @RequestParam(value = "UPDATE_POSI_ID_LIST", required = false) List<String> UPDATE_POSI_ID_LIST, @RequestParam(value = "DELETE_POSI_ID_LIST", required = false) List<String> DELETE_POSI_ID_LIST, @RequestParam(value = "INSERT_EMP_ID_LIST", required = false) List<String> INSERT_EMP_ID_LIST, @RequestParam(value = "UPDATE_EMP_ID_LIST", required = false) List<String> UPDATE_EMP_ID_LIST, @RequestParam(value = "DELETE_EMP_ID_LIST", required = false) List<String> DELETE_EMP_ID_LIST, @RequestParam(value = "INSERT_POSI_EMP_ID_LIST", required = false) List<String> INSERT_POSI_EMP_ID_LIST, @RequestParam(value = "UPDATE_POSI_EMP_ID_LIST", required = false) List<String> UPDATE_POSI_EMP_ID_LIST,
            @RequestParam(value = "DELETE_POSI_EMP_ID_LIST", required = false) List<String> DELETE_POSI_EMP_ID_LIST, @RequestParam(value = "INSERT_EMP_RELATION_ID_LIST", required = false) List<String> INSERT_EMP_RELATION_ID_LIST, @RequestParam(value = "UPDATE_EMP_RELATION_ID_LIST", required = false) List<String> UPDATE_EMP_RELATION_ID_LIST, @RequestParam(value = "DELETE_EMP_RELATION_ID_LIST", required = false) List<String> DELETE_EMP_RELATION_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omServerService.pushReplaceMirrorServerOrgnSet(MIRROR_SERVER_ID_, ORGN_SET_ID_, INSERT_ORG_ID_LIST, UPDATE_ORG_ID_LIST, DELETE_ORG_ID_LIST, INSERT_DUTY_ID_LIST, UPDATE_DUTY_ID_LIST, DELETE_DUTY_ID_LIST, INSERT_POSI_ID_LIST, UPDATE_POSI_ID_LIST, DELETE_POSI_ID_LIST, INSERT_EMP_ID_LIST, UPDATE_EMP_ID_LIST, DELETE_EMP_ID_LIST, INSERT_POSI_EMP_ID_LIST, UPDATE_POSI_EMP_ID_LIST, DELETE_POSI_EMP_ID_LIST, INSERT_EMP_RELATION_ID_LIST, UPDATE_EMP_RELATION_ID_LIST, DELETE_EMP_RELATION_ID_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmMirrorServerOrgnSet")
    @ResponseBody
    public Map<String, Object> selectOmMirrorServerOrgnSet(String MIRROR_SERVER_ID_, String ORGN_SET_ID_, String PARENT_ORGN_SET_ID_, String ORGN_SET_CODE_, String ORGN_SET_NAME_, @RequestParam(value = "ORGN_SET_STATUS_LIST", required = false) List<String> ORGN_SET_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> mirrorServerOrgnSetList = omServerService.selectMirrorServerOrgnSet(MIRROR_SERVER_ID_, ORGN_SET_ID_, PARENT_ORGN_SET_ID_, ORGN_SET_CODE_, ORGN_SET_NAME_, ORGN_SET_STATUS_LIST, rootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omServerService.countMirrorServerOrgnSet(MIRROR_SERVER_ID_, ORGN_SET_ID_, PARENT_ORGN_SET_ID_, ORGN_SET_CODE_, ORGN_SET_NAME_, ORGN_SET_STATUS_LIST, rootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }
        List<Map<String, Object>> mirrorServerOrgnSetListClone = (List<Map<String, Object>>) OdUtils.deepClone(mirrorServerOrgnSetList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> mirrorServerOrgnSetIdList = OdUtils.collect(mirrorServerOrgnSetList, "ORGN_SET_ID_", String.class);
        Map<String, Object> mirrorServerOrgnSet;
        for (int i = 0; i < mirrorServerOrgnSetListClone.size(); i++) {
            mirrorServerOrgnSet = mirrorServerOrgnSetListClone.get(i);
            if (mirrorServerOrgnSet.get("PARENT_ORGN_SET_ID_") == null || mirrorServerOrgnSet.get("PARENT_ORGN_SET_ID_").equals("") || !mirrorServerOrgnSetIdList.contains(mirrorServerOrgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(mirrorServerOrgnSet);
                fillChildMirrorServerOrgnSet(mirrorServerOrgnSet, mirrorServerOrgnSetListClone);
            }
        }

        result.put("mirrorServerOrgnSetList", mirrorServerOrgnSetList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildMirrorServerOrgnSet(Map<String, Object> mirrorServerOrgnSet, List<Map<String, Object>> mirrorServerOrgnSetList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childMirrorServerOrgnSet;
        for (int i = 0; i < mirrorServerOrgnSetList.size(); i++) {
            childMirrorServerOrgnSet = mirrorServerOrgnSetList.get(i);
            if (mirrorServerOrgnSet.get("ORGN_SET_ID_").equals(childMirrorServerOrgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(childMirrorServerOrgnSet);
                fillChildMirrorServerOrgnSet(childMirrorServerOrgnSet, mirrorServerOrgnSetList);
            }
        }
        mirrorServerOrgnSet.put("children", children);
    }
}