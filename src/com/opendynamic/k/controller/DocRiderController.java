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
import com.opendynamic.k.service.DocRiderService;

@Controller
public class DocRiderController extends OdController {
    @Autowired
    private DocRiderService docRiderService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageDocRider")
    public String manageDocRider(Map<String, Object> operator) {
        return "k/DocRider/manageDocRider";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertDocRider")
    public String preInsertDocRider(Map<String, Object> operator) {
        return "k/DocRider/preInsertDocRider";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocRider")
    public String preUpdateDocRider(Map<String, Object> operator) {
        return "k/DocRider/preUpdateDocRider";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDocRider")
    public String viewDocRider(Map<String, Object> operator) {
        return "k/DocRider/viewDocRider";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_RIDER_ID_")
    @RequestMapping(value = "loadDocRider")
    @ResponseBody
    public Map<String, Object> loadDocRider(String DOC_RIDER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> docRider = docRiderService.loadDocRider(DOC_RIDER_ID_);

        result.put("docRider", docRider);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_RIDER_ID_")
    @RequestMapping(value = "loadDocRiderFile")
    public void loadDocRiderFile(String DOC_RIDER_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> docRider = docRiderService.loadDocRider(DOC_RIDER_ID_);// 获取下载文件名
        String fileName = (String) docRider.get("DOC_RIDER_FILE_NAME_");
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = docRiderService.loadDocRiderFile(DOC_RIDER_ID_);// 二进制流文件内容
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

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocRider")
    @ResponseBody
    public Map<String, Object> selectDocRider(String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docRiderList = docRiderService.selectDocRider(DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_NAME_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docRiderService.countDocRider(DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_NAME_);
        }

        result.put("docRiderList", docRiderList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "countDocRider")
    @ResponseBody
    public Map<String, Object> countDocRider(String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        int count = docRiderService.countDocRider(DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_NAME_);

        result.put("count", count);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocRiderByIdList")
    @ResponseBody
    public Map<String, Object> selectDocRiderByIdList(@RequestParam(value = "DOC_RIDER_ID_LIST", required = false) List<String> DOC_RIDER_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docRiderList = docRiderService.selectDocRiderByIdList(DOC_RIDER_ID_LIST);

        result.put("docRiderList", docRiderList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DOC_RIDER_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertDocRider")
    @ResponseBody
    public Map<String, Object> insertDocRider(String DOC_RIDER_ID_, String DOC_ID_, MultipartFile DOC_RIDER_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream DOC_RIDER_FILE_InputStream;
            String DOC_RIDER_FILE_NAME_;
            Integer DOC_RIDER_FILE_LENGTH_;
            if (DOC_RIDER_FILE_ != null) {
                DOC_RIDER_FILE_InputStream = DOC_RIDER_FILE_.getInputStream();// 获取上传二进制流
                DOC_RIDER_FILE_NAME_ = OdUtils.getFileName(DOC_RIDER_FILE_.getOriginalFilename());
                DOC_RIDER_FILE_LENGTH_ = (int) DOC_RIDER_FILE_.getSize();
                if ((DOC_RIDER_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                DOC_RIDER_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                DOC_RIDER_FILE_NAME_ = null;
                DOC_RIDER_FILE_LENGTH_ = 0;
            }
            if (docRiderService.insertDocRider(DOC_RIDER_ID_, DOC_ID_, DOC_RIDER_FILE_InputStream, DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            DOC_RIDER_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("docRider", docRiderService.loadDocRider(DOC_RIDER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_RIDER_ID_")
    @RequestMapping(value = "updateDocRider")
    @ResponseBody
    public Map<String, Object> updateDocRider(String DOC_RIDER_ID_, MultipartFile DOC_RIDER_FILE_, Map<String, Object> operator, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream DOC_RIDER_FILE_InputStream;
            String DOC_RIDER_FILE_NAME_;
            Integer DOC_RIDER_FILE_LENGTH_;
            if (DOC_RIDER_FILE_ != null) {
                DOC_RIDER_FILE_InputStream = DOC_RIDER_FILE_.getInputStream();// 获取上传二进制流
                DOC_RIDER_FILE_NAME_ = OdUtils.getFileName(DOC_RIDER_FILE_.getOriginalFilename());
                DOC_RIDER_FILE_LENGTH_ = (int) DOC_RIDER_FILE_.getSize();
                if ((DOC_RIDER_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                DOC_RIDER_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                DOC_RIDER_FILE_NAME_ = null;
                DOC_RIDER_FILE_LENGTH_ = 0;
            }
            if (docRiderService.updateDocRider(DOC_RIDER_ID_, DOC_RIDER_FILE_InputStream, DOC_RIDER_FILE_NAME_, DOC_RIDER_FILE_LENGTH_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            DOC_RIDER_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("docRider", docRiderService.loadDocRider(DOC_RIDER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_RIDER_ID_")
    @RequestMapping(value = "deleteDocRider")
    @ResponseBody
    public Map<String, Object> deleteDocRider(String DOC_RIDER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docRiderService.deleteDocRider(DOC_RIDER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}