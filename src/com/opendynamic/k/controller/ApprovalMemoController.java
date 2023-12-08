package com.opendynamic.k.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.ff.service.FfService;
import com.opendynamic.k.service.ApprovalMemoService;

@Controller
public class ApprovalMemoController extends OdController {
    @Autowired
    private ApprovalMemoService approvalMemoService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageApprovalMemo")
    public String manageApprovalMemo(Map<String, Object> operator) {
        return "k/ApprovalMemo/manageApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertApprovalMemo")
    public String preInsertApprovalMemo(Map<String, Object> operator) {
        return "k/ApprovalMemo/preInsertApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateApprovalMemo")
    public String preUpdateApprovalMemo(Map<String, Object> operator) {
        return "k/ApprovalMemo/preUpdateApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewApprovalMemo")
    public String viewApprovalMemo(Map<String, Object> operator) {
        return "k/ApprovalMemo/viewApprovalMemo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_ID_")
    @RequestMapping(value = "loadApprovalMemo")
    @ResponseBody
    public Map<String, Object> loadApprovalMemo(String APPROVAL_MEMO_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> approvalMemo = approvalMemoService.loadApprovalMemo(APPROVAL_MEMO_ID_);

        result.put("approvalMemo", approvalMemo);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_CODE_")
    @RequestMapping(value = "loadLastApprovalMemoByTaskId")
    @ResponseBody
    public Map<String, Object> loadLastApprovalMemoByTaskId(String TASK_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> approvalMemo = approvalMemoService.loadLastApprovalMemoByTaskId(TASK_ID_);

        result.put("approvalMemo", approvalMemo);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectApprovalMemo")
    @ResponseBody
    public Map<String, Object> selectApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, @RequestParam(value = "APPROVAL_MEMO_STATUS_LIST", required = false) List<String> APPROVAL_MEMO_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> approvalMemoList = approvalMemoService.selectApprovalMemo(APPROVAL_MEMO_ID_, TASK_ID_, NODE_ID_, NODE_TYPE_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, COM_ID_, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_DUE_DATE_, TO_DUE_DATE_, APPROVAL_MEMO_TYPE_, FROM_APPROVAL_DATE_, TO_APPROVAL_DATE_, APPROVAL_MEMO_STATUS_LIST, page, limit);
        Map<String, Object> approvalMemo;
        for (int i = approvalMemoList.size() - 1; i >= 0; i--) {
            approvalMemo = approvalMemoList.get(i);
            if (StringUtils.isNotEmpty((String) approvalMemo.get("NODE_TYPE_")) && (approvalMemo.get("NODE_TYPE_").equals(FfService.NODE_TYPE_STAGE) || approvalMemo.get("NODE_TYPE_").equals(FfService.NODE_TYPE_SUB_PROC) || approvalMemo.get("NODE_TYPE_").equals(FfService.NODE_TYPE_GATEWAY))) {
                updateApprovalMemoParentNodeId(approvalMemoList, approvalMemo);
                approvalMemoList.remove(i);
            }
        }

        List<Map<String, Object>> approvalMemoListClone = (List<Map<String, Object>>) OdUtils.deepClone(approvalMemoList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < approvalMemoListClone.size(); i++) {
            approvalMemo = approvalMemoListClone.get(i);
            if (approvalMemo.get("PROC_ID_").equals(approvalMemo.get("PARENT_NODE_ID_"))) {
                children.add(approvalMemo);
                fillChildApprovalMemo(approvalMemo, approvalMemoListClone, i);
            }
        }

        result.put("approvalMemoList", approvalMemoList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = false, logCategory = "K")
    @RequestMapping(value = "selectApprovalMemoInterface")
    @ResponseBody
    public Map<String, Object> selectApprovalMemoInterface(String APPROVAL_MEMO_ID_, String TASK_ID_, String NODE_ID_, String NODE_TYPE_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String COM_ID_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_DUE_DATE_, Date TO_DUE_DATE_, Integer APPROVAL_MEMO_TYPE_, Date FROM_APPROVAL_DATE_, Date TO_APPROVAL_DATE_, @RequestParam(value = "APPROVAL_MEMO_STATUS_LIST", required = false) List<String> APPROVAL_MEMO_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> approvalMemoList = approvalMemoService.selectApprovalMemo(APPROVAL_MEMO_ID_, TASK_ID_, NODE_ID_, NODE_TYPE_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, COM_ID_, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_DUE_DATE_, TO_DUE_DATE_, APPROVAL_MEMO_TYPE_, FROM_APPROVAL_DATE_, TO_APPROVAL_DATE_, APPROVAL_MEMO_STATUS_LIST, page, limit);
        Map<String, Object> approvalMemo;
        for (int i = approvalMemoList.size() - 1; i >= 0; i--) {
            approvalMemo = approvalMemoList.get(i);
            if (StringUtils.isNotEmpty((String) approvalMemo.get("NODE_TYPE_")) && (approvalMemo.get("NODE_TYPE_").equals(FfService.NODE_TYPE_STAGE) || approvalMemo.get("NODE_TYPE_").equals(FfService.NODE_TYPE_SUB_PROC) || approvalMemo.get("NODE_TYPE_").equals(FfService.NODE_TYPE_GATEWAY))) {
                updateApprovalMemoParentNodeId(approvalMemoList, approvalMemo);
                approvalMemoList.remove(i);
            }
        }

        List<Map<String, Object>> approvalMemoListClone = (List<Map<String, Object>>) OdUtils.deepClone(approvalMemoList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        for (int i = 0; i < approvalMemoListClone.size(); i++) {
            approvalMemo = approvalMemoListClone.get(i);
            if (approvalMemo.get("PROC_ID_").equals(approvalMemo.get("PARENT_NODE_ID_"))) {
                children.add(approvalMemo);
                fillChildApprovalMemo(approvalMemo, approvalMemoListClone, i);
            }
        }

        result.put("approvalMemoList", approvalMemoList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void updateApprovalMemoParentNodeId(List<Map<String, Object>> approvalMemoList, Map<String, Object> approvalMemo) {
        for (Map<String, Object> _approvalMemo : approvalMemoList) {
            if (_approvalMemo.get("PARENT_NODE_ID_").equals(approvalMemo.get("NODE_ID_"))) {
                _approvalMemo.put("PARENT_NODE_ID_", approvalMemo.get("PARENT_NODE_ID_"));
            }
        }
    }

    private void fillChildApprovalMemo(Map<String, Object> approvalMemo, List<Map<String, Object>> approvalMemoList, int startIndex) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childApprovalMemo;
        for (int i = startIndex + 1; i < approvalMemoList.size(); i++) {
            childApprovalMemo = approvalMemoList.get(i);
            if (approvalMemo.get("NODE_ID_") != null && approvalMemo.get("NODE_ID_").equals(childApprovalMemo.get("PARENT_NODE_ID_")) && StringUtils.isEmpty((String) childApprovalMemo.get("PREVIOUS_TASK_ID_"))) {
                children.add(childApprovalMemo);
                approvalMemo.put("ASSIGNEE_NAME_", childApprovalMemo.get("ASSIGNEE_NAME_"));
                approvalMemo.put("EXECUTOR_NAME_", childApprovalMemo.get("EXECUTOR_NAME_"));
                approvalMemo.put("ORG_NAME_", childApprovalMemo.get("ORG_NAME_"));
                approvalMemo.put("APPROVAL_MEMO_", childApprovalMemo.get("APPROVAL_MEMO_"));
                approvalMemo.put("APPROVAL_DATE_", childApprovalMemo.get("APPROVAL_DATE_"));
                if (childApprovalMemo.get("APPROVAL_MEMO_STATUS_").equals("7")) {
                    approvalMemo.put("APPROVAL_MEMO_STATUS_", childApprovalMemo.get("APPROVAL_MEMO_STATUS_"));
                }
                fillChildApprovalMemo(childApprovalMemo, approvalMemoList, i);
            }
            if ((approvalMemo.get("TASK_ID_") != null && approvalMemo.get("TASK_ID_").equals(childApprovalMemo.get("TASK_ID_")))) {
                break;
            }
            if (approvalMemo.get("TASK_ID_") != null && approvalMemo.get("TASK_ID_").equals(childApprovalMemo.get("PREVIOUS_TASK_ID_"))) {
                children.add(childApprovalMemo);
                fillChildApprovalMemo(childApprovalMemo, approvalMemoList, i);
            }
        }
        approvalMemo.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectApprovalMemoByIdList")
    @ResponseBody
    public Map<String, Object> selectApprovalMemoByIdList(@RequestParam(value = "APPROVAL_MEMO_ID_LIST", required = false) List<String> APPROVAL_MEMO_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> approvalMemoList = approvalMemoService.selectApprovalMemoByIdList(APPROVAL_MEMO_ID_LIST);

        result.put("approvalMemoList", approvalMemoList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertApprovalMemo")
    @ResponseBody
    public Map<String, Object> insertApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (approvalMemoService.insertApprovalMemo(APPROVAL_MEMO_ID_, TASK_ID_, PREVIOUS_TASK_ID_, NODE_ID_, NODE_TYPE_, NODE_NAME_, PARENT_NODE_ID_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, ORG_NAME_, COM_ID_, COM_NAME_, new Date(), DUE_DATE_, APPROVAL_MEMO_TYPE_, APPROVAL_MEMO_, APPROVAL_DATE_, "1", null, null, null) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("approvalMemo", approvalMemoService.loadApprovalMemo(APPROVAL_MEMO_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_ID_")
    @RequestMapping(value = "updateApprovalMemo")
    @ResponseBody
    public Map<String, Object> updateApprovalMemo(String APPROVAL_MEMO_ID_, String TASK_ID_, String PREVIOUS_TASK_ID_, String NODE_ID_, String NODE_TYPE_, String NODE_NAME_, String PARENT_NODE_ID_, String PROC_ID_, String BIZ_ID_, String ASSIGNEE_, String ASSIGNEE_CODE_, String ASSIGNEE_NAME_, String EXECUTOR_, String EXECUTOR_CODE_, String EXECUTOR_NAME_, String ORG_ID_, String ORG_NAME_, String COM_ID_, String COM_NAME_, Date DUE_DATE_, String APPROVAL_MEMO_TYPE_, String APPROVAL_MEMO_, Date APPROVAL_DATE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (approvalMemoService.updateApprovalMemo(APPROVAL_MEMO_ID_, TASK_ID_, PREVIOUS_TASK_ID_, NODE_ID_, NODE_TYPE_, NODE_NAME_, PARENT_NODE_ID_, PROC_ID_, BIZ_ID_, ASSIGNEE_, ASSIGNEE_CODE_, ASSIGNEE_NAME_, EXECUTOR_, EXECUTOR_CODE_, EXECUTOR_NAME_, ORG_ID_, ORG_NAME_, COM_ID_, COM_NAME_, DUE_DATE_, APPROVAL_MEMO_TYPE_, APPROVAL_MEMO_, APPROVAL_DATE_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("approvalMemo", approvalMemoService.loadApprovalMemo(APPROVAL_MEMO_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_ID_")
    @RequestMapping(value = "updateApprovalMemoApprovalMemo")
    @ResponseBody
    public Map<String, Object> updateApprovalMemoApprovalMemo(String APPROVAL_MEMO_ID_, String APPROVAL_MEMO_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (approvalMemoService.updateApprovalMemoApprovalMemo(APPROVAL_MEMO_ID_, APPROVAL_MEMO_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("approvalMemo", approvalMemoService.loadApprovalMemo(APPROVAL_MEMO_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_ID_")
    @RequestMapping(value = "saveApprovalMemo")
    @ResponseBody
    public Map<String, Object> saveApprovalMemo(String TASK_ID_, String APPROVAL_MEMO_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (approvalMemoService.saveApprovalMemo(TASK_ID_, APPROVAL_MEMO_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateApprovalMemoOrder")
    @ResponseBody
    public Map<String, Object> updateApprovalMemoOrder(@RequestParam(value = "APPROVAL_MEMO_ID_LIST", required = true) List<String> APPROVAL_MEMO_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (approvalMemoService.updateApprovalMemoOrder(APPROVAL_MEMO_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "APPROVAL_MEMO_ID_")
    @RequestMapping(value = "deleteApprovalMemo")
    @ResponseBody
    public Map<String, Object> deleteApprovalMemo(String APPROVAL_MEMO_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (approvalMemoService.deleteApprovalMemo(APPROVAL_MEMO_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}