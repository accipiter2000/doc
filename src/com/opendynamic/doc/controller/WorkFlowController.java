package com.opendynamic.doc.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.ff.query.TaskQuery;
import com.opendynamic.ff.service.FfAdjustProcDefService;
import com.opendynamic.ff.service.FfNodeService;
import com.opendynamic.ff.service.FfOperationService;
import com.opendynamic.ff.service.FfProcDefService;
import com.opendynamic.ff.service.FfService;
import com.opendynamic.ff.vo.CandidateList;
import com.opendynamic.ff.vo.FfResult;
import com.opendynamic.ff.vo.NodeDef;
import com.opendynamic.ff.vo.Operation;
import com.opendynamic.ff.vo.Proc;
import com.opendynamic.ff.vo.ProcDef;
import com.opendynamic.ff.vo.RunningNodeDef;
import com.opendynamic.ff.vo.RunningProcDef;
import com.opendynamic.ff.vo.Task;
import com.opendynamic.doc.service.ApprovalMemoService;
import com.opendynamic.doc.service.DocService;
import com.opendynamic.doc.service.WorkFlowService;
import com.opendynamic.om.service.OmService;

@Controller
public class WorkFlowController extends OdController {
    @Autowired
    private WorkFlowService workFlowService;
    @Autowired
    private FfService ffService;
    @Autowired
    private FfProcDefService ffProcDefService;
    @Autowired
    private FfAdjustProcDefService ffAdjustProcDefService;
    @Autowired
    private FfNodeService ffNodeService;
    @Autowired
    private FfOperationService ffOperationService;
    @Autowired
    private DocService docService;
    @Autowired
    private ApprovalMemoService approvalMemoService;
    @Autowired
    private OmService omService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageProcDef")
    public String manageProcDef(Map<String, Object> operator) {
        return "k/ProcDef/manageProcDef";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertProcDef")
    public String preInsertProcDef(Map<String, Object> operator) {
        return "k/ProcDef/preInsertProcDef";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewProcDef")
    public String viewProcDef(Map<String, Object> operator) {
        return "k/ProcDef/viewProcDef";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "manageProc")
    public String manageProc(Map<String, Object> operator) {
        return "k/WorkFlow/manageProc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "manageNode")
    public String manageNode(Map<String, Object> operator) {
        return "k/WorkFlow/manageNode";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "manageTask")
    public String manageTask(Map<String, Object> operator) {
        return "k/WorkFlow/manageTask";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "preAdjustBranchProcDef")
    public String preAdjustBranchProcDef(Map<String, Object> operator) {
        return "k/WorkFlow/preAdjustBranchProcDef";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageMyToDoTask")
    public String manageMyToDoTask(Map<String, Object> operator) {
        return "k/WorkFlow/manageMyToDoTask";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "myToDoTaskDashboard")
    public String myToDoTaskDashboard(Map<String, Object> operator) {
        return "k/WorkFlow/myToDoTaskDashboard";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "commonApproveDoc")
    public String commonApproveDoc(Map<String, Object> operator) {
        return "k/WorkFlow/commonApproveDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewRunningProcDiagram")
    public String viewRunningProcDiagram(Map<String, Object> operator) {
        return "k/WorkFlow/viewRunningProcDiagram";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preChooseCenterForwardStep")
    public String preChooseCenterForwardStep(Map<String, Object> operator) {
        return "k/WorkFlow/preChooseCenterForwardStep";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageMyOperation")
    public String manageMyOperation(Map<String, Object> operator) {
        return "k/WorkFlow/manageMyOperation";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "viewNextNodeTaskInfo")
    public String viewNextNodeTaskInfo(Map<String, Object> operator) {
        return "k/WorkFlow/viewNextNodeTaskInfo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_ID_")
    @RequestMapping(value = "loadProcDef")
    @ResponseBody
    public Map<String, Object> loadProcDef(String PROC_DEF_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> procDef = ffProcDefService.loadProcDef(PROC_DEF_ID_);

        result.put("procDef", procDef);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_CODE_")
    @RequestMapping(value = "loadProcDefByCode")
    @ResponseBody
    public Map<String, Object> loadProcDefByCode(String PROC_DEF_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> procDef = ffProcDefService.loadProcDefByCode(PROC_DEF_CODE_);

        result.put("procDef", procDef);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_ID_")
    @RequestMapping(value = "loadProcDefDiagramFile")
    public void loadProcDefDiagramFile(String PROC_DEF_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> procDef = ffProcDefService.loadProcDef(PROC_DEF_ID_);// 获取下载文件名
        String fileName = (String) procDef.get("PROC_DEF_DIAGRAM_FILE_NAME_");
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式
        response.setHeader("Content-type", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = ffProcDefService.loadProcDefDiagramFile(PROC_DEF_ID_);// 二进制流文件内容
        OutputStream outputStream = response.getOutputStream();
        byte[] content = new byte[65535];
        int length = 0;
        while ((length = inputStream.read(content)) != -1) {
            outputStream.write(content, 0, length);
        }
        outputStream.flush();
        outputStream.close();
        inputStream.close();
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectProcDef")
    @ResponseBody
    public Map<String, Object> selectProcDef(String PROC_DEF_ID_, @RequestParam(value = "PROC_DEF_ID_LIST", required = false) List<String> PROC_DEF_ID_LIST, String PROC_DEF_CODE_, @RequestParam(value = "PROC_DEF_CODE_LIST", required = false) List<String> PROC_DEF_CODE_LIST, String PROC_DEF_NAME_, @RequestParam(value = "PROC_DEF_NAME_LIST", required = false) List<String> PROC_DEF_NAME_LIST, String PROC_DEF_CAT_, @RequestParam(value = "PROC_DEF_CAT_LIST", required = false) List<String> PROC_DEF_CAT_LIST, Integer VERSION_, @RequestParam(value = "VERSION_LIST", required = false) List<Integer> VERSION_LIST, String PROC_DEF_STATUS_, @RequestParam(value = "PROC_DEF_STATUS_LIST", required = false) List<String> PROC_DEF_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> procDefList = ffProcDefService.selectProcDef(PROC_DEF_ID_, PROC_DEF_ID_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_DEF_NAME_, PROC_DEF_NAME_LIST, PROC_DEF_CAT_, PROC_DEF_CAT_LIST, VERSION_, VERSION_LIST, PROC_DEF_STATUS_, PROC_DEF_STATUS_LIST, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = ffProcDefService.countProcDef(PROC_DEF_ID_, PROC_DEF_ID_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_DEF_NAME_, PROC_DEF_NAME_LIST, PROC_DEF_CAT_, PROC_DEF_CAT_LIST, VERSION_, VERSION_LIST, PROC_DEF_STATUS_, PROC_DEF_STATUS_LIST);
        }

        result.put("procDefList", procDefList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "PROC_DEF_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "deployProcDef")
    @ResponseBody
    public Map<String, Object> deployProcDef(String PROC_DEF_ID_, String PROC_DEF_MODEL_, MultipartFile PROC_DEF_DIAGRAM_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream PROC_DEF_DIAGRAM_FILE_InputStream;
            String PROC_DEF_DIAGRAM_FILE_NAME_;
            Integer PROC_DEF_DIAGRAM_FILE_LENGTH_;
            if (PROC_DEF_DIAGRAM_FILE_ != null) {
                PROC_DEF_DIAGRAM_FILE_InputStream = PROC_DEF_DIAGRAM_FILE_.getInputStream();// 获取上传二进制流
                PROC_DEF_DIAGRAM_FILE_NAME_ = OdUtils.getFileName(PROC_DEF_DIAGRAM_FILE_.getOriginalFilename());
                PROC_DEF_DIAGRAM_FILE_LENGTH_ = (int) PROC_DEF_DIAGRAM_FILE_.getSize();
                if ((PROC_DEF_DIAGRAM_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                PROC_DEF_DIAGRAM_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                PROC_DEF_DIAGRAM_FILE_NAME_ = null;
                PROC_DEF_DIAGRAM_FILE_LENGTH_ = 0;
            }
            ffService.deployProcDef(PROC_DEF_ID_, PROC_DEF_MODEL_, PROC_DEF_DIAGRAM_FILE_InputStream, PROC_DEF_DIAGRAM_FILE_NAME_, PROC_DEF_DIAGRAM_FILE_LENGTH_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
            PROC_DEF_DIAGRAM_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("procDef", ffProcDefService.loadProcDef(PROC_DEF_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_ID_")
    @RequestMapping(value = "disableProcDef")
    @ResponseBody
    public Map<String, Object> disableProcDef(String PROC_DEF_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (ffProcDefService.disableProcDef(PROC_DEF_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("procDef", ffProcDefService.loadProcDef(PROC_DEF_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_ID_")
    @RequestMapping(value = "enableProcDef")
    @ResponseBody
    public Map<String, Object> enableProcDef(String PROC_DEF_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (ffProcDefService.enableProcDef(PROC_DEF_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("procDef", ffProcDefService.loadProcDef(PROC_DEF_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_ID_")
    @RequestMapping(value = "deleteProcDef")
    @ResponseBody
    public Map<String, Object> deleteProcDef(String PROC_DEF_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (ffProcDefService.deleteProcDef(PROC_DEF_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "refreshProcDefCache")
    @ResponseBody
    public Map<String, Object> refreshProcDefCache(String PROC_DEF_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        ffService.refreshProcDefCache();

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "loadAdjustProcDef")
    @ResponseBody
    public Map<String, Object> loadAdjustProcDef(String ADJUST_PROC_DEF_ID_) {
        Map<String, Object> result = new HashMap<String, Object>();

        result.put("adjustProcDef", ffAdjustProcDefService.loadAdjustProcDef(ADJUST_PROC_DEF_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "adjustBranchProcDef")
    @ResponseBody
    public Map<String, Object> adjustBranchProcDef(String BRANCH_ID_, String PROC_DEF_MODEL_, MultipartFile PROC_DEF_DIAGRAM_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream PROC_DEF_DIAGRAM_FILE_InputStream;
            String PROC_DEF_DIAGRAM_FILE_NAME_;
            Integer PROC_DEF_DIAGRAM_FILE_LENGTH_;
            if (PROC_DEF_DIAGRAM_FILE_ != null) {
                PROC_DEF_DIAGRAM_FILE_InputStream = PROC_DEF_DIAGRAM_FILE_.getInputStream();// 获取上传二进制流
                PROC_DEF_DIAGRAM_FILE_NAME_ = OdUtils.getFileName(PROC_DEF_DIAGRAM_FILE_.getOriginalFilename());
                PROC_DEF_DIAGRAM_FILE_LENGTH_ = (int) PROC_DEF_DIAGRAM_FILE_.getSize();
                if ((PROC_DEF_DIAGRAM_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                PROC_DEF_DIAGRAM_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                PROC_DEF_DIAGRAM_FILE_NAME_ = null;
                PROC_DEF_DIAGRAM_FILE_LENGTH_ = 0;
            }
            ffService.adjustBranchProcDef(BRANCH_ID_, PROC_DEF_MODEL_, PROC_DEF_DIAGRAM_FILE_InputStream, PROC_DEF_DIAGRAM_FILE_NAME_, PROC_DEF_DIAGRAM_FILE_LENGTH_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
            PROC_DEF_DIAGRAM_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectProc")
    @ResponseBody
    public Map<String, Object> selectProc(@RequestParam(value = "BIZ_TYPE_LIST", required = false) List<String> BIZ_TYPE_LIST, String BIZ_CODE_, String BIZ_NAME_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, String dataScope, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> procList = ffService.createProcQuery().setBizTypeList(BIZ_TYPE_LIST).setBizCode(BIZ_CODE_).setBizName(BIZ_NAME_).setProcStatusList(PROC_STATUS_LIST).setFromCreationDate(FROM_CREATION_DATE_).setToCreationDate(TO_CREATION_DATE_).setDataScope(dataScope).setPage(page).setLimit(limit).queryForMapList();
        int total = 0;
        if (limit != null && limit > 0) {
            total = ffService.createProcQuery().setBizTypeList(BIZ_TYPE_LIST).setBizCode(BIZ_CODE_).setBizName(BIZ_NAME_).setProcStatusList(PROC_STATUS_LIST).setFromCreationDate(FROM_CREATION_DATE_).setToCreationDate(TO_CREATION_DATE_).setDataScope(dataScope).setPage(page).setLimit(limit).count();
        }

        result.put("procList", procList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectNode")
    @ResponseBody
    public Map<String, Object> selectNode(String PROC_ID_, String dataScope, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> nodeList = ffService.createNodeQuery().setProcId(PROC_ID_).setDataScope(dataScope).queryForMapList();
        Collections.reverse(nodeList);

        result.put("nodeList", nodeList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectTask")
    @ResponseBody
    public Map<String, Object> selectTask(String ASSIGNEE_, @RequestParam(value = "TASK_STATUS_LIST", required = false) List<String> TASK_STATUS_LIST, String BIZ_CODE_, String BIZ_NAME_, String dataScope, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<String> ASSIGNEE_LIST = null;
        if (StringUtils.isNotEmpty(ASSIGNEE_)) {
            ASSIGNEE_LIST = Arrays.asList(ASSIGNEE_);
        }
        List<Map<String, Object>> taskList = ffService.createTaskQuery().setAssigneeList(ASSIGNEE_LIST).setTaskStatusList(TASK_STATUS_LIST).setBizCode(BIZ_CODE_).setBizName(BIZ_NAME_).setDataScope(dataScope).setPage(page).setLimit(limit).queryForMapList();
        result.put("taskList", taskList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "loadBranch")
    @ResponseBody
    public Map<String, Object> loadBranch(String NODE_ID_, String dataScope) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> parentNodeQueryList = ffService.createParentNodeQuery().setNodeId(NODE_ID_).setRecursive(true).setIncludeSelf(true).setDataScope(dataScope).queryForMapList();
        Map<String, Object> branch = null;
        for (int i = parentNodeQueryList.size() - 1; i >= 0; i--) {
            if (parentNodeQueryList.get(i).get("NODE_TYPE_").equals(FfService.NODE_TYPE_BRANCH)) {
                branch = ffNodeService.loadNode((String) parentNodeQueryList.get(i).get("NODE_ID_"));
            }
        }

        result.put("branch", branch);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "loadTask")
    @ResponseBody
    public Map<String, Object> loadTask(String TASK_ID_, String dataScope, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> task = ffService.createTaskQuery().setTaskId(TASK_ID_).setDataScope(dataScope).queryForMap();

        result.put("task", task);
        result.put("success", true);

        return result;
    }

    // 待办
    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectMyToDoTask")
    @ResponseBody
    public Map<String, Object> selectMyToDoTask(@RequestParam(value = "forwardStatusList", required = false) List<String> forwardStatusList, String dataScope, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);

        TaskQuery taskQuery = ffService.createTaskQuery().setAssigneeList(posiEmpIdList).setTaskStatus(FfService.TASK_STATUS_ACTIVE).setDataScope(dataScope);
        if (forwardStatusList != null && forwardStatusList.size() > 0) {
            taskQuery = taskQuery.setForwardStatusList(forwardStatusList);
        }
        List<Map<String, Object>> taskList = taskQuery.queryForMapList();

        result.put("taskList", taskList);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "countMyToDoTask")
    @ResponseBody
    public Map<String, Object> countMyToDoTask(@RequestParam(value = "forwardStatusList", required = false) List<String> forwardStatusList, String dataScope, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);

        TaskQuery taskQuery = ffService.createTaskQuery().setAssigneeList(posiEmpIdList).setTaskStatus(FfService.TASK_STATUS_ACTIVE).setDataScope(dataScope);
        if (forwardStatusList != null && forwardStatusList.size() > 0) {
            taskQuery = taskQuery.setForwardStatusList(forwardStatusList);
        }

        result.put("total", taskQuery.count());
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateAssignee")
    @ResponseBody
    public Map<String, Object> updateAssignee(@RequestParam(value = "taskIdList", required = true) List<String> taskIdList, String assignee, String assigneeName, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        for (String taskId : taskIdList) {
            ffService.updateTaskAssignee(taskId, assignee, assigneeName, (String) operator.get("POSI_EMP_ID_"));
        }

        result.put("success", true);

        return result;
    }

    // 重新上报
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "restartDocProc")
    @ResponseBody
    public Map<String, Object> restartDocProc(@RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String DOC_ID_ = (String) nodeVarMap.get("DOC_ID_");
        nodeVarMap.remove("DOC_ID_");
        if (StringUtils.isEmpty((String) nodeVarMap.get("CENTER_FORWARD_STEP"))) {
            nodeVarMap.remove("CENTER_FORWARD_STEP");
        }

        CandidateList candidateList = null;
        if (StringUtils.isNotEmpty((String) nodeVarMap.get("CANDIDATE_LIST"))) {
            candidateList = new Gson().fromJson((String) nodeVarMap.get("CANDIDATE_LIST"), CandidateList.class);
            nodeVarMap.remove("CANDIDATE_LIST");
        }

        FfResult ffResult = workFlowService.restartDocProc(DOC_ID_, nodeVarMap, candidateList, operator);

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("proc", ffResult.getCreateProcList().get(0));
        result.put("nextAssigneeNameList", OdUtils.collectFromBean(ffResult.getCreateTaskList(), "assigneeName", String.class).toString());
        result.put("success", true);

        return result;
    }

    // 重新上报
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "restartDocIsolateProc")
    @ResponseBody
    public Map<String, Object> restartDocIsolateProc(String DOC_ID_, String isolateSubProcNodeId, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        FfResult ffResult = workFlowService.restartDocIsolateProc(DOC_ID_, isolateSubProcNodeId, null, null, operator);

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("proc", ffResult.getCreateProcList().get(0));
        result.put("nextAssigneeNameList", OdUtils.collectFromBean(ffResult.getCreateTaskList(), "assigneeName", String.class).toString());
        result.put("success", true);

        return result;
    }

    // 完成任务
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "TASK_ID_")
    @RequestMapping(value = "completeDocTask")
    @ResponseBody
    public Map<String, Object> completeDocTask(@RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String TASK_ID_ = (String) nodeVarMap.get("TASK_ID_");
        String APPROVAL_MEMO_ = (String) nodeVarMap.get("APPROVAL_MEMO_");
        nodeVarMap.remove("TASK_ID_");
        nodeVarMap.remove("APPROVAL_MEMO_");
        if (StringUtils.isEmpty((String) nodeVarMap.get("CENTER_FORWARD_STEP"))) {
            nodeVarMap.remove("CENTER_FORWARD_STEP");
        }

        CandidateList candidateList = null;
        if (StringUtils.isNotEmpty((String) nodeVarMap.get("CANDIDATE_LIST"))) {
            candidateList = new Gson().fromJson((String) nodeVarMap.get("CANDIDATE_LIST"), CandidateList.class);
            nodeVarMap.remove("CANDIDATE_LIST");
        }

        FfResult ffResult = workFlowService.completeDocTask(TASK_ID_, APPROVAL_MEMO_, nodeVarMap, candidateList, operator);

        List<Task> taskList = new ArrayList<Task>();
        taskList.addAll(ffResult.getCreateTaskList());
        taskList.addAll(ffResult.getActivateTaskList());

        if (ffResult.getCompleteProcList().size() > 0) {
            result.put("completeProc", true);
        }
        result.put("nextAssigneeNameList", OdUtils.collectFromBean(taskList, "assigneeName", String.class).toString());
        result.put("success", true);

        return result;
    }

    // 假驳回任务，实为同意
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "TASK_ID_")
    @RequestMapping(value = "fakeRejectDocTask")
    @ResponseBody
    public Map<String, Object> fakeRejectDocTask(@RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String TASK_ID_ = (String) nodeVarMap.get("TASK_ID_");
        String APPROVAL_MEMO_ = (String) nodeVarMap.get("APPROVAL_MEMO_");
        nodeVarMap.remove("TASK_ID_");
        nodeVarMap.remove("APPROVAL_MEMO_");
        if (StringUtils.isEmpty((String) nodeVarMap.get("CENTER_FORWARD_STEP"))) {
            nodeVarMap.remove("CENTER_FORWARD_STEP");
        }

        CandidateList candidateList = null;
        if (StringUtils.isNotEmpty((String) nodeVarMap.get("CANDIDATE_LIST"))) {
            candidateList = new Gson().fromJson((String) nodeVarMap.get("CANDIDATE_LIST"), CandidateList.class);
            nodeVarMap.remove("CANDIDATE_LIST");
        }

        FfResult ffResult = workFlowService.fakeRejectDocTask(TASK_ID_, APPROVAL_MEMO_, nodeVarMap, candidateList, operator);

        List<Task> taskList = new ArrayList<Task>();
        taskList.addAll(ffResult.getCreateTaskList());
        taskList.addAll(ffResult.getActivateTaskList());

        if (ffResult.getCompleteProcList().size() > 0) {
            result.put("completeProc", true);
        }
        result.put("nextAssigneeNameList", OdUtils.collectFromBean(taskList, "assigneeName", String.class).toString());
        result.put("success", true);

        return result;
    }

    // 转发任务
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "TASK_ID_")
    @RequestMapping(value = "forwardDocTask")
    @ResponseBody
    public Map<String, Object> forwardDocTask(@RequestParam(value = "assigneeList", required = false) List<String> assigneeList, @RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String TASK_ID_ = (String) nodeVarMap.get("TASK_ID_");
        String APPROVAL_MEMO_ = (String) nodeVarMap.get("APPROVAL_MEMO_");
        String ACTION_ = "commonApproveDoc.do?DOC_ID_=${proc.getBizId()}&TASK_ID_=${task.getTaskId()}";
        nodeVarMap.remove("TASK_ID_");
        nodeVarMap.remove("APPROVAL_MEMO_");
        nodeVarMap.remove("assigneeList");
        FfResult ffResult = workFlowService.forwardDocTask(TASK_ID_, assigneeList, ACTION_, APPROVAL_MEMO_, nodeVarMap, operator);

        List<Task> taskList = new ArrayList<Task>();
        taskList.addAll(ffResult.getCreateTaskList());
        taskList.addAll(ffResult.getActivateTaskList());

        result.put("nextAssigneeNameList", OdUtils.collectFromBean(taskList, "assigneeName", String.class).toString());
        result.put("success", true);

        return result;
    }

    // 驳回流程
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "TASK_ID_")
    @RequestMapping(value = "rejectDocTask")
    @ResponseBody
    public Map<String, Object> rejectDocTask(@RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String TASK_ID_ = (String) nodeVarMap.get("TASK_ID_");
        String APPROVAL_MEMO_ = (String) nodeVarMap.get("APPROVAL_MEMO_");
        nodeVarMap.remove("TASK_ID_");
        nodeVarMap.remove("APPROVAL_MEMO_");
        workFlowService.rejectDocTask(TASK_ID_, APPROVAL_MEMO_, nodeVarMap, operator);

        result.put("success", true);

        return result;
    }

    // 追加办理人
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "TASK_ID_")
    @RequestMapping(value = "appendDocCandidate")
    @ResponseBody
    public Map<String, Object> appendDocCandidate(String NODE_ID_, String CANDIDATE_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        CandidateList candidateList = null;
        if (StringUtils.isNotEmpty(CANDIDATE_LIST)) {
            candidateList = new Gson().fromJson(CANDIDATE_LIST, CandidateList.class);
        }

        FfResult ffResult = workFlowService.appendDocCandidate(NODE_ID_, candidateList, operator);
        List<Task> taskList = ffResult.getCreateTaskList();

        result.put("nextAssigneeNameList", OdUtils.collectFromBean(taskList, "assigneeName", String.class).toString());
        result.put("success", true);

        return result;
    }

    // 撤回
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "TASK_ID_")
    @RequestMapping(value = "withdrawDocTask")
    @ResponseBody
    public Map<String, Object> withdrawDocTask(String TASK_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        workFlowService.withdrawDocTask(TASK_ID_, operator);

        result.put("success", true);

        return result;
    }

    // 撤回
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "NODE_ID_")
    @RequestMapping(value = "withdrawDocNode")
    @ResponseBody
    public Map<String, Object> withdrawDocNode(String NODE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        workFlowService.withdrawDocNode(NODE_ID_, operator);

        result.put("success", true);

        return result;
    }

    // 取下个节点定义
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "getStartRunningNodeDefList")
    @ResponseBody
    public Map<String, Object> getStartRunningNodeDefList(@RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String procDefCode = (String) nodeVarMap.get("procDefCode");
        nodeVarMap.remove("procDefCode");
        nodeVarMap.put("INIT_EMP_ID_", operator.get("EMP_ID_"));
        nodeVarMap.put("INIT_EMP_NAME_", operator.get("EMP_NAME_"));
        nodeVarMap.put("INIT_ORG_ID_", operator.get("ORG_ID_"));
        nodeVarMap.put("INIT_ORG_NAME_", operator.get("ORG_NAME_"));
        nodeVarMap.put("INIT_COM_ID_", operator.get("COM_ID_"));
        nodeVarMap.put("INIT_COM_NAME_", operator.get("COM_NAME_"));
        nodeVarMap.put("INIT_DUTY_ID_", operator.get("DUTY_ID_"));
        nodeVarMap.put("INIT_DUTY_NAME_", operator.get("DUTY_NAME_"));
        nodeVarMap.put("INIT_POSI_ID_", operator.get("POSI_ID_"));
        nodeVarMap.put("INIT_POSI_NAME_", operator.get("POSI_NAME_"));
        nodeVarMap.put("INIT_POSI_EMP_ID_", operator.get("POSI_EMP_ID_"));
        if (operator.get("COM_ID_") != null) {
            nodeVarMap.put("initCom", omService.createOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId((String) operator.get("COM_ID_")).queryForObject());
        }
        List<RunningNodeDef> nextRunningNodeDefList = ffService.getStartRunningNodeDefList(null, ffService.loadProcDefByCode(procDefCode), nodeVarMap);

        result.put("nextRunningNodeDefList", nextRunningNodeDefList);
        result.put("success", true);

        return result;
    }

    // 取下个节点定义
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "getNextRunningNodeDefList")
    @ResponseBody
    public Map<String, Object> getNextRunningNodeDefList(@RequestParam HashMap<String, Object> nodeVarMap, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String TADK_ID_ = (String) nodeVarMap.get("TASK_ID_");
        nodeVarMap.remove("TASK_ID_");
        List<RunningNodeDef> nextRunningNodeDefList = ffService.getNextRunningNodeDefList(TADK_ID_, nodeVarMap);

        result.put("nextRunningNodeDefList", nextRunningNodeDefList);
        result.put("success", true);

        return result;
    }

    // 取流程图
    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "PROC_ID_")
    @RequestMapping(value = "getRunningProcDef")
    @ResponseBody
    public Map<String, Object> getRunningProcDef(String PROC_ID_, String TASK_ID_, boolean drawOptional, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        RunningProcDef runningProcDef = ffService.getRunningProcDef(PROC_ID_, TASK_ID_, drawOptional);
        Map<String, Object> nodeVarMap = runningProcDef.getNodeVarMap();
        Iterator<Map.Entry<String, Object>> iterator = nodeVarMap.entrySet().iterator();
        while (iterator.hasNext()) {
            Map.Entry<String, Object> entry = iterator.next();
            Object value = entry.getValue();
            if (value != null && !(value instanceof Serializable)) {
                iterator.remove();
            }
        }

        result.put("runningProcDef", runningProcDef);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF", businessKeyParameterName = "PROC_DEF_ID_")
    @RequestMapping(value = "loadOperation")
    @ResponseBody
    public Map<String, Object> loadOperation(String OPERATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> operation = ffOperationService.loadOperation(OPERATION_ID_);

        result.put("operation", operation);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectMyOperation")
    @ResponseBody
    public Map<String, Object> selectMyOperation(String OPERATION_ID_, String OPERATION_, String PROC_ID_, String NODE_ID_, String TASK_ID_, String OPERATOR_NAME_, Date FROM_OPERATION_DATE_, Date TO_OPERATION_DATE_, @RequestParam(value = "OPERATION_STATUS_LIST", required = false) List<String> OPERATION_STATUS_LIST, String BIZ_ID_, @RequestParam(value = "BIZ_TYPE_LIST", required = false) List<String> BIZ_TYPE_LIST, String BIZ_CODE_, String BIZ_NAME_, String dataScope, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);

        List<Map<String, Object>> myOperationList = ffService.createOperationQuery().setOperationId(OPERATION_ID_).setOperation(OPERATION_).setProcId(PROC_ID_).setNodeId(NODE_ID_).setTaskId(TASK_ID_).setOperatorList(posiEmpIdList).setOperatorName(OPERATOR_NAME_).setFromOperationDate(FROM_OPERATION_DATE_).setToOperationDate(TO_OPERATION_DATE_).setOperationStatusList(OPERATION_STATUS_LIST).setBizId(BIZ_ID_).setBizTypeList(BIZ_TYPE_LIST).setBizCode(BIZ_CODE_).setBizName(BIZ_NAME_).setDataScope(dataScope).setPage(page).setLimit(limit).queryForMapList();
        for (Map<String, Object> myOperation : myOperationList) {
            if (myOperation.get("TASK_ID_") != null) {
                Map<String, Object> approvalMemo = approvalMemoService.loadLastApprovalMemoByTaskId((String) myOperation.get("TASK_ID_"));
                if (approvalMemo != null) {
                    myOperation.put("APPROVAL_MEMO_", approvalMemo.get("APPROVAL_MEMO_"));
                }
            }
        }

        int total = 0;
        if (limit != null && limit > 0) {
            total = ffService.createOperationQuery().setOperationId(OPERATION_ID_).setOperation(OPERATION_).setProcId(PROC_ID_).setNodeId(NODE_ID_).setTaskId(TASK_ID_).setOperationIdList(posiEmpIdList).setOperatorName(OPERATOR_NAME_).setFromOperationDate(FROM_OPERATION_DATE_).setToOperationDate(TO_OPERATION_DATE_).setOperationStatusList(OPERATION_STATUS_LIST).setBizId(BIZ_ID_).setBizTypeList(BIZ_TYPE_LIST).setBizCode(BIZ_CODE_).setBizName(BIZ_NAME_).setDataScope(dataScope).setPage(page).setLimit(limit).count();
        }

        result.put("myOperationList", myOperationList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    /**
     * 获取操作相关新增的节点和任务，用于调整下一步审批人
     * 
     * @param OPERATION_ID_
     * @param operator
     * @return
     */
    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "getNextNodeTaskInfo")
    @ResponseBody
    public Map<String, Object> getNextNodeTaskInfo(String OPERATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        // 查询该操作涉及的节点，并找出此次操作新增的根节点
        List<Map<String, Object>> nodeOpList = ffOperationService.selectNodeOp(OPERATION_ID_);
        List<String> nodeOpIdList = OdUtils.collect(nodeOpList, "NODE_ID_", String.class);
        List<Map<String, Object>> rootNodeOpList = new ArrayList<>();
        for (Map<String, Object> nodeOp : nodeOpList) {// 只保留这些节点中新增的根节点，
            if ((nodeOp.get("PARENT_NODE_ID_") == null || !nodeOpIdList.contains(nodeOp.get("PARENT_NODE_ID_"))) && FfService.OPERATION_INSERT.equals(nodeOp.get("OPERATION_TYPE_"))) {
                rootNodeOpList.add(nodeOp);
            }
        }

        // 获取这些根节点下的所有节点
        List<Map<String, Object>> nodeList = new ArrayList<>();
        for (Map<String, Object> rootNodeOp : rootNodeOpList) {
            nodeList.addAll(ffService.createChildNodeQuery().setNodeId((String) rootNodeOp.get("NODE_ID_")).setRecursive(true).setIncludeSelf(true).setPreviousNodeIds((String) rootNodeOp.get("PREVIOUS_NODE_IDS_")).setDataScope(FfService.DATA_SCOPE_PROC_DEF).queryForMapList());
        }
        for (int i = nodeList.size() - 1; i >= 0; i--) {
            Map<String, Object> node = nodeList.get(i);
            if (node.get("NODE_TYPE_").equals(FfService.NODE_TYPE_SERVICE_TASK) || node.get("NODE_TYPE_").equals(FfService.NODE_TYPE_STAGE) || node.get("NODE_TYPE_").equals(FfService.NODE_TYPE_GATEWAY) || node.get("NODE_TYPE_").equals(FfService.NODE_TYPE_END)) {
                nodeList.remove(i);
            }
        }
        if (nodeList.size() == 0) {
            return result;
        }

        List<String> nodeIdList = OdUtils.collect(nodeList, "NODE_ID_", String.class);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> node : nodeList) {
            // 设置子流程编码
            node.put("SUB_PROC_DEF_CODE_", ffService.loadProcDef((String) node.get("SUB_PROC_DEF_ID_")).getProcDefCode());
            // 设置前台显示值
            node.put("DISPLAY_VALUE_", node.get("NODE_NAME_"));
            // 设置该节点下的任务和子流程是否为候选
            ProcDef procDef = ffService.getNodeProcDef(ffService.loadNode((String) node.get("NODE_ID_")));
            NodeDef nodeDef = procDef.getNodeDef((String) node.get("NODE_CODE_"));
            if (nodeDef != null && (StringUtils.isNotEmpty(nodeDef.getCandidateAssignee()) || StringUtils.isNotEmpty(nodeDef.getCandidateSubProcDef()))) {
                node.put("candidate", true);
            }
            else {
                node.put("candidate", false);
            }

            // 组建节点树
            if (node.get("PARENT_NODE_ID_") == null || node.get("PARENT_NODE_ID_").equals("") || !nodeIdList.contains(node.get("PARENT_NODE_ID_"))) {
                String subProcPath = ffService.getSubProcPath(ffService.loadNode((String) node.get("NODE_ID_")));
                node.put("subProcPath", subProcPath);
                children.add(node);
                // 当前节点类型为子流程时，预设其子节点的subProcPath
                if (node.get("NODE_TYPE_").equals(FfService.NODE_TYPE_SUB_PROC)) {
                    if (StringUtils.isEmpty(subProcPath)) {
                        subProcPath = (String) node.get("NODE_CODE_");
                    }
                    else {
                        subProcPath = subProcPath + "." + (String) node.get("NODE_CODE_");
                    }
                }
                fillChildNode(node, subProcPath, nodeList);
            }
        }

        // 将这些节点下的任务挂到树上
        List<Map<String, Object>> taskList = ffService.createTaskQuery().setNodeIdList(nodeIdList).queryForMapList();
        Map<String, Object> task;
        Map<String, Object> node;
        for (int i = 0; i < taskList.size(); i++) {
            task = taskList.get(i);

            // 设置前台显示值
            task.put("DISPLAY_VALUE_", task.get("ASSIGNEE_NAME_"));
            // 设置为空子节点
            task.put("children", new ArrayList<>());
            // 将任务挂到节点树上
            node = findNode((String) task.get("NODE_ID_"), nodeList);
            List<Map<String, Object>> _children = (List<Map<String, Object>>) node.get("children");
            if (_children == null) {
                _children = new ArrayList<Map<String, Object>>();
                node.put("children", _children);
            }
            // 设置任务是否可删除
            if ((boolean) node.get("candidate") == true && task.get("TASK_STATUS_").equals(FfService.TASK_STATUS_ACTIVE)) {
                task.put("deletable", true);
            }
            else {
                task.put("deletable", false);
            }

            _children.add(task);
        }

        // 设置该节点是否为可删除的子流程
        for (Map<String, Object> _node : nodeList) {
            if ((boolean) _node.get("candidate") == true && _node.get("NODE_TYPE_").equals(FfService.NODE_TYPE_SUB_PROC) && _node.get("children") != null) {
                List<Map<String, Object>> _children = (List<Map<String, Object>>) _node.get("children");
                for (Map<String, Object> branchNode : _children) {
                    List<String> childNodeIdList = getChildNodeIdList(branchNode);
                    if (undoable(taskList, childNodeIdList)) {
                        branchNode.put("deletable", true);
                    }
                }
            }
        }

        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildNode(Map<String, Object> node, String subProcPath, List<Map<String, Object>> nodeList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childNode;
        for (int i = 0; i < nodeList.size(); i++) {
            childNode = nodeList.get(i);
            if (node.get("NODE_ID_").equals(childNode.get("PARENT_NODE_ID_"))) {
                children.add(childNode);

                // 当前节点类型为子流程时，预设其子节点的subProcPath
                if (childNode.get("NODE_TYPE_").equals(FfService.NODE_TYPE_SUB_PROC)) {
                    childNode.put("subProcPath", subProcPath);
                    if (StringUtils.isEmpty(subProcPath)) {
                        subProcPath = (String) childNode.get("NODE_CODE_");
                    }
                    else {
                        subProcPath = subProcPath + "." + (String) childNode.get("NODE_CODE_");
                    }
                }
                // 当前节点类型为分支时，补全节点的subProcPath
                else
                    if (childNode.get("NODE_TYPE_").equals(FfService.NODE_TYPE_BRANCH)) {
                        subProcPath = subProcPath + ":" + childNode.get("SUB_PROC_DEF_CODE_");
                        childNode.put("subProcPath", subProcPath);
                    } // 其它节点类型，继续使用当前的subProcPath
                    else {
                        childNode.put("subProcPath", subProcPath);
                    }

                fillChildNode(childNode, subProcPath, nodeList);
            }
        }
        node.put("children", children);
    }

    /**
     * 按ID查找节点
     * 
     * @param nodeId
     * @param nodeList
     * @return
     */
    private Map<String, Object> findNode(String nodeId, List<Map<String, Object>> nodeList) {
        for (Map<String, Object> node : nodeList) {
            if (node.get("NODE_ID_").equals(nodeId)) {
                return node;
            }
        }

        return null;
    }

    /**
     * 获取该节点下所有子节点ID，包括自身。
     * 
     * @param node
     * @return
     */
    @SuppressWarnings("unchecked")
    private List<String> getChildNodeIdList(Map<String, Object> node) {
        List<String> childNodeIdList = new ArrayList<>();
        childNodeIdList.add((String) node.get("NODE_ID_"));

        if (node.get("children") != null) {
            List<Map<String, Object>> children = (List<Map<String, Object>>) node.get("children");
            for (Map<String, Object> _node : children) {
                if (!_node.containsKey("TASK_ID_")) {
                    childNodeIdList.addAll(getChildNodeIdList(_node));
                }
            }
        }

        return childNodeIdList;
    }

    /**
     * 这些节点下的任务是否都为活动状态，如果是这些节点的父节点可撤回，否则不可撤回。
     * 
     * @param taskList
     * @param nodeIdList
     * @return
     */
    private boolean undoable(List<Map<String, Object>> taskList, List<String> nodeIdList) {
        for (Map<String, Object> task : taskList) {
            if (nodeIdList.contains(task.get("NODE_ID_")) && !task.get("TASK_STATUS_").equals(FfService.TASK_STATUS_ACTIVE)) {
                return false;
            }
        }

        return true;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectNodeOp")
    @ResponseBody
    public Map<String, Object> selectNodeOp(String OPERATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> nodeOpList = ffOperationService.selectNodeOp(OPERATION_ID_);

        result.put("nodeOpList", nodeOpList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "selectTaskOp")
    @ResponseBody
    public Map<String, Object> selectTaskOp(String OPERATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> taskOpList = ffOperationService.selectTaskOp(OPERATION_ID_);

        result.put("taskOpList", taskOpList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "undoOperation")
    @ResponseBody
    public Map<String, Object> undoOperation(String OPERATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        FfResult ffResult = ffOperationService.undo(OPERATION_ID_);
        List<Task> activateTaskList = ffResult.getActivateTaskList();
        for (Task activateTask : activateTaskList) {
            approvalMemoService.activateLastApprovalMemoByTaskId(activateTask.getTaskId(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }
        List<Proc> deleteProcList = ffResult.getDeleteProcList();
        for (Proc deleteProc : deleteProcList) {
            docService.updateDocProcStatus(deleteProc.getBizId(), "0");
        }
        List<Proc> activateProcList = ffResult.getActivateProcList();
        for (Proc activateProc : activateProcList) {
            docService.updateDocProcStatus(activateProc.getBizId(), "1");
        }
        approvalMemoService.deleteApprovalMemoByOperationId(OPERATION_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("operation", ffOperationService.loadOperation(OPERATION_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "FF")
    @RequestMapping(value = "getProcByOperationId")
    @ResponseBody
    public Map<String, Object> getProcByOperationId(String OPERATION_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Operation operation = ffService.createOperationQuery().setOperationId(OPERATION_ID_).queryForObject();
        Proc proc = ffService.createProcQuery().setProcId(operation.getProcId()).queryForObject();

        result.put("proc", proc);
        result.put("success", true);

        return result;
    }
}