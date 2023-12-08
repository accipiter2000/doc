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
import com.opendynamic.cb.service.DashboardService;

@Controller
public class DashboardController extends OdController {
    @Autowired
    private DashboardService dashboardService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageCommonDashboard")
    public String manageCommonDashboard(Map<String, Object> operator) {
        return "cb/Dashboard/manageCommonDashboard";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageMyDashboard")
    public String manageMyDashboard(Map<String, Object> operator) {
        return "cb/Dashboard/manageMyDashboard";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertDashboard")
    public String preInsertDashboard(Map<String, Object> operator) {
        return "cb/Dashboard/preInsertDashboard";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateDashboard")
    public String preUpdateDashboard(Map<String, Object> operator) {
        return "cb/Dashboard/preUpdateDashboard";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewMyDashboard")
    public String viewMyDashboard(Map<String, Object> operator) {
        return "cb/Dashboard/viewMyDashboard";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_ID_")
    @RequestMapping(value = "loadDashboard")
    @ResponseBody
    public Map<String, Object> loadDashboard(String DASHBOARD_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> dashboard = dashboardService.loadDashboard(DASHBOARD_ID_);

        result.put("dashboard", dashboard);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCommonDashboard")
    @ResponseBody
    public Map<String, Object> selectCommonDashboard(Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dashboardList = dashboardService.selectCommonDashboard(page, limit);

        result.put("dashboardList", dashboardList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectMyDashboard")
    @ResponseBody
    public Map<String, Object> selectMyDashboard(Boolean alternative, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dashboardList = dashboardService.selectMyDashboard((String) operator.get("POSI_EMP_ID_"), alternative, page, limit);

        result.put("dashboardList", dashboardList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectDashboardByIdList")
    @ResponseBody
    public Map<String, Object> selectDashboardByIdList(@RequestParam(value = "DASHBOARD_ID_LIST", required = false) List<String> DASHBOARD_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dashboardList = dashboardService.selectDashboardByIdList(DASHBOARD_ID_LIST);

        result.put("dashboardList", dashboardList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertCommonDashboardByDashboardModule")
    @ResponseBody
    public Map<String, Object> insertCommonDashboardByDashboardModule(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardService.insertDashboardByDashboardModule(DASHBOARD_ID_, DASHBOARD_MODULE_ID_, null) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboard", dashboardService.loadDashboard(DASHBOARD_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertMyDashboardByDashboardModule")
    @ResponseBody
    public Map<String, Object> insertMyDashboardByDashboardModule(String DASHBOARD_ID_, String DASHBOARD_MODULE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardService.insertDashboardByDashboardModule(DASHBOARD_ID_, DASHBOARD_MODULE_ID_, (String) operator.get("POSI_EMP_ID_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboard", dashboardService.loadDashboard(DASHBOARD_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_ID_")
    @RequestMapping(value = "updateDashboard")
    @ResponseBody
    public Map<String, Object> updateDashboard(String DASHBOARD_ID_, String DASHBOARD_MODULE_NAME_, String URL_, String WIDTH_, String HEIGHT_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardService.updateDashboard(DASHBOARD_ID_, DASHBOARD_MODULE_NAME_, URL_, WIDTH_, HEIGHT_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("dashboard", dashboardService.loadDashboard(DASHBOARD_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateDashboardOrder")
    @ResponseBody
    public Map<String, Object> updateDashboardOrder(@RequestParam(value = "DASHBOARD_ID_LIST", required = true) List<String> DASHBOARD_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardService.updateDashboardOrder(DASHBOARD_ID_LIST) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DASHBOARD_ID_")
    @RequestMapping(value = "deleteDashboard")
    @ResponseBody
    public Map<String, Object> deleteDashboard(String DASHBOARD_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dashboardService.deleteDashboard(DASHBOARD_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}