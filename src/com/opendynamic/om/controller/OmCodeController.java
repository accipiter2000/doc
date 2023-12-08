package com.opendynamic.om.controller;

import java.util.ArrayList;
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
import com.opendynamic.om.service.OmCodeService;

@Controller
public class OmCodeController extends OdController {
    @Autowired
    private OmCodeService omCodeService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmCode")
    public String manageOmCode() {
        return "om/Code/manageCode";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preChooseOmCode")
    public String preChooseOmCode() {
        return "om/Code/preChooseCode";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmCode")
    public String preInsertOmCode() {
        return "om/Code/preInsertCode";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmCode")
    public String preUpdateOmCode() {
        return "om/Code/preUpdateCode";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmCode")
    public String viewOmCode() {
        return "om/Code/viewCode";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "loadOmCode")
    @ResponseBody
    public Map<String, Object> loadOmCode(String CODE_ID_) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> code = omCodeService.loadCode(CODE_ID_);

        result.put("code", code);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmCode")
    @ResponseBody
    public Map<String, Object> selectOmCode(String CODE_ID_, String PARENT_CODE_ID_, @RequestParam(value = "CATEGORY_LIST", required = false) List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly, Integer page, Integer limit) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> codeList = omCodeService.selectCode(CODE_ID_, PARENT_CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, rootOnly, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = omCodeService.countCode(CODE_ID_, PARENT_CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, rootOnly);
        }
        List<Map<String, Object>> codeListClone = (List<Map<String, Object>>) OdUtils.deepClone(codeList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> codeIdList = OdUtils.collect(codeList, "CODE_ID_", String.class);
        Map<String, Object> code;
        for (int i = 0; i < codeListClone.size(); i++) {
            code = codeListClone.get(i);
            if (code.get("PARENT_CODE_ID_") == null || code.get("PARENT_CODE_ID_").equals("") || !codeIdList.contains(code.get("PARENT_CODE_ID_"))) {
                children.add(code);
                fillChildCode(code, codeListClone);
            }
        }

        result.put("codeList", codeList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildCode(Map<String, Object> code, List<Map<String, Object>> codeList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childCode;
        for (int i = 0; i < codeList.size(); i++) {
            childCode = codeList.get(i);
            if (code.get("CODE_ID_").equals(childCode.get("PARENT_CODE_ID_"))) {
                children.add(childCode);
                fillChildCode(childCode, codeList);
            }
        }
        code.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "selectParentOmCode")
    @ResponseBody
    public Map<String, Object> selectParentOmCode(String CODE_ID_, @RequestParam(value = "CATEGORY_LIST", required = false) List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> codeList = omCodeService.selectParentCode(CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, recursive, includeSelf);
        List<Map<String, Object>> codeListClone = (List<Map<String, Object>>) OdUtils.deepClone(codeList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> codeIdList = OdUtils.collect(codeList, "CODE_ID_", String.class);
        Map<String, Object> code;
        for (int i = 0; i < codeListClone.size(); i++) {
            code = codeListClone.get(i);
            if (code.get("PARENT_CODE_ID_") == null || code.get("PARENT_CODE_ID_").equals("") || !codeIdList.contains(code.get("PARENT_CODE_ID_"))) {
                children.add(code);
                fillChildParentCode(code, codeListClone);
            }
        }

        result.put("codeList", codeList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildParentCode(Map<String, Object> code, List<Map<String, Object>> codeList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childCode;
        for (int i = 0; i < codeList.size(); i++) {
            childCode = codeList.get(i);
            if (code.get("CODE_ID_").equals(childCode.get("PARENT_CODE_ID_"))) {
                children.add(childCode);
                fillChildParentCode(childCode, codeList);
            }
        }
        code.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "selectChildOmCode")
    @ResponseBody
    public Map<String, Object> selectChildOmCode(String CODE_ID_, @RequestParam(value = "CATEGORY_LIST", required = false) List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> codeList = omCodeService.selectChildCode(CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, recursive, includeSelf);
        List<Map<String, Object>> codeListClone = (List<Map<String, Object>>) OdUtils.deepClone(codeList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> codeIdList = OdUtils.collect(codeList, "CODE_ID_", String.class);
        Map<String, Object> code;
        for (int i = 0; i < codeListClone.size(); i++) {
            code = codeListClone.get(i);
            if (code.get("PARENT_CODE_ID_") == null || code.get("PARENT_CODE_ID_").equals("") || !codeIdList.contains(code.get("PARENT_CODE_ID_"))) {
                children.add(code);
                fillChildChildCode(code, codeListClone);
            }
        }

        result.put("codeList", codeList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildChildCode(Map<String, Object> code, List<Map<String, Object>> codeList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childCode;
        for (int i = 0; i < codeList.size(); i++) {
            childCode = codeList.get(i);
            if (code.get("CODE_ID_").equals(childCode.get("PARENT_CODE_ID_"))) {
                children.add(childCode);
                fillChildChildCode(childCode, codeList);
            }
        }
        code.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmCodeCategory")
    @ResponseBody
    public Map<String, Object> selectOmCodeCategory() {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> codeCategoryList = omCodeService.selectCodeCategory();

        result.put("codeCategoryList", codeCategoryList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmCodeByIdList")
    @ResponseBody
    public Map<String, Object> selectOmCodeByIdList(@RequestParam(value = "CODE_ID_LIST", required = false) List<String> CODE_ID_LIST) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> codeList = omCodeService.selectCodeByIdList(CODE_ID_LIST);

        result.put("codeList", codeList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmCode")
    @ResponseBody
    public Map<String, Object> insertOmCode(String CODE_ID_, String PARENT_CODE_ID_, String CATEGORY_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omCodeService.insertCode(CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("code", omCodeService.loadCode(CODE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "updateOmCode")
    @ResponseBody
    public Map<String, Object> updateOmCode(String CODE_ID_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omCodeService.updateCode(CODE_ID_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("code", omCodeService.loadCode(CODE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmCodeOrder")
    @ResponseBody
    public Map<String, Object> updateOmCodeOrder(@RequestParam(value = "CODE_ID_LIST", required = true) List<String> CODE_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omCodeService.updateCodeOrder(CODE_ID_LIST, ORDER_LIST) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "moveOmCode")
    @ResponseBody
    public Map<String, Object> moveOmCode(String CODE_ID_, String PARENT_CODE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omCodeService.moveCode(CODE_ID_, PARENT_CODE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("code", omCodeService.loadCode(CODE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "deleteOmCode")
    @ResponseBody
    public Map<String, Object> deleteOmCode(String CODE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omCodeService.deleteCode(CODE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}