package com.opendynamic.cb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;

@Controller
public class OdConfigController extends OdController {
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getServer")
    @ResponseBody
    public Map<String, Object> getServer(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        result.put("server", OdConfig.getServer());
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getMaxUploadSize")
    @ResponseBody
    public Map<String, Object> getMaxUploadSize(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        result.put("maxUploadSize", OdConfig.getMaxUploadSize());
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getOrgnSetId")
    @ResponseBody
    public Map<String, Object> getOrgnSetId(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        result.put("orgnSetId", OdConfig.getOrgnSetId());
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getOrgnSetCode")
    @ResponseBody
    public Map<String, Object> getOrgnSetCode(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        result.put("orgnSetCode", OdConfig.getOrgnSetCode());
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getDefaultCssHref")
    @ResponseBody
    public Map<String, Object> getDefaultCssHref(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        result.put("defaultCssHref", OdConfig.getDefaultCssHref());
        result.put("success", true);

        return result;
    }
}