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
import com.opendynamic.om.service.OmMirrorServerService;

@Controller
public class OmMirrorServerController extends OdController {
    @Autowired
    private OmMirrorServerService omMirrorServerService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmMirrorServer")
    public String manageOmMirrorServer(Map<String, Object> operator) {
        return "om/MirrorServer/manageMirrorServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmMirrorServer")
    public String preInsertOmMirrorServer(Map<String, Object> operator) {
        return "om/MirrorServer/preInsertMirrorServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmMirrorServer")
    public String preUpdateOmMirrorServer(Map<String, Object> operator) {
        return "om/MirrorServer/preUpdateMirrorServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "viewOmMirrorServer")
    public String viewOmMirrorServer(Map<String, Object> operator) {
        return "om/MirrorServer/viewMirrorServer";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "loadOmMirrorServer")
    @ResponseBody
    public Map<String, Object> loadOmMirrorServer(String MIRROR_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> mirrorServer = omMirrorServerService.loadMirrorServer(MIRROR_SERVER_ID_);

        result.put("mirrorServer", mirrorServer);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmMirrorServer")
    @ResponseBody
    public Map<String, Object> selectOmMirrorServer(String MIRROR_SERVER_ID_, String MIRROR_SERVER_NAME_, @RequestParam(value = "MIRROR_SERVER_STATUS_LIST", required = false) List<String> MIRROR_SERVER_STATUS_LIST, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> mirrorServerList = omMirrorServerService.selectMirrorServer(MIRROR_SERVER_ID_, MIRROR_SERVER_NAME_, MIRROR_SERVER_STATUS_LIST, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = omMirrorServerService.countMirrorServer(MIRROR_SERVER_ID_, MIRROR_SERVER_NAME_, MIRROR_SERVER_STATUS_LIST);
        }

        result.put("mirrorServerList", mirrorServerList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmMirrorServerByIdList")
    @ResponseBody
    public Map<String, Object> selectOmMirrorServerByIdList(@RequestParam(value = "MIRROR_SERVER_ID_LIST", required = false) List<String> MIRROR_SERVER_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> mirrorServerList = omMirrorServerService.selectMirrorServerByIdList(MIRROR_SERVER_ID_LIST);

        result.put("mirrorServerList", mirrorServerList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmMirrorServer")
    @ResponseBody
    public Map<String, Object> insertOmMirrorServer(String MIRROR_SERVER_ID_, String MIRROR_SERVER_NAME_, String DRIVER_CLASS_NAME_, String URL_, String USERNAME_, String PASSWORD_, String MEMO_, Date LAST_SYNC_DATE_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMirrorServerService.insertMirrorServer(MIRROR_SERVER_ID_, MIRROR_SERVER_NAME_, DRIVER_CLASS_NAME_, URL_, USERNAME_, PASSWORD_, MEMO_, LAST_SYNC_DATE_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mirrorServer", omMirrorServerService.loadMirrorServer(MIRROR_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "updateOmMirrorServer")
    @ResponseBody
    public Map<String, Object> updateOmMirrorServer(String MIRROR_SERVER_ID_, String MIRROR_SERVER_NAME_, String DRIVER_CLASS_NAME_, String URL_, String USERNAME_, String PASSWORD_, String MEMO_, Date LAST_SYNC_DATE_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMirrorServerService.updateMirrorServer(MIRROR_SERVER_ID_, MIRROR_SERVER_NAME_, DRIVER_CLASS_NAME_, URL_, USERNAME_, PASSWORD_, MEMO_, LAST_SYNC_DATE_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mirrorServer", omMirrorServerService.loadMirrorServer(MIRROR_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "updateOmMirrorServerOrder")
    @ResponseBody
    public Map<String, Object> updateOmMirrorServerOrder(@RequestParam(value = "MIRROR_SERVER_ID_LIST", required = true) List<String> MIRROR_SERVER_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMirrorServerService.updateMirrorServerOrder(MIRROR_SERVER_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "disableOmMirrorServer")
    @ResponseBody
    public Map<String, Object> disableOmMirrorServer(String MIRROR_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMirrorServerService.disableMirrorServer(MIRROR_SERVER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mirrorServer", omMirrorServerService.loadMirrorServer(MIRROR_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "enableOmMirrorServer")
    @ResponseBody
    public Map<String, Object> enableOmMirrorServer(String MIRROR_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMirrorServerService.enableMirrorServer(MIRROR_SERVER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("mirrorServer", omMirrorServerService.loadMirrorServer(MIRROR_SERVER_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "MIRROR_SERVER_ID_")
    @RequestMapping(value = "deleteOmMirrorServer")
    @ResponseBody
    public Map<String, Object> deleteOmMirrorServer(String MIRROR_SERVER_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (omMirrorServerService.deleteMirrorServer(MIRROR_SERVER_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}