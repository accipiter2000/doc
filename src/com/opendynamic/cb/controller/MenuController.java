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
import com.opendynamic.cb.service.MenuService;

@Controller
public class MenuController extends OdController {
    @Autowired
    private MenuService menuService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageMenu")
    public String manageMenu(Map<String, Object> operator) {
        return "cb/Menu/manageMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preChooseMenu")
    public String preChooseMenu(Map<String, Object> operator) {
        return "cb/Menu/preChooseMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertMenu")
    public String preInsertMenu(Map<String, Object> operator) {
        return "cb/Menu/preInsertMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateMenu")
    public String preUpdateMenu(Map<String, Object> operator) {
        return "cb/Menu/preUpdateMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewMenu")
    public String viewMenu(Map<String, Object> operator) {
        return "cb/Menu/viewMenu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "loadMenu")
    @ResponseBody
    public Map<String, Object> loadMenu(String MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> menu = menuService.loadMenu(MENU_ID_);

        result.put("menu", menu);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectMenu")
    @ResponseBody
    public Map<String, Object> selectMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, @RequestParam(value = "MENU_TYPE_LIST", required = false) List<String> MENU_TYPE_LIST, @RequestParam(value = "MENU_STATUS_LIST", required = false) List<String> MENU_STATUS_LIST, Boolean rootOnly, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> menuList = menuService.selectMenu(MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = menuService.countMenu(MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, rootOnly);
        }
        List<Map<String, Object>> menuListClone = (List<Map<String, Object>>) OdUtils.deepClone(menuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> menuIdList = OdUtils.collect(menuList, "MENU_ID_", String.class);
        Map<String, Object> menu;
        for (int i = 0; i < menuListClone.size(); i++) {
            menu = menuListClone.get(i);
            if (menu.get("PARENT_MENU_ID_") == null || menu.get("PARENT_MENU_ID_").equals("") || !menuIdList.contains(menu.get("PARENT_MENU_ID_"))) {
                children.add(menu);
                fillChildMenu(menu, menuListClone);
            }
        }

        result.put("menuList", menuList);
        result.put("total", total);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildMenu(Map<String, Object> menu, List<Map<String, Object>> menuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childMenu;
        for (int i = 0; i < menuList.size(); i++) {
            childMenu = menuList.get(i);
            if (menu.get("MENU_ID_").equals(childMenu.get("PARENT_MENU_ID_"))) {
                children.add(childMenu);
                fillChildMenu(childMenu, menuList);
            }
        }
        menu.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "selectParentMenu")
    @ResponseBody
    public Map<String, Object> selectParentMenu(String MENU_ID_, String MENU_NAME_, @RequestParam(value = "MENU_TYPE_LIST", required = false) List<String> MENU_TYPE_LIST, @RequestParam(value = "MENU_STATUS_LIST", required = false) List<String> MENU_STATUS_LIST, Boolean recursive, Boolean includeSelf, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> menuList = menuService.selectParentMenu(MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, recursive, includeSelf);
        List<Map<String, Object>> menuListClone = (List<Map<String, Object>>) OdUtils.deepClone(menuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> menuIdList = OdUtils.collect(menuList, "MENU_ID_", String.class);
        Map<String, Object> menu;
        for (int i = 0; i < menuListClone.size(); i++) {
            menu = menuListClone.get(i);
            if (menu.get("PARENT_MENU_ID_") == null || menu.get("PARENT_MENU_ID_").equals("") || !menuIdList.contains(menu.get("PARENT_MENU_ID_"))) {
                children.add(menu);
                fillChildParentMenu(menu, menuListClone);
            }
        }

        result.put("menuList", menuList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildParentMenu(Map<String, Object> menu, List<Map<String, Object>> menuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childMenu;
        for (int i = 0; i < menuList.size(); i++) {
            childMenu = menuList.get(i);
            if (menu.get("MENU_ID_").equals(childMenu.get("PARENT_MENU_ID_"))) {
                children.add(childMenu);
                fillChildParentMenu(childMenu, menuList);
            }
        }
        menu.put("children", children);
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "selectChildMenu")
    @ResponseBody
    public Map<String, Object> selectChildMenu(String MENU_ID_, String MENU_NAME_, @RequestParam(value = "MENU_TYPE_LIST", required = false) List<String> MENU_TYPE_LIST, @RequestParam(value = "MENU_STATUS_LIST", required = false) List<String> MENU_STATUS_LIST, Boolean recursive, Boolean includeSelf, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> menuList = menuService.selectChildMenu(MENU_ID_, MENU_NAME_, MENU_TYPE_LIST, MENU_STATUS_LIST, recursive, includeSelf);
        List<Map<String, Object>> menuListClone = (List<Map<String, Object>>) OdUtils.deepClone(menuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> menuIdList = OdUtils.collect(menuList, "MENU_ID_", String.class);
        Map<String, Object> menu;
        for (int i = 0; i < menuListClone.size(); i++) {
            menu = menuListClone.get(i);
            if (menu.get("PARENT_MENU_ID_") == null || menu.get("PARENT_MENU_ID_").equals("") || !menuIdList.contains(menu.get("PARENT_MENU_ID_"))) {
                children.add(menu);
                fillChildChildMenu(menu, menuListClone);
            }
        }

        result.put("menuList", menuList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildChildMenu(Map<String, Object> menu, List<Map<String, Object>> menuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childMenu;
        for (int i = 0; i < menuList.size(); i++) {
            childMenu = menuList.get(i);
            if (menu.get("MENU_ID_").equals(childMenu.get("PARENT_MENU_ID_"))) {
                children.add(childMenu);
                fillChildChildMenu(childMenu, menuList);
            }
        }
        menu.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectMenuByIdList")
    @ResponseBody
    public Map<String, Object> selectMenuByIdList(@RequestParam(value = "MENU_ID_LIST", required = false) List<String> MENU_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> menuList = menuService.selectMenuByIdList(MENU_ID_LIST);

        result.put("menuList", menuList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertMenu")
    @ResponseBody
    public Map<String, Object> insertMenu(String MENU_ID_, String PARENT_MENU_ID_, String MENU_NAME_, String MENU_TYPE_, String URL_, String ICON_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.insertMenu(MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_, URL_, ICON_, ORDER_, "1", new Date(), new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("menu", menuService.loadMenu(MENU_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "updateMenu")
    @ResponseBody
    public Map<String, Object> updateMenu(String MENU_ID_, String MENU_NAME_, String MENU_TYPE_, String URL_, String ICON_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.updateMenu(MENU_ID_, MENU_NAME_, MENU_TYPE_, URL_, ICON_, ORDER_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("menu", menuService.loadMenu(MENU_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "updateMenuOrder")
    @ResponseBody
    public Map<String, Object> updateMenuOrder(@RequestParam(value = "MENU_ID_LIST", required = true) List<String> MENU_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.updateMenuOrder(MENU_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "moveMenu")
    @ResponseBody
    public Map<String, Object> moveMenu(String MENU_ID_, String PARENT_MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.moveMenu(MENU_ID_, PARENT_MENU_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("menu", menuService.loadMenu(MENU_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "disableMenu")
    @ResponseBody
    public Map<String, Object> disableMenu(String MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.disableMenu(MENU_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("menu", menuService.loadMenu(MENU_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "enableMenu")
    @ResponseBody
    public Map<String, Object> enableMenu(String MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.enableMenu(MENU_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("menu", menuService.loadMenu(MENU_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "MENU_ID_")
    @RequestMapping(value = "deleteMenu")
    @ResponseBody
    public Map<String, Object> deleteMenu(String MENU_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (menuService.deleteMenu(MENU_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}