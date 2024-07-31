package com.opendynamic.doc.controller;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
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

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.doc.service.DocService;

@Controller
public class DocController extends OdController {
    @Autowired
    private DocService docService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageDoc")
    public String manageDoc(Map<String, Object> operator) {
        return "k/Doc/manageDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageMyDraftDoc")
    public String manageMyDraftDoc(Map<String, Object> operator) {
        return "k/Doc/manageMyDraftDoc";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageMyInvolvedDoc")
    public String manageMyInvolvedDoc(Map<String, Object> operator) {
        return "k/Doc/manageMyInvolvedDoc";
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
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> doc = docService.loadDoc(DOC_ID_);

        result.put("doc", doc);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_CODE_")
    @RequestMapping(value = "loadDocByCode")
    @ResponseBody
    public Map<String, Object> loadDocByCode(String DOC_CODE_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> doc = docService.loadDocByCode(DOC_CODE_);

        result.put("doc", doc);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "loadDocTemplateFile")
    public void loadDocTemplateFile(String DOC_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
    @RequestMapping(value = "loadDocTemplateHtml")
    @ResponseBody
    public Map<String, Object> loadDocTemplateHtml(String DOC_ID_, Boolean editable, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        String templateHtml = docService.loadTemplateHtml(DOC_ID_, editable);

        result.put("templateHtml", templateHtml);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDoc")
    @ResponseBody
    public Map<String, Object> selectDoc(String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, @RequestParam(value = "USING_TEMPLATE_PLACEHOLDERS_LIST", required = false) List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> docList = docService.selectDoc(DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docService.countDoc(DOC_ID_, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);
        }

        result.put("docList", docList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    // 我起草的
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectMyDraftDoc")
    @ResponseBody
    public Map<String, Object> selectMyDraftDoc(String DOC_ID_, String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, @RequestParam(value = "USING_TEMPLATE_PLACEHOLDERS_LIST", required = false) List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> myDraftDocList = docService.selectMyDraftDoc((String) operator.get("EMP_ID_"), DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docService.countMyDraftDoc((String) operator.get("EMP_ID_"), DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);
        }

        result.put("myDraftDocList", myDraftDocList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    // 已办
    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectMyInvolvedDoc")
    @ResponseBody
    public Map<String, Object> selectMyInvolvedDoc(String DOC_TYPE_NAME_, String DOC_CODE_, String DOC_NAME_, @RequestParam(value = "USING_TEMPLATE_PLACEHOLDERS_LIST", required = false) List<String> USING_TEMPLATE_PLACEHOLDERS_LIST, String DRAFTER_ID_, String DRAFTER_COM_ID_, String PROC_DEF_CODE_, String PROC_ID_, @RequestParam(value = "PROC_STATUS_LIST", required = false) List<String> PROC_STATUS_LIST, @RequestParam(value = "DOC_STATUS_LIST", required = false) List<String> DOC_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> posiEmpList = (List<Map<String, Object>>) operator.get("posiEmpList");
        List<String> posiEmpIdList = OdUtils.collect(posiEmpList, "POSI_EMP_ID_", String.class);

        List<Map<String, Object>> myInvolvedDocList = docService.selectMyInvolvedDoc(posiEmpIdList, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docService.countMyInvolvedDoc(posiEmpIdList, DOC_TYPE_NAME_, DOC_CODE_, DOC_NAME_, USING_TEMPLATE_PLACEHOLDERS_LIST, DRAFTER_ID_, DRAFTER_COM_ID_, PROC_DEF_CODE_, PROC_ID_, PROC_STATUS_LIST, DOC_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);
        }

        result.put("myInvolvedDocList", myInvolvedDocList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocByIdList")
    @ResponseBody
    public Map<String, Object> selectDocByIdList(@RequestParam(value = "DOC_ID_LIST", required = false) List<String> DOC_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> docList = docService.selectDocByIdList(DOC_ID_LIST);

        result.put("docList", docList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertDocByDocType")
    @ResponseBody
    public Map<String, Object> insertDocByDocType(String DOC_ID_, String DOC_TYPE_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (docService.insertDocByDocType(DOC_ID_, DOC_TYPE_ID_, DOC_CODE_, DOC_NAME_, MEMO_, (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"), (String) operator.get("COM_ID_"), (String) operator.get("COM_NAME_"), new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "updateDocByDocType")
    @ResponseBody
    public Map<String, Object> updateDocByDocType(String DOC_ID_, String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (docService.updateDocByDocType(DOC_ID_, DOC_TYPE_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDoc")
    @ResponseBody
    public Map<String, Object> updateDoc(String DOC_ID_, String DOC_CODE_, String DOC_NAME_, String MEMO_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (docService.updateDoc(DOC_ID_, DOC_CODE_, DOC_NAME_, MEMO_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDocFile")
    @ResponseBody
    public Map<String, Object> updateDocFile(String DOC_ID_, MultipartFile DOC_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

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
        catch (Exception e) {
            throw new RuntimeException(e);
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "updateDocData")
    @ResponseBody
    public Map<String, Object> updateDocData(String DOC_ID_, @RequestParam(value = "BOOK_MARK_LIST", required = false) List<String> BOOK_MARK_LIST, @RequestParam(value = "VALUE_LIST", required = false) List<String> VALUE_LIST, @RequestParam(value = "DATA_TYPE_LIST", required = false) List<String> DATA_TYPE_LIST, @RequestParam(value = "ORDER_LIST", required = false) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (VALUE_LIST.isEmpty()) {
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
    @RequestMapping(value = "disableDoc")
    @ResponseBody
    public Map<String, Object> disableDoc(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (docService.disableDoc(DOC_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "enableDoc")
    @ResponseBody
    public Map<String, Object> enableDoc(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (docService.enableDoc(DOC_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("doc", docService.loadDoc(DOC_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "deleteDoc")
    @ResponseBody
    public Map<String, Object> deleteDoc(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (docService.deleteDoc(DOC_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "isUsingTemplatePlaceholders")
    @ResponseBody
    public Map<String, Object> isUsingTemplatePlaceholders(String DOC_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        result.put("isUsingTemplatePlaceholders", docService.isUsingTemplatePlaceholders(DOC_ID_));
        result.put("success", true);
        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "getDocTemplateBookmarkList")
    public void getDocTemplateBookmarkList(String DOC_ID_, Map<String, Object> operator, HttpServletResponse response) throws Exception {
        response.setContentType("application/json;charset=UTF-8");
        String templateBookmarkList = docService.getTemplateBookmark(DOC_ID_);
        if (templateBookmarkList != null) {
            response.getWriter().write(templateBookmarkList);
        }
        else {
            response.getWriter().write("{\"templateBookmarkList\":[]}");
        }
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_ID_")
    @RequestMapping(value = "getDocDiff")
    @ResponseBody
    public Map<String, Object> getDocDiff(String DOC_ID_, Integer VERSION_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        result.put("docDiff", docService.getDocDiff(DOC_ID_, VERSION_));
        result.put("success", true);
        return result;
    }
}