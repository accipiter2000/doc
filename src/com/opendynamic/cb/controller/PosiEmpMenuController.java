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
import com.opendynamic.cb.service.PosiEmpMenuService;

@Controller
public class PosiEmpMenuController extends OdController {
    @Autowired
    private PosiEmpMenuService posiEmpMenuService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "managePosiEmpMenu")
    public String managePosiEmpMenu(Map<String, Object> operator) {
        return "cb/PosiEmpMenu/managePosiEmpMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "POSI_EMP_MENU_ID_")
    @RequestMapping(value = "loadPosiEmpMenu")
    @ResponseBody
    public Map<String, Object> loadPosiEmpMenu(String POSI_EMP_MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> posiEmpMenu = posiEmpMenuService.loadPosiEmpMenu(POSI_EMP_MENU_ID_);

        result.put("posiEmpMenu", posiEmpMenu);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectPosiEmpMenu")
    @ResponseBody
    public Map<String, Object> selectPosiEmpMenu(String POSI_EMP_MENU_ID_, String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, @RequestParam(value = "MENU_TYPE_LIST", required = false) List<String> MENU_TYPE_LIST, @RequestParam(value = "MENU_STATUS_LIST", required = false) List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpMenuList = posiEmpMenuService.selectPosiEmpMenu(POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = posiEmpMenuService.countPosiEmpMenu(POSI_EMP_MENU_ID_, POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);
        }
        List<Map<String, Object>> posiEmpMenuListClone = (List<Map<String, Object>>) OdUtils.deepClone(posiEmpMenuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> posiEmpMenuIdList = OdUtils.collect(posiEmpMenuList, "MENU_ID_", String.class);
        Map<String, Object> posiEmpMenu;
        for (int i = 0; i < posiEmpMenuListClone.size(); i++) {
            posiEmpMenu = posiEmpMenuListClone.get(i);
            if (posiEmpMenu.get("PARENT_MENU_ID_") == null || posiEmpMenu.get("PARENT_MENU_ID_").equals("") || !posiEmpMenuIdList.contains(posiEmpMenu.get("PARENT_MENU_ID_"))) {
                children.add(posiEmpMenu);
                fillChildPosiEmpMenu(posiEmpMenu, posiEmpMenuListClone);
            }
        }

        result.put("posiEmpMenuList", posiEmpMenuList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildPosiEmpMenu(Map<String, Object> posiEmpMenu, List<Map<String, Object>> posiEmpMenuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childPosiEmpMenu;
        for (int i = 0; i < posiEmpMenuList.size(); i++) {
            childPosiEmpMenu = posiEmpMenuList.get(i);
            if (posiEmpMenu.get("MENU_ID_").equals(childPosiEmpMenu.get("PARENT_MENU_ID_"))) {
                children.add(childPosiEmpMenu);
                fillChildPosiEmpMenu(childPosiEmpMenu, posiEmpMenuList);
            }
        }
        posiEmpMenu.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectPosiEmpMenuByIdList")
    @ResponseBody
    public Map<String, Object> selectPosiEmpMenuByIdList(@RequestParam(value = "POSI_EMP_MENU_ID_LIST", required = false) List<String> POSI_EMP_MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> posiEmpMenuList = posiEmpMenuService.selectPosiEmpMenuByIdList(POSI_EMP_MENU_ID_LIST);

        result.put("posiEmpMenuList", posiEmpMenuList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "insertPosiEmpMenu")
    @ResponseBody
    public Map<String, Object> insertPosiEmpMenu(@RequestParam(value = "POSI_EMP_ID_LIST", required = true) List<String> POSI_EMP_ID_LIST, @RequestParam(value = "POSI_NAME_LIST", required = true) List<String> POSI_NAME_LIST, @RequestParam(value = "EMP_NAME_LIST", required = true) List<String> EMP_NAME_LIST, @RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (posiEmpMenuService.insertPosiEmpMenu(POSI_EMP_ID_LIST, POSI_NAME_LIST, EMP_NAME_LIST, MENU_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "POSI_EMP_ID_")
    @RequestMapping(value = "updatePosiEmpMenuByMenuIdList")
    @ResponseBody
    public Map<String, Object> updatePosiEmpMenuByMenuIdList(String POSI_EMP_ID_, String POSI_NAME_, String EMP_NAME_, @RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        posiEmpMenuService.updatePosiEmpMenuByMenuIdList(POSI_EMP_ID_, POSI_NAME_, EMP_NAME_, MENU_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("success", true);

        return result;
    }
}