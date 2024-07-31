package com.opendynamic.cb.controller;

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
import com.opendynamic.cb.service.CodeService;

@Controller
public class CodeController extends OdController {
    @Autowired
    private CodeService codeService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageCode")
    public String manageCode() {
        return "cb/Code/manageCode";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preChooseCode")
    public String preChooseCode() {
        return "cb/Code/preChooseCode";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertCode")
    public String preInsertCode() {
        return "cb/Code/preInsertCode";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateCode")
    public String preUpdateCode() {
        return "cb/Code/preUpdateCode";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewCode")
    public String viewCode() {
        return "cb/Code/viewCode";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "loadCode")
    @ResponseBody
    public Map<String, Object> loadCode(String CODE_ID_) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> code = codeService.loadCode(CODE_ID_);

        result.put("code", code);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCode")
    @ResponseBody
    public Map<String, Object> selectCode(String CODE_ID_, String PARENT_CODE_ID_, @RequestParam(value = "CATEGORY_LIST", required = false) List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean rootOnly, Integer page, Integer limit) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> codeList = codeService.selectCode(CODE_ID_, PARENT_CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, rootOnly, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = codeService.countCode(CODE_ID_, PARENT_CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, rootOnly);
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
    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "selectParentCode")
    @ResponseBody
    public Map<String, Object> selectParentCode(String CODE_ID_, @RequestParam(value = "CATEGORY_LIST", required = false) List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> codeList = codeService.selectParentCode(CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, recursive, includeSelf);
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
    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "selectChildCode")
    @ResponseBody
    public Map<String, Object> selectChildCode(String CODE_ID_, @RequestParam(value = "CATEGORY_LIST", required = false) List<String> CATEGORY_LIST, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Boolean recursive, Boolean includeSelf) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> codeList = codeService.selectChildCode(CODE_ID_, CATEGORY_LIST, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, recursive, includeSelf);
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

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCodeCategory")
    @ResponseBody
    public Map<String, Object> selectCodeCategory() {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> codeCategoryList = codeService.selectCodeCategory();

        result.put("codeCategoryList", codeCategoryList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCodeByIdList")
    @ResponseBody
    public Map<String, Object> selectCodeByIdList(@RequestParam(value = "CODE_ID_LIST", required = false) List<String> CODE_ID_LIST) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> codeList = codeService.selectCodeByIdList(CODE_ID_LIST);

        result.put("codeList", codeList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertCode")
    @ResponseBody
    public Map<String, Object> insertCode(String CODE_ID_, String PARENT_CODE_ID_, String CATEGORY_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (codeService.insertCode(CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("code", codeService.loadCode(CODE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "updateCode")
    @ResponseBody
    public Map<String, Object> updateCode(String CODE_ID_, String CODE_, String NAME_, String EXT_ATTR_1_, String EXT_ATTR_2_, String EXT_ATTR_3_, String EXT_ATTR_4_, String EXT_ATTR_5_, String EXT_ATTR_6_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (codeService.updateCode(CODE_ID_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("code", codeService.loadCode(CODE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateCodeOrder")
    @ResponseBody
    public Map<String, Object> updateCodeOrder(@RequestParam(value = "CODE_ID_LIST", required = true) List<String> CODE_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (codeService.updateCodeOrder(CODE_ID_LIST, ORDER_LIST) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "moveCode")
    @ResponseBody
    public Map<String, Object> moveCode(String CODE_ID_, String PARENT_CODE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (codeService.moveCode(CODE_ID_, PARENT_CODE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("code", codeService.loadCode(CODE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CODE_ID_")
    @RequestMapping(value = "deleteCode")
    @ResponseBody
    public Map<String, Object> deleteCode(String CODE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (codeService.deleteCode(CODE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}