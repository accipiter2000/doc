package com.opendynamic.doc.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.doc.service.DocService;
import com.opendynamic.om.service.OmService;

@Controller
public class DocController extends OdController {
    @Autowired
    private DocService docService;
    @Autowired
    private OmService omService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageDoc")
    public String manageDoc(Map<String, Object> operator) {
        return "k/Doc/manageDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageMyAdminDoc")
    public String manageMyAdminDoc(Map<String, Object> operator) {
        return "k/Doc/manageMyAdminDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageMyInvolvedDoc")
    public String manageMyInvolvedDoc(Map<String, Object> operator) {
        return "k/Doc/manageMyInvolvedDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preChooseDoc")
    public String preChooseDoc(Map<String, Object> operator) {
        return "k/Doc/preChooseDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "compileDoc")
    public String compileDoc(Map<String, Object> operator) {
        return "k/Doc/compileDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDoc")
    public String preUpdateDoc(Map<String, Object> operator) {
        return "k/Doc/preUpdateDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocTemplateFile")
    public String preUpdateDocTemplateFile(Map<String, Object> operator) {
        return "k/Doc/preUpdateTemplateFile";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocHtml")
    public String preUpdateDocHtml(Map<String, Object> operator) {
        return "k/Doc/preUpdateHtml";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocIndex")
    public String preUpdateDocIndex(Map<String, Object> operator) {
        return "k/Doc/preUpdateIndex";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDoc")
    public String viewDoc(Map<String, Object> operator) {
        return "k/Doc/viewDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDocBasicInfo")
    public String viewDocBasicInfo(Map<String, Object> operator) {
        return "k/Doc/viewDocBasicInfo";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDocFile")
    public String viewDocFile(Map<String, Object> operator) {
        return "k/Doc/viewDocFile";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDocDiff")
    public String viewDocDiff(Map<String, Object> operator) {
        return "k/Doc/viewDocDiff";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "loadDoc")
    @ResponseBody
    public Map<String, Object> loadDoc(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> doc = docService.loadDoc(DOC_ID_);

        result.put("doc", doc);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_CODE_")
    @RequestMapping(value = "loadDocByCode")
    @ResponseBody
    public Map<String, Object> loadDocByCode(String DOC_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> doc = docService.loadDocByCode(DOC_CODE_);

        result.put("doc", doc);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "loadTemplateFile")
    public void loadTemplateFile(String DOC_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);// 获取下载文件名
        String fileName = (String) doc.get("TEMPLATE_FILE_NAME_");
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = docService.loadTemplateFile(DOC_ID_);// 二进制流文件内容
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

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "loadDocFile")
    public void loadDocFile(String DOC_ID_, Boolean readOnly, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);// 获取下载文件名
        String fileName = (String) doc.get("DOC_FILE_NAME_");
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = docService.loadDocFile(DOC_ID_, readOnly);// 二进制流文件内容
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

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "loadPdfDocFile")
    public void loadPdfDocFile(String DOC_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> doc = docService.loadDoc(DOC_ID_);// 获取下载文件名
        String fileName = (String) doc.get("DOC_FILE_NAME_");
        fileName += ".pdf";
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = docService.loadPdfDocFile(DOC_ID_);// 二进制流文件内容
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

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "loadDocHtml")
    @ResponseBody
    public Map<String, Object> loadDocHtml(String DOC_ID_, Boolean editable, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String html = docService.loadHtml(DOC_ID_, editable);

        result.put("html", html);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDoc")
    @ResponseBody
    public Map<String, Object> selectDoc(String DOC_ID_, @RequestParam(value = "DOC_ID_LIST", required = false) List<String> DOC_ID_LIST, String DOC_CODE_, @RequestParam(value = "DOC_CODE_LIST", required = false) List<String> DOC_CODE_LIST, String DOC_NAME_, @RequestParam(value = "DOC_NAME_LIST", required = false) List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, @RequestParam(value = "DOC_TYPE_NAME_LIST", required = false) List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, @RequestParam(value = "OWNER_ID_LIST", required = false) List<String> OWNER_ID_LIST, String OWNER_NAME_, @RequestParam(value = "OWNER_NAME_LIST", required = false) List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, @RequestParam(value = "OWNER_ORG_ID_LIST", required = false) List<String> OWNER_ORG_ID_LIST,
            String OWNER_ORG_NAME_, @RequestParam(value = "OWNER_ORG_NAME_LIST", required = false) List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, @RequestParam(value = "USING_TEMPLATE_LIST", required = false) List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, @RequestParam(value = "PROC_DEF_CODE_LIST", required = false) List<String> PROC_DEF_CODE_LIST, String PROC_ID_, @RequestParam(value = "PROC_ID_LIST", required = false) List<String> PROC_ID_LIST, String PROC_STATUS_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, String DOC_STATUS_, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_,
            Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docList = docService.selectDoc(DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, OWNER_ID_, OWNER_ID_LIST, OWNER_NAME_, OWNER_NAME_LIST, OWNER_ORG_ID_, OWNER_ORG_ID_LIST, OWNER_ORG_NAME_, OWNER_ORG_NAME_LIST, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docService.countDoc(DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, OWNER_ID_, OWNER_ID_LIST, OWNER_NAME_, OWNER_NAME_LIST, OWNER_ORG_ID_, OWNER_ORG_ID_LIST, OWNER_ORG_NAME_, OWNER_ORG_NAME_LIST, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_);
        }

        result.put("docList", docList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    // 我管理的
    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectMyAdminDoc")
    @ResponseBody
    public Map<String, Object> selectMyAdminDoc(String DOC_ID_, @RequestParam(value = "DOC_ID_LIST", required = false) List<String> DOC_ID_LIST, String DOC_CODE_, @RequestParam(value = "DOC_CODE_LIST", required = false) List<String> DOC_CODE_LIST, String DOC_NAME_, @RequestParam(value = "DOC_NAME_LIST", required = false) List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, @RequestParam(value = "DOC_TYPE_NAME_LIST", required = false) List<String> DOC_TYPE_NAME_LIST, String USING_TEMPLATE_, @RequestParam(value = "USING_TEMPLATE_LIST", required = false) List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, @RequestParam(value = "PROC_DEF_CODE_LIST", required = false) List<String> PROC_DEF_CODE_LIST, String PROC_ID_,
            @RequestParam(value = "PROC_ID_LIST", required = false) List<String> PROC_ID_LIST, String PROC_STATUS_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, String DOC_STATUS_, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<String> COM_ID_LIST = new ArrayList<>();
        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        for (Map<String, Object> posiEmp : posiEmpList) {
            if (posiEmp.get("DUTY_CODE_").equals("公文管理员")) {
                List<Map<String, Object>> parentOrgList = omService.createParentOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId((String) posiEmp.get("ORG_ID_")).setOrgTypeList(Arrays.asList("1", "2", "3", "4", "5", "99")).setIncludeSelf(true).setRecursive(true).queryForMapList();
                if (parentOrgList.size() > 0) {
                    Map<String, Object> com = parentOrgList.get(0);
                    COM_ID_LIST.add((String) com.get("ORG_ID_"));
                }
            }
        }
        if (COM_ID_LIST.size() > 0) {
            List<Map<String, Object>> myAdminDocList = docService.selectMyAdminDoc(DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, null, null, null, null, null, COM_ID_LIST, null, null, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_, page, limit);
            int total = 0;
            if (limit != null && limit > 0) {
                total = docService.countMyAdminDoc(DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, null, null, null, null, null, COM_ID_LIST, null, null, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_);
            }

            result.put("myAdminDocList", myAdminDocList);
            result.put("total", total);
            result.put("success", true);
        }
        else {
            result.put("myAdminDocList", new ArrayList<>());
            result.put("total", 0);
            result.put("success", true);
        }

        return result;
    }

    // 已办
    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectMyInvolvedDoc")
    @ResponseBody
    public Map<String, Object> selectMyInvolvedDoc(String DOC_ID_, @RequestParam(value = "DOC_ID_LIST", required = false) List<String> DOC_ID_LIST, String DOC_CODE_, @RequestParam(value = "DOC_CODE_LIST", required = false) List<String> DOC_CODE_LIST, String DOC_NAME_, @RequestParam(value = "DOC_NAME_LIST", required = false) List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, @RequestParam(value = "DOC_TYPE_NAME_LIST", required = false) List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, @RequestParam(value = "OWNER_ID_LIST", required = false) List<String> OWNER_ID_LIST, String OWNER_NAME_, @RequestParam(value = "OWNER_NAME_LIST", required = false) List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, @RequestParam(value = "OWNER_ORG_ID_LIST", required = false) List<String> OWNER_ORG_ID_LIST,
            String OWNER_ORG_NAME_, @RequestParam(value = "OWNER_ORG_NAME_LIST", required = false) List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, @RequestParam(value = "USING_TEMPLATE_LIST", required = false) List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, @RequestParam(value = "PROC_DEF_CODE_LIST", required = false) List<String> PROC_DEF_CODE_LIST, String PROC_ID_, @RequestParam(value = "PROC_ID_LIST", required = false) List<String> PROC_ID_LIST, String PROC_STATUS_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, String DOC_STATUS_, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_,
            Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);

        List<Map<String, Object>> myInvolvedDocList = docService.selectMyInvolvedDoc(posiEmpIdList, DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, OWNER_ID_, OWNER_ID_LIST, OWNER_NAME_, OWNER_NAME_LIST, OWNER_ORG_ID_, OWNER_ORG_ID_LIST, OWNER_ORG_NAME_, OWNER_ORG_NAME_LIST, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docService.countMyInvolvedDoc(posiEmpIdList, DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, OWNER_ID_, OWNER_ID_LIST, OWNER_NAME_, OWNER_NAME_LIST, OWNER_ORG_ID_, OWNER_ORG_ID_LIST, OWNER_ORG_NAME_, OWNER_ORG_NAME_LIST, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_);
        }

        result.put("myInvolvedDocList", myInvolvedDocList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "countMyInvolvedDoc")
    @ResponseBody
    public Map<String, Object> countMyInvolvedDoc(String DOC_ID_, @RequestParam(value = "DOC_ID_LIST", required = false) List<String> DOC_ID_LIST, String DOC_CODE_, @RequestParam(value = "DOC_CODE_LIST", required = false) List<String> DOC_CODE_LIST, String DOC_NAME_, @RequestParam(value = "DOC_NAME_LIST", required = false) List<String> DOC_NAME_LIST, String DOC_TYPE_NAME_, @RequestParam(value = "DOC_TYPE_NAME_LIST", required = false) List<String> DOC_TYPE_NAME_LIST, String OWNER_ID_, @RequestParam(value = "OWNER_ID_LIST", required = false) List<String> OWNER_ID_LIST, String OWNER_NAME_, @RequestParam(value = "OWNER_NAME_LIST", required = false) List<String> OWNER_NAME_LIST, String OWNER_ORG_ID_, @RequestParam(value = "OWNER_ORG_ID_LIST", required = false) List<String> OWNER_ORG_ID_LIST,
            String OWNER_ORG_NAME_, @RequestParam(value = "OWNER_ORG_NAME_LIST", required = false) List<String> OWNER_ORG_NAME_LIST, String USING_TEMPLATE_, @RequestParam(value = "USING_TEMPLATE_LIST", required = false) List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, @RequestParam(value = "PROC_DEF_CODE_LIST", required = false) List<String> PROC_DEF_CODE_LIST, String PROC_ID_, @RequestParam(value = "PROC_ID_LIST", required = false) List<String> PROC_ID_LIST, String PROC_STATUS_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, String DOC_STATUS_, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Date FROM_EFFECTIVE_DATE_, Date TO_EFFECTIVE_DATE_,
            Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);

        int total = 0;
        if (limit != null && limit > 0) {
            total = docService.countMyInvolvedDoc(posiEmpIdList, DOC_ID_, DOC_ID_LIST, DOC_CODE_, DOC_CODE_LIST, DOC_NAME_, DOC_NAME_LIST, DOC_TYPE_NAME_, DOC_TYPE_NAME_LIST, OWNER_ID_, OWNER_ID_LIST, OWNER_NAME_, OWNER_NAME_LIST, OWNER_ORG_ID_, OWNER_ORG_ID_LIST, OWNER_ORG_NAME_, OWNER_ORG_NAME_LIST, USING_TEMPLATE_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, PROC_DEF_CODE_LIST, PROC_ID_, PROC_ID_LIST, PROC_STATUS_, PROC_STATUS_LIST, DOC_STATUS_, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, FROM_EFFECTIVE_DATE_, TO_EFFECTIVE_DATE_);
        }

        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocByIdList")
    @ResponseBody
    public Map<String, Object> selectDocByIdList(@RequestParam(value = "DOC_ID_LIST", required = false) List<String> DOC_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docList = docService.selectDocByIdList(DOC_ID_LIST);

        result.put("docList", docList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertDocByDocType")
    @ResponseBody
    public Map<String, Object> insertDocByDocType(String DOC_TYPE_ID_, String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.insertDocByDocType(DOC_TYPE_ID_, DOC_ID_, DOC_CODE_, DOC_NAME_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"), (String) operator.get("COM_ID_"), (String) operator.get("COM_NAME_"), MEMO_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDoc")
    @ResponseBody
    public Map<String, Object> updateDoc(String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.updateDoc(DOC_ID_, DOC_CODE_, DOC_NAME_, MEMO_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "updateDocDocType")
    @ResponseBody
    public Map<String, Object> updateDocDocType(String DOC_ID_, String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.updateDocDocType(DOC_ID_, DOC_TYPE_ID_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDocHtml")
    @ResponseBody
    public Map<String, Object> updateDocHtml(String DOC_ID_, String HTML_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.updateHtml(DOC_ID_, HTML_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDocIndex")
    @ResponseBody
    public Map<String, Object> updateDocIndex(String DOC_ID_, String INDEX_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.updateIndex(DOC_ID_, INDEX_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDocTemplateFile")
    @ResponseBody
    public Map<String, Object> updateDocTemplateFile(String DOC_ID_, MultipartFile TEMPLATE_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream TEMPLATE_FILE_InputStream;
            String TEMPLATE_FILE_NAME_;
            Integer TEMPLATE_FILE_LENGTH_;
            if (TEMPLATE_FILE_ != null) {
                TEMPLATE_FILE_InputStream = TEMPLATE_FILE_.getInputStream();// 获取上传二进制流
                TEMPLATE_FILE_NAME_ = OdUtils.getFileName(TEMPLATE_FILE_.getOriginalFilename());
                TEMPLATE_FILE_LENGTH_ = (int) TEMPLATE_FILE_.getSize();
            }
            else {
                TEMPLATE_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                TEMPLATE_FILE_NAME_ = null;
                TEMPLATE_FILE_LENGTH_ = 0;
            }
            if (docService.updateDocTemplateFile(DOC_ID_, TEMPLATE_FILE_InputStream, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            TEMPLATE_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDocFile")
    @ResponseBody
    public Map<String, Object> updateDocFile(String DOC_ID_, MultipartFile DOC_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream DOC_FILE_InputStream;
            String DOC_FILE_NAME_;
            Integer DOC_FILE_LENGTH_;
            if (DOC_FILE_ != null) {
                DOC_FILE_InputStream = DOC_FILE_.getInputStream();// 获取上传二进制流
                DOC_FILE_NAME_ = OdUtils.getFileName(DOC_FILE_.getOriginalFilename());
                DOC_FILE_LENGTH_ = (int) DOC_FILE_.getSize();
            }
            else {
                DOC_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                DOC_FILE_NAME_ = null;
                DOC_FILE_LENGTH_ = 0;
            }
            if (docService.updateDocFile(DOC_ID_, DOC_FILE_InputStream, DOC_FILE_NAME_, DOC_FILE_LENGTH_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            DOC_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateDocData")
    @ResponseBody
    public Map<String, Object> updateDocData(String DOC_ID_, @RequestParam(value = "BOOK_MARK_LIST", required = false) List<String> BOOK_MARK_LIST, @RequestParam(value = "VALUE_LIST", required = false) List<String> VALUE_LIST, @RequestParam(value = "DATA_TYPE_LIST", required = false) List<String> DATA_TYPE_LIST, @RequestParam(value = "ORDER_LIST", required = false) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (VALUE_LIST.size() == 0) {
            VALUE_LIST = new ArrayList<>(BOOK_MARK_LIST.size());
            for (int i = 0; i < BOOK_MARK_LIST.size(); i++) {
                VALUE_LIST.add("");
            }
        }
        try {
            docService.updateDocData(DOC_ID_, BOOK_MARK_LIST, VALUE_LIST, DATA_TYPE_LIST, ORDER_LIST, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));
        }
        catch (Exception e) {
            throw new RuntimeException(e);
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "deleteDoc")
    @ResponseBody
    public Map<String, Object> deleteDoc(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.deleteDoc(DOC_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "deleteTemplateFile")
    @ResponseBody
    public Map<String, Object> deleteTemplateFile(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.deleteTemplateFile(DOC_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "deleteDocFile")
    @ResponseBody
    public Map<String, Object> deleteDocFile(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docService.deleteDocFile(DOC_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "getDocBookmark")
    public void getDocBookmark(String DOC_ID_, Map<String, Object> operator, HttpServletResponse response) throws Exception {
        response.setContentType("application/json;charset=UTF-8");
        String bookmark = docService.getBookmark(DOC_ID_);
        if (bookmark != null) {
            response.getWriter().write(bookmark);
        }
        else {
            response.getWriter().write("{\"bookmarkList\":[]}");
        }
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "hasDocFile")
    @ResponseBody
    public Map<String, Object> hasDocFile(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        result.put("hasDocFile", docService.hasDocFile(DOC_ID_));
        result.put("success", true);
        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "isUsingTemplate")
    @ResponseBody
    public Map<String, Object> isUsingTemplate(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        result.put("isUsingTemplate", docService.isUsingTemplate(DOC_ID_));
        result.put("success", true);
        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "getDocDiff")
    @ResponseBody
    public Map<String, Object> getDocDiff(String DOC_ID_, Integer VERSION_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        result.put("docDiff", docService.getDocDiff(DOC_ID_, VERSION_));
        result.put("success", true);
        return result;
    }
}