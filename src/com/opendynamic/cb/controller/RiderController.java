package com.opendynamic.cb.controller;

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
import com.opendynamic.cb.service.RiderService;

@Controller
public class RiderController extends OdController {
    @Autowired
    private RiderService riderService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageRider")
    public String manageRider(Map<String, Object> operator) {
        return "cb/Rider/manageRider";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_")
    @RequestMapping(value = "loadRider")
    @ResponseBody
    public Map<String, Object> loadRider(String RIDER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> rider = riderService.loadRider(RIDER_ID_);

        result.put("rider", rider);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_")
    @RequestMapping(value = "loadRiderFile")
    public void loadRiderFile(String RIDER_ID_, Map<String, Object> operator, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> rider = riderService.loadRider(RIDER_ID_);// 获取下载文件名
        String fileName = (String) rider.get("RIDER_FILE_NAME_");
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = riderService.loadRiderFile(RIDER_ID_);// 二进制流文件内容
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

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectRider")
    @ResponseBody
    public Map<String, Object> selectRider(String RIDER_ID_, String OBJ_ID_, String RIDER_FILE_NAME_, String RIDER_TAG_, @RequestParam(value = "RIDER_STATUS_LIST", required = false) List<String> RIDER_STATUS_LIST, Boolean tagUnion, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> riderList = riderService.selectRider(RIDER_ID_, OBJ_ID_, RIDER_FILE_NAME_, RIDER_TAG_, RIDER_STATUS_LIST, tagUnion, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = riderService.countRider(RIDER_ID_, OBJ_ID_, RIDER_FILE_NAME_, RIDER_TAG_, RIDER_STATUS_LIST, tagUnion);
        }

        result.put("riderList", riderList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectRiderByIdList")
    @ResponseBody
    public Map<String, Object> selectRiderByIdList(@RequestParam(value = "RIDER_ID_LIST", required = false) List<String> RIDER_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> riderList = riderService.selectRiderByIdList(RIDER_ID_LIST);

        result.put("riderList", riderList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertRider")
    @ResponseBody
    public Map<String, Object> insertRider(String RIDER_ID_, String OBJ_ID_, MultipartFile RIDER_FILE_, String MEMO_, String RIDER_TAG_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream RIDER_FILE_InputStream;
            String RIDER_FILE_NAME_;
            Integer RIDER_FILE_LENGTH_;
            if (RIDER_FILE_ != null) {
                RIDER_FILE_InputStream = RIDER_FILE_.getInputStream();// 获取上传二进制流
                RIDER_FILE_NAME_ = OdUtils.getFileName(RIDER_FILE_.getOriginalFilename());
                RIDER_FILE_LENGTH_ = (int) RIDER_FILE_.getSize();
                if ((RIDER_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                RIDER_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                RIDER_FILE_NAME_ = null;
                RIDER_FILE_LENGTH_ = 0;
            }
            if (riderService.insertRider(RIDER_ID_, OBJ_ID_, RIDER_FILE_InputStream, RIDER_FILE_NAME_, RIDER_FILE_LENGTH_, MEMO_, RIDER_TAG_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            RIDER_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("rider", riderService.loadRider(RIDER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_")
    @RequestMapping(value = "updateRider")
    @ResponseBody
    public Map<String, Object> updateRider(String RIDER_ID_, MultipartFile RIDER_FILE_, String MEMO_, String RIDER_TAG_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        try {
            InputStream RIDER_FILE_InputStream;
            String RIDER_FILE_NAME_;
            Integer RIDER_FILE_LENGTH_;
            if (RIDER_FILE_ != null) {
                RIDER_FILE_InputStream = RIDER_FILE_.getInputStream();// 获取上传二进制流
                RIDER_FILE_NAME_ = OdUtils.getFileName(RIDER_FILE_.getOriginalFilename());
                RIDER_FILE_LENGTH_ = (int) RIDER_FILE_.getSize();
                if ((RIDER_FILE_LENGTH_) >= OdConfig.getMaxUploadSize()) {// 上传文件大小限制检查
                    throw new RuntimeException("errors.uploadingFilesIsTooBig");
                }
            }
            else {
                RIDER_FILE_InputStream = new ByteArrayInputStream(new byte[0]);
                RIDER_FILE_NAME_ = null;
                RIDER_FILE_LENGTH_ = 0;
            }
            if (riderService.updateRider(RIDER_ID_, RIDER_FILE_InputStream, RIDER_FILE_NAME_, RIDER_FILE_LENGTH_, MEMO_, RIDER_TAG_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
                throw new RuntimeException("errors.noDataChange");
            }
            RIDER_FILE_InputStream.close();
        }
        catch (IOException e) {
            throw new RuntimeException(e);
        }

        result.put("rider", riderService.loadRider(RIDER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateRiderOrder")
    @ResponseBody
    public Map<String, Object> updateRiderOrder(@RequestParam(value = "RIDER_ID_LIST", required = true) List<String> RIDER_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (riderService.updateRiderOrder(RIDER_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_")
    @RequestMapping(value = "disableRider")
    @ResponseBody
    public Map<String, Object> disableRider(String RIDER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (riderService.disableRider(RIDER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("rider", riderService.loadRider(RIDER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_")
    @RequestMapping(value = "enableRider")
    @ResponseBody
    public Map<String, Object> enableRider(String RIDER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (riderService.enableRider(RIDER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("rider", riderService.loadRider(RIDER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "RIDER_ID_")
    @RequestMapping(value = "deleteRider")
    @ResponseBody
    public Map<String, Object> deleteRider(String RIDER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (riderService.deleteRider(RIDER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}