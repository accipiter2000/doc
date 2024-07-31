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
import com.opendynamic.cb.service.WorkingCalendarService;

@Controller
public class WorkingCalendarController extends OdController {
    @Autowired
    private WorkingCalendarService workingCalendarService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageCommonWorkingCalendar")
    public String manageCommonWorkingCalendar(Map<String, Object> operator) {
        return "cb/WorkingCalendar/manageCommonWorkingCalendar";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageMyWorkingCalendar")
    public String manageMyWorkingCalendar(Map<String, Object> operator) {
        return "cb/WorkingCalendar/manageMyWorkingCalendar";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertCommonWorkingCalendar")
    public String preInsertCommonWorkingCalendar(Map<String, Object> operator) {
        return "cb/WorkingCalendar/preInsertCommonWorkingCalendar";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertMyWorkingCalendar")
    public String preInsertMyWorkingCalendar(Map<String, Object> operator) {
        return "cb/WorkingCalendar/preInsertMyWorkingCalendar";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateWorkingCalendar")
    public String preUpdateWorkingCalendar(Map<String, Object> operator) {
        return "cb/WorkingCalendar/preUpdateWorkingCalendar";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewMyWorkingCalendar")
    public String viewMyWorkingCalendar(Map<String, Object> operator) {
        return "cb/WorkingCalendar/viewMyWorkingCalendar";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "WORKING_CALENDAR_ID_")
    @RequestMapping(value = "loadWorkingCalendar")
    @ResponseBody
    public Map<String, Object> loadWorkingCalendar(String WORKING_CALENDAR_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> workingCalendar = workingCalendarService.loadWorkingCalendar(WORKING_CALENDAR_ID_);

        result.put("workingCalendar", workingCalendar);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCommonWorkingCalendar")
    @ResponseBody
    public Map<String, Object> selectCommonWorkingCalendar(Date FROM_DATE_, Date TO_DATE_, @RequestParam(value = "WORKING_DAY_LIST", required = false) List<String> WORKING_DAY_LIST, Boolean hasMark, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> workingCalendarList = workingCalendarService.selectCommonWorkingCalendar(FROM_DATE_, TO_DATE_, WORKING_DAY_LIST, hasMark);

        result.put("workingCalendarList", workingCalendarList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectMyWorkingCalendar")
    @ResponseBody
    public Map<String, Object> selectMyWorkingCalendar(Date FROM_DATE_, Date TO_DATE_, @RequestParam(value = "WORKING_DAY_LIST", required = false) List<String> WORKING_DAY_LIST, Boolean hasMark, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> workingCalendarList = workingCalendarService.selectMyWorkingCalendar((String) operator.get("EMP_ID_"), FROM_DATE_, TO_DATE_, WORKING_DAY_LIST, hasMark);

        result.put("workingCalendarList", workingCalendarList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectWorkingCalendarByIdList")
    @ResponseBody
    public Map<String, Object> selectWorkingCalendarByIdList(@RequestParam(value = "WORKING_CALENDAR_ID_LIST", required = false) List<String> WORKING_CALENDAR_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> workingCalendarList = workingCalendarService.selectWorkingCalendarByIdList(WORKING_CALENDAR_ID_LIST);

        result.put("workingCalendarList", workingCalendarList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateCommonWorkingCalendar")
    @ResponseBody
    public Map<String, Object> updateCommonWorkingCalendar(Date DATE_, String WORKING_DAY_, String MARK_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        String WORKING_CALENDAR_ID_ = workingCalendarService.updateCommonWorkingCalendar(DATE_, WORKING_DAY_, MARK_);

        result.put("workingCalendar", workingCalendarService.loadWorkingCalendar(WORKING_CALENDAR_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateMyWorkingCalendar")
    @ResponseBody
    public Map<String, Object> updateMyWorkingCalendar(Date DATE_, String WORKING_DAY_, String MARK_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        String WORKING_CALENDAR_ID_ = workingCalendarService.updateMyWorkingCalendar((String) operator.get("EMP_ID_"), DATE_, WORKING_DAY_, MARK_);
        Map<String, Object> workingCalendar = null;
        if (WORKING_CALENDAR_ID_ != null) {
            workingCalendar = workingCalendarService.loadWorkingCalendar(WORKING_CALENDAR_ID_);
        }
        else {
            workingCalendar = workingCalendarService.selectCommonWorkingCalendar(DATE_, DATE_, null, null).get(0);
        }

        result.put("workingCalendar", workingCalendar);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "WORKING_CALENDAR_ID_")
    @RequestMapping(value = "deleteWorkingCalendar")
    @ResponseBody
    public Map<String, Object> deleteWorkingCalendar(String WORKING_CALENDAR_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (workingCalendarService.deleteWorkingCalendar(WORKING_CALENDAR_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "initWorkingCalendar")
    @ResponseBody
    public Map<String, Object> initWorkingCalendar(Integer YEAR_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (workingCalendarService.initWorkingCalendar(YEAR_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getNextWorkingDay")
    @ResponseBody
    public Map<String, Object> getNextWorkingDay(String EMP_ID_, Date FROM_DATE_, int days, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Date nextWorkingDay = workingCalendarService.getNextWorkingDay(EMP_ID_, FROM_DATE_, days);

        result.put("nextWorkingDay", nextWorkingDay);
        result.put("success", true);

        return result;
    }
}