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
import com.opendynamic.om.service.OmMainServerService;

@Controller
public class OmMainServerController extends OdController {
    @Autowired
    private OmMainServerService omMainServerService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmMainServer")
    public String manageOmMainServer(Map<String, Object> operator) {
        return "om/MainServer/manageMainServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmMainServer")
    public String preInsertOmMainServer(Map<String, Object> operator) {
        return "om/MainServer/preInsertMainServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmMainServer")
    public String preUpdateOmMainServer(Map<String, Object> operator) {
        return "om/MainServer/preUpdateMainServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmMainServer")
    public String viewOmMainServer(Map<String, Object> operator) {
        return "om/MainServer/viewMainServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MAIN_SERVER_ID_")
    @RequestMapping(value = "loadOmMainServer")
    @ResponseBody
    public Map<String, Object> loadOmMainServer(String MAIN_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> mainServer = omMainServerService.loadMainServer(MAIN_SERVER_ID_);

        result.put("mainServer", mainServer);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmMainServer")
    @ResponseBody
    public Map<String, Object> selectOmMainServer(String MAIN_SERVER_ID_, String MAIN_SERVER_NAME_, @RequestParam(value = "MAIN_SERVER_STATUS_LIST", required = false) List<String> MAIN_SERVER_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> mainServerList = omMainServerService.selectMainServer(MAIN_SERVER_ID_, MAIN_SERVER_NAME_, MAIN_SERVER_STATUS_LIST, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = omMainServerService.countMainServer(MAIN_SERVER_ID_, MAIN_SERVER_NAME_, MAIN_SERVER_STATUS_LIST);
        }

        result.put("mainServerList", mainServerList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmMainServerByIdList")
    @ResponseBody
    public Map<String, Object> selectOmMainServerByIdList(@RequestParam(value = "MAIN_SERVER_ID_LIST", required = false) List<String> MAIN_SERVER_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> mainServerList = omMainServerService.selectMainServerByIdList(MAIN_SERVER_ID_LIST);

        result.put("mainServerList", mainServerList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MAIN_SERVER_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmMainServer")
    @ResponseBody
    public Map<String, Object> insertOmMainServer(String MAIN_SERVER_ID_, String MAIN_SERVER_NAME_, String DRIVER_CLASS_NAME_, String URL_, String USERNAME_, String PASSWORD_, String MEMO_, Date LAST_SYNC_DATE_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMainServerService.insertMainServer(MAIN_SERVER_ID_, MAIN_SERVER_NAME_, DRIVER_CLASS_NAME_, URL_, USERNAME_, PASSWORD_, MEMO_, LAST_SYNC_DATE_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mainServer", omMainServerService.loadMainServer(MAIN_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MAIN_SERVER_ID_")
    @RequestMapping(value = "updateOmMainServer")
    @ResponseBody
    public Map<String, Object> updateOmMainServer(String MAIN_SERVER_ID_, String MAIN_SERVER_NAME_, String DRIVER_CLASS_NAME_, String URL_, String USERNAME_, String PASSWORD_, String MEMO_, Date LAST_SYNC_DATE_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMainServerService.updateMainServer(MAIN_SERVER_ID_, MAIN_SERVER_NAME_, DRIVER_CLASS_NAME_, URL_, USERNAME_, PASSWORD_, MEMO_, LAST_SYNC_DATE_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mainServer", omMainServerService.loadMainServer(MAIN_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmMainServerOrder")
    @ResponseBody
    public Map<String, Object> updateOmMainServerOrder(@RequestParam(value = "MAIN_SERVER_ID_LIST", required = true) List<String> MAIN_SERVER_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMainServerService.updateMainServerOrder(MAIN_SERVER_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MAIN_SERVER_ID_")
    @RequestMapping(value = "disableOmMainServer")
    @ResponseBody
    public Map<String, Object> disableOmMainServer(String MAIN_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMainServerService.disableMainServer(MAIN_SERVER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mainServer", omMainServerService.loadMainServer(MAIN_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MAIN_SERVER_ID_")
    @RequestMapping(value = "enableOmMainServer")
    @ResponseBody
    public Map<String, Object> enableOmMainServer(String MAIN_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMainServerService.enableMainServer(MAIN_SERVER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mainServer", omMainServerService.loadMainServer(MAIN_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MAIN_SERVER_ID_")
    @RequestMapping(value = "deleteOmMainServer")
    @ResponseBody
    public Map<String, Object> deleteOmMainServer(String MAIN_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMainServerService.deleteMainServer(MAIN_SERVER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}