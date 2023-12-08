package com.opendynamic.om.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.om.service.OmTagService;

@Controller
public class OmTagController extends OdController {
    @Autowired
    private OmTagService omTagService;

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "manageOmTag")
    public String manageOmTag() {
        return "om/Tag/manageTag";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preInsertOmTag")
    public String preInsertOmTag() {
        return "om/Tag/preInsertTag";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "preUpdateOmTag")
    public String preUpdateOmTag() {
        return "om/Tag/preUpdateTag";
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "TAG_ID_")
    @RequestMapping(value = "loadOmTag")
    @ResponseBody
    public Map<String, Object> loadOmTag(String TAG_ID_) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> tag = omTagService.loadTag(OdConfig.getOrgnSetId(), null, TAG_ID_);

        result.put("tag", tag);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmTag")
    @ResponseBody
    public Map<String, Object> selectOmTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Integer page, Integer limit) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> tagList = omTagService.selectTag(OdConfig.getOrgnSetId(), null, TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = omTagService.countTag(OdConfig.getOrgnSetId(), null, TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_);
        }

        result.put("tagList", tagList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM")
    @RequestMapping(value = "selectOmTagByIdList")
    @ResponseBody
    public Map<String, Object> selectOmTagByIdList(@RequestParam(value = "TAG_ID_LIST", required = false) List<String> TAG_ID_LIST) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> tagList = omTagService.selectTagByIdList(OdConfig.getOrgnSetId(), TAG_ID_LIST);

        result.put("tagList", tagList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "TAG_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertOmTag")
    @ResponseBody
    public Map<String, Object> insertOmTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omTagService.insertTag(OdConfig.getOrgnSetId(), TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("tag", omTagService.loadTag(OdConfig.getOrgnSetId(), null, TAG_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "TAG_ID_")
    @RequestMapping(value = "updateOmTag")
    @ResponseBody
    public Map<String, Object> updateOmTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omTagService.updateTag(OdConfig.getOrgnSetId(), TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("tag", omTagService.loadTag(OdConfig.getOrgnSetId(), null, TAG_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logger = "OM", logCategory = "OM", businessKeyParameterName = "TAG_ID_")
    @RequestMapping(value = "deleteOmTag")
    @ResponseBody
    public Map<String, Object> deleteOmTag(String TAG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (omTagService.deleteTag(OdConfig.getOrgnSetId(), TAG_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}