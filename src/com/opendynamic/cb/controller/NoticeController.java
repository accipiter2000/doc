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

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.cb.service.NoticeService;
import com.opendynamic.om.service.OmEmpService;
import com.opendynamic.om.service.OmService;

@Controller
public class NoticeController extends OdController {
    @Autowired
    private NoticeService noticeService;
    @Autowired
    private OmService omService;
    @Autowired
    private OmEmpService omEmpService;

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "manageMyNotice")
    public String manageMyNotice(Map<String, Object> operator) {
        return "cb/Notice/manageMyNotice";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectMyNotice")
    @ResponseBody
    public Map<String, Object> selectMyNotice(String NOTICE_ID_, String SOURCE_, String IDENTITY_, Date FROM_EXP_DATE_, Date TO_EXP_DATE_, @RequestParam(value = "NOTICE_STATUS_LIST", required = false) List<String> NOTICE_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> noticeList = noticeService.selectNotice(NOTICE_ID_, null, null, (String) operator.get("EMP_CODE_"), SOURCE_, IDENTITY_, FROM_EXP_DATE_, TO_EXP_DATE_, NOTICE_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_, page, limit);
        int total = 0;
        if (limit != null && limit > 0) {
            total = noticeService.countNotice(NOTICE_ID_, null, (String) operator.get("EMP_ID_"), null, SOURCE_, IDENTITY_, FROM_EXP_DATE_, TO_EXP_DATE_, NOTICE_STATUS_LIST, FROM_CREATION_DATE_, TO_CREATION_DATE_);
        }

        result.put("noticeList", noticeList);
        result.put("total", total);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "NOTICE_ID_")
    @RequestMapping(value = "updateNoticeStatus")
    @ResponseBody
    public Map<String, Object> updateNoticeStatus(String NOTICE_ID_, String NOTICE_STATUS_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (noticeService.updateNoticeStatus(NOTICE_ID_, NOTICE_STATUS_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("notice", noticeService.loadNotice(NOTICE_ID_));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB", businessKeyParameterName = "NOTICE_ID_")
    @RequestMapping(value = "deleteNotice")
    @ResponseBody
    public Map<String, Object> deleteNotice(String NOTICE_ID_, Map<String, Object> operator) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (noticeService.deleteNotice(NOTICE_ID_) == 0) {
            throw new RuntimeException("errors.noDataChange");
        }

        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = false, logCategory = "CB", businessKeyParameterName = "IDENTITY_")
    @RequestMapping(value = "redirectNotice")
    @ResponseBody
    public Map<String, Object> redirectNotice(String IDENTITY_, Map<String, Object> operator, HttpSession session) {
        Map<String, Object> result = new HashMap<String, Object>();

        List<Map<String, Object>> noticeList = noticeService.selectNotice(null, null, null, null, null, IDENTITY_, null, null, null, null, null, 1, -1);
        if (noticeList.size() != 1) {
            throw new RuntimeException("errors.noticeNotFound");
        }

        Map<String, Object> notice = noticeList.get(0);
        if (operator == null) {
            Map<String, Object> emp = omEmpService.loadEmpByCode(OdConfig.getOrgnSetId(), null, (String) notice.get("EMP_CODE_"), null, null);
            if (emp == null) {
                throw new RuntimeException("errors.login");
            }
            List<Map<String, Object>> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setEmpId((String) emp.get("EMP_ID_")).queryForMapList();
            if (posiEmpList.size() == 0) {
                throw new RuntimeException("errors.posiRequired");
            }

            operator = initOperator(posiEmpList, null);
            session.setAttribute("operator", operator);
        }

        if ("0".equals(notice.get("NOTICE_STATUS_"))) {
            noticeService.updateNoticeStatus((String) notice.get("NOTICE_ID_"), "1");
        }

        result.put("BIZ_URL_", notice.get("BIZ_URL_"));
        result.put("success", true);

        return result;
    }
}