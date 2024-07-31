package com.opendynamic.om.controller;

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
import com.opendynamic.om.service.OmLogService;

@Controller
public class OmLogController extends OdController {
    @Autowired
    private OmLogService omLogService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmLog")
    public String manageOmLog() {
        return "om/Log/manageLog";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmLog")
    public String viewOmLog() {
        return "om/Log/viewLog";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "LOG_ID_")
    @RequestMapping(value = "loadOmLog")
    @ResponseBody
    public Map<String, Object> loadOmLog(String LOG_ID_) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> log = omLogService.loadLog(LOG_ID_);

        result.put("log", log);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmLog")
    @ResponseBody
    public Map<String, Object> selectOmLog(String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, @RequestParam(value = "ERROR_LIST", required = false) List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> logList = omLogService.selectLog(LOG_ID_, CATEGORY_, IP_, ACTION_, BUSINESS_KEY_, ERROR_LIST, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, FROM_CREATION_DATE_, TO_CREATION_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = omLogService.countLog(LOG_ID_, CATEGORY_, IP_, ACTION_, BUSINESS_KEY_, ERROR_LIST, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, FROM_CREATION_DATE_, TO_CREATION_DATE_);
        }

        result.put("logList", logList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmLogByIdList")
    @ResponseBody
    public Map<String, Object> selectOmLogByIdList(@RequestParam(value = "LOG_ID_LIST", required = false) List<String> LOG_ID_LIST) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> logList = omLogService.selectLogByIdList(LOG_ID_LIST);

        result.put("logList", logList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "LOG_ID_")
    @RequestMapping(value = "deleteOmLog")
    @ResponseBody
    public Map<String, Object> deleteOmLog(String LOG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omLogService.deleteLog(LOG_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}