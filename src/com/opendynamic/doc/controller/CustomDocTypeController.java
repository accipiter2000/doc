package com.opendynamic.doc.controller;

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
import com.opendynamic.doc.service.CustomDocTypeService;

@Controller
public class CustomDocTypeController extends OdController {
    @Autowired
    private CustomDocTypeService customDocTypeService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageCustomDocType")
    public String manageCustomDocType(Map<String, Object> operator) {
        return "k/CustomDocType/manageCustomDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preChooseCustomDocType")
    public String preChooseCustomDocType(Map<String, Object> operator) {
        return "k/CustomDocType/preChooseCustomDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertCustomDocType")
    public String preInsertCustomDocType(Map<String, Object> operator) {
        return "k/CustomDocType/preInsertCustomDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateCustomDocType")
    public String preUpdateCustomDocType(Map<String, Object> operator) {
        return "k/CustomDocType/preUpdateCustomDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewCustomDocType")
    public String viewCustomDocType(Map<String, Object> operator) {
        return "k/CustomDocType/viewCustomDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_DOC_TYPE_ID_")
    @RequestMapping(value = "loadCustomDocType")
    @ResponseBody
    public Map<String, Object> loadCustomDocType(String CUSTOM_DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> customDocType = customDocTypeService.loadCustomDocType(CUSTOM_DOC_TYPE_ID_);

        result.put("customDocType", customDocType);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectCustomDocType")
    @ResponseBody
    public Map<String, Object> selectCustomDocType(String CUSTOM_DOC_TYPE_ID_, String DOC_TYPE_ID_, @RequestParam(value = "DOC_TYPE_STATUS_LIST", required = false) List<String> DOC_TYPE_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String EMP_ID_ = (String) operator.get("EMP_ID_");
        List<Map<String, Object>> customDocTypeList = customDocTypeService.selectCustomDocType(CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_, DOC_TYPE_STATUS_LIST, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = customDocTypeService.countCustomDocType(CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_, DOC_TYPE_STATUS_LIST);
        }

        result.put("customDocTypeList", customDocTypeList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectCustomDocTypeByIdList")
    @ResponseBody
    public Map<String, Object> selectCustomDocTypeByIdList(@RequestParam(value = "CUSTOM_DOC_TYPE_ID_LIST", required = false) List<String> CUSTOM_DOC_TYPE_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> customDocTypeList = customDocTypeService.selectCustomDocTypeByIdList(CUSTOM_DOC_TYPE_ID_LIST);

        result.put("customDocTypeList", customDocTypeList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_DOC_TYPE_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertCustomDocType")
    @ResponseBody
    public Map<String, Object> insertCustomDocType(String CUSTOM_DOC_TYPE_ID_, String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String EMP_ID_ = (String) operator.get("EMP_ID_");
        if (customDocTypeService.insertCustomDocType(CUSTOM_DOC_TYPE_ID_, EMP_ID_, DOC_TYPE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("customDocType", customDocTypeService.loadCustomDocType(CUSTOM_DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_DOC_TYPE_ID_")
    @RequestMapping(value = "updateCustomDocType")
    @ResponseBody
    public Map<String, Object> updateCustomDocType(String CUSTOM_DOC_TYPE_ID_, String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customDocTypeService.updateCustomDocType(CUSTOM_DOC_TYPE_ID_, DOC_TYPE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("customDocType", customDocTypeService.loadCustomDocType(CUSTOM_DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateCustomDocTypeOrder")
    @ResponseBody
    public Map<String, Object> updateCustomDocTypeOrder(@RequestParam(value = "CUSTOM_DOC_TYPE_ID_LIST", required = true) List<String> CUSTOM_DOC_TYPE_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customDocTypeService.updateCustomDocTypeOrder(CUSTOM_DOC_TYPE_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_DOC_TYPE_ID_")
    @RequestMapping(value = "deleteCustomDocType")
    @ResponseBody
    public Map<String, Object> deleteCustomDocType(String CUSTOM_DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customDocTypeService.deleteCustomDocType(CUSTOM_DOC_TYPE_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}