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
import com.opendynamic.cb.service.PosiMenuService;

@Controller
public class PosiMenuController extends OdController {
    @Autowired
    private PosiMenuService posiMenuService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "managePosiMenu")
    public String managePosiMenu(Map<String, Object> operator) {
        return "cb/PosiMenu/managePosiMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "POSI_MENU_ID_")
    @RequestMapping(value = "loadPosiMenu")
    @ResponseBody
    public Map<String, Object> loadPosiMenu(String POSI_MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> posiMenu = posiMenuService.loadPosiMenu(POSI_MENU_ID_);

        result.put("posiMenu", posiMenu);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectPosiMenu")
    @ResponseBody
    public Map<String, Object> selectPosiMenu(String POSI_MENU_ID_, String POSI_ID_, String POSI_NAME_, String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, @RequestParam(value = "MENU_TYPE_LIST", required = false) List<String> MENU_TYPE_LIST, @RequestParam(value = "MENU_STATUS_LIST", required = false) List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> posiMenuList = posiMenuService.selectPosiMenu(POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = posiMenuService.countPosiMenu(POSI_MENU_ID_, POSI_ID_, POSI_NAME_, MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);
        }
        List<Map<String, Object>> posiMenuListClone = (List<Map<String, Object>>) OdUtils.deepClone(posiMenuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> posiMenuIdList = OdUtils.collect(posiMenuList, "MENU_ID_", String.class);
        Map<String, Object> posiMenu;
        for (int i = 0; i < posiMenuListClone.size(); i++) {
            posiMenu = posiMenuListClone.get(i);
            if (posiMenu.get("PARENT_MENU_ID_") == null || posiMenu.get("PARENT_MENU_ID_").equals("") || !posiMenuIdList.contains(posiMenu.get("PARENT_MENU_ID_"))) {
                children.add(posiMenu);
                fillChildPosiMenu(posiMenu, posiMenuListClone);
            }
        }

        result.put("posiMenuList", posiMenuList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildPosiMenu(Map<String, Object> posiMenu, List<Map<String, Object>> posiMenuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childPosiMenu;
        for (int i = 0; i < posiMenuList.size(); i++) {
            childPosiMenu = posiMenuList.get(i);
            if (posiMenu.get("MENU_ID_").equals(childPosiMenu.get("PARENT_MENU_ID_"))) {
                children.add(childPosiMenu);
                fillChildPosiMenu(childPosiMenu, posiMenuList);
            }
        }
        posiMenu.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectPosiMenuByIdList")
    @ResponseBody
    public Map<String, Object> selectPosiMenuByIdList(@RequestParam(value = "POSI_MENU_ID_LIST", required = false) List<String> POSI_MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> posiMenuList = posiMenuService.selectPosiMenuByIdList(POSI_MENU_ID_LIST);

        result.put("posiMenuList", posiMenuList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "insertPosiMenu")
    @ResponseBody
    public Map<String, Object> insertPosiMenu(@RequestParam(value = "POSI_ID_LIST", required = true) List<String> POSI_ID_LIST, @RequestParam(value = "POSI_NAME_LIST", required = true) List<String> POSI_NAME_LIST, @RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (posiMenuService.insertPosiMenu(POSI_ID_LIST, POSI_NAME_LIST, MENU_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "POSI_ID_")
    @RequestMapping(value = "updatePosiMenuByMenuIdList")
    @ResponseBody
    public Map<String, Object> updatePosiMenuByMenuIdList(String POSI_ID_, String POSI_NAME_, @RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        posiMenuService.updatePosiMenuByMenuIdList(POSI_ID_, POSI_NAME_, MENU_ID_LIST, new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_"));

        result.put("success", true);

        return result;
    }
}