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
import com.opendynamic.om.service.OmEmpRelationService;

@Controller
public class OmEmpRelationController extends OdController {
    @Autowired
    private OmEmpRelationService omEmpRelationService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmEmpRelation")
    public String manageOmEmpRelation(Map<String, Object> operator) {
        return "om/EmpRelation/manageEmpRelation";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmEmpRelation")
    public String preInsertOmEmpRelation(Map<String, Object> operator) {
        return "om/EmpRelation/preInsertEmpRelation";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmEmpRelation")
    public String preUpdateOmEmpRelation(Map<String, Object> operator) {
        return "om/EmpRelation/preUpdateEmpRelation";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmEmpRelation")
    public String viewOmEmpRelation(Map<String, Object> operator) {
        return "om/EmpRelation/viewEmpRelation";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_RELATION_ID_")
    @RequestMapping(value = "loadOmEmpRelation")
    @ResponseBody
    public Map<String, Object> loadOmEmpRelation(String EMP_RELATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> empRelation = omEmpRelationService.loadEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("empRelation", empRelation);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmEmpRelation")
    @ResponseBody
    public Map<String, Object> selectOmEmpRelation(String EMP_RELATION_ID_, @RequestParam(value = "EMP_RELATION_ID_LIST,", required = false) List<String> EMP_RELATION_ID_LIST, String EMP_RELATION_, @RequestParam(value = "EMP_RELATION_LIST,", required = false) List<String> EMP_RELATION_LIST, String EMP_RELATION_CATEGORY_, @RequestParam(value = "EMP_RELATION_CATEGORY_LIST,", required = false) List<String> EMP_RELATION_CATEGORY_LIST, String EMP_RELATION_TAG_, String EMP_RELATION_EXT_ATTR_1_, @RequestParam(value = "EMP_RELATION_EXT_ATTR_1_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_1_LIST, String EMP_RELATION_EXT_ATTR_2_, @RequestParam(value = "EMP_RELATION_EXT_ATTR_2_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_2_LIST, String EMP_RELATION_EXT_ATTR_3_,
            @RequestParam(value = "EMP_RELATION_EXT_ATTR_3_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_3_LIST, String EMP_RELATION_EXT_ATTR_4_, @RequestParam(value = "EMP_RELATION_EXT_ATTR_4_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_4_LIST, String EMP_RELATION_EXT_ATTR_5_, @RequestParam(value = "EMP_RELATION_EXT_ATTR_5_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_5_LIST, String EMP_RELATION_EXT_ATTR_6_, @RequestParam(value = "EMP_RELATION_EXT_ATTR_6_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_6_LIST, String EMP_RELATION_EXT_ATTR_7_, @RequestParam(value = "EMP_RELATION_EXT_ATTR_7_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_7_LIST, String EMP_RELATION_EXT_ATTR_8_,
            @RequestParam(value = "EMP_RELATION_EXT_ATTR_8_LIST,", required = false) List<String> EMP_RELATION_EXT_ATTR_8_LIST, String EMP_RELATION_STATUS_, @RequestParam(value = "EMP_RELATION_STATUS_LIST,", required = false) List<String> EMP_RELATION_STATUS_LIST, String UPPER_EMP_ID_, @RequestParam(value = "UPPER_EMP_ID_LIST,", required = false) List<String> UPPER_EMP_ID_LIST, String UPPER_EMP_CODE_, @RequestParam(value = "UPPER_EMP_CODE_LIST,", required = false) List<String> UPPER_EMP_CODE_LIST, String UPPER_EMP_NAME_, @RequestParam(value = "UPPER_EMP_NAME_LIST", required = false) List<String> UPPER_EMP_NAME_LIST, String UPPER_EMP_CATEGORY_, @RequestParam(value = "UPPER_EMP_CATEGORY_LIST,", required = false) List<String> UPPER_EMP_CATEGORY_LIST, String UPPER_EMP_TAG_,
            String UPPER_EMP_EXT_ATTR_1_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_1_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_1_LIST, String UPPER_EMP_EXT_ATTR_2_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_2_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_2_LIST, String UPPER_EMP_EXT_ATTR_3_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_3_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_3_LIST, String UPPER_EMP_EXT_ATTR_4_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_4_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_4_LIST, String UPPER_EMP_EXT_ATTR_5_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_5_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_5_LIST, String UPPER_EMP_EXT_ATTR_6_,
            @RequestParam(value = "UPPER_EMP_EXT_ATTR_6_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_6_LIST, String UPPER_EMP_EXT_ATTR_7_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_7_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_7_LIST, String UPPER_EMP_EXT_ATTR_8_, @RequestParam(value = "UPPER_EMP_EXT_ATTR_8_LIST,", required = false) List<String> UPPER_EMP_EXT_ATTR_8_LIST, String UPPER_EMP_STATUS_, @RequestParam(value = "UPPER_EMP_STATUS_LIST,", required = false) List<String> UPPER_EMP_STATUS_LIST, String UPPER_ORG_ID_, @RequestParam(value = "UPPER_ORG_ID_LIST,", required = false) List<String> UPPER_ORG_ID_LIST, String UPPER_PARENT_ORG_ID_, @RequestParam(value = "UPPER_PARENT_ORG_ID_LIST,", required = false) List<String> UPPER_PARENT_ORG_ID_LIST,
            String UPPER_ORG_CODE_, @RequestParam(value = "UPPER_ORG_CODE_LIST,", required = false) List<String> UPPER_ORG_CODE_LIST, String UPPER_ORG_NAME_, @RequestParam(value = "UPPER_ORG_NAME_LIST", required = false) List<String> UPPER_ORG_NAME_LIST, String UPPER_ORG_TYPE_, @RequestParam(value = "UPPER_ORG_TYPE_LIST,", required = false) List<String> UPPER_ORG_TYPE_LIST, String UPPER_ORG_CATEGORY_, @RequestParam(value = "UPPER_ORG_CATEGORY_LIST,", required = false) List<String> UPPER_ORG_CATEGORY_LIST, String UPPER_ORG_TAG_, String UPPER_ORG_EXT_ATTR_1_, @RequestParam(value = "UPPER_ORG_EXT_ATTR_1_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_1_LIST, String UPPER_ORG_EXT_ATTR_2_,
            @RequestParam(value = "UPPER_ORG_EXT_ATTR_2_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_2_LIST, String UPPER_ORG_EXT_ATTR_3_, @RequestParam(value = "UPPER_ORG_EXT_ATTR_3_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_3_LIST, String UPPER_ORG_EXT_ATTR_4_, @RequestParam(value = "UPPER_ORG_EXT_ATTR_4_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_4_LIST, String UPPER_ORG_EXT_ATTR_5_, @RequestParam(value = "UPPER_ORG_EXT_ATTR_5_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_5_LIST, String UPPER_ORG_EXT_ATTR_6_, @RequestParam(value = "UPPER_ORG_EXT_ATTR_6_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_6_LIST, String UPPER_ORG_EXT_ATTR_7_,
            @RequestParam(value = "UPPER_ORG_EXT_ATTR_7_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_7_LIST, String UPPER_ORG_EXT_ATTR_8_, @RequestParam(value = "UPPER_ORG_EXT_ATTR_8_LIST,", required = false) List<String> UPPER_ORG_EXT_ATTR_8_LIST, String UPPER_ORG_STATUS_, @RequestParam(value = "UPPER_ORG_STATUS_LIST,", required = false) List<String> UPPER_ORG_STATUS_LIST, String LOWER_EMP_ID_, @RequestParam(value = "LOWER_EMP_ID_LIST,", required = false) List<String> LOWER_EMP_ID_LIST, String LOWER_EMP_CODE_, @RequestParam(value = "LOWER_EMP_CODE_LIST,", required = false) List<String> LOWER_EMP_CODE_LIST, String LOWER_EMP_NAME_, @RequestParam(value = "LOWER_EMP_NAME_LIST", required = false) List<String> LOWER_EMP_NAME_LIST, String LOWER_EMP_CATEGORY_,
            @RequestParam(value = "LOWER_EMP_CATEGORY_LIST,", required = false) List<String> LOWER_EMP_CATEGORY_LIST, String LOWER_EMP_TAG_, String LOWER_EMP_EXT_ATTR_1_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_1_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_1_LIST, String LOWER_EMP_EXT_ATTR_2_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_2_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_2_LIST, String LOWER_EMP_EXT_ATTR_3_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_3_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_3_LIST, String LOWER_EMP_EXT_ATTR_4_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_4_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_4_LIST, String LOWER_EMP_EXT_ATTR_5_,
            @RequestParam(value = "LOWER_EMP_EXT_ATTR_5_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_5_LIST, String LOWER_EMP_EXT_ATTR_6_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_6_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_6_LIST, String LOWER_EMP_EXT_ATTR_7_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_7_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_7_LIST, String LOWER_EMP_EXT_ATTR_8_, @RequestParam(value = "LOWER_EMP_EXT_ATTR_8_LIST,", required = false) List<String> LOWER_EMP_EXT_ATTR_8_LIST, String LOWER_EMP_STATUS_, @RequestParam(value = "LOWER_EMP_STATUS_LIST,", required = false) List<String> LOWER_EMP_STATUS_LIST, String LOWER_ORG_ID_, @RequestParam(value = "LOWER_ORG_ID_LIST,", required = false) List<String> LOWER_ORG_ID_LIST,
            String LOWER_PARENT_ORG_ID_, @RequestParam(value = "LOWER_PARENT_ORG_ID_LIST,", required = false) List<String> LOWER_PARENT_ORG_ID_LIST, String LOWER_ORG_CODE_, @RequestParam(value = "LOWER_ORG_CODE_LIST,", required = false) List<String> LOWER_ORG_CODE_LIST, String LOWER_ORG_NAME_, @RequestParam(value = "LOWER_ORG_NAME_LIST", required = false) List<String> LOWER_ORG_NAME_LIST, String LOWER_ORG_TYPE_, @RequestParam(value = "LOWER_ORG_TYPE_LIST,", required = false) List<String> LOWER_ORG_TYPE_LIST, String LOWER_ORG_CATEGORY_, @RequestParam(value = "LOWER_ORG_CATEGORY_LIST,", required = false) List<String> LOWER_ORG_CATEGORY_LIST, String LOWER_ORG_TAG_, String LOWER_ORG_EXT_ATTR_1_,
            @RequestParam(value = "LOWER_ORG_EXT_ATTR_1_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_1_LIST, String LOWER_ORG_EXT_ATTR_2_, @RequestParam(value = "LOWER_ORG_EXT_ATTR_2_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_2_LIST, String LOWER_ORG_EXT_ATTR_3_, @RequestParam(value = "LOWER_ORG_EXT_ATTR_3_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_3_LIST, String LOWER_ORG_EXT_ATTR_4_, @RequestParam(value = "LOWER_ORG_EXT_ATTR_4_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_4_LIST, String LOWER_ORG_EXT_ATTR_5_, @RequestParam(value = "LOWER_ORG_EXT_ATTR_5_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_5_LIST, String LOWER_ORG_EXT_ATTR_6_,
            @RequestParam(value = "LOWER_ORG_EXT_ATTR_6_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_6_LIST, String LOWER_ORG_EXT_ATTR_7_, @RequestParam(value = "LOWER_ORG_EXT_ATTR_7_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_7_LIST, String LOWER_ORG_EXT_ATTR_8_, @RequestParam(value = "LOWER_ORG_EXT_ATTR_8_LIST,", required = false) List<String> LOWER_ORG_EXT_ATTR_8_LIST, String LOWER_ORG_STATUS_, @RequestParam(value = "LOWER_ORG_STATUS_LIST,", required = false) List<String> LOWER_ORG_STATUS_LIST, Boolean empRelationTagUnion, Boolean upperEmpTagUnion, Boolean upperOrgTagUnion, String upperWithinOrgId, Boolean upperOrgRootOnly, Boolean lowerEmpTagUnion, Boolean lowerOrgTagUnion, String lowerWithinOrgId, Boolean lowerOrgRootOnly, Integer page, Integer limit,
            Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> empRelationList = omEmpRelationService.selectEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, EMP_RELATION_ID_LIST, EMP_RELATION_, EMP_RELATION_LIST, EMP_RELATION_CATEGORY_, EMP_RELATION_CATEGORY_LIST, EMP_RELATION_TAG_, EMP_RELATION_EXT_ATTR_1_, EMP_RELATION_EXT_ATTR_1_LIST, EMP_RELATION_EXT_ATTR_2_, EMP_RELATION_EXT_ATTR_2_LIST, EMP_RELATION_EXT_ATTR_3_, EMP_RELATION_EXT_ATTR_3_LIST, EMP_RELATION_EXT_ATTR_4_, EMP_RELATION_EXT_ATTR_4_LIST, EMP_RELATION_EXT_ATTR_5_, EMP_RELATION_EXT_ATTR_5_LIST, EMP_RELATION_EXT_ATTR_6_, EMP_RELATION_EXT_ATTR_6_LIST, EMP_RELATION_EXT_ATTR_7_, EMP_RELATION_EXT_ATTR_7_LIST, EMP_RELATION_EXT_ATTR_8_, EMP_RELATION_EXT_ATTR_8_LIST, EMP_RELATION_STATUS_, EMP_RELATION_STATUS_LIST, UPPER_EMP_ID_, UPPER_EMP_ID_LIST,
                UPPER_EMP_CODE_, UPPER_EMP_CODE_LIST, UPPER_EMP_NAME_, UPPER_EMP_NAME_LIST, UPPER_EMP_CATEGORY_, UPPER_EMP_CATEGORY_LIST, UPPER_EMP_TAG_, UPPER_EMP_EXT_ATTR_1_, UPPER_EMP_EXT_ATTR_1_LIST, UPPER_EMP_EXT_ATTR_2_, UPPER_EMP_EXT_ATTR_2_LIST, UPPER_EMP_EXT_ATTR_3_, UPPER_EMP_EXT_ATTR_3_LIST, UPPER_EMP_EXT_ATTR_4_, UPPER_EMP_EXT_ATTR_4_LIST, UPPER_EMP_EXT_ATTR_5_, UPPER_EMP_EXT_ATTR_5_LIST, UPPER_EMP_EXT_ATTR_6_, UPPER_EMP_EXT_ATTR_6_LIST, UPPER_EMP_EXT_ATTR_7_, UPPER_EMP_EXT_ATTR_7_LIST, UPPER_EMP_EXT_ATTR_8_, UPPER_EMP_EXT_ATTR_8_LIST, UPPER_EMP_STATUS_, UPPER_EMP_STATUS_LIST, UPPER_ORG_ID_, UPPER_ORG_ID_LIST, UPPER_PARENT_ORG_ID_, UPPER_PARENT_ORG_ID_LIST, UPPER_ORG_CODE_, UPPER_ORG_CODE_LIST, UPPER_ORG_NAME_, UPPER_ORG_NAME_LIST, UPPER_ORG_TYPE_, UPPER_ORG_TYPE_LIST,
                UPPER_ORG_CATEGORY_, UPPER_ORG_CATEGORY_LIST, UPPER_ORG_TAG_, UPPER_ORG_EXT_ATTR_1_, UPPER_ORG_EXT_ATTR_1_LIST, UPPER_ORG_EXT_ATTR_2_, UPPER_ORG_EXT_ATTR_2_LIST, UPPER_ORG_EXT_ATTR_3_, UPPER_ORG_EXT_ATTR_3_LIST, UPPER_ORG_EXT_ATTR_4_, UPPER_ORG_EXT_ATTR_4_LIST, UPPER_ORG_EXT_ATTR_5_, UPPER_ORG_EXT_ATTR_5_LIST, UPPER_ORG_EXT_ATTR_6_, UPPER_ORG_EXT_ATTR_6_LIST, UPPER_ORG_EXT_ATTR_7_, UPPER_ORG_EXT_ATTR_7_LIST, UPPER_ORG_EXT_ATTR_8_, UPPER_ORG_EXT_ATTR_8_LIST, UPPER_ORG_STATUS_, UPPER_ORG_STATUS_LIST, LOWER_EMP_ID_, LOWER_EMP_ID_LIST, LOWER_EMP_CODE_, LOWER_EMP_CODE_LIST, LOWER_EMP_NAME_, LOWER_EMP_NAME_LIST, LOWER_EMP_CATEGORY_, LOWER_EMP_CATEGORY_LIST, LOWER_EMP_TAG_, LOWER_EMP_EXT_ATTR_1_, LOWER_EMP_EXT_ATTR_1_LIST, LOWER_EMP_EXT_ATTR_2_, LOWER_EMP_EXT_ATTR_2_LIST,
                LOWER_EMP_EXT_ATTR_3_, LOWER_EMP_EXT_ATTR_3_LIST, LOWER_EMP_EXT_ATTR_4_, LOWER_EMP_EXT_ATTR_4_LIST, LOWER_EMP_EXT_ATTR_5_, LOWER_EMP_EXT_ATTR_5_LIST, LOWER_EMP_EXT_ATTR_6_, LOWER_EMP_EXT_ATTR_6_LIST, LOWER_EMP_EXT_ATTR_7_, LOWER_EMP_EXT_ATTR_7_LIST, LOWER_EMP_EXT_ATTR_8_, LOWER_EMP_EXT_ATTR_8_LIST, LOWER_EMP_STATUS_, LOWER_EMP_STATUS_LIST, LOWER_ORG_ID_, LOWER_ORG_ID_LIST, LOWER_PARENT_ORG_ID_, LOWER_PARENT_ORG_ID_LIST, LOWER_ORG_CODE_, LOWER_ORG_CODE_LIST, LOWER_ORG_NAME_, LOWER_ORG_NAME_LIST, LOWER_ORG_TYPE_, LOWER_ORG_TYPE_LIST, LOWER_ORG_CATEGORY_, LOWER_ORG_CATEGORY_LIST, LOWER_ORG_TAG_, LOWER_ORG_EXT_ATTR_1_, LOWER_ORG_EXT_ATTR_1_LIST, LOWER_ORG_EXT_ATTR_2_, LOWER_ORG_EXT_ATTR_2_LIST, LOWER_ORG_EXT_ATTR_3_, LOWER_ORG_EXT_ATTR_3_LIST, LOWER_ORG_EXT_ATTR_4_,
                LOWER_ORG_EXT_ATTR_4_LIST, LOWER_ORG_EXT_ATTR_5_, LOWER_ORG_EXT_ATTR_5_LIST, LOWER_ORG_EXT_ATTR_6_, LOWER_ORG_EXT_ATTR_6_LIST, LOWER_ORG_EXT_ATTR_7_, LOWER_ORG_EXT_ATTR_7_LIST, LOWER_ORG_EXT_ATTR_8_, LOWER_ORG_EXT_ATTR_8_LIST, LOWER_ORG_STATUS_, LOWER_ORG_STATUS_LIST, empRelationTagUnion, upperEmpTagUnion, upperOrgTagUnion, upperWithinOrgId, upperOrgRootOnly, lowerEmpTagUnion, lowerOrgTagUnion, lowerWithinOrgId, lowerOrgRootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omEmpRelationService.countEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, EMP_RELATION_ID_LIST, EMP_RELATION_, EMP_RELATION_LIST, EMP_RELATION_CATEGORY_, EMP_RELATION_CATEGORY_LIST, EMP_RELATION_TAG_, EMP_RELATION_EXT_ATTR_1_, EMP_RELATION_EXT_ATTR_1_LIST, EMP_RELATION_EXT_ATTR_2_, EMP_RELATION_EXT_ATTR_2_LIST, EMP_RELATION_EXT_ATTR_3_, EMP_RELATION_EXT_ATTR_3_LIST, EMP_RELATION_EXT_ATTR_4_, EMP_RELATION_EXT_ATTR_4_LIST, EMP_RELATION_EXT_ATTR_5_, EMP_RELATION_EXT_ATTR_5_LIST, EMP_RELATION_EXT_ATTR_6_, EMP_RELATION_EXT_ATTR_6_LIST, EMP_RELATION_EXT_ATTR_7_, EMP_RELATION_EXT_ATTR_7_LIST, EMP_RELATION_EXT_ATTR_8_, EMP_RELATION_EXT_ATTR_8_LIST, EMP_RELATION_STATUS_, EMP_RELATION_STATUS_LIST, UPPER_EMP_ID_, UPPER_EMP_ID_LIST, UPPER_EMP_CODE_,
                    UPPER_EMP_CODE_LIST, UPPER_EMP_NAME_, UPPER_EMP_NAME_LIST, UPPER_EMP_CATEGORY_, UPPER_EMP_CATEGORY_LIST, UPPER_EMP_TAG_, UPPER_EMP_EXT_ATTR_1_, UPPER_EMP_EXT_ATTR_1_LIST, UPPER_EMP_EXT_ATTR_2_, UPPER_EMP_EXT_ATTR_2_LIST, UPPER_EMP_EXT_ATTR_3_, UPPER_EMP_EXT_ATTR_3_LIST, UPPER_EMP_EXT_ATTR_4_, UPPER_EMP_EXT_ATTR_4_LIST, UPPER_EMP_EXT_ATTR_5_, UPPER_EMP_EXT_ATTR_5_LIST, UPPER_EMP_EXT_ATTR_6_, UPPER_EMP_EXT_ATTR_6_LIST, UPPER_EMP_EXT_ATTR_7_, UPPER_EMP_EXT_ATTR_7_LIST, UPPER_EMP_EXT_ATTR_8_, UPPER_EMP_EXT_ATTR_8_LIST, UPPER_EMP_STATUS_, UPPER_EMP_STATUS_LIST, UPPER_ORG_ID_, UPPER_ORG_ID_LIST, UPPER_PARENT_ORG_ID_, UPPER_PARENT_ORG_ID_LIST, UPPER_ORG_CODE_, UPPER_ORG_CODE_LIST, UPPER_ORG_NAME_, UPPER_ORG_NAME_LIST, UPPER_ORG_TYPE_, UPPER_ORG_TYPE_LIST, UPPER_ORG_CATEGORY_,
                    UPPER_ORG_CATEGORY_LIST, UPPER_ORG_TAG_, UPPER_ORG_EXT_ATTR_1_, UPPER_ORG_EXT_ATTR_1_LIST, UPPER_ORG_EXT_ATTR_2_, UPPER_ORG_EXT_ATTR_2_LIST, UPPER_ORG_EXT_ATTR_3_, UPPER_ORG_EXT_ATTR_3_LIST, UPPER_ORG_EXT_ATTR_4_, UPPER_ORG_EXT_ATTR_4_LIST, UPPER_ORG_EXT_ATTR_5_, UPPER_ORG_EXT_ATTR_5_LIST, UPPER_ORG_EXT_ATTR_6_, UPPER_ORG_EXT_ATTR_6_LIST, UPPER_ORG_EXT_ATTR_7_, UPPER_ORG_EXT_ATTR_7_LIST, UPPER_ORG_EXT_ATTR_8_, UPPER_ORG_EXT_ATTR_8_LIST, UPPER_ORG_STATUS_, UPPER_ORG_STATUS_LIST, LOWER_EMP_ID_, LOWER_EMP_ID_LIST, LOWER_EMP_CODE_, LOWER_EMP_CODE_LIST, LOWER_EMP_NAME_, LOWER_EMP_NAME_LIST, LOWER_EMP_CATEGORY_, LOWER_EMP_CATEGORY_LIST, LOWER_EMP_TAG_, LOWER_EMP_EXT_ATTR_1_, LOWER_EMP_EXT_ATTR_1_LIST, LOWER_EMP_EXT_ATTR_2_, LOWER_EMP_EXT_ATTR_2_LIST, LOWER_EMP_EXT_ATTR_3_,
                    LOWER_EMP_EXT_ATTR_3_LIST, LOWER_EMP_EXT_ATTR_4_, LOWER_EMP_EXT_ATTR_4_LIST, LOWER_EMP_EXT_ATTR_5_, LOWER_EMP_EXT_ATTR_5_LIST, LOWER_EMP_EXT_ATTR_6_, LOWER_EMP_EXT_ATTR_6_LIST, LOWER_EMP_EXT_ATTR_7_, LOWER_EMP_EXT_ATTR_7_LIST, LOWER_EMP_EXT_ATTR_8_, LOWER_EMP_EXT_ATTR_8_LIST, LOWER_EMP_STATUS_, LOWER_EMP_STATUS_LIST, LOWER_ORG_ID_, LOWER_ORG_ID_LIST, LOWER_PARENT_ORG_ID_, LOWER_PARENT_ORG_ID_LIST, LOWER_ORG_CODE_, LOWER_ORG_CODE_LIST, LOWER_ORG_NAME_, LOWER_ORG_NAME_LIST, LOWER_ORG_TYPE_, LOWER_ORG_TYPE_LIST, LOWER_ORG_CATEGORY_, LOWER_ORG_CATEGORY_LIST, LOWER_ORG_TAG_, LOWER_ORG_EXT_ATTR_1_, LOWER_ORG_EXT_ATTR_1_LIST, LOWER_ORG_EXT_ATTR_2_, LOWER_ORG_EXT_ATTR_2_LIST, LOWER_ORG_EXT_ATTR_3_, LOWER_ORG_EXT_ATTR_3_LIST, LOWER_ORG_EXT_ATTR_4_, LOWER_ORG_EXT_ATTR_4_LIST,
                    LOWER_ORG_EXT_ATTR_5_, LOWER_ORG_EXT_ATTR_5_LIST, LOWER_ORG_EXT_ATTR_6_, LOWER_ORG_EXT_ATTR_6_LIST, LOWER_ORG_EXT_ATTR_7_, LOWER_ORG_EXT_ATTR_7_LIST, LOWER_ORG_EXT_ATTR_8_, LOWER_ORG_EXT_ATTR_8_LIST, LOWER_ORG_STATUS_, LOWER_ORG_STATUS_LIST, empRelationTagUnion, upperEmpTagUnion, upperOrgTagUnion, upperWithinOrgId, upperOrgRootOnly, lowerEmpTagUnion, lowerOrgTagUnion, lowerWithinOrgId, lowerOrgRootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }

        result.put("empRelationList", empRelationList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmEmpRelationByIdList")
    @ResponseBody
    public Map<String, Object> selectOmEmpRelationByIdList(@RequestParam(value = "EMP_RELATION_ID_LIST", required = false) List<String> EMP_RELATION_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> empRelationList = omEmpRelationService.selectEmpRelationByIdList(OdConfig.getOrgnSetId(), EMP_RELATION_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("empRelationList", empRelationList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_RELATION_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmEmpRelation")
    @ResponseBody
    public Map<String, Object> insertOmEmpRelation(String EMP_RELATION_ID_, String UPPER_EMP_ID_, String LOWER_EMP_ID_, String EMP_RELATION_, String EMP_RELATION_CATEGORY_, String MEMO_, String EMP_RELATION_TAG_, String EMP_RELATION_EXT_ATTR_1_, String EMP_RELATION_EXT_ATTR_2_, String EMP_RELATION_EXT_ATTR_3_, String EMP_RELATION_EXT_ATTR_4_, String EMP_RELATION_EXT_ATTR_5_, String EMP_RELATION_EXT_ATTR_6_, String EMP_RELATION_EXT_ATTR_7_, String EMP_RELATION_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.insertEmpRelation(OdConfig.getOrgnSetId(), EMP_RELATION_ID_, UPPER_EMP_ID_, LOWER_EMP_ID_, EMP_RELATION_, EMP_RELATION_CATEGORY_, MEMO_, EMP_RELATION_TAG_, EMP_RELATION_EXT_ATTR_1_, EMP_RELATION_EXT_ATTR_2_, EMP_RELATION_EXT_ATTR_3_, EMP_RELATION_EXT_ATTR_4_, EMP_RELATION_EXT_ATTR_5_, EMP_RELATION_EXT_ATTR_6_, EMP_RELATION_EXT_ATTR_7_, EMP_RELATION_EXT_ATTR_8_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("empRelation", omEmpRelationService.loadEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_RELATION_ID_")
    @RequestMapping(value = "updateOmEmpRelation")
    @ResponseBody
    public Map<String, Object> updateOmEmpRelation(String EMP_RELATION_ID_, String EMP_RELATION_, String EMP_RELATION_CATEGORY_, String MEMO_, String EMP_RELATION_TAG_, String EMP_RELATION_EXT_ATTR_1_, String EMP_RELATION_EXT_ATTR_2_, String EMP_RELATION_EXT_ATTR_3_, String EMP_RELATION_EXT_ATTR_4_, String EMP_RELATION_EXT_ATTR_5_, String EMP_RELATION_EXT_ATTR_6_, String EMP_RELATION_EXT_ATTR_7_, String EMP_RELATION_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.updateEmpRelation(OdConfig.getOrgnSetId(), EMP_RELATION_ID_, EMP_RELATION_, EMP_RELATION_CATEGORY_, MEMO_, EMP_RELATION_TAG_, EMP_RELATION_EXT_ATTR_1_, EMP_RELATION_EXT_ATTR_2_, EMP_RELATION_EXT_ATTR_3_, EMP_RELATION_EXT_ATTR_4_, EMP_RELATION_EXT_ATTR_5_, EMP_RELATION_EXT_ATTR_6_, EMP_RELATION_EXT_ATTR_7_, EMP_RELATION_EXT_ATTR_8_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("empRelation", omEmpRelationService.loadEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmEmpRelationOrder")
    @ResponseBody
    public Map<String, Object> updateOmEmpRelationOrder(@RequestParam(value = "EMP_RELATION_ID_LIST", required = true) List<String> EMP_RELATION_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.updateEmpRelationOrder(OdConfig.getOrgnSetId(), EMP_RELATION_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_RELATION_ID_")
    @RequestMapping(value = "disableOmEmpRelation")
    @ResponseBody
    public Map<String, Object> disableOmEmpRelation(String EMP_RELATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.disableEmpRelation(OdConfig.getOrgnSetId(), EMP_RELATION_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("empRelation", omEmpRelationService.loadEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_RELATION_ID_")
    @RequestMapping(value = "enableOmEmpRelation")
    @ResponseBody
    public Map<String, Object> enableOmEmpRelation(String EMP_RELATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.enableEmpRelation(OdConfig.getOrgnSetId(), EMP_RELATION_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("empRelation", omEmpRelationService.loadEmpRelation(OdConfig.getOrgnSetId(), null, EMP_RELATION_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_RELATION_ID_")
    @RequestMapping(value = "deleteOmEmpRelation")
    @ResponseBody
    public Map<String, Object> deleteOmEmpRelation(String EMP_RELATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.deleteEmpRelation(OdConfig.getOrgnSetId(), EMP_RELATION_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "deleteOmEmpRelationByEmpId")
    @ResponseBody
    public Map<String, Object> deleteOmEmpRelationByEmpId(String EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omEmpRelationService.deleteEmpRelationByEmpId(OdConfig.getOrgnSetId(), EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}