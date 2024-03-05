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
import com.opendynamic.doc.service.CustomApprovalMemoService;

@Controller
public class CustomApprovalMemoController extends OdController {
    @Autowired
    private CustomApprovalMemoService customApprovalMemoService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageCustomApprovalMemo")
    public String manageCustomApprovalMemo(Map<String, Object> operator) {
        return "k/CustomApprovalMemo/manageCustomApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertCustomApprovalMemo")
    public String preInsertCustomApprovalMemo(Map<String, Object> operator) {
        return "k/CustomApprovalMemo/preInsertCustomApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateCustomApprovalMemo")
    public String preUpdateCustomApprovalMemo(Map<String, Object> operator) {
        return "k/CustomApprovalMemo/preUpdateCustomApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewCustomApprovalMemo")
    public String viewCustomApprovalMemo(Map<String, Object> operator) {
        return "k/CustomApprovalMemo/viewCustomApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_APPROVAL_MEMO_ID_")
    @RequestMapping(value = "loadCustomApprovalMemo")
    @ResponseBody
    public Map<String, Object> loadCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> customApprovalMemo = customApprovalMemoService.loadCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_);

        result.put("customApprovalMemo", customApprovalMemo);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectCustomApprovalMemo")
    @ResponseBody
    public Map<String, Object> selectCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> customApprovalMemoList = customApprovalMemoService.selectCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_, (String) operator.get("EMP_ID_"), page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = customApprovalMemoService.countCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_, (String) operator.get("EMP_ID_"));
        }

        result.put("customApprovalMemoList", customApprovalMemoList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectCustomApprovalMemoByIdList")
    @ResponseBody
    public Map<String, Object> selectCustomApprovalMemoByIdList(@RequestParam(value = "CUSTOM_APPROVAL_MEMO_ID_LIST", required = false) List<String> CUSTOM_APPROVAL_MEMO_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> customApprovalMemoList = customApprovalMemoService.selectCustomApprovalMemoByIdList(CUSTOM_APPROVAL_MEMO_ID_LIST);

        result.put("customApprovalMemoList", customApprovalMemoList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_APPROVAL_MEMO_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertCustomApprovalMemo")
    @ResponseBody
    public Map<String, Object> insertCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String APPROVAL_MEMO_, String DEFAULT_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customApprovalMemoService.insertCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_, (String) operator.get("EMP_ID_"), APPROVAL_MEMO_, DEFAULT_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("customApprovalMemo", customApprovalMemoService.loadCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_APPROVAL_MEMO_ID_")
    @RequestMapping(value = "updateCustomApprovalMemo")
    @ResponseBody
    public Map<String, Object> updateCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String APPROVAL_MEMO_, String DEFAULT_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customApprovalMemoService.updateCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_, (String) operator.get("EMP_ID_"), APPROVAL_MEMO_, DEFAULT_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("customApprovalMemo", customApprovalMemoService.loadCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateCustomApprovalMemoOrder")
    @ResponseBody
    public Map<String, Object> updateCustomApprovalMemoOrder(@RequestParam(value = "CUSTOM_APPROVAL_MEMO_ID_LIST", required = true) List<String> CUSTOM_APPROVAL_MEMO_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customApprovalMemoService.updateCustomApprovalMemoOrder(CUSTOM_APPROVAL_MEMO_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "CUSTOM_APPROVAL_MEMO_ID_")
    @RequestMapping(value = "deleteCustomApprovalMemo")
    @ResponseBody
    public Map<String, Object> deleteCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customApprovalMemoService.deleteCustomApprovalMemo(CUSTOM_APPROVAL_MEMO_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}