package com.opendynamic.cb.controller;

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
import com.opendynamic.cb.service.LogService;

@Controller
public class LogController extends OdController {
    @Autowired
    private LogService logService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageLog")
    public String manageLog() {
        return "cb/Log/manageLog";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewLog")
    public String viewLog() {
        return "cb/Log/viewLog";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "LOG_ID_")
    @RequestMapping(value = "loadLog")
    @ResponseBody
    public Map<String, Object> loadLog(String LOG_ID_) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> log = logService.loadLog(LOG_ID_);

        result.put("log", log);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectLog")
    @ResponseBody
    public Map<String, Object> selectLog(String LOG_ID_, String CATEGORY_, String IP_, String ACTION_, String BUSINESS_KEY_, @RequestParam(value = "ERROR_LIST", required = false) List<String> ERROR_LIST, String ORG_ID_, String ORG_NAME_, String POSI_ID_, String POSI_NAME_, String EMP_ID_, String EMP_NAME_, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> logList = logService.selectLog(LOG_ID_, CATEGORY_, IP_, ACTION_, BUSINESS_KEY_, ERROR_LIST, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, FROM_CREATION_DATE_, TO_CREATION_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = logService.countLog(LOG_ID_, CATEGORY_, IP_, ACTION_, BUSINESS_KEY_, ERROR_LIST, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, FROM_CREATION_DATE_, TO_CREATION_DATE_);
        }

        result.put("logList", logList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectLogByIdList")
    @ResponseBody
    public Map<String, Object> selectLogByIdList(@RequestParam(value = "LOG_ID_LIST", required = false) List<String> LOG_ID_LIST) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> logList = logService.selectLogByIdList(LOG_ID_LIST);

        result.put("logList", logList);
        result.put("success", true);

        return result;
    }
}