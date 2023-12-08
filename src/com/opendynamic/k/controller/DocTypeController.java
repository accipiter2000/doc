package com.opendynamic.k.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
import com.opendynamic.k.service.DocTypeService;

@Controller
public class DocTypeController extends OdController {
    @Autowired
    private DocTypeService docTypeService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageDocType")
    public String manageDocType(Map<String, Object> operator) {
        return "k/DocType/manageDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preChooseDocType")
    public String preChooseDocType(Map<String, Object> operator) {
        return "k/DocType/preChooseDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertDocType")
    public String preInsertDocType(Map<String, Object> operator) {
        return "k/DocType/preInsertDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocType")
    public String preUpdateDocType(Map<String, Object> operator) {
        return "k/DocType/preUpdateDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocTypeHtml")
    public String preUpdateDocTypeHtml(Map<String, Object> operator) {
        return "k/DocType/preUpdateHtml";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDocType")
    public String viewDocType(Map<String, Object> operator) {
        return "k/DocType/viewDocType";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "loadDocType")
    @ResponseBody
    public Map<String, Object> loadDocType(String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> docType = docTypeService.loadDocType(DOC_TYPE_ID_);

        result.put("docType", docType);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "loadDocTypeTemplateFile")
    public void loadDocTypeTemplateFile(String DOC_TYPE_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> docType = docTypeService.loadDocType(DOC_TYPE_ID_);// 获取下载文件名
        String fileName = (String) docType.get("TEMPLATE_FILE_NAME_");
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = docTypeService.loadTemplateFile(DOC_TYPE_ID_);// 二进制流文件内容
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

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "loadDocTypeHtml")
    @ResponseBody
    public Map<String, Object> loadDocTypeHtml(String DOC_TYPE_ID_, Boolean editable, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        String html = docTypeService.loadHtml(DOC_TYPE_ID_, editable);

        result.put("html", html);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocType")
    @ResponseBody
    public Map<String, Object> selectDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, @RequestParam(value = "USING_TEMPLATE_LIST", required = false) List<String> USING_TEMPLATE_LIST, String PROC_DEF_CODE_, @RequestParam(value = "DOC_TYPE_STATUS_LIST", required = false) List<String> DOC_TYPE_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docTypeList = docTypeService.selectDocType(DOC_TYPE_ID_, DOC_TYPE_NAME_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, DOC_TYPE_STATUS_LIST, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docTypeService.countDocType(DOC_TYPE_ID_, DOC_TYPE_NAME_, USING_TEMPLATE_LIST, PROC_DEF_CODE_, DOC_TYPE_STATUS_LIST);
        }

        result.put("docTypeList", docTypeList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocTypeByIdList")
    @ResponseBody
    public Map<String, Object> selectDocTypeByIdList(@RequestParam(value = "DOC_TYPE_ID_LIST", required = false) List<String> DOC_TYPE_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docTypeList = docTypeService.selectDocTypeByIdList(DOC_TYPE_ID_LIST);

        result.put("docTypeList", docTypeList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DOC_TYPE_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertDocType")
    @ResponseBody
    public Map<String, Object> insertDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, MultipartFile TEMPLATE_FILE_, String HTML_, String BOOKMARK_, String INDEX_, String USING_TEMPLATE_, String PROC_DEF_CODE_, String DESC_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream TEMPLATE_FILE_InputStream;
            String TEMPLATE_FILE_NAME_;
            Integer TEMPLATE_FILE_LENGTH_;
            if (TEMPLATE_FILE_ != null) {
                TEMPLATE_FILE_InputStream = TEMPLATE_FILE_.getInputStream();// 获取上传二进制流
                TEMPLATE_FILE_NAME_ = OdUtils.getFileName(TEMPLATE_FILE_.getOriginalFilename());
                TEMPLATE_FILE_LENGTH_ = (int) TEMPLATE_FILE_.getSize();
                if ((TEMPLATE_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                TEMPLATE_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                TEMPLATE_FILE_NAME_ = null;
                TEMPLATE_FILE_LENGTH_ = 0;
            }
            if (docTypeService.insertDocType(DOC_TYPE_ID_, DOC_TYPE_NAME_, TEMPLATE_FILE_InputStream, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, HTML_, BOOKMARK_, INDEX_, USING_TEMPLATE_, PROC_DEF_CODE_, DESC_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            TEMPLATE_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("docType", docTypeService.loadDocType(DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "updateDocType")
    @ResponseBody
    public Map<String, Object> updateDocType(String DOC_TYPE_ID_, String DOC_TYPE_NAME_, MultipartFile TEMPLATE_FILE_, String INDEX_, String USING_TEMPLATE_, String PROC_DEF_CODE_, String DESC_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream TEMPLATE_FILE_InputStream;
            String TEMPLATE_FILE_NAME_;
            Integer TEMPLATE_FILE_LENGTH_;
            if (TEMPLATE_FILE_ != null) {
                TEMPLATE_FILE_InputStream = TEMPLATE_FILE_.getInputStream();// 获取上传二进制流
                TEMPLATE_FILE_NAME_ = OdUtils.getFileName(TEMPLATE_FILE_.getOriginalFilename());
                TEMPLATE_FILE_LENGTH_ = (int) TEMPLATE_FILE_.getSize();
                if ((TEMPLATE_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                TEMPLATE_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                TEMPLATE_FILE_NAME_ = null;
                TEMPLATE_FILE_LENGTH_ = 0;
            }
            if (docTypeService.updateDocType(DOC_TYPE_ID_, DOC_TYPE_NAME_, TEMPLATE_FILE_InputStream, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, INDEX_, USING_TEMPLATE_, PROC_DEF_CODE_, DESC_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            TEMPLATE_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("docType", docTypeService.loadDocType(DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "updateDocTypeHtml")
    @ResponseBody
    public Map<String, Object> updateDocTypeHtml(String DOC_TYPE_ID_, String HTML_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docTypeService.updateHtml(DOC_TYPE_ID_, HTML_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "updateDocTypeTemplateFile")
    @ResponseBody
    public Map<String, Object> updateDocTypeTemplateFile(String DOC_TYPE_ID_, MultipartFile TEMPLATE_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream TEMPLATE_FILE_InputStream;
            String TEMPLATE_FILE_NAME_;
            Integer TEMPLATE_FILE_LENGTH_;
            if (TEMPLATE_FILE_ != null) {
                TEMPLATE_FILE_InputStream = TEMPLATE_FILE_.getInputStream();// 获取上传二进制流
                TEMPLATE_FILE_NAME_ = OdUtils.getFileName(TEMPLATE_FILE_.getOriginalFilename());
                TEMPLATE_FILE_LENGTH_ = (int) TEMPLATE_FILE_.getSize();
                if ((TEMPLATE_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                TEMPLATE_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                TEMPLATE_FILE_NAME_ = null;
                TEMPLATE_FILE_LENGTH_ = 0;
            }
            if (docTypeService.updateTemplateFile(DOC_TYPE_ID_, TEMPLATE_FILE_InputStream, TEMPLATE_FILE_NAME_, TEMPLATE_FILE_LENGTH_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            TEMPLATE_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("docType", docTypeService.loadDocType(DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateDocTypeOrder")
    @ResponseBody
    public Map<String, Object> updateDocTypeOrder(@RequestParam(value = "DOC_TYPE_ID_LIST", required = true) List<String> DOC_TYPE_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docTypeService.updateDocTypeOrder(DOC_TYPE_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "disableDocType")
    @ResponseBody
    public Map<String, Object> disableDocType(String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docTypeService.disableDocType(DOC_TYPE_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("docType", docTypeService.loadDocType(DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "enableDocType")
    @ResponseBody
    public Map<String, Object> enableDocType(String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docTypeService.enableDocType(DOC_TYPE_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("docType", docTypeService.loadDocType(DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "deleteDocType")
    @ResponseBody
    public Map<String, Object> deleteDocType(String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docTypeService.deleteDocType(DOC_TYPE_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_TYPE_ID_")
    @RequestMapping(value = "deleteDocTypeTemplateFile")
    @ResponseBody
    public Map<String, Object> deleteDocTypeTemplateFile(String DOC_TYPE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docTypeService.deleteTemplateFile(DOC_TYPE_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("docType", docTypeService.loadDocType(DOC_TYPE_ID_));
        result.put("success", true);

        return result;
    }
}