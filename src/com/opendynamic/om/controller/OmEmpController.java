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
import com.opendynamic.om.service.OmEmpService;

@Controller
public class OmEmpController extends OdController {
    @Autowired
    private OmEmpService omEmpService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmEmp")
    public String manageOmEmp(Map<String, Object> operator) {
        return "om/Emp/manageEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmEmp")
    public String preChooseOmEmp(Map<String, Object> operator) {
        return "om/Emp/preChooseEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmEmp")
    public String preInsertOmEmp(Map<String, Object> operator) {
        return "om/Emp/preInsertEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmEmp")
    public String preUpdateOmEmp(Map<String, Object> operator) {
        return "om/Emp/preUpdateEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmMyEmpPassword")
    public String preUpdateOmMyEmpPassword(Map<String, Object> operator) {
        return "om/Emp/preUpdateMyEmpPassword";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmEmp")
    public String viewOmEmp(Map<String, Object> operator) {
        return "om/Emp/viewEmp";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "loadOmEmp")
    @ResponseBody
    public Map<String, Object> loadOmEmp(String EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> emp = omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("emp", emp);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_CODE_")
    @RequestMapping(value = "loadOmEmpByCode")
    @ResponseBody
    public Map<String, Object> loadOmEmpByCode(String EMP_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> emp = omEmpService.loadEmpByCode(OdConfig.getOrgnSetId(), null, EMP_CODE_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("emp", emp);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = false, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_CODE_")
    @RequestMapping(value = "loadOmEmpByPassword")
    @ResponseBody
    public Map<String, Object> loadOmEmpByPassword(String EMP_CODE_, String PASSWORD_) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> emp = omEmpService.loadEmpByPassword(OdConfig.getOrgnSetId(), null, EMP_CODE_, PASSWORD_, null, null);

        result.put("emp", emp);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmEmp")
    @ResponseBody
    public Map<String, Object> selectOmEmp(String EMP_ID_, @RequestParam(value = "EMP_ID_LIST", required = false) List<String> EMP_ID_LIST, String EMP_CODE_, @RequestParam(value = "EMP_CODE_LIST", required = false) List<String> EMP_CODE_LIST, String EMP_NAME_, @RequestParam(value = "EMP_NAME_LIST", required = false) List<String> EMP_NAME_LIST, String EMP_CATEGORY_, @RequestParam(value = "EMP_CATEGORY_LIST", required = false) List<String> EMP_CATEGORY_LIST, String EMP_TAG_, String EMP_EXT_ATTR_1_, @RequestParam(value = "EMP_EXT_ATTR_1_LIST", required = false) List<String> EMP_EXT_ATTR_1_LIST, String EMP_EXT_ATTR_2_, @RequestParam(value = "EMP_EXT_ATTR_2_LIST", required = false) List<String> EMP_EXT_ATTR_2_LIST, String EMP_EXT_ATTR_3_,
            @RequestParam(value = "EMP_EXT_ATTR_3_LIST", required = false) List<String> EMP_EXT_ATTR_3_LIST, String EMP_EXT_ATTR_4_, @RequestParam(value = "EMP_EXT_ATTR_4_LIST", required = false) List<String> EMP_EXT_ATTR_4_LIST, String EMP_EXT_ATTR_5_, @RequestParam(value = "EMP_EXT_ATTR_5_LIST", required = false) List<String> EMP_EXT_ATTR_5_LIST, String EMP_EXT_ATTR_6_, @RequestParam(value = "EMP_EXT_ATTR_6_LIST", required = false) List<String> EMP_EXT_ATTR_6_LIST, String EMP_EXT_ATTR_7_, @RequestParam(value = "EMP_EXT_ATTR_7_LIST", required = false) List<String> EMP_EXT_ATTR_7_LIST, String EMP_EXT_ATTR_8_, @RequestParam(value = "EMP_EXT_ATTR_8_LIST", required = false) List<String> EMP_EXT_ATTR_8_LIST, String EMP_STATUS_,
            @RequestParam(value = "EMP_STATUS_LIST", required = false) List<String> EMP_STATUS_LIST, String ORG_ID_, @RequestParam(value = "ORG_ID_LIST", required = false) List<String> ORG_ID_LIST, String PARENT_ORG_ID_, @RequestParam(value = "PARENT_ORG_ID_LIST", required = false) List<String> PARENT_ORG_ID_LIST, String ORG_CODE_, @RequestParam(value = "ORG_CODE_LIST", required = false) List<String> ORG_CODE_LIST, String ORG_NAME_, @RequestParam(value = "ORG_NAME_LIST", required = false) List<String> ORG_NAME_LIST, String ORG_TYPE_, @RequestParam(value = "ORG_TYPE_LIST", required = false) List<String> ORG_TYPE_LIST, String ORG_CATEGORY_, @RequestParam(value = "ORG_CATEGORY_LIST", required = false) List<String> ORG_CATEGORY_LIST, String ORG_TAG_, String ORG_EXT_ATTR_1_,
            @RequestParam(value = "ORG_EXT_ATTR_1_LIST", required = false) List<String> ORG_EXT_ATTR_1_LIST, String ORG_EXT_ATTR_2_, @RequestParam(value = "ORG_EXT_ATTR_2_LIST", required = false) List<String> ORG_EXT_ATTR_2_LIST, String ORG_EXT_ATTR_3_, @RequestParam(value = "ORG_EXT_ATTR_3_LIST", required = false) List<String> ORG_EXT_ATTR_3_LIST, String ORG_EXT_ATTR_4_, @RequestParam(value = "ORG_EXT_ATTR_4_LIST", required = false) List<String> ORG_EXT_ATTR_4_LIST, String ORG_EXT_ATTR_5_, @RequestParam(value = "ORG_EXT_ATTR_5_LIST", required = false) List<String> ORG_EXT_ATTR_5_LIST, String ORG_EXT_ATTR_6_, @RequestParam(value = "ORG_EXT_ATTR_6_LIST", required = false) List<String> ORG_EXT_ATTR_6_LIST, String ORG_EXT_ATTR_7_,
            @RequestParam(value = "ORG_EXT_ATTR_7_LIST", required = false) List<String> ORG_EXT_ATTR_7_LIST, String ORG_EXT_ATTR_8_, @RequestParam(value = "ORG_EXT_ATTR_8_LIST", required = false) List<String> ORG_EXT_ATTR_8_LIST, String ORG_STATUS_, @RequestParam(value = "ORG_STATUS_LIST", required = false) List<String> ORG_STATUS_LIST, Boolean empTagUnion, Boolean orgTagUnion, String withinOrgId, Boolean orgRootOnly, Integer page, Integer limit, String OPERATOR_ID_, String OPERATOR_NAME_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> empList = omEmpService.selectEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, EMP_ID_LIST, EMP_CODE_, EMP_CODE_LIST, EMP_NAME_, EMP_NAME_LIST, EMP_CATEGORY_, EMP_CATEGORY_LIST, EMP_TAG_, EMP_EXT_ATTR_1_, EMP_EXT_ATTR_1_LIST, EMP_EXT_ATTR_2_, EMP_EXT_ATTR_2_LIST, EMP_EXT_ATTR_3_, EMP_EXT_ATTR_3_LIST, EMP_EXT_ATTR_4_, EMP_EXT_ATTR_4_LIST, EMP_EXT_ATTR_5_, EMP_EXT_ATTR_5_LIST, EMP_EXT_ATTR_6_, EMP_EXT_ATTR_6_LIST, EMP_EXT_ATTR_7_, EMP_EXT_ATTR_7_LIST, EMP_EXT_ATTR_8_, EMP_EXT_ATTR_8_LIST, EMP_STATUS_, EMP_STATUS_LIST, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_,
                ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, empTagUnion, orgTagUnion, withinOrgId, orgRootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omEmpService.countEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, EMP_ID_LIST, EMP_CODE_, EMP_CODE_LIST, EMP_NAME_, EMP_NAME_LIST, EMP_CATEGORY_, EMP_CATEGORY_LIST, EMP_TAG_, EMP_EXT_ATTR_1_, EMP_EXT_ATTR_1_LIST, EMP_EXT_ATTR_2_, EMP_EXT_ATTR_2_LIST, EMP_EXT_ATTR_3_, EMP_EXT_ATTR_3_LIST, EMP_EXT_ATTR_4_, EMP_EXT_ATTR_4_LIST, EMP_EXT_ATTR_5_, EMP_EXT_ATTR_5_LIST, EMP_EXT_ATTR_6_, EMP_EXT_ATTR_6_LIST, EMP_EXT_ATTR_7_, EMP_EXT_ATTR_7_LIST, EMP_EXT_ATTR_8_, EMP_EXT_ATTR_8_LIST, EMP_STATUS_, EMP_STATUS_LIST, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_,
                    ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, empTagUnion, orgTagUnion, withinOrgId, orgRootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }

        result.put("empList", empList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmEmpByIdList")
    @ResponseBody
    public Map<String, Object> selectOmEmpByIdList(@RequestParam(value = "EMP_ID_LIST", required = false) List<String> EMP_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> empList = omEmpService.selectEmpByIdList(OdConfig.getOrgnSetId(), EMP_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("empList", empList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmEmp")
    @ResponseBody
    public Map<String, Object> insertOmEmp(String EMP_ID_, String ORG_ID_, String EMP_CODE_, String EMP_NAME_, String PASSWORD_, String PASSWORD_RESET_REQ_, String PARTY_, String EMP_LEVEL_, String GENDER_, Date BIRTH_DATE_, String TEL_, String EMAIL_, Date IN_DATE_, Date OUT_DATE_, String EMP_CATEGORY_, String MEMO_, String EMP_TAG_, String EMP_EXT_ATTR_1_, String EMP_EXT_ATTR_2_, String EMP_EXT_ATTR_3_, String EMP_EXT_ATTR_4_, String EMP_EXT_ATTR_5_, String EMP_EXT_ATTR_6_, String EMP_EXT_ATTR_7_, String EMP_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.insertEmp(OdConfig.getOrgnSetId(), EMP_ID_, ORG_ID_, EMP_CODE_, EMP_NAME_, PASSWORD_, PASSWORD_RESET_REQ_, PARTY_, EMP_LEVEL_, GENDER_, BIRTH_DATE_, TEL_, EMAIL_, IN_DATE_, OUT_DATE_, EMP_CATEGORY_, MEMO_, EMP_TAG_, EMP_EXT_ATTR_1_, EMP_EXT_ATTR_2_, EMP_EXT_ATTR_3_, EMP_EXT_ATTR_4_, EMP_EXT_ATTR_5_, EMP_EXT_ATTR_6_, EMP_EXT_ATTR_7_, EMP_EXT_ATTR_8_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("emp", omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "updateOmEmp")
    @ResponseBody
    public Map<String, Object> updateOmEmp(String EMP_ID_, String EMP_CODE_, String EMP_NAME_, String PARTY_, String EMP_LEVEL_, String GENDER_, Date BIRTH_DATE_, String TEL_, String EMAIL_, Date IN_DATE_, Date OUT_DATE_, String EMP_CATEGORY_, String MEMO_, String EMP_TAG_, String EMP_EXT_ATTR_1_, String EMP_EXT_ATTR_2_, String EMP_EXT_ATTR_3_, String EMP_EXT_ATTR_4_, String EMP_EXT_ATTR_5_, String EMP_EXT_ATTR_6_, String EMP_EXT_ATTR_7_, String EMP_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.updateEmp(OdConfig.getOrgnSetId(), EMP_ID_, EMP_CODE_, EMP_NAME_, PARTY_, EMP_LEVEL_, GENDER_, BIRTH_DATE_, TEL_, EMAIL_, IN_DATE_, OUT_DATE_, EMP_CATEGORY_, MEMO_, EMP_TAG_, EMP_EXT_ATTR_1_, EMP_EXT_ATTR_2_, EMP_EXT_ATTR_3_, EMP_EXT_ATTR_4_, EMP_EXT_ATTR_5_, EMP_EXT_ATTR_6_, EMP_EXT_ATTR_7_, EMP_EXT_ATTR_8_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("emp", omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmMyEmpPassword")
    @ResponseBody
    public Map<String, Object> updateOmMyEmpPassword(String OLD_PASSWORD_, String NEW_PASSWORD_, Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.updateEmpPassword(OdConfig.getOrgnSetId(), (String) operator.get("EMP_ID_"), OLD_PASSWORD_, NEW_PASSWORD_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "resetOmEmpPassword")
    @ResponseBody
    public Map<String, Object> resetOmEmpPassword(String EMP_ID_, String PASSWORD_, Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.resetEmpPassword(OdConfig.getOrgnSetId(), EMP_ID_, PASSWORD_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("emp", omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmEmpOrder")
    @ResponseBody
    public Map<String, Object> updateOmEmpOrder(@RequestParam(value = "EMP_ID_LIST", required = true) List<String> EMP_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.updateEmpOrder(OdConfig.getOrgnSetId(), EMP_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "moveOmEmp")
    @ResponseBody
    public Map<String, Object> moveOmEmp(String EMP_ID_, String ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.moveEmp(OdConfig.getOrgnSetId(), EMP_ID_, ORG_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("emp", omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "disableOmEmp")
    @ResponseBody
    public Map<String, Object> disableOmEmp(String EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.disableEmp(OdConfig.getOrgnSetId(), EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("emp", omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "enableOmEmp")
    @ResponseBody
    public Map<String, Object> enableOmEmp(String EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.enableEmp(OdConfig.getOrgnSetId(), EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("emp", omEmpService.loadEmp(OdConfig.getOrgnSetId(), null, EMP_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "EMP_ID_")
    @RequestMapping(value = "deleteOmEmp")
    @ResponseBody
    public Map<String, Object> deleteOmEmp(String EMP_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omEmpService.deleteEmp(OdConfig.getOrgnSetId(), EMP_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}