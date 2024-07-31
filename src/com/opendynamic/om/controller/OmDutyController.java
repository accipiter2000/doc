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
import com.opendynamic.om.service.OmDutyService;

@Controller
public class OmDutyController extends OdController {
    @Autowired
    private OmDutyService omDutyService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmDuty")
    public String manageOmDuty(Map<String, Object> operator) {
        return "om/Duty/manageDuty";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmDuty")
    public String preChooseOmDuty(Map<String, Object> operator) {
        return "om/Duty/preChooseDuty";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmDuty")
    public String preInsertOmDuty(Map<String, Object> operator) {
        return "om/Duty/preInsertDuty";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmDuty")
    public String preUpdateOmDuty(Map<String, Object> operator) {
        return "om/Duty/preUpdateDuty";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmDuty")
    public String viewOmDuty(Map<String, Object> operator) {
        return "om/Duty/viewDuty";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_ID_")
    @RequestMapping(value = "loadOmDuty")
    @ResponseBody
    public Map<String, Object> loadOmDuty(String DUTY_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> duty = omDutyService.loadDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("duty", duty);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_CODE_")
    @RequestMapping(value = "loadOmDutyByCode")
    @ResponseBody
    public Map<String, Object> loadOmDutyByCode(String DUTY_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> duty = omDutyService.loadDutyByCode(OdConfig.getOrgnSetId(), null, DUTY_CODE_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("duty", duty);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmDuty")
    @ResponseBody
    public Map<String, Object> selectOmDuty(String DUTY_ID_, @RequestParam(value = "DUTY_ID_LIST", required = false) List<String> DUTY_ID_LIST, String DUTY_CODE_, @RequestParam(value = "DUTY_CODE_LIST", required = false) List<String> DUTY_CODE_LIST, String DUTY_NAME_, @RequestParam(value = "DUTY_NAME_LIST", required = false) List<String> DUTY_NAME_LIST, String DUTY_CATEGORY_, @RequestParam(value = "DUTY_CATEGORY_LIST", required = false) List<String> DUTY_CATEGORY_LIST, String DUTY_TAG_, String DUTY_EXT_ATTR_1_, @RequestParam(value = "DUTY_EXT_ATTR_1_LIST", required = false) List<String> DUTY_EXT_ATTR_1_LIST, String DUTY_EXT_ATTR_2_, @RequestParam(value = "DUTY_EXT_ATTR_2_LIST", required = false) List<String> DUTY_EXT_ATTR_2_LIST, String DUTY_EXT_ATTR_3_,
            @RequestParam(value = "DUTY_EXT_ATTR_3_LIST", required = false) List<String> DUTY_EXT_ATTR_3_LIST, String DUTY_EXT_ATTR_4_, @RequestParam(value = "DUTY_EXT_ATTR_4_LIST", required = false) List<String> DUTY_EXT_ATTR_4_LIST, String DUTY_EXT_ATTR_5_, @RequestParam(value = "DUTY_EXT_ATTR_5_LIST", required = false) List<String> DUTY_EXT_ATTR_5_LIST, String DUTY_EXT_ATTR_6_, @RequestParam(value = "DUTY_EXT_ATTR_6_LIST", required = false) List<String> DUTY_EXT_ATTR_6_LIST, String DUTY_EXT_ATTR_7_, @RequestParam(value = "DUTY_EXT_ATTR_7_LIST", required = false) List<String> DUTY_EXT_ATTR_7_LIST, String DUTY_EXT_ATTR_8_, @RequestParam(value = "DUTY_EXT_ATTR_8_LIST", required = false) List<String> DUTY_EXT_ATTR_8_LIST, String DUTY_STATUS_,
            @RequestParam(value = "DUTY_STATUS_LIST", required = false) List<String> DUTY_STATUS_LIST, Boolean dutyTagUnion, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> dutyList = omDutyService.selectDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, DUTY_ID_LIST, DUTY_CODE_, DUTY_CODE_LIST, DUTY_NAME_, DUTY_NAME_LIST, DUTY_CATEGORY_, DUTY_CATEGORY_LIST, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_1_LIST, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_2_LIST, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_3_LIST, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_4_LIST, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_5_LIST, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_6_LIST, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_7_LIST, DUTY_EXT_ATTR_8_, DUTY_EXT_ATTR_8_LIST, DUTY_STATUS_, DUTY_STATUS_LIST, dutyTagUnion, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omDutyService.countDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, DUTY_ID_LIST, DUTY_CODE_, DUTY_CODE_LIST, DUTY_NAME_, DUTY_NAME_LIST, DUTY_CATEGORY_, DUTY_CATEGORY_LIST, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_1_LIST, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_2_LIST, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_3_LIST, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_4_LIST, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_5_LIST, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_6_LIST, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_7_LIST, DUTY_EXT_ATTR_8_, DUTY_EXT_ATTR_8_LIST, DUTY_STATUS_, DUTY_STATUS_LIST, dutyTagUnion, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }

        result.put("dutyList", dutyList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmDutyByIdList")
    @ResponseBody
    public Map<String, Object> selectOmDutyByIdList(@RequestParam(value = "DUTY_ID_LIST", required = false) List<String> DUTY_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> dutyList = omDutyService.selectDutyByIdList(OdConfig.getOrgnSetId(), DUTY_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("dutyList", dutyList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmDuty")
    @ResponseBody
    public Map<String, Object> insertOmDuty(String DUTY_ID_, String DUTY_CODE_, String DUTY_NAME_, String DUTY_CATEGORY_, String MEMO_, String DUTY_TAG_, String DUTY_EXT_ATTR_1_, String DUTY_EXT_ATTR_2_, String DUTY_EXT_ATTR_3_, String DUTY_EXT_ATTR_4_, String DUTY_EXT_ATTR_5_, String DUTY_EXT_ATTR_6_, String DUTY_EXT_ATTR_7_, String DUTY_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omDutyService.insertDuty(OdConfig.getOrgnSetId(), DUTY_ID_, DUTY_CODE_, DUTY_NAME_, DUTY_CATEGORY_, MEMO_, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_8_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("duty", omDutyService.loadDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_ID_")
    @RequestMapping(value = "updateOmDuty")
    @ResponseBody
    public Map<String, Object> updateOmDuty(String DUTY_ID_, String DUTY_CODE_, String DUTY_NAME_, String DUTY_CATEGORY_, String MEMO_, String DUTY_TAG_, String DUTY_EXT_ATTR_1_, String DUTY_EXT_ATTR_2_, String DUTY_EXT_ATTR_3_, String DUTY_EXT_ATTR_4_, String DUTY_EXT_ATTR_5_, String DUTY_EXT_ATTR_6_, String DUTY_EXT_ATTR_7_, String DUTY_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omDutyService.updateDuty(OdConfig.getOrgnSetId(), DUTY_ID_, DUTY_CODE_, DUTY_NAME_, DUTY_CATEGORY_, MEMO_, DUTY_TAG_, DUTY_EXT_ATTR_1_, DUTY_EXT_ATTR_2_, DUTY_EXT_ATTR_3_, DUTY_EXT_ATTR_4_, DUTY_EXT_ATTR_5_, DUTY_EXT_ATTR_6_, DUTY_EXT_ATTR_7_, DUTY_EXT_ATTR_8_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("duty", omDutyService.loadDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmDutyOrder")
    @ResponseBody
    public Map<String, Object> updateOmDutyOrder(@RequestParam(value = "DUTY_ID_LIST", required = true) List<String> DUTY_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omDutyService.updateDutyOrder(OdConfig.getOrgnSetId(), DUTY_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_ID_")
    @RequestMapping(value = "disableOmDuty")
    @ResponseBody
    public Map<String, Object> disableOmDuty(String DUTY_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omDutyService.disableDuty(OdConfig.getOrgnSetId(), DUTY_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("duty", omDutyService.loadDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_ID_")
    @RequestMapping(value = "enableOmDuty")
    @ResponseBody
    public Map<String, Object> enableOmDuty(String DUTY_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omDutyService.enableDuty(OdConfig.getOrgnSetId(), DUTY_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("duty", omDutyService.loadDuty(OdConfig.getOrgnSetId(), null, DUTY_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "DUTY_ID_")
    @RequestMapping(value = "deleteOmDuty")
    @ResponseBody
    public Map<String, Object> deleteOmDuty(String DUTY_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omDutyService.deleteDuty(OdConfig.getOrgnSetId(), DUTY_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}