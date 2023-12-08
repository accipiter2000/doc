package com.opendynamic.cb.controller;

import java.util.ArrayList;
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
import com.opendynamic.OdUtils;
import com.opendynamic.cb.service.DutyMenuService;

@Controller
public class DutyMenuController extends OdController {
    @Autowired
    private DutyMenuService dutyMenuService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageDutyMenu")
    public String manageDutyMenu(Map<String, Object> operator) {
        return "cb/DutyMenu/manageDutyMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DUTY_MENU_ID_")
    @RequestMapping(value = "loadDutyMenu")
    @ResponseBody
    public Map<String, Object> loadDutyMenu(String DUTY_MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> dutyMenu = dutyMenuService.loadDutyMenu(DUTY_MENU_ID_);

        result.put("dutyMenu", dutyMenu);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectDutyMenu")
    @ResponseBody
    public Map<String, Object> selectDutyMenu(String DUTY_MENU_ID_, String DUTY_ID_, String DUTY_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, @RequestParam(value = "MENU_TYPE_LIST", required = false) List<String> MENU_TYPE_LIST, @RequestParam(value = "MENU_STATUS_LIST", required = false) List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dutyMenuList = dutyMenuService.selectDutyMenu(DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = dutyMenuService.countDutyMenu(DUTY_MENU_ID_, DUTY_ID_, DUTY_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);
        }
        List<Map<String, Object>> dutyMenuListClone = (List<Map<String, Object>>) OdUtils.deepClone(dutyMenuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> dutyMenuIdList = OdUtils.collect(dutyMenuList, "MENU_ID_", String.class);
        Map<String, Object> dutyMenu;
        for (int i = 0; i < dutyMenuListClone.size(); i++) {
            dutyMenu = dutyMenuListClone.get(i);
            if (dutyMenu.get("PARENT_MENU_ID_") == null || dutyMenu.get("PARENT_MENU_ID_").equals("") || !dutyMenuIdList.contains(dutyMenu.get("PARENT_MENU_ID_"))) {
                children.add(dutyMenu);
                fillChildDutyMenu(dutyMenu, dutyMenuListClone);
            }
        }

        result.put("dutyMenuList", dutyMenuList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildDutyMenu(Map<String, Object> dutyMenu, List<Map<String, Object>> dutyMenuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childDutyMenu;
        for (int i = 0; i < dutyMenuList.size(); i++) {
            childDutyMenu = dutyMenuList.get(i);
            if (dutyMenu.get("MENU_ID_").equals(childDutyMenu.get("PARENT_MENU_ID_"))) {
                children.add(childDutyMenu);
                fillChildDutyMenu(childDutyMenu, dutyMenuList);
            }
        }
        dutyMenu.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectDutyMenuByIdList")
    @ResponseBody
    public Map<String, Object> selectDutyMenuByIdList(@RequestParam(value = "DUTY_MENU_ID_LIST", required = false) List<String> DUTY_MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> dutyMenuList = dutyMenuService.selectDutyMenuByIdList(DUTY_MENU_ID_LIST);

        result.put("dutyMenuList", dutyMenuList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "insertDutyMenu")
    @ResponseBody
    public Map<String, Object> insertDutyMenu(@RequestParam(value = "DUTY_ID_LIST", required = true) List<String> DUTY_ID_LIST, @RequestParam(value = "DUTY_NAME_LIST", required = true) List<String> DUTY_NAME_LIST, @RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (dutyMenuService.insertDutyMenu(DUTY_ID_LIST, DUTY_NAME_LIST, MENU_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "DUTY_ID_")
    @RequestMapping(value = "updateDutyMenuByMenuIdList")
    @ResponseBody
    public Map<String, Object> updateDutyMenuByMenuIdList(String DUTY_ID_, String DUTY_NAME_, @RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        dutyMenuService.updateDutyMenuByMenuIdList(DUTY_ID_, DUTY_NAME_, MENU_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("success", true);

        return result;
    }
}