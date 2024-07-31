package com.opendynamic.doc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.doc.service.DocDataService;

@Controller
public class DocDataController extends OdController {
    @Autowired
    private DocDataService docDataService;

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "manageDocData")
    public String manageDocData(Map<String, Object> operator) {
        return "k/DocData/manageDocData";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preInsertDocData")
    public String preInsertDocData(Map<String, Object> operator) {
        return "k/DocData/preInsertDocData";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "preUpdateDocData")
    public String preUpdateDocData(Map<String, Object> operator) {
        return "k/DocData/preUpdateDocData";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "viewDocData")
    public String viewDocData(Map<String, Object> operator) {
        return "k/DocData/viewDocData";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocData")
    @ResponseBody
    public Map<String, Object> selectDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<>();

        List<Map<String, Object>> docDataList = docDataService.selectDocData(DOC_DATA_ID_, DOC_ID_, BOOKMARK_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = docDataService.countDocData(DOC_DATA_ID_, DOC_ID_, BOOKMARK_);
        }

        result.put("docDataList", docDataList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }
}