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
import com.opendynamic.om.service.OmPosiEmpService;

@Controller
public class OmPosiEmpController extends OdController {
    @Autowired
    private OmPosiEmpService omPosiEmpService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmPosiEmp")
    public String manageOmPosiEmp(Map<String, Object> operator) {
        return "om/PosiEmp/managePosiEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmEmpPosi")
    public String manageOmEmpPosi(Map<String, Object> operator) {
        return "om/PosiEmp/manageEmpPosi";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmPosiEmp")
    public String preChooseOmPosiEmp(Map<String, Object> operator) {
        return "om/PosiEmp/preChoosePosiEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "loadOmPosiEmp")
    @ResponseBody
    public Map<String, Object> loadOmPosiEmp(String POSI_EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> posiEmp = omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("posiEmp", posiEmp);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmPosiEmp")
    @ResponseBody
    public Map<String, Object> selectOmPosiEmp(String POSI_EMP_ID_, @RequestParam(value = "POSI_EMP_ID_LIST", required = false) List<String> POSI_EMP_ID_LIST, String MAIN_, @RequestParam(value = "MAIN_LIST", required = false) List<String> MAIN_LIST, String POSI_EMP_CATEGORY_, @RequestParam(value = "POSI_EMP_CATEGORY_LIST", required = false) List<String> POSI_EMP_CATEGORY_LIST, String POSI_EMP_TAG_, String POSI_EMP_EXT_ATTR_1_, @RequestParam(value = "POSI_EMP_EXT_ATTR_1_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_1_LIST, String POSI_EMP_EXT_ATTR_2_, @RequestParam(value = "POSI_EMP_EXT_ATTR_2_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_2_LIST, String POSI_EMP_EXT_ATTR_3_,
            @RequestParam(value = "POSI_EMP_EXT_ATTR_3_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_3_LIST, String POSI_EMP_EXT_ATTR_4_, @RequestParam(value = "POSI_EMP_EXT_ATTR_4_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_4_LIST, String POSI_EMP_EXT_ATTR_5_, @RequestParam(value = "POSI_EMP_EXT_ATTR_5_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_5_LIST, String POSI_EMP_EXT_ATTR_6_, @RequestParam(value = "POSI_EMP_EXT_ATTR_6_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_6_LIST, String POSI_EMP_EXT_ATTR_7_, @RequestParam(value = "POSI_EMP_EXT_ATTR_7_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_7_LIST, String POSI_EMP_EXT_ATTR_8_, @RequestParam(value = "POSI_EMP_EXT_ATTR_8_LIST", required = false) List<String> POSI_EMP_EXT_ATTR_8_LIST,
            String POSI_EMP_STATUS_, @RequestParam(value = "POSI_EMP_STATUS_LIST", required = false) List<String> POSI_EMP_STATUS_LIST, String EMP_ID_, @RequestParam(value = "EMP_ID_LIST", required = false) List<String> EMP_ID_LIST, String EMP_CODE_, @RequestParam(value = "EMP_CODE_LIST", required = false) List<String> EMP_CODE_LIST, String EMP_NAME_, @RequestParam(value = "EMP_NAME_LIST", required = false) List<String> EMP_NAME_LIST, String EMP_CATEGORY_, @RequestParam(value = "EMP_CATEGORY_LIST", required = false) List<String> EMP_CATEGORY_LIST, String EMP_TAG_, String EMP_EXT_ATTR_1_, @RequestParam(value = "EMP_EXT_ATTR_1_LIST", required = false) List<String> EMP_EXT_ATTR_1_LIST, String EMP_EXT_ATTR_2_,
            @RequestParam(value = "EMP_EXT_ATTR_2_LIST", required = false) List<String> EMP_EXT_ATTR_2_LIST, String EMP_EXT_ATTR_3_, @RequestParam(value = "EMP_EXT_ATTR_3_LIST", required = false) List<String> EMP_EXT_ATTR_3_LIST, String EMP_EXT_ATTR_4_, @RequestParam(value = "EMP_EXT_ATTR_4_LIST", required = false) List<String> EMP_EXT_ATTR_4_LIST, String EMP_EXT_ATTR_5_, @RequestParam(value = "EMP_EXT_ATTR_5_LIST", required = false) List<String> EMP_EXT_ATTR_5_LIST, String EMP_EXT_ATTR_6_, @RequestParam(value = "EMP_EXT_ATTR_6_LIST", required = false) List<String> EMP_EXT_ATTR_6_LIST, String EMP_EXT_ATTR_7_, @RequestParam(value = "EMP_EXT_ATTR_7_LIST", required = false) List<String> EMP_EXT_ATTR_7_LIST, String EMP_EXT_ATTR_8_,
            @RequestParam(value = "EMP_EXT_ATTR_8_LIST", required = false) List<String> EMP_EXT_ATTR_8_LIST, String EMP_STATUS_, @RequestParam(value = "EMP_STATUS_LIST", required = false) List<String> EMP_STATUS_LIST, String POSI_ID_, @RequestParam(value = "POSI_ID_LIST", required = false) List<String> POSI_ID_LIST, String POSI_CODE_, @RequestParam(value = "POSI_CODE_LIST", required = false) List<String> POSI_CODE_LIST, String POSI_NAME_, @RequestParam(value = "POSI_NAME_LIST", required = false) List<String> POSI_NAME_LIST, String ORG_LEADER_TYPE_, @RequestParam(value = "ORG_LEADER_TYPE_LIST", required = false) List<String> ORG_LEADER_TYPE_LIST, String POSI_CATEGORY_, @RequestParam(value = "POSI_CATEGORY_LIST", required = false) List<String> POSI_CATEGORY_LIST, String POSI_TAG_,
            String POSI_EXT_ATTR_1_, @RequestParam(value = "POSI_EXT_ATTR_1_LIST", required = false) List<String> POSI_EXT_ATTR_1_LIST, String POSI_EXT_ATTR_2_, @RequestParam(value = "POSI_EXT_ATTR_2_LIST", required = false) List<String> POSI_EXT_ATTR_2_LIST, String POSI_EXT_ATTR_3_, @RequestParam(value = "POSI_EXT_ATTR_3_LIST", required = false) List<String> POSI_EXT_ATTR_3_LIST, String POSI_EXT_ATTR_4_, @RequestParam(value = "POSI_EXT_ATTR_4_LIST", required = false) List<String> POSI_EXT_ATTR_4_LIST, String POSI_EXT_ATTR_5_, @RequestParam(value = "POSI_EXT_ATTR_5_LIST", required = false) List<String> POSI_EXT_ATTR_5_LIST, String POSI_EXT_ATTR_6_, @RequestParam(value = "POSI_EXT_ATTR_6_LIST", required = false) List<String> POSI_EXT_ATTR_6_LIST, String POSI_EXT_ATTR_7_,
            @RequestParam(value = "POSI_EXT_ATTR_7_LIST", required = false) List<String> POSI_EXT_ATTR_7_LIST, String POSI_EXT_ATTR_8_, @RequestParam(value = "POSI_EXT_ATTR_8_LIST", required = false) List<String> POSI_EXT_ATTR_8_LIST, String POSI_STATUS_, @RequestParam(value = "POSI_STATUS_LIST", required = false) List<String> POSI_STATUS_LIST, String DUTY_ID_, @RequestParam(value = "DUTY_ID_LIST", required = false) List<String> DUTY_ID_LIST, String DUTY_CODE_, @RequestParam(value = "DUTY_CODE_LIST", required = false) List<String> DUTY_CODE_LIST, String DUTY_NAME_, @RequestParam(value = "DUTY_NAME_LIST", required = false) List<String> DUTY_NAME_LIST, String DUTY_CATEGORY_, @RequestParam(value = "DUTY_CATEGORY_LIST", required = false) List<String> DUTY_CATEGORY_LIST, String DUTY_TAG_,
            String DUTY_EXT_ATTR_1_, @RequestParam(value = "DUTY_EXT_ATTR_1_LIST", required = false) List<String> DUTY_EXT_ATTR_1_LIST, String DUTY_EXT_ATTR_2_, @RequestParam(value = "DUTY_EXT_ATTR_2_LIST", required = false) List<String> DUTY_EXT_ATTR_2_LIST, String DUTY_EXT_ATTR_3_, @RequestParam(value = "DUTY_EXT_ATTR_3_LIST", required = false) List<String> DUTY_EXT_ATTR_3_LIST, String DUTY_EXT_ATTR_4_, @RequestParam(value = "DUTY_EXT_ATTR_4_LIST", required = false) List<String> DUTY_EXT_ATTR_4_LIST, String DUTY_EXT_ATTR_5_, @RequestParam(value = "DUTY_EXT_ATTR_5_LIST", required = false) List<String> DUTY_EXT_ATTR_5_LIST, String DUTY_EXT_ATTR_6_, @RequestParam(value = "DUTY_EXT_ATTR_6_LIST", required = false) List<String> DUTY_EXT_ATTR_6_LIST, String DUTY_EXT_ATTR_7_,
            @RequestParam(value = "DUTY_EXT_ATTR_7_LIST", required = false) List<String> DUTY_EXT_ATTR_7_LIST, String DUTY_EXT_ATTR_8_, @RequestParam(value = "DUTY_EXT_ATTR_8_LIST", required = false) List<String> DUTY_EXT_ATTR_8_LIST, String DUTY_STATUS_, @RequestParam(value = "DUTY_STATUS_LIST", required = false) List<String> DUTY_STATUS_LIST, String ORG_ID_, @RequestParam(value = "ORG_ID_LIST", required = false) List<String> ORG_ID_LIST, String PARENT_ORG_ID_, @RequestParam(value = "PARENT_ORG_ID_LIST", required = false) List<String> PARENT_ORG_ID_LIST, String ORG_CODE_, @RequestParam(value = "ORG_CODE_LIST", required = false) List<String> ORG_CODE_LIST, String ORG_NAME_, @RequestParam(value = "ORG_NAME_LIST", required = false) List<String> ORG_NAME_LIST, String ORG_TYPE_,
            @RequestParam(value = "ORG_TYPE_LIST", required = false) List<String> ORG_TYPE_LIST, String ORG_CATEGORY_, @RequestParam(value = "ORG_CATEGORY_LIST", required = false) List<String> ORG_CATEGORY_LIST, String ORG_TAG_, String ORG_EXT_ATTR_1_, @RequestParam(value = "ORG_EXT_ATTR_1_LIST", required = false) List<String> ORG_EXT_ATTR_1_LIST, String ORG_EXT_ATTR_2_, @RequestParam(value = "ORG_EXT_ATTR_2_LIST", required = false) List<String> ORG_EXT_ATTR_2_LIST, String ORG_EXT_ATTR_3_, @RequestParam(value = "ORG_EXT_ATTR_3_LIST", required = false) List<String> ORG_EXT_ATTR_3_LIST, String ORG_EXT_ATTR_4_, @RequestParam(value = "ORG_EXT_ATTR_4_LIST", required = false) List<String> ORG_EXT_ATTR_4_LIST, String ORG_EXT_ATTR_5_,
            @RequestParam(value = "ORG_EXT_ATTR_5_LIST", required = false) List<String> ORG_EXT_ATTR_5_LIST, String ORG_EXT_ATTR_6_, @RequestParam(value = "ORG_EXT_ATTR_6_LIST", required = false) List<String> ORG_EXT_ATTR_6_LIST, String ORG_EXT_ATTR_7_, @RequestParam(value = "ORG_EXT_ATTR_7_LIST", required = false) List<String> ORG_EXT_ATTR_7_LIST, String ORG_EXT_ATTR_8_, @RequestParam(value = "ORG_EXT_ATTR_8_LIST", required = false) List<String> ORG_EXT_ATTR_8_LIST, String ORG_STATUS_, @RequestParam(value = "ORG_STATUS_LIST", required = false) List<String> ORG_STATUS_LIST, Boolean posiEmpTagUnion, Boolean empTagUnion, Boolean posiTagUnion, Boolean dutyTagUnion, Boolean orgTagUnion, String withinOrgId, Boolean orgRootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> posiEmpList = omPosiEmpService.selectPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, POSI_EMP_ID_LIST, MAIN_, MAIN_LIST, POSI_EMP_CATEGORY_, POSI_EMP_CATEGORY_LIST, POSI_EMP_TAG_, POSI_EMP_EXT_ATTR_1_, POSI_EMP_EXT_ATTR_1_LIST, POSI_EMP_EXT_ATTR_2_, POSI_EMP_EXT_ATTR_2_LIST, POSI_EMP_EXT_ATTR_3_, POSI_EMP_EXT_ATTR_3_LIST, POSI_EMP_EXT_ATTR_4_, POSI_EMP_EXT_ATTR_4_LIST, POSI_EMP_EXT_ATTR_5_, POSI_EMP_EXT_ATTR_5_LIST, POSI_EMP_EXT_ATTR_6_, POSI_EMP_EXT_ATTR_6_LIST, POSI_EMP_EXT_ATTR_7_, POSI_EMP_EXT_ATTR_7_LIST, POSI_EMP_EXT_ATTR_8_, POSI_EMP_EXT_ATTR_8_LIST, POSI_EMP_STATUS_, POSI_EMP_STATUS_LIST, EMP_ID_, EMP_ID_LIST, EMP_CODE_, EMP_CODE_LIST, EMP_NAME_, EMP_NAME_LIST, EMP_CATEGORY_, EMP_CATEGORY_LIST, EMP_TAG_, EMP_EXT_ATTR_1_, EMP_EXT_ATTR_1_LIST,
                EMP_EXT_ATTR_2_, EMP_EXT_ATTR_2_LIST, EMP_EXT_ATTR_3_, EMP_EXT_ATTR_3_LIST, EMP_EXT_ATTR_4_, EMP_EXT_ATTR_4_LIST, EMP_EXT_ATTR_5_, EMP_EXT_ATTR_5_LIST, EMP_EXT_ATTR_6_, EMP_EXT_ATTR_6_LIST, EMP_EXT_ATTR_7_, EMP_EXT_ATTR_7_LIST, EMP_EXT_ATTR_8_, EMP_EXT_ATTR_8_LIST, EMP_STATUS_, EMP_STATUS_LIST, POSI_ID_, POSI_ID_LIST, POSI_CODE_, POSI_CODE_LIST, POSI_NAME_, POSI_NAME_LIST, ORG_LEADER_TYPE_, ORG_LEADER_TYPE_LIST, POSI_CATEGORY_, POSI_CATEGORY_LIST, POSI_TAG_, POSI_EXT_ATTR_1_, POSI_EXT_ATTR_1_LIST, POSI_EXT_ATTR_2_, POSI_EXT_ATTR_2_LIST, POSI_EXT_ATTR_3_, POSI_EXT_ATTR_3_LIST, POSI_EXT_ATTR_4_, POSI_EXT_ATTR_4_LIST, POSI_EXT_ATTR_5_, POSI_EXT_ATTR_5_LIST, POSI_EXT_ATTR_6_, POSI_EXT_ATTR_6_LIST, POSI_EXT_ATTR_7_, POSI_EXT_ATTR_7_LIST, POSI_EXT_ATTR_8_, POSI_EXT_ATTR_8_LIST,
                POSI_STATUS_, POSI_STATUS_LIST, DUTY_ID_, DUTY_ID_LIST, DUTY_CODE_, DUTY_CODE_LIST, DUTY_NAME_, DUTY_NAME_LIST, DUTY_CATEGORY_, DUTY_CATEGORY_LIST, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_1_LIST, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_2_LIST, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_3_LIST, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_4_LIST, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_5_LIST, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_6_LIST, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_7_LIST, DUTY_EXT_ATTR_8_, DUTY_EXT_ATTR_8_LIST, DUTY_STATUS_, DUTY_STATUS_LIST, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_,
                ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, posiEmpTagUnion, empTagUnion, posiTagUnion, dutyTagUnion, orgTagUnion, withinOrgId, orgRootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omPosiEmpService.countPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, POSI_EMP_ID_LIST, MAIN_, MAIN_LIST, POSI_EMP_CATEGORY_, POSI_EMP_CATEGORY_LIST, POSI_EMP_TAG_, POSI_EMP_EXT_ATTR_1_, POSI_EMP_EXT_ATTR_1_LIST, POSI_EMP_EXT_ATTR_2_, POSI_EMP_EXT_ATTR_2_LIST, POSI_EMP_EXT_ATTR_3_, POSI_EMP_EXT_ATTR_3_LIST, POSI_EMP_EXT_ATTR_4_, POSI_EMP_EXT_ATTR_4_LIST, POSI_EMP_EXT_ATTR_5_, POSI_EMP_EXT_ATTR_5_LIST, POSI_EMP_EXT_ATTR_6_, POSI_EMP_EXT_ATTR_6_LIST, POSI_EMP_EXT_ATTR_7_, POSI_EMP_EXT_ATTR_7_LIST, POSI_EMP_EXT_ATTR_8_, POSI_EMP_EXT_ATTR_8_LIST, POSI_EMP_STATUS_, POSI_EMP_STATUS_LIST, EMP_ID_, EMP_ID_LIST, EMP_CODE_, EMP_CODE_LIST, EMP_NAME_, EMP_NAME_LIST, EMP_CATEGORY_, EMP_CATEGORY_LIST, EMP_TAG_, EMP_EXT_ATTR_1_, EMP_EXT_ATTR_1_LIST, EMP_EXT_ATTR_2_,
                    EMP_EXT_ATTR_2_LIST, EMP_EXT_ATTR_3_, EMP_EXT_ATTR_3_LIST, EMP_EXT_ATTR_4_, EMP_EXT_ATTR_4_LIST, EMP_EXT_ATTR_5_, EMP_EXT_ATTR_5_LIST, EMP_EXT_ATTR_6_, EMP_EXT_ATTR_6_LIST, EMP_EXT_ATTR_7_, EMP_EXT_ATTR_7_LIST, EMP_EXT_ATTR_8_, EMP_EXT_ATTR_8_LIST, EMP_STATUS_, EMP_STATUS_LIST, POSI_ID_, POSI_ID_LIST, POSI_CODE_, POSI_CODE_LIST, POSI_NAME_, POSI_NAME_LIST, ORG_LEADER_TYPE_, ORG_LEADER_TYPE_LIST, POSI_CATEGORY_, POSI_CATEGORY_LIST, POSI_TAG_, POSI_EXT_ATTR_1_, POSI_EXT_ATTR_1_LIST, POSI_EXT_ATTR_2_, POSI_EXT_ATTR_2_LIST, POSI_EXT_ATTR_3_, POSI_EXT_ATTR_3_LIST, POSI_EXT_ATTR_4_, POSI_EXT_ATTR_4_LIST, POSI_EXT_ATTR_5_, POSI_EXT_ATTR_5_LIST, POSI_EXT_ATTR_6_, POSI_EXT_ATTR_6_LIST, POSI_EXT_ATTR_7_, POSI_EXT_ATTR_7_LIST, POSI_EXT_ATTR_8_, POSI_EXT_ATTR_8_LIST, POSI_STATUS_,
                    POSI_STATUS_LIST, DUTY_ID_, DUTY_ID_LIST, DUTY_CODE_, DUTY_CODE_LIST, DUTY_NAME_, DUTY_NAME_LIST, DUTY_CATEGORY_, DUTY_CATEGORY_LIST, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_1_LIST, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_2_LIST, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_3_LIST, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_4_LIST, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_5_LIST, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_6_LIST, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_7_LIST, DUTY_EXT_ATTR_8_, DUTY_EXT_ATTR_8_LIST, DUTY_STATUS_, DUTY_STATUS_LIST, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_,
                    ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, posiEmpTagUnion, empTagUnion, posiTagUnion, dutyTagUnion, orgTagUnion, withinOrgId, orgRootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }

        result.put("posiEmpList", posiEmpList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmPosiEmpByIdList")
    @ResponseBody
    public Map<String, Object> selectOmPosiEmpByIdList(@RequestParam(value = "POSI_EMP_ID_LIST", required = false) List<String> POSI_EMP_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> posiEmpList = omPosiEmpService.selectPosiEmpByIdList(OdConfig.getOrgnSetId(), POSI_EMP_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("posiEmpList", posiEmpList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmPosiEmp")
    @ResponseBody
    public Map<String, Object> insertOmPosiEmp(String POSI_EMP_ID_, String POSI_ID_, String EMP_ID_, String MAIN_, String POSI_EMP_CATEGORY_, String MEMO_, String POSI_EMP_TAG_, String POSI_EMP_EXT_ATTR_1_, String POSI_EMP_EXT_ATTR_2_, String POSI_EMP_EXT_ATTR_3_, String POSI_EMP_EXT_ATTR_4_, String POSI_EMP_EXT_ATTR_5_, String POSI_EMP_EXT_ATTR_6_, String POSI_EMP_EXT_ATTR_7_, String POSI_EMP_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.insertPosiEmp(OdConfig.getOrgnSetId(), POSI_EMP_ID_, POSI_ID_, EMP_ID_, MAIN_, POSI_EMP_CATEGORY_, MEMO_, POSI_EMP_TAG_, POSI_EMP_EXT_ATTR_1_, POSI_EMP_EXT_ATTR_2_, POSI_EMP_EXT_ATTR_3_, POSI_EMP_EXT_ATTR_4_, POSI_EMP_EXT_ATTR_5_, POSI_EMP_EXT_ATTR_6_, POSI_EMP_EXT_ATTR_7_, POSI_EMP_EXT_ATTR_8_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posiEmp", omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "insertOmPosiEmpByEmpIdList")
    @ResponseBody
    public Map<String, Object> insertOmPosiEmpByEmpIdList(String POSI_ID_, @RequestParam(value = "EMP_ID_LIST", required = true) List<String> EMP_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.insertPosiEmpByEmpIdList(OdConfig.getOrgnSetId(), POSI_ID_, EMP_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "insertOmPosiEmpByPosiIdList")
    @ResponseBody
    public Map<String, Object> insertOmPosiEmpByPosiIdList(String EMP_ID_, @RequestParam(value = "POSI_ID_LIST", required = true) List<String> POSI_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.insertPosiEmpByPosiIdList(OdConfig.getOrgnSetId(), EMP_ID_, POSI_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "updateOmPosiEmp")
    @ResponseBody
    public Map<String, Object> updateOmPosiEmp(String POSI_EMP_ID_, String MAIN_, String POSI_EMP_CATEGORY_, String MEMO_, String POSI_EMP_TAG_, String POSI_EMP_EXT_ATTR_1_, String POSI_EMP_EXT_ATTR_2_, String POSI_EMP_EXT_ATTR_3_, String POSI_EMP_EXT_ATTR_4_, String POSI_EMP_EXT_ATTR_5_, String POSI_EMP_EXT_ATTR_6_, String POSI_EMP_EXT_ATTR_7_, String POSI_EMP_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.updatePosiEmp(OdConfig.getOrgnSetId(), POSI_EMP_ID_, MAIN_, POSI_EMP_CATEGORY_, MEMO_, POSI_EMP_TAG_, POSI_EMP_EXT_ATTR_1_, POSI_EMP_EXT_ATTR_2_, POSI_EMP_EXT_ATTR_3_, POSI_EMP_EXT_ATTR_4_, POSI_EMP_EXT_ATTR_5_, POSI_EMP_EXT_ATTR_6_, POSI_EMP_EXT_ATTR_7_, POSI_EMP_EXT_ATTR_8_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posiEmp", omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "updateOmPosiEmpMain")
    @ResponseBody
    public Map<String, Object> updateOmPosiEmpMain(String POSI_EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.updatePosiEmpMain(OdConfig.getOrgnSetId(), POSI_EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posiEmp", omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "disableOmPosiEmp")
    @ResponseBody
    public Map<String, Object> disableOmPosiEmp(String POSI_EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.disablePosiEmp(OdConfig.getOrgnSetId(), POSI_EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posiEmp", omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "enableOmPosiEmp")
    @ResponseBody
    public Map<String, Object> enableOmPosiEmp(String POSI_EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.enablePosiEmp(OdConfig.getOrgnSetId(), POSI_EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posiEmp", omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "deleteOmPosiEmp")
    @ResponseBody
    public Map<String, Object> deleteOmPosiEmp(String POSI_EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.deletePosiEmp(OdConfig.getOrgnSetId(), POSI_EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "deleteOmPosiEmpByIdList")
    @ResponseBody
    public Map<String, Object> deleteOmPosiEmpByIdList(@RequestParam(value = "POSI_EMP_ID_LIST", required = true) List<String> POSI_EMP_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omPosiEmpService.deletePosiEmpByIdList(OdConfig.getOrgnSetId(), POSI_EMP_ID_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}