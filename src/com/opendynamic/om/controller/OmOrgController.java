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

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.om.service.OmOrgService;

@Controller
public class OmOrgController extends OdController {
    @Autowired
    private OmOrgService omOrgService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmOrg")
    public String manageOmOrg(Map<String, Object> operator) {
        return "om/Org/manageOrg";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmOrg")
    public String preChooseOmOrg(Map<String, Object> operator) {
        return "om/Org/preChooseOrg";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmOrg")
    public String preInsertOmOrg(Map<String, Object> operator) {
        return "om/Org/preInsertOrg";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmOrg")
    public String preUpdateOmOrg(Map<String, Object> operator) {
        return "om/Org/preUpdateOrg";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmOrg")
    public String viewOmOrg(Map<String, Object> operator) {
        return "om/Org/viewOrg";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "loadOmOrg")
    @ResponseBody
    public Map<String, Object> loadOmOrg(String ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> org = omOrgService.loadOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("org", org);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_CODE_")
    @RequestMapping(value = "loadOmOrgByCode")
    @ResponseBody
    public Map<String, Object> loadOmOrgByCode(String ORG_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> org = omOrgService.loadOrgByCode(OdConfig.getOrgnSetId(), null, ORG_CODE_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("org", org);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmOrg")
    @ResponseBody
    public Map<String, Object> selectOmOrg(String ORG_ID_, @RequestParam(value = "ORG_ID_LIST", required = false) List<String> ORG_ID_LIST, String PARENT_ORG_ID_, @RequestParam(value = "PARENT_ORG_ID_LIST", required = false) List<String> PARENT_ORG_ID_LIST, String ORG_CODE_, @RequestParam(value = "ORG_CODE_LIST", required = false) List<String> ORG_CODE_LIST, String ORG_NAME_, @RequestParam(value = "ORG_NAME_LIST", required = false) List<String> ORG_NAME_LIST, String ORG_TYPE_, @RequestParam(value = "ORG_TYPE_LIST", required = false) List<String> ORG_TYPE_LIST, String ORG_CATEGORY_, @RequestParam(value = "ORG_CATEGORY_LIST", required = false) List<String> ORG_CATEGORY_LIST, String ORG_TAG_, String ORG_EXT_ATTR_1_,
            @RequestParam(value = "ORG_EXT_ATTR_1_LIST", required = false) List<String> ORG_EXT_ATTR_1_LIST, String ORG_EXT_ATTR_2_, @RequestParam(value = "ORG_EXT_ATTR_2_LIST", required = false) List<String> ORG_EXT_ATTR_2_LIST, String ORG_EXT_ATTR_3_, @RequestParam(value = "ORG_EXT_ATTR_3_LIST", required = false) List<String> ORG_EXT_ATTR_3_LIST, String ORG_EXT_ATTR_4_, @RequestParam(value = "ORG_EXT_ATTR_4_LIST", required = false) List<String> ORG_EXT_ATTR_4_LIST, String ORG_EXT_ATTR_5_, @RequestParam(value = "ORG_EXT_ATTR_5_LIST", required = false) List<String> ORG_EXT_ATTR_5_LIST, String ORG_EXT_ATTR_6_, @RequestParam(value = "ORG_EXT_ATTR_6_LIST", required = false) List<String> ORG_EXT_ATTR_6_LIST, String ORG_EXT_ATTR_7_,
            @RequestParam(value = "ORG_EXT_ATTR_7_LIST", required = false) List<String> ORG_EXT_ATTR_7_LIST, String ORG_EXT_ATTR_8_, @RequestParam(value = "ORG_EXT_ATTR_8_LIST", required = false) List<String> ORG_EXT_ATTR_8_LIST, String ORG_STATUS_, @RequestParam(value = "ORG_STATUS_LIST", required = false) List<String> ORG_STATUS_LIST, Boolean orgTagUnion, String withinOrgId, Boolean orgRootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgList = omOrgService.selectOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, orgTagUnion, withinOrgId, orgRootOnly, page, limit, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        int total = 0;
        if (limit != null && limit > 0) {
            total = omOrgService.countOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, ORG_ID_LIST, PARENT_ORG_ID_, PARENT_ORG_ID_LIST, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, orgTagUnion, withinOrgId, orgRootOnly, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }
        List<Map<String, Object>> orgListClone = (List<Map<String, Object>>) OdUtils.deepClone(orgList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> orgIdList = OdUtils.collect(orgList, "ORG_ID_", String.class);
        Map<String, Object> org;
        for (int i = 0; i < orgListClone.size(); i++) {
            org = orgListClone.get(i);
            if (org.get("PARENT_ORG_ID_") == null || org.get("PARENT_ORG_ID_").equals("") || !orgIdList.contains(org.get("PARENT_ORG_ID_"))) {
                children.add(org);
                fillChildOrg(org, orgListClone);
            }
        }

        result.put("orgList", orgList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildOrg(Map<String, Object> org, List<Map<String, Object>> orgList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childOrg;
        for (int i = 0; i < orgList.size(); i++) {
            childOrg = orgList.get(i);
            if (org.get("ORG_ID_").equals(childOrg.get("PARENT_ORG_ID_"))) {
                children.add(childOrg);
                fillChildOrg(childOrg, orgList);
            }
        }
        org.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "selectParentOmOrg")
    @ResponseBody
    public Map<String, Object> selectParentOmOrg(String ORG_ID_, String ORG_CODE_, @RequestParam(value = "ORG_CODE_LIST", required = false) List<String> ORG_CODE_LIST, String ORG_NAME_, @RequestParam(value = "ORG_NAME_LIST", required = false) List<String> ORG_NAME_LIST, String ORG_TYPE_, @RequestParam(value = "ORG_TYPE_LIST", required = false) List<String> ORG_TYPE_LIST, String ORG_CATEGORY_, @RequestParam(value = "ORG_CATEGORY_LIST", required = false) List<String> ORG_CATEGORY_LIST, String ORG_TAG_, String ORG_EXT_ATTR_1_, @RequestParam(value = "ORG_EXT_ATTR_1_LIST", required = false) List<String> ORG_EXT_ATTR_1_LIST, String ORG_EXT_ATTR_2_, @RequestParam(value = "ORG_EXT_ATTR_2_LIST", required = false) List<String> ORG_EXT_ATTR_2_LIST, String ORG_EXT_ATTR_3_,
            @RequestParam(value = "ORG_EXT_ATTR_3_LIST", required = false) List<String> ORG_EXT_ATTR_3_LIST, String ORG_EXT_ATTR_4_, @RequestParam(value = "ORG_EXT_ATTR_4_LIST", required = false) List<String> ORG_EXT_ATTR_4_LIST, String ORG_EXT_ATTR_5_, @RequestParam(value = "ORG_EXT_ATTR_5_LIST", required = false) List<String> ORG_EXT_ATTR_5_LIST, String ORG_EXT_ATTR_6_, @RequestParam(value = "ORG_EXT_ATTR_6_LIST", required = false) List<String> ORG_EXT_ATTR_6_LIST, String ORG_EXT_ATTR_7_, @RequestParam(value = "ORG_EXT_ATTR_7_LIST", required = false) List<String> ORG_EXT_ATTR_7_LIST, String ORG_EXT_ATTR_8_, @RequestParam(value = "ORG_EXT_ATTR_8_LIST", required = false) List<String> ORG_EXT_ATTR_8_LIST, String ORG_STATUS_,
            @RequestParam(value = "ORG_STATUS_LIST", required = false) List<String> ORG_STATUS_LIST, Boolean orgTagUnion, String withinOrgId, Boolean orgRootOnly, Boolean recursive, Boolean includeSelf, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgList = omOrgService.selectParentOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, orgTagUnion, withinOrgId, orgRootOnly, recursive, includeSelf, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        List<Map<String, Object>> orgListClone = (List<Map<String, Object>>) OdUtils.deepClone(orgList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> orgIdList = OdUtils.collect(orgList, "ORG_ID_", String.class);
        Map<String, Object> org;
        for (int i = 0; i < orgListClone.size(); i++) {
            org = orgListClone.get(i);
            if (org.get("PARENT_ORG_ID_") == null || org.get("PARENT_ORG_ID_").equals("") || !orgIdList.contains(org.get("PARENT_ORG_ID_"))) {
                children.add(org);
                fillChildParentOrg(org, orgListClone);
            }
        }

        result.put("orgList", orgList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildParentOrg(Map<String, Object> org, List<Map<String, Object>> orgList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childOrg;
        for (int i = 0; i < orgList.size(); i++) {
            childOrg = orgList.get(i);
            if (org.get("ORG_ID_").equals(childOrg.get("PARENT_ORG_ID_"))) {
                children.add(childOrg);
                fillChildParentOrg(childOrg, orgList);
            }
        }
        org.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "selectChildOmOrg")
    @ResponseBody
    public Map<String, Object> selectChildOmOrg(String ORG_ID_, String ORG_CODE_, @RequestParam(value = "ORG_CODE_LIST", required = false) List<String> ORG_CODE_LIST, String ORG_NAME_, @RequestParam(value = "ORG_NAME_LIST", required = false) List<String> ORG_NAME_LIST, String ORG_TYPE_, @RequestParam(value = "ORG_TYPE_LIST", required = false) List<String> ORG_TYPE_LIST, String ORG_CATEGORY_, @RequestParam(value = "ORG_CATEGORY_LIST", required = false) List<String> ORG_CATEGORY_LIST, String ORG_TAG_, String ORG_EXT_ATTR_1_, @RequestParam(value = "ORG_EXT_ATTR_1_LIST", required = false) List<String> ORG_EXT_ATTR_1_LIST, String ORG_EXT_ATTR_2_, @RequestParam(value = "ORG_EXT_ATTR_2_LIST", required = false) List<String> ORG_EXT_ATTR_2_LIST, String ORG_EXT_ATTR_3_,
            @RequestParam(value = "ORG_EXT_ATTR_3_LIST", required = false) List<String> ORG_EXT_ATTR_3_LIST, String ORG_EXT_ATTR_4_, @RequestParam(value = "ORG_EXT_ATTR_4_LIST", required = false) List<String> ORG_EXT_ATTR_4_LIST, String ORG_EXT_ATTR_5_, @RequestParam(value = "ORG_EXT_ATTR_5_LIST", required = false) List<String> ORG_EXT_ATTR_5_LIST, String ORG_EXT_ATTR_6_, @RequestParam(value = "ORG_EXT_ATTR_6_LIST", required = false) List<String> ORG_EXT_ATTR_6_LIST, String ORG_EXT_ATTR_7_, @RequestParam(value = "ORG_EXT_ATTR_7_LIST", required = false) List<String> ORG_EXT_ATTR_7_LIST, String ORG_EXT_ATTR_8_, @RequestParam(value = "ORG_EXT_ATTR_8_LIST", required = false) List<String> ORG_EXT_ATTR_8_LIST, String ORG_STATUS_,
            @RequestParam(value = "ORG_STATUS_LIST", required = false) List<String> ORG_STATUS_LIST, Boolean orgTagUnion, String withinOrgId, Boolean orgRootOnly, Boolean recursive, Boolean includeSelf, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgList = omOrgService.selectChildOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, ORG_CODE_, ORG_CODE_LIST, ORG_NAME_, ORG_NAME_LIST, ORG_TYPE_, ORG_TYPE_LIST, ORG_CATEGORY_, ORG_CATEGORY_LIST, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_1_LIST, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_2_LIST, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_3_LIST, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_4_LIST, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_5_LIST, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_6_LIST, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_7_LIST, ORG_EXT_ATTR_8_, ORG_EXT_ATTR_8_LIST, ORG_STATUS_, ORG_STATUS_LIST, orgTagUnion, withinOrgId, orgRootOnly, recursive, includeSelf, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        List<Map<String, Object>> orgListClone = (List<Map<String, Object>>) OdUtils.deepClone(orgList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> orgIdList = OdUtils.collect(orgList, "ORG_ID_", String.class);
        Map<String, Object> org;
        for (int i = 0; i < orgListClone.size(); i++) {
            org = orgListClone.get(i);
            if (org.get("PARENT_ORG_ID_") == null || org.get("PARENT_ORG_ID_").equals("") || !orgIdList.contains(org.get("PARENT_ORG_ID_"))) {
                children.add(org);
                fillChildChildOrg(org, orgListClone);
            }
        }

        result.put("orgList", orgList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildChildOrg(Map<String, Object> org, List<Map<String, Object>> orgList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childOrg;
        for (int i = 0; i < orgList.size(); i++) {
            childOrg = orgList.get(i);
            if (org.get("ORG_ID_").equals(childOrg.get("PARENT_ORG_ID_"))) {
                children.add(childOrg);
                fillChildChildOrg(childOrg, orgList);
            }
        }
        org.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmOrgByIdList")
    @ResponseBody
    public Map<String, Object> selectOmOrgByIdList(@RequestParam(value = "ORG_ID_LIST", required = false) List<String> ORG_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> orgList = omOrgService.selectOrgByIdList(OdConfig.getOrgnSetId(), ORG_ID_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("orgList", orgList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmOrg")
    @ResponseBody
    public Map<String, Object> insertOmOrg(String ORG_ID_, String PARENT_ORG_ID_, String ORG_CODE_, String ORG_NAME_, String ORG_ABBR_NAME_, String ORG_TYPE_, String ORG_CATEGORY_, String MEMO_, String ORG_TAG_, String ORG_EXT_ATTR_1_, String ORG_EXT_ATTR_2_, String ORG_EXT_ATTR_3_, String ORG_EXT_ATTR_4_, String ORG_EXT_ATTR_5_, String ORG_EXT_ATTR_6_, String ORG_EXT_ATTR_7_, String ORG_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.insertOrg(OdConfig.getOrgnSetId(), ORG_ID_, PARENT_ORG_ID_, ORG_CODE_, ORG_NAME_, ORG_ABBR_NAME_, ORG_TYPE_, ORG_CATEGORY_, MEMO_, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_8_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("org", omOrgService.loadOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "updateOmOrg")
    @ResponseBody
    public Map<String, Object> updateOmOrg(String ORG_ID_, String ORG_CODE_, String ORG_NAME_, String ORG_ABBR_NAME_, String ORG_TYPE_, String ORG_CATEGORY_, String MEMO_, String ORG_TAG_, String ORG_EXT_ATTR_1_, String ORG_EXT_ATTR_2_, String ORG_EXT_ATTR_3_, String ORG_EXT_ATTR_4_, String ORG_EXT_ATTR_5_, String ORG_EXT_ATTR_6_, String ORG_EXT_ATTR_7_, String ORG_EXT_ATTR_8_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.updateOrg(OdConfig.getOrgnSetId(), ORG_ID_, ORG_CODE_, ORG_NAME_, ORG_ABBR_NAME_, ORG_TYPE_, ORG_CATEGORY_, MEMO_, ORG_TAG_, ORG_EXT_ATTR_1_, ORG_EXT_ATTR_2_, ORG_EXT_ATTR_3_, ORG_EXT_ATTR_4_, ORG_EXT_ATTR_5_, ORG_EXT_ATTR_6_, ORG_EXT_ATTR_7_, ORG_EXT_ATTR_8_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("org", omOrgService.loadOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmOrgOrder")
    @ResponseBody
    public Map<String, Object> updateOmOrgOrder(@RequestParam(value = "ORG_ID_LIST", required = true) List<String> ORG_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.updateOrgOrder(OdConfig.getOrgnSetId(), ORG_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "moveOmOrg")
    @ResponseBody
    public Map<String, Object> moveOmOrg(String ORG_ID_, String PARENT_ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.moveOrg(OdConfig.getOrgnSetId(), ORG_ID_, PARENT_ORG_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("org", omOrgService.loadOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "disableOmOrg")
    @ResponseBody
    public Map<String, Object> disableOmOrg(String ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.disableOrg(OdConfig.getOrgnSetId(), ORG_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("org", omOrgService.loadOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "enableOmOrg")
    @ResponseBody
    public Map<String, Object> enableOmOrg(String ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.enableOrg(OdConfig.getOrgnSetId(), ORG_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("org", omOrgService.loadOrg(OdConfig.getOrgnSetId(), null, ORG_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "ORG_ID_")
    @RequestMapping(value = "deleteOmOrg")
    @ResponseBody
    public Map<String, Object> deleteOmOrg(String ORG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omOrgService.deleteOrg(OdConfig.getOrgnSetId(), ORG_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}