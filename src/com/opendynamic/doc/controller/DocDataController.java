package com.opendynamic.doc.controller;

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

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_DATA_ID_")
    @RequestMapping(value = "loadDocData")
    @ResponseBody
    public Map<String, Object> loadDocData(String DOC_DATA_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        Map<String, Object> docData = docDataService.loadDocData(DOC_DATA_ID_);

        result.put("docData", docData);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocData")
    @ResponseBody
    public Map<String, Object> selectDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

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

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "selectDocDataByIdList")
    @ResponseBody
    public Map<String, Object> selectDocDataByIdList(@RequestParam(value = "DOC_DATA_ID_LIST", required = false) List<String> DOC_DATA_ID_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> docDataList = docDataService.selectDocDataByIdList(DOC_DATA_ID_LIST);

        result.put("docDataList", docDataList);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_DATA_ID_", businessKeyInitRequired = true)
    @RequestMapping(value = "insertDocData")
    @ResponseBody
    public Map<String, Object> insertDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, String VALUE_, String DATA_TYPE_, Integer ORDER_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docDataService.insertDocData(DOC_DATA_ID_, DOC_ID_, BOOKMARK_, VALUE_, DATA_TYPE_, ORDER_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("docData", docDataService.loadDocData(DOC_DATA_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K")
    @RequestMapping(value = "updateDocDataOrder")
    @ResponseBody
    public Map<String, Object> updateDocDataOrder(@RequestParam(value = "DOC_DATA_ID_LIST", required = true) List<String> DOC_DATA_ID_LIST, @RequestParam(value = "ORDER_LIST", required = true) List<Integer> ORDER_LIST, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docDataService.updateDocDataOrder(DOC_DATA_ID_LIST, ORDER_LIST, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "K", businessKeyParameterName = "DOC_DATA_ID_")
    @RequestMapping(value = "deleteDocData")
    @ResponseBody
    public Map<String, Object> deleteDocData(String DOC_DATA_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (docDataService.deleteDocData(DOC_DATA_ID_, new Date(), (String) operator.get("EMP_ID_"), (String) operator.get("EMP_NAME_")) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }
}