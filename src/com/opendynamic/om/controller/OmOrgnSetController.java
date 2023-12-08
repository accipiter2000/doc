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
import com.opendynamic.om.service.OmOrgnSetService;
import com.opendynamic.om.vo.OrgnChange;

@Controller
public class OmOrgnSetController extends OdController {
    @Autowired
    private OmOrgnSetService omOrgnSetService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmOrgnSet")
    public String manageOmOrgnSet(Map<String, Object> operator) {
        return "om/OrgnSet/manageOrgnSet";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmOrgnSet")
    public String preChooseOmOrgnSet(Map<String, Object> operator) {
        return "om/OrgnSet/preChooseOrgnSet";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmOrgnSet")
    public String preInsertOmOrgnSet(Map<String, Object> operator) {
        return "om/OrgnSet/preInsertOrgnSet";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmOrgnSet")
    public String preUpdateOmOrgnSet(Map<String, Object> operator) {
        return "om/OrgnSet/preUpdateOrgnSet";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmOrgnSet")
    public String viewOmOrgnSet(Map<String, Object> operator) {
        return "om/OrgnSet/viewOrgnSet";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmOrgnSetSync")
    public String manageOmOrgnSetSync(Map<String, Object> operator) {
        return "om/OrgnSet/manageOrgnSetSync";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "loadOmOrgnSet")
    @ResponseBody
    public Map<String, Object> loadOmOrgnSet(String ORGN_SET_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> orgnSet = omOrgnSetService.loadOrgnSet(ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgnSet", orgnSet);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_CODE_")
    @RequestMapping(value = "loadOmOrgnSetByCode")
    @ResponseBody
    public Map<String, Object> loadOmOrgnSetByCode(String ORGN_SET_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> orgnSet = omOrgnSetService.loadOrgnSetByCode(ORGN_SET_CODE_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgnSet", orgnSet);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmOrgnSet")
    @ResponseBody
    public Map<String, Object> selectOmOrgnSet(String ORGN_SET_ID_, @RequestParam(value = "ORGN_SET_ID_LIST", required = false) List<String> ORGN_SET_ID_LIST, String PARENT_ORGN_SET_ID_, @RequestParam(value = "PARENT_ORGN_SET_ID_LIST", required = false) List<String> PARENT_ORGN_SET_ID_LIST, String ORGN_SET_CODE_, @RequestParam(value = "ORGN_SET_CODE_LIST", required = false) List<String> ORGN_SET_CODE_LIST, String ORGN_SET_NAME_, @RequestParam(value = "ORGN_SET_NAME_LIST", required = false) List<String> ORGN_SET_NAME_LIST, String ORGN_SET_STATUS_, @RequestParam(value = "ORGN_SET_STATUS_LIST", required = false) List<String> ORGN_SET_STATUS_LIST, Boolean orgnSetRootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgnSetList = omOrgnSetService.selectOrgnSet(ORGN_SET_ID_, ORGN_SET_ID_LIST, PARENT_ORGN_SET_ID_, PARENT_ORGN_SET_ID_LIST, ORGN_SET_CODE_, ORGN_SET_CODE_LIST, ORGN_SET_NAME_, ORGN_SET_NAME_LIST, ORGN_SET_STATUS_, ORGN_SET_STATUS_LIST, orgnSetRootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omOrgnSetService.countOrgnSet(ORGN_SET_ID_, ORGN_SET_ID_LIST, PARENT_ORGN_SET_ID_, PARENT_ORGN_SET_ID_LIST, ORGN_SET_CODE_, ORGN_SET_CODE_LIST, ORGN_SET_NAME_, ORGN_SET_NAME_LIST, ORGN_SET_STATUS_, ORGN_SET_STATUS_LIST, orgnSetRootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }
        List<Map<String, Object>> orgnSetListClone = (List<Map<String, Object>>) OdUtils.deepClone(orgnSetList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> orgnSetIdList = OdUtils.collect(orgnSetList, "ORGN_SET_ID_", String.class);
        Map<String, Object> orgnSet;
        for (int i = 0; i < orgnSetListClone.size(); i++) {
            orgnSet = orgnSetListClone.get(i);
            if (orgnSet.get("PARENT_ORGN_SET_ID_") == null || orgnSet.get("PARENT_ORGN_SET_ID_").equals("") || !orgnSetIdList.contains(orgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(orgnSet);
                fillChildOrgnSet(orgnSet, orgnSetListClone);
            }
        }

        result.put("orgnSetList", orgnSetList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildOrgnSet(Map<String, Object> orgnSet, List<Map<String, Object>> orgnSetList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childOrgnSet;
        for (int i = 0; i < orgnSetList.size(); i++) {
            childOrgnSet = orgnSetList.get(i);
            if (orgnSet.get("ORGN_SET_ID_").equals(childOrgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(childOrgnSet);
                fillChildOrgnSet(childOrgnSet, orgnSetList);
            }
        }
        orgnSet.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "selectParentOmOrgnSet")
    @ResponseBody
    public Map<String, Object> selectParentOmOrgnSet(String ORGN_SET_ID_, String ORGN_SET_CODE_, @RequestParam(value = "ORGN_SET_CODE_LIST", required = false) List<String> ORGN_SET_CODE_LIST, String ORGN_SET_NAME_, @RequestParam(value = "ORGN_SET_NAME_LIST", required = false) List<String> ORGN_SET_NAME_LIST, String ORGN_SET_STATUS_, @RequestParam(value = "ORGN_SET_STATUS_LIST", required = false) List<String> ORGN_SET_STATUS_LIST, Boolean orgnSetRootOnly, Boolean recursive, Boolean includeSelf, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgnSetList = omOrgnSetService.selectParentOrgnSet(ORGN_SET_ID_, ORGN_SET_CODE_, ORGN_SET_CODE_LIST, ORGN_SET_NAME_, ORGN_SET_NAME_LIST, ORGN_SET_STATUS_, ORGN_SET_STATUS_LIST, orgnSetRootOnly, recursive, includeSelf, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        List<Map<String, Object>> orgnSetListClone = (List<Map<String, Object>>) OdUtils.deepClone(orgnSetList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> orgnSetIdList = OdUtils.collect(orgnSetList, "ORGN_SET_ID_", String.class);
        Map<String, Object> orgnSet;
        for (int i = 0; i < orgnSetListClone.size(); i++) {
            orgnSet = orgnSetListClone.get(i);
            if (orgnSet.get("PARENT_ORGN_SET_ID_") == null || orgnSet.get("PARENT_ORGN_SET_ID_").equals("") || !orgnSetIdList.contains(orgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(orgnSet);
                fillChildParentOrgnSet(orgnSet, orgnSetListClone);
            }
        }

        result.put("orgnSetList", orgnSetList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildParentOrgnSet(Map<String, Object> orgnSet, List<Map<String, Object>> orgnSetList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childOrgnSet;
        for (int i = 0; i < orgnSetList.size(); i++) {
            childOrgnSet = orgnSetList.get(i);
            if (orgnSet.get("ORGN_SET_ID_").equals(childOrgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(childOrgnSet);
                fillChildParentOrgnSet(childOrgnSet, orgnSetList);
            }
        }
        orgnSet.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "selectChildOmOrgnSet")
    @ResponseBody
    public Map<String, Object> selectChildOmOrgnSet(String ORGN_SET_ID_, String ORGN_SET_CODE_, @RequestParam(value = "ORGN_SET_CODE_LIST", required = false) List<String> ORGN_SET_CODE_LIST, String ORGN_SET_NAME_, @RequestParam(value = "ORGN_SET_NAME_LIST", required = false) List<String> ORGN_SET_NAME_LIST, String ORGN_SET_STATUS_, @RequestParam(value = "ORGN_SET_STATUS_LIST", required = false) List<String> ORGN_SET_STATUS_LIST, Boolean orgnSetRootOnly, Boolean recursive, Boolean includeSelf, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgnSetList = omOrgnSetService.selectChildOrgnSet(ORGN_SET_ID_, ORGN_SET_CODE_, ORGN_SET_CODE_LIST, ORGN_SET_NAME_, ORGN_SET_NAME_LIST, ORGN_SET_STATUS_, ORGN_SET_STATUS_LIST, orgnSetRootOnly, recursive, includeSelf, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        List<Map<String, Object>> orgnSetListClone = (List<Map<String, Object>>) OdUtils.deepClone(orgnSetList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> orgnSetIdList = OdUtils.collect(orgnSetList, "ORGN_SET_ID_", String.class);
        Map<String, Object> orgnSet;
        for (int i = 0; i < orgnSetListClone.size(); i++) {
            orgnSet = orgnSetListClone.get(i);
            if (orgnSet.get("PARENT_ORGN_SET_ID_") == null || orgnSet.get("PARENT_ORGN_SET_ID_").equals("") || !orgnSetIdList.contains(orgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(orgnSet);
                fillChildChildOrgnSet(orgnSet, orgnSetListClone);
            }
        }

        result.put("orgnSetList", orgnSetList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildChildOrgnSet(Map<String, Object> orgnSet, List<Map<String, Object>> orgnSetList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childOrgnSet;
        for (int i = 0; i < orgnSetList.size(); i++) {
            childOrgnSet = orgnSetList.get(i);
            if (orgnSet.get("ORGN_SET_ID_").equals(childOrgnSet.get("PARENT_ORGN_SET_ID_"))) {
                children.add(childOrgnSet);
                fillChildChildOrgnSet(childOrgnSet, orgnSetList);
            }
        }
        orgnSet.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmOrgnSetByIdList")
    @ResponseBody
    public Map<String, Object> selectOmOrgnSetByIdList(@RequestParam(value = "ORGN_SET_ID_LIST", required = false) List<String> ORGN_SET_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgnSetList = omOrgnSetService.selectOrgnSetByIdList(ORGN_SET_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgnSetList", orgnSetList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmOrgnSet")
    @ResponseBody
    public Map<String, Object> insertOmOrgnSet(String ORGN_SET_ID_, String PARENT_ORGN_SET_ID_, String ORGN_SET_CODE_, String ORGN_SET_NAME_, String ALLOW_SYNC_, String MEMO_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.insertOrgnSet(ORGN_SET_ID_, PARENT_ORGN_SET_ID_, ORGN_SET_CODE_, ORGN_SET_NAME_, ALLOW_SYNC_, MEMO_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("orgnSet", omOrgnSetService.loadOrgnSet(ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "updateOmOrgnSet")
    @ResponseBody
    public Map<String, Object> updateOmOrgnSet(String ORGN_SET_ID_, String ORGN_SET_CODE_, String ORGN_SET_NAME_, String ALLOW_SYNC_, String MEMO_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.updateOrgnSet(ORGN_SET_ID_, ORGN_SET_CODE_, ORGN_SET_NAME_, ALLOW_SYNC_, MEMO_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("orgnSet", omOrgnSetService.loadOrgnSet(ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmOrgnSetOrder")
    @ResponseBody
    public Map<String, Object> updateOmOrgnSetOrder(@RequestParam(value = "ORGN_SET_ID_LIST", required = true) List<String> ORGN_SET_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.updateOrgnSetOrder(ORGN_SET_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "moveOmOrgnSet")
    @ResponseBody
    public Map<String, Object> moveOmOrgnSet(String ORGN_SET_ID_, String PARENT_ORGN_SET_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.moveOrgnSet(ORGN_SET_ID_, PARENT_ORGN_SET_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("orgnSet", omOrgnSetService.loadOrgnSet(ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "disableOmOrgnSet")
    @ResponseBody
    public Map<String, Object> disableOmOrgnSet(String ORGN_SET_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.disableOrgnSet(ORGN_SET_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("orgnSet", omOrgnSetService.loadOrgnSet(ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "enableOmOrgnSet")
    @ResponseBody
    public Map<String, Object> enableOmOrgnSet(String ORGN_SET_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.enableOrgnSet(ORGN_SET_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("orgnSet", omOrgnSetService.loadOrgnSet(ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "deleteOmOrgnSet")
    @ResponseBody
    public Map<String, Object> deleteOmOrgnSet(String ORGN_SET_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.deleteOrgnSet(ORGN_SET_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "copyOmOrgnSet")
    @ResponseBody
    public Map<String, Object> copyOmOrgnSet(String BASE_ORGN_SET_ID_, String ORGN_SET_ID_, Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.copyOrgnSet(BASE_ORGN_SET_ID_, ORGN_SET_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "compareOmOrgnSet")
    @ResponseBody
    public Map<String, Object> compareOmOrgnSet(String BASE_ORGN_SET_ID_, String ORGN_SET_ID_, Date UPDATE_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        OrgnChange orgnChange = omOrgnSetService.compareOrgnSet(BASE_ORGN_SET_ID_, ORGN_SET_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgnChange", orgnChange);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORGN_SET_ID_")
    @RequestMapping(value = "replaceOmOrgnSet")
    @ResponseBody
    public Map<String, Object> replaceOmOrgnSet(String BASE_ORGN_SET_ID_, String ORGN_SET_ID_, @RequestParam(value = "INSERT_ORG_ID_LIST", required = false) List<String> INSERT_ORG_ID_LIST, @RequestParam(value = "UPDATE_ORG_ID_LIST", required = false) List<String> UPDATE_ORG_ID_LIST, @RequestParam(value = "DELETE_ORG_ID_LIST", required = false) List<String> DELETE_ORG_ID_LIST, @RequestParam(value = "INSERT_DUTY_ID_LIST", required = false) List<String> INSERT_DUTY_ID_LIST, @RequestParam(value = "UPDATE_DUTY_ID_LIST", required = false) List<String> UPDATE_DUTY_ID_LIST, @RequestParam(value = "DELETE_DUTY_ID_LIST", required = false) List<String> DELETE_DUTY_ID_LIST, @RequestParam(value = "INSERT_POSI_ID_LIST", required = false) List<String> INSERT_POSI_ID_LIST,
            @RequestParam(value = "UPDATE_POSI_ID_LIST", required = false) List<String> UPDATE_POSI_ID_LIST, @RequestParam(value = "DELETE_POSI_ID_LIST", required = false) List<String> DELETE_POSI_ID_LIST, @RequestParam(value = "INSERT_EMP_ID_LIST", required = false) List<String> INSERT_EMP_ID_LIST, @RequestParam(value = "UPDATE_EMP_ID_LIST", required = false) List<String> UPDATE_EMP_ID_LIST, @RequestParam(value = "DELETE_EMP_ID_LIST", required = false) List<String> DELETE_EMP_ID_LIST, @RequestParam(value = "INSERT_POSI_EMP_ID_LIST", required = false) List<String> INSERT_POSI_EMP_ID_LIST, @RequestParam(value = "UPDATE_POSI_EMP_ID_LIST", required = false) List<String> UPDATE_POSI_EMP_ID_LIST,
            @RequestParam(value = "DELETE_POSI_EMP_ID_LIST", required = false) List<String> DELETE_POSI_EMP_ID_LIST, @RequestParam(value = "INSERT_EMP_RELATION_ID_LIST", required = false) List<String> INSERT_EMP_RELATION_ID_LIST, @RequestParam(value = "UPDATE_EMP_RELATION_ID_LIST", required = false) List<String> UPDATE_EMP_RELATION_ID_LIST, @RequestParam(value = "DELETE_EMP_RELATION_ID_LIST", required = false) List<String> DELETE_EMP_RELATION_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgnSetService.replaceOrgnSet(BASE_ORGN_SET_ID_, ORGN_SET_ID_, INSERT_ORG_ID_LIST, UPDATE_ORG_ID_LIST, DELETE_ORG_ID_LIST, INSERT_DUTY_ID_LIST, UPDATE_DUTY_ID_LIST, DELETE_DUTY_ID_LIST, INSERT_POSI_ID_LIST, UPDATE_POSI_ID_LIST, DELETE_POSI_ID_LIST, INSERT_EMP_ID_LIST, UPDATE_EMP_ID_LIST, DELETE_EMP_ID_LIST, INSERT_POSI_EMP_ID_LIST, UPDATE_POSI_EMP_ID_LIST, DELETE_POSI_EMP_ID_LIST, INSERT_EMP_RELATION_ID_LIST, UPDATE_EMP_RELATION_ID_LIST, DELETE_EMP_RELATION_ID_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}