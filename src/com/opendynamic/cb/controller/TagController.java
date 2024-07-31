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
import com.opendynamic.cb.service.TagService;

@Controller
public class TagController extends OdController {
    @Autowired
    private TagService tagService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageTag")
    public String manageTag() {
        return "cb/Tag/manageTag";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preInsertTag")
    public String preInsertTag() {
        return "cb/Tag/preInsertTag";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "preUpdateTag")
    public String preUpdateTag() {
        return "cb/Tag/preUpdateTag";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "TAG_ID_")
    @RequestMapping(value = "loadTag")
    @ResponseBody
    public Map<String, Object> loadTag(String TAG_ID_) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> tag = tagService.loadTag(TAG_ID_);

        result.put("tag", tag);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectTag")
    @ResponseBody
    public Map<String, Object> selectTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Integer page, Integer limit) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> tagList = tagService.selectTag(TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = tagService.countTag(TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_);
        }

        result.put("tagList", tagList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectTagByIdList")
    @ResponseBody
    public Map<String, Object> selectTagByIdList(@RequestParam(value = "TAG_ID_LIST", required = false) List<String> TAG_ID_LIST) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> tagList = tagService.selectTagByIdList(TAG_ID_LIST);

        result.put("tagList", tagList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "TAG_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertTag")
    @ResponseBody
    public Map<String, Object> insertTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (tagService.insertTag(TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("tag", tagService.loadTag(TAG_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "TAG_ID_")
    @RequestMapping(value = "updateTag")
    @ResponseBody
    public Map<String, Object> updateTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (tagService.updateTag(TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("tag", tagService.loadTag(TAG_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "TAG_ID_")
    @RequestMapping(value = "deleteTag")
    @ResponseBody
    public Map<String, Object> deleteTag(String TAG_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        if (tagService.deleteTag(TAG_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}