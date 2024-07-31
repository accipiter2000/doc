package com.opendynamic.cb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.opendynamic.OdConfig;
import com.opendynamic.OdController;
import com.opendynamic.OdControllerWrapper;
import com.opendynamic.OdUtils;
import com.opendynamic.om.service.OmEmpService;
import com.opendynamic.om.service.OmOrgnSetService;
import com.opendynamic.om.service.OmService;

@Controller
public class CbController extends OdController {
    @Autowired
    private OmService omService;
    @Autowired
    private OmOrgnSetService omOrgnSetService;
    @Autowired
    private OmEmpService omEmpService;

    @OdControllerWrapper(loginRequired = false, logCategory = "CB")
    @RequestMapping(value = "preLogin")
    public String preLogin() {
        return "preLogin";
    }

    @OdControllerWrapper(loginRequired = false, logCategory = "CB")
    @RequestMapping(value = "preLoginForTest")
    public String preLoginForTest() {
        return "preLoginForTest";
    }

    @OdControllerWrapper(loginRequired = false, logCategory = "CB")
    @RequestMapping(value = "logout")
    public String logout(HttpSession session) {
        session.removeAttribute("operator");

        return "preLogin";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "index")
    public String index() {
        return "index";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "banner")
    public String banner() {
        return "banner";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "menu")
    public String menu() {
        return "menu";
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "home")
    public String home() {
        return "home";
    }

    // 欢迎栏
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "welcome")
    public String welcome() {
        return "welcome";
    }

    @OdControllerWrapper(loginRequired = false, logCategory = "CB", businessKeyParameterName = "EMP_CODE_")
    @RequestMapping(value = "login")
    @ResponseBody
    public Map<String, Object> login(String EMP_CODE_, String PASSWORD_, String POSI_ID_, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> emp = omEmpService.loadEmpByPassword(OdConfig.getOrgnSetId(), null, EMP_CODE_, PASSWORD_, null, null);
        if (emp == null) {
            throw new RuntimeException("errors.login");
        }
        List<Map<String, Object>> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setEmpId((String) emp.get("EMP_ID_")).queryForMapList();
        if (posiEmpList.isEmpty()) {
            throw new RuntimeException("errors.posiRequired");
        }

        Map<String, Object> operator = initOperator(posiEmpList, POSI_ID_);
        session.setAttribute("operator", operator);

        result.put("operator", operator);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = false, logCategory = "CB", businessKeyParameterName = "EMP_CODE_")
    @RequestMapping(value = "loginForTest")
    @ResponseBody
    public Map<String, Object> loginForTest(String EMP_CODE_, String POSI_ID_, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> emp = omEmpService.loadEmpByCode(OdConfig.getOrgnSetId(), null, EMP_CODE_, null, null);
        if (emp == null) {
            throw new RuntimeException("errors.login");
        }
        List<Map<String, Object>> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setEmpId((String) emp.get("EMP_ID_")).queryForMapList();
        if (posiEmpList.isEmpty()) {
            throw new RuntimeException("errors.posiRequired");
        }

        Map<String, Object> operator = initOperator(posiEmpList, POSI_ID_);
        session.setAttribute("operator", operator);

        result.put("operator", operator);
        result.put("sessionId", session.getId());
        result.put("success", true);

        return result;
    }

    @SuppressWarnings("unchecked")
    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "selectEmpMenu")
    @ResponseBody
    public Map<String, Object> selectEmpMenu(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 收集该员工所有岗位的菜单，去重
        List<Map<String, Object>> empMenuList = null;
        Map<String, Map<String, Object>> empMenuMap = new HashMap<>();
        for (Map<String, Object> posiEmp : (List<Map<String, Object>>) ((Map<String, Object>) session.getAttribute("operator")).get("posiEmpList")) {
            empMenuList = selectEmpMenu((String) posiEmp.get("POSI_EMP_ID_"), Arrays.asList("0", "1", "11"));
            for (Map<String, Object> empMenu : empMenuList) {
                empMenuMap.put((String) empMenu.get("MENU_ID_"), empMenu);
            }
        }
        empMenuList.clear();
        empMenuList.addAll(empMenuMap.values());

        // 重新排序
        empMenuList.sort(new Comparator<Map<String, Object>>() {
            @Override
            public int compare(Map<String, Object> empMenu1, Map<String, Object> empMenu2) {
                int order1 = 0;
                int order2 = 0;
                if (empMenu1.get("ORDER_") != null) {
                    order1 = ((BigDecimal) empMenu1.get("ORDER_")).intValue();
                }
                if (empMenu2.get("ORDER_") != null) {
                    order2 = ((BigDecimal) empMenu2.get("ORDER_")).intValue();
                }

                if (order1 < order2) {
                    return -1;
                }
                else
                    if (order1 > order2) {
                        return 1;
                    }
                    else {
                        return 0;
                    }
            }
        });

        List<Map<String, Object>> empMenuListClone = (List<Map<String, Object>>) OdUtils.deepClone(empMenuList);
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();
        List<String> empMenuIdList = OdUtils.collect(empMenuList, "MENU_ID_", String.class);
        Map<String, Object> empMenu;
        for (int i = 0; i < empMenuListClone.size(); i++) {
            empMenu = empMenuListClone.get(i);
            if (empMenu.get("PARENT_MENU_ID_") == null || empMenu.get("PARENT_MENU_ID_").equals("") || !empMenuIdList.contains(empMenu.get("PARENT_MENU_ID_"))) {
                children.add(empMenu);
                fillChildEmpMenu(empMenu, empMenuListClone);
            }
        }

        result.put("empMenuList", empMenuList);
        result.put("children", children);
        result.put("success", true);

        return result;
    }

    private void fillChildEmpMenu(Map<String, Object> empMenu, List<Map<String, Object>> empMenuList) {
        List<Map<String, Object>> children = new ArrayList<Map<String, Object>>();

        Map<String, Object> childEmpMenu;
        for (int i = 0; i < empMenuList.size(); i++) {
            childEmpMenu = empMenuList.get(i);
            if (empMenu.get("MENU_ID_").equals(childEmpMenu.get("PARENT_MENU_ID_"))) {
                children.add(childEmpMenu);
                fillChildEmpMenu(childEmpMenu, empMenuList);
            }
        }
        empMenu.put("children", children);
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getOperator")
    @ResponseBody
    public Map<String, Object> getOperator(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        result.put("operator", session.getAttribute("operator"));
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getOrgnSet")
    @ResponseBody
    public Map<String, Object> getOrgnSet() {
        Map<String, Object> result = new HashMap<>();

        Map<String, Object> orgnSet = omOrgnSetService.loadOrgnSet(OdConfig.getOrgnSetId(), null, null);

        result.put("orgnSet", orgnSet);
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "getSessionId")
    @ResponseBody
    public Map<String, Object> getSessionId(HttpSession httpSession) {
        Map<String, Object> result = new HashMap<>();

        result.put("sessionId", httpSession.getId());
        result.put("success", true);

        return result;
    }

    @OdControllerWrapper(loginRequired = true, logCategory = "CB")
    @RequestMapping(value = "downloadResource")
    @ResponseBody
    public void downloadResource(String url, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
        url = URLDecoder.decode(url, "UTF-8");
        File file = new File(this.getClass().getResource("/../../resource/" + url).getFile());
        String fileName = file.getName();
        String agent = (String) request.getHeader("USER-AGENT");
        if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {// 兼容火狐中文文件名下载
            fileName = "=?UTF-8?B?" + (new String(Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";
        }
        else {
            fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
        }
        response.reset();
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);// 下载模式

        InputStream inputStream = new FileInputStream(file);
        OutputStream out = response.getOutputStream();
        byte[] content = new byte[65535];
        int length = 0;
        while ((length = inputStream.read(content)) != -1) {
            out.write(content, 0, length);
        }
        out.flush();
        out.close();
        inputStream.close();
    }
}