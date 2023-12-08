package com.opendynamic.cb.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.cb.service.CustomThemeService;

@Controller
public class CustomThemeController extends OdController {
    @Autowired
    private CustomThemeService customThemeService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageCustomTheme")
    public String manageCustomTheme(Map<String, Object> operator) {
        return "cb/CustomTheme/manageCustomTheme";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertCustomTheme")
    public String preInsertCustomTheme(Map<String, Object> operator) {
        return "cb/CustomTheme/preInsertCustomTheme";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateCustomTheme")
    public String preUpdateCustomTheme(Map<String, Object> operator) {
        return "cb/CustomTheme/preUpdateCustomTheme";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "viewCustomTheme")
    public String viewCustomTheme(Map<String, Object> operator) {
        return "cb/CustomTheme/viewCustomTheme";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CUSTOM_THEME_ID_")
    @RequestMapping(value = "loadCustomTheme")
    @ResponseBody
    public Map<String, Object> loadCustomTheme(String CUSTOM_THEME_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> customTheme = customThemeService.loadCustomTheme(CUSTOM_THEME_ID_);

        result.put("customTheme", customTheme);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "loadCustomThemeByOperatorId")
    @ResponseBody
    public Map<String, Object> loadCustomThemeByOperatorId(Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> customTheme = customThemeService.loadCustomThemeByOperatorId((String) operator.get("POSI_EMP_ID_"));

        result.put("customTheme", customTheme);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCustomTheme")
    @ResponseBody
    public Map<String, Object> selectCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> customThemeList = customThemeService.selectCustomTheme(CUSTOM_THEME_ID_, OPERATOR_ID_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = customThemeService.countCustomTheme(CUSTOM_THEME_ID_, OPERATOR_ID_);
        }

        result.put("customThemeList", customThemeList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectCustomThemeByIdList")
    @ResponseBody
    public Map<String, Object> selectCustomThemeByIdList(@RequestParam(value = "CUSTOM_THEME_ID_LIST", required = false) List<String> CUSTOM_THEME_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> customThemeList = customThemeService.selectCustomThemeByIdList(CUSTOM_THEME_ID_LIST);

        result.put("customThemeList", customThemeList);
        result.put("success", true);

        return result;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CUSTOM_THEME_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertCustomTheme")
    @ResponseBody
    public Map<String, Object> insertCustomTheme(String CUSTOM_THEME_ID_, String CSS_HREF_, Map<String, Object> operator, HttpSession session) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customThemeService.insertCustomTheme(CUSTOM_THEME_ID_, (String) operator.get("POSI_EMP_ID_"), CSS_HREF_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }
        ((Map) session.getAttribute("operator")).put("CSS_HREF_", CSS_HREF_);

        result.put("customTheme", customThemeService.loadCustomTheme(CUSTOM_THEME_ID_));
        result.put("success", true);

        return result;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CUSTOM_THEME_ID_")
    @RequestMapping(value = "updateCustomTheme")
    @ResponseBody
    public Map<String, Object> updateCustomTheme(String CUSTOM_THEME_ID_, String CSS_HREF_, Map<String, Object> operator, HttpSession session) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customThemeService.updateCustomTheme(CUSTOM_THEME_ID_, CSS_HREF_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }
        ((Map) session.getAttribute("operator")).put("CSS_HREF_", CSS_HREF_);

        result.put("customTheme", customThemeService.loadCustomTheme(CUSTOM_THEME_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "CUSTOM_THEME_ID_")
    @RequestMapping(value = "deleteCustomTheme")
    @ResponseBody
    public Map<String, Object> deleteCustomTheme(String CUSTOM_THEME_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (customThemeService.deleteCustomTheme(CUSTOM_THEME_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}