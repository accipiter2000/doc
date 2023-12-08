package com.opendynamic.cb.controller;

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
import com.opendynamic.cb.service.DashboardModuleService;

@Controller
public class DashboardModuleController extends OdController {
    @Autowired
    private DashboardModuleService dashboardModuleService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageDashboardModule")
    public String manageDashboardModule(Map<String, Object> operator) {
        return "cb/DashboardModule/manageDashboardModule";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertDashboardModule")
    public String preInsertDashboardModule(Map<String, Object> operator) {
        return "cb/DashboardModule/preInsertDashboardModule";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateDashboardModule")
    public String preUpdateDashboardModule(Map<String, Object> operator) {
        return "cb/DashboardModule/preUpdateDashboardModule";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewDashboardModule")
    public String viewDashboardModule(Map<String, Object> operator) {
        return "cb/DashboardModule/viewDashboardModule";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_MODULE_ID_")
    @RequestMapping(value = "loadDashboardModule")
    @ResponseBody
    public Map<String, Object> loadDashboardModule(String DASHBOARD_MODULE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> dashboardModule = dashboardModuleService.loadDashboardModule(DASHBOARD_MODULE_ID_);

        result.put("dashboardModule", dashboardModule);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectDashboardModule")
    @ResponseBody
    public Map<String, Object> selectDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, @RequestParam(value = "DASHBOARD_MODULE_TYPE_LIST", required = false) List<String> DASHBOARD_MODULE_TYPE_LIST, String DASHBOARD_MODULE_TAG_, @RequestParam(value = "DASHBOARD_MODULE_STATUS_LIST", required = false) List<String> DASHBOARD_MODULE_STATUS_LIST, Boolean tagUnion, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dashboardModuleList = dashboardModuleService.selectDashboardModule(DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_LIST, DASHBOARD_MODULE_TAG_, DASHBOARD_MODULE_STATUS_LIST, tagUnion, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = dashboardModuleService.countDashboardModule(DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_LIST, DASHBOARD_MODULE_TAG_, DASHBOARD_MODULE_STATUS_LIST, tagUnion);
        }

        result.put("dashboardModuleList", dashboardModuleList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectDashboardModuleByIdList")
    @ResponseBody
    public Map<String, Object> selectDashboardModuleByIdList(@RequestParam(value = "DASHBOARD_MODULE_ID_LIST", required = false) List<String> DASHBOARD_MODULE_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dashboardModuleList = dashboardModuleService.selectDashboardModuleByIdList(DASHBOARD_MODULE_ID_LIST);

        result.put("dashboardModuleList", dashboardModuleList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_MODULE_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertDashboardModule")
    @ResponseBody
    public Map<String, Object> insertDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, String DASHBOARD_MODULE_TYPE_, String DEFAULT_URL_, String DEFAULT_WIDTH_, String DEFAULT_HEIGHT_, String DASHBOARD_MODULE_TAG_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardModuleService.insertDashboardModule(DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_, DEFAULT_URL_, DEFAULT_WIDTH_, DEFAULT_HEIGHT_, DASHBOARD_MODULE_TAG_, ORDER_, "1") == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboardModule", dashboardModuleService.loadDashboardModule(DASHBOARD_MODULE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_MODULE_ID_")
    @RequestMapping(value = "updateDashboardModule")
    @ResponseBody
    public Map<String, Object> updateDashboardModule(String DASHBOARD_MODULE_ID_, String DASHBOARD_MODULE_NAME_, String DASHBOARD_MODULE_TYPE_, String DEFAULT_URL_, String DEFAULT_WIDTH_, String DEFAULT_HEIGHT_, String DASHBOARD_MODULE_TAG_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardModuleService.updateDashboardModule(DASHBOARD_MODULE_ID_, DASHBOARD_MODULE_NAME_, DASHBOARD_MODULE_TYPE_, DEFAULT_URL_, DEFAULT_WIDTH_, DEFAULT_HEIGHT_, DASHBOARD_MODULE_TAG_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboardModule", dashboardModuleService.loadDashboardModule(DASHBOARD_MODULE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateDashboardModuleOrder")
    @ResponseBody
    public Map<String, Object> updateDashboardModuleOrder(@RequestParam(value = "DASHBOARD_MODULE_ID_LIST", required = true) List<String> DASHBOARD_MODULE_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardModuleService.updateDashboardModuleOrder(DASHBOARD_MODULE_ID_LIST, ORDER_LIST) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_MODULE_ID_")
    @RequestMapping(value = "disableDashboardModule")
    @ResponseBody
    public Map<String, Object> disableDashboardModule(String DASHBOARD_MODULE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardModuleService.disableDashboardModule(DASHBOARD_MODULE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboardModule", dashboardModuleService.loadDashboardModule(DASHBOARD_MODULE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_MODULE_ID_")
    @RequestMapping(value = "enableDashboardModule")
    @ResponseBody
    public Map<String, Object> enableDashboardModule(String DASHBOARD_MODULE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardModuleService.enableDashboardModule(DASHBOARD_MODULE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboardModule", dashboardModuleService.loadDashboardModule(DASHBOARD_MODULE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_MODULE_ID_")
    @RequestMapping(value = "deleteDashboardModule")
    @ResponseBody
    public Map<String, Object> deleteDashboardModule(String DASHBOARD_MODULE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardModuleService.deleteDashboardModule(DASHBOARD_MODULE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}