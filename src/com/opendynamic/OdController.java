package com.opendynamic;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.opendynamic.cb.service.CustomThemeService;
import com.opendynamic.cb.service.DutyMenuService;
import com.opendynamic.cb.service.PosiEmpMenuService;
import com.opendynamic.cb.service.PosiMenuService;
import com.opendynamic.om.service.OmPosiEmpService;
import com.opendynamic.om.service.OmService;

public class OdController {
    @Autowired
    private OmService omService;
    @Autowired
    private OmPosiEmpService omPosiEmpService;
    @Autowired
    private DutyMenuService dutyMenuService;
    @Autowired
    private PosiMenuService posiMenuService;
    @Autowired
    private PosiEmpMenuService posiEmpMenuService;
    @Autowired
    private CustomThemeService customThemeService;

    /**
     * 初始化日期格式,用于JSON转换
     * 
     * @param binder
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    protected Map<String, Object> initOperator(List<Map<String, Object>> posiEmpList, String POSI_ID_) {
        Map<String, Object> operator = new HashMap<>();

        Map<String, Object> posiEmp = posiEmpList.get(0);
        if (StringUtils.isNotEmpty(POSI_ID_)) {
            for (Map<String, Object> _emp : posiEmpList) {
                if (POSI_ID_.equals(_emp.get("POSI_ID_"))) {
                    posiEmp = _emp;
                    break;
                }
            }
        }
        else {
            for (Map<String, Object> _emp : posiEmpList) {
                if ("1".equals(_emp.get("MAIN_"))) {
                    posiEmp = _emp;
                    break;
                }
            }
        }

        operator.put("EMP_ID_", posiEmp.get("EMP_ID_"));
        operator.put("EMP_CODE_", posiEmp.get("EMP_CODE_"));
        operator.put("EMP_NAME_", posiEmp.get("EMP_NAME_"));
        operator.put("ORG_ID_", posiEmp.get("ORG_ID_"));
        operator.put("ORG_CODE_", posiEmp.get("ORG_CODE_"));
        operator.put("ORG_NAME_", posiEmp.get("ORG_NAME_"));
        List<Map<String, Object>> parentOrgList = omService.createParentOrgQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setOrgId((String) posiEmp.get("ORG_ID_")).setOrgTypeList(Arrays.asList("1", "2", "3", "4", "5", "99")).setRecursive(true).setIncludeSelf(true).queryForMapList();
        if (parentOrgList.size() > 0) {
            Map<String, Object> com = parentOrgList.get(0);
            operator.put("COM_ID_", com.get("ORG_ID_"));
            operator.put("COM_CODE_", com.get("ORG_CODE_"));
            operator.put("COM_NAME_", com.get("ORG_NAME_"));
        }
        operator.put("DUTY_ID_", posiEmp.get("DUTY_ID_"));
        operator.put("DUTY_CODE_", posiEmp.get("DUTY_CODE_"));
        operator.put("DUTY_NAME_", posiEmp.get("DUTY_NAME_"));
        operator.put("POSI_ID_", posiEmp.get("POSI_ID_"));
        operator.put("POSI_CODE_", posiEmp.get("POSI_CODE_"));
        operator.put("POSI_NAME_", posiEmp.get("POSI_NAME_"));
        operator.put("POSI_EMP_ID_", posiEmp.get("POSI_EMP_ID_"));

        operator.put("posiEmpList", posiEmpList);

        List<Map<String, Object>> menuList = new ArrayList<>();
        for (Map<String, Object> _posiEmp : posiEmpList) {
            menuList.addAll(selectEmpMenu((String) _posiEmp.get("POSI_EMP_ID_"), null));
        }
        operator.put("menuList", menuList);

        Map<String, Object> customTheme = customThemeService.loadCustomThemeByOperatorId((String) posiEmp.get("POSI_EMP_ID_"));
        if (customTheme != null) {
            operator.put("CSS_HREF_", customTheme.get("CSS_HREF_"));
        }
        else {
            operator.put("CSS_HREF_", OdConfig.getDefaultCssHref());
        }

        return operator;
    }

    protected List<Map<String, Object>> selectEmpMenu(String POSI_EMP_ID_, List<String> MENU_TYPE_LIST) {
        List<Map<String, Object>> empMenuList;

        empMenuList = posiEmpMenuService.selectPosiEmpMenu(null, POSI_EMP_ID_, null, null, null, null, null, MENU_TYPE_LIST, Arrays.asList("1"), null, 1, -1);
        if (empMenuList.size() > 0) {
            return empMenuList;
        }

        Map<String, Object> posiEmp = omPosiEmpService.loadPosiEmp(OdConfig.getOrgnSetId(), null, POSI_EMP_ID_, null, null);
        empMenuList = posiMenuService.selectPosiMenu(null, (String) posiEmp.get("POSI_ID_"), null, null, null, null, MENU_TYPE_LIST, Arrays.asList("1"), null, 1, -1);
        if (empMenuList.size() > 0) {
            return empMenuList;
        }

        if (posiEmp.get("DUTY_ID_") != null) {
            return dutyMenuService.selectDutyMenu(null, (String) posiEmp.get("DUTY_ID_"), null, null, null, null, MENU_TYPE_LIST, Arrays.asList("1"), null, 1, -1);
        }

        return new ArrayList<>();
    }
}