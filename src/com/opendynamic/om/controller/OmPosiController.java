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
import com.opendynamic.om.service.OmPosiService;

@Controller
public class OmPosiController extends OdController {
    @Autowired
    private OmPosiService omPosiService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmPosi")
    public String manageOmPosi(Map<String, Object> operator) {
        return "om/Posi/managePosi";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmPosi")
    public String preChooseOmPosi(Map<String, Object> operator) {
        return "om/Posi/preChoosePosi";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmPosi")
    public String preInsertOmPosi(Map<String, Object> operator) {
        return "om/Posi/preInsertPosi";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmPosi")
    public String preUpdateOmPosi(Map<String, Object> operator) {
        return "om/Posi/preUpdatePosi";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmPosi")
    public String viewOmPosi(Map<String, Object> operator) {
        return "om/Posi/viewPosi";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "loadOmPosi")
    @ResponseBody
    public Map<String, Object> loadOmPosi(String POSI_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> posi = omPosiService.loadPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("posi", posi);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_CODE_")
    @RequestMapping(value = "loadOmPosiByCode")
    @ResponseBody
    public Map<String, Object> loadOmPosiByCode(String POSI_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> posi = omPosiService.loadPosiByCode(OdConfig.getOrgnSetId(), null, POSI_CODE_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("posi", posi);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmPosi")
    @ResponseBody
    public Map<String, Object> selectOmPosi(String POSI_ID_, @RequestParam(value = "POSI_ID_LIST", required = false) List<String> POSI_ID_LIST, String POSI_CODE_, @RequestParam(value = "POSI_CODE_LIST", required = false) List<String> POSI_CODE_LIST, String POSI_NAME_, @RequestParam(value = "POSI_NAME_LIST", required = false) List<String> POSI_NAME_LIST, String ORG_LEADER_TYPE_, @RequestParam(value = "ORG_LEADER_TYPE_LIST", required = false) List<String> ORG_LEADER_TYPE_LIST, String POSI_CATEGORY_, @RequestParam(value = "POSI_CATEGORY_LIST", required = false) List<String> POSI_CATEGORY_LIST, String POSI_TAG_, String POSI_EXT_ATTR_1_, @RequestParam(value = "POSI_EXT_ATTR_1_LIST", required = false) List<String> POSI_EXT_ATTR_1_LIST, String POSI_EXT_ATTR_2_,
            @RequestParam(value = "POSI_EXT_ATTR_2_LIST", required = false) List<String> POSI_EXT_ATTR_2_LIST, String POSI_EXT_ATTR_3_, @RequestParam(value = "POSI_EXT_ATTR_3_LIST", required = false) List<String> POSI_EXT_ATTR_3_LIST, String POSI_EXT_ATTR_4_, @RequestParam(value = "POSI_EXT_ATTR_4_LIST", required = false) List<String> POSI_EXT_ATTR_4_LIST, String POSI_EXT_ATTR_5_, @RequestParam(value = "POSI_EXT_ATTR_5_LIST", required = false) List<String> POSI_EXT_ATTR_5_LIST, String POSI_EXT_ATTR_6_, @RequestParam(value = "POSI_EXT_ATTR_6_LIST", required = false) List<String> POSI_EXT_ATTR_6_LIST, String POSI_EXT_ATTR_7_, @RequestParam(value = "POSI_EXT_ATTR_7_LIST", required = false) List<String> POSI_EXT_ATTR_7_LIST, String POSI_EXT_ATTR_8_,
            @RequestParam(value = "POSI_EXT_ATTR_8_LIST", required = false) List<String> POSI_EXT_ATTR_8_LIST, String POSI_STATUS_, @RequestParam(value = "POSI_STATUS_LIST", required = false) List<String> POSI_STATUS_LIST, String DUTY_ID_, @RequestParam(value = "DUTY_ID_LIST", required = false) List<String> DUTY_ID_LIST, String DUTY_CODE_, @RequestParam(value = "DUTY_CODE_LIST", required = false) List<String> DUTY_CODE_LIST, String DUTY_NAME_, @RequestParam(value = "DUTY_NAME_LIST", required = false) List<String> DUTY_NAME_LIST, String DUTY_CATEGORY_, @RequestParam(value = "DUTY_CATEGORY_LIST", required = false) List<String> DUTY_CATEGORY_LIST, String DUTY_TAG_, String DUTY_EXT_ATTR_1_, @RequestParam(value = "DUTY_EXT_ATTR_1_LIST", required = false) List<String> DUTY_EXT_ATTR_1_LIST,
            String DUTY_EXT_ATTR_2_, @RequestParam(value = "DUTY_EXT_ATTR_2_LIST", required = false) List<String> DUTY_EXT_ATTR_2_LIST, String DUTY_EXT_ATTR_3_, @RequestParam(value = "DUTY_EXT_ATTR_3_LIST", required = false) List<String> DUTY_EXT_ATTR_3_LIST, String DUTY_EXT_ATTR_4_, @RequestParam(value = "DUTY_EXT_ATTR_4_LIST", required = false) List<String> DUTY_EXT_ATTR_4_LIST, String DUTY_EXT_ATTR_5_, @RequestParam(value = "DUTY_EXT_ATTR_5_LIST", required = false) List<String> DUTY_EXT_ATTR_5_LIST, String DUTY_EXT_ATTR_6_, @RequestParam(value = "DUTY_EXT_ATTR_6_LIST", required = false) List<String> DUTY_EXT_ATTR_6_LIST, String DUTY_EXT_ATTR_7_, @RequestParam(value = "DUTY_EXT_ATTR_7_LIST", required = false) List<String> DUTY_EXT_ATTR_7_LIST, String DUTY_EXT_ATTR_8_,
            @RequestParam(value = "DUTY_EXT_ATTR_8_LIST", required = false) List<String> DUTY_EXT_ATTR_8_LIST, String DUTY_STATUS_, @RequestParam(value = "DUTY_STATUS_LIST", required = false) List<String> DUTY_STATUS_LIST, String ORG_ID_, @RequestParam(value = "ORG_ID_LIST", required = false) List<String> ORG_ID_LIST, String PARENT_ORG_ID_, @RequestParam(value = "PARENT_ORG_ID_LIST", required = false) List<String> PARENT_ORG_ID_LIST, String ORG_CODE_, @RequestParam(value = "ORG_CODE_LIST", required = false) List<String> ORG_CODE_LIST, String ORG_NAME_, @RequestParam(value = "ORG_NAME_LIST", required = false) List<String> ORG_NAME_LIST, String ORG_TYPE_, @RequestParam(value = "ORG_TYPE_LIST", required = false) List<String> ORG_TYPE_LIST, String ORG_CATEGORY_,
            @RequestParam(value = "ORG_CATEGORY_LIST", required = false) List<String> ORG_CATEGORY_LIST, String ORG_TAG_, String ORG_EXT_ATTR_1_, @RequestParam(value = "ORG_EXT_ATTR_1_LIST", required = false) List<String> ORG_EXT_ATTR_1_LIST, String ORG_EXT_ATTR_2_, @RequestParam(value = "ORG_EXT_ATTR_2_LIST", required = false) List<String> ORG_EXT_ATTR_2_LIST, String ORG_EXT_ATTR_3_, @RequestParam(value = "ORG_EXT_ATTR_3_LIST", required = false) List<String> ORG_EXT_ATTR_3_LIST, String ORG_EXT_ATTR_4_, @RequestParam(value = "ORG_EXT_ATTR_4_LIST", required = false) List<String> ORG_EXT_ATTR_4_LIST, String ORG_EXT_ATTR_5_, @RequestParam(value = "ORG_EXT_ATTR_5_LIST", required = false) List<String> ORG_EXT_ATTR_5_LIST, String ORG_EXT_ATTR_6_,
            @RequestParam(value = "ORG_EXT_ATTR_6_LIST", required = false) List<String> ORG_EXT_ATTR_6_LIST, String ORG_EXT_ATTR_7_, @RequestParam(value = "ORG_EXT_ATTR_7_LIST", required = false) List<String> ORG_EXT_ATTR_7_LIST, String ORG_EXT_ATTR_8_, @RequestParam(value = "ORG_EXT_ATTR_8_LIST", required = false) List<String> ORG_EXT_ATTR_8_LIST, String ORG_STATUS_, @RequestParam(value = "ORG_STATUS_LIST", required = false) List<String> ORG_STATUS_LIST, Boolean posiTagUnion, Boolean dutyTagUnion, Boolean orgTagUnion, String withinOrgId, Boolean orgRootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiList = omPosiService.selectPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, POSI_ID_LIST, POSI_CODE_, POSI_CODE_LIST, POSI_NAME_, POSI_NAME_LIST, ORG_LEADER_TYPE_, ORG_LEADER_TYPE_LIST, POSI_CATEGORY_, POSI_CATEGORY_LIST, POSI_TAG_, POSI_EXT_ATTR_1_, POSI_EXT_ATTR_1_LIST, POSI_EXT_ATTR_2_, POSI_EXT_ATTR_2_LIST, POSI_EXT_ATTR_3_, POSI_EXT_ATTR_3_LIST, POSI_EXT_ATTR_4_, POSI_EXT_ATTR_4_LIST, POSI_EXT_ATTR_5_, POSI_EXT_ATTR_5_LIST, POSI_EXT_ATTR_6_, POSI_EXT_ATTR_6_LIST, POSI_EXT_ATTR_7_, POSI_EXT_ATTR_7_LIST, POSI_EXT_ATTR_8_, POSI_EXT_ATTR_8_LIST, POSI_STATUS_, POSI_STATUS_LIST, DUTY_ID_, DUTY_ID_LIST, DUTY_CODE_, DUTY_CODE_LIST, DUTY_NAME_, DUTY_NAME_LIST, DUTY_CATEGORY_, DUTY_CATEGORY_LIST, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_1_LIST,
                DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_2_LIST, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_3_LIST, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_4_LIST, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_5_LIST, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_6_LIST, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_7_LIST, DUTY_EXT_ATTR_8_, DUTY_EXT_ATTR_8_LIST, DUTY_STATUS_, DUTY_STATUS_LIST, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_,
                ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, posiTagUnion, dutyTagUnion, orgTagUnion, withinOrgId, orgRootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omPosiService.countPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, POSI_ID_LIST, POSI_CODE_, POSI_CODE_LIST, POSI_NAME_, POSI_NAME_LIST, ORG_LEADER_TYPE_, ORG_LEADER_TYPE_LIST, POSI_CATEGORY_, POSI_CATEGORY_LIST, POSI_TAG_, POSI_EXT_ATTR_1_, POSI_EXT_ATTR_1_LIST, POSI_EXT_ATTR_2_, POSI_EXT_ATTR_2_LIST, POSI_EXT_ATTR_3_, POSI_EXT_ATTR_3_LIST, POSI_EXT_ATTR_4_, POSI_EXT_ATTR_4_LIST, POSI_EXT_ATTR_5_, POSI_EXT_ATTR_5_LIST, POSI_EXT_ATTR_6_, POSI_EXT_ATTR_6_LIST, POSI_EXT_ATTR_7_, POSI_EXT_ATTR_7_LIST, POSI_EXT_ATTR_8_, POSI_EXT_ATTR_8_LIST, POSI_STATUS_, POSI_STATUS_LIST, DUTY_ID_, DUTY_ID_LIST, DUTY_CODE_, DUTY_CODE_LIST, DUTY_NAME_, DUTY_NAME_LIST, DUTY_CATEGORY_, DUTY_CATEGORY_LIST, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_1_LIST, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_2_LIST,
                    DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_3_LIST, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_4_LIST, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_5_LIST, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_6_LIST, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_7_LIST, DUTY_EXT_ATTR_8_, DUTY_EXT_ATTR_8_LIST, DUTY_STATUS_, DUTY_STATUS_LIST, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_,
                    ORG_STATUS_LIST, posiTagUnion, dutyTagUnion, orgTagUnion, withinOrgId, orgRootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }

        result.put("posiList", posiList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmPosiByIdList")
    @ResponseBody
    public Map<String, Object> selectOmPosiByIdList(@RequestParam(value = "POSI_ID_LIST", required = false) List<String> POSI_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiList = omPosiService.selectPosiByIdList(OdConfig.getOrgnSetId(), POSI_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("posiList", posiList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmPosi")
    @ResponseBody
    public Map<String, Object> insertOmPosi(String POSI_ID_, String ORG_ID_, String DUTY_ID_, String POSI_CODE_, String POSI_NAME_, String ORG_LEADER_TYPE_, String POSI_CATEGORY_, String MEMO_, String POSI_TAG_, String POSI_EXT_ATTR_1_, String POSI_EXT_ATTR_2_, String POSI_EXT_ATTR_3_, String POSI_EXT_ATTR_4_, String POSI_EXT_ATTR_5_, String POSI_EXT_ATTR_6_, String POSI_EXT_ATTR_7_, String POSI_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.insertPosi(OdConfig.getOrgnSetId(), POSI_ID_, ORG_ID_, DUTY_ID_, POSI_CODE_, POSI_NAME_, ORG_LEADER_TYPE_, POSI_CATEGORY_, MEMO_, POSI_TAG_, POSI_EXT_ATTR_1_, POSI_EXT_ATTR_2_, POSI_EXT_ATTR_3_, POSI_EXT_ATTR_4_, POSI_EXT_ATTR_5_, POSI_EXT_ATTR_6_, POSI_EXT_ATTR_7_, POSI_EXT_ATTR_8_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posi", omPosiService.loadPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "updateOmPosi")
    @ResponseBody
    public Map<String, Object> updateOmPosi(String POSI_ID_, String DUTY_ID_, String POSI_CODE_, String POSI_NAME_, String ORG_LEADER_TYPE_, String POSI_CATEGORY_, String MEMO_, String POSI_TAG_, String POSI_EXT_ATTR_1_, String POSI_EXT_ATTR_2_, String POSI_EXT_ATTR_3_, String POSI_EXT_ATTR_4_, String POSI_EXT_ATTR_5_, String POSI_EXT_ATTR_6_, String POSI_EXT_ATTR_7_, String POSI_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.updatePosi(OdConfig.getOrgnSetId(), POSI_ID_, DUTY_ID_, POSI_CODE_, POSI_NAME_, ORG_LEADER_TYPE_, POSI_CATEGORY_, MEMO_, POSI_TAG_, POSI_EXT_ATTR_1_, POSI_EXT_ATTR_2_, POSI_EXT_ATTR_3_, POSI_EXT_ATTR_4_, POSI_EXT_ATTR_5_, POSI_EXT_ATTR_6_, POSI_EXT_ATTR_7_, POSI_EXT_ATTR_8_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posi", omPosiService.loadPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmPosiOrder")
    @ResponseBody
    public Map<String, Object> updateOmPosiOrder(@RequestParam(value = "POSI_ID_LIST", required = true) List<String> POSI_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.updatePosiOrder(OdConfig.getOrgnSetId(), POSI_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "moveOmPosi")
    @ResponseBody
    public Map<String, Object> moveOmPosi(String POSI_ID_, String ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.movePosi(OdConfig.getOrgnSetId(), POSI_ID_, ORG_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posi", omPosiService.loadPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "disableOmPosi")
    @ResponseBody
    public Map<String, Object> disableOmPosi(String POSI_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.disablePosi(OdConfig.getOrgnSetId(), POSI_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posi", omPosiService.loadPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "enableOmPosi")
    @ResponseBody
    public Map<String, Object> enableOmPosi(String POSI_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.enablePosi(OdConfig.getOrgnSetId(), POSI_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("posi", omPosiService.loadPosi(OdConfig.getOrgnSetId(), null, POSI_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "deleteOmPosi")
    @ResponseBody
    public Map<String, Object> deleteOmPosi(String POSI_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omPosiService.deletePosi(OdConfig.getOrgnSetId(), POSI_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}