package com.opendynamic;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Method;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.ldap.LdapName;
import javax.naming.ldap.Rdn;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContext;

import com.opendynamic.cb.service.CustomThemeService;
import com.opendynamic.cb.service.DutyMenuService;
import com.opendynamic.cb.service.LogService;
import com.opendynamic.cb.service.PosiEmpMenuService;
import com.opendynamic.cb.service.PosiMenuService;
import com.opendynamic.om.service.OmEmpService;
import com.opendynamic.om.service.OmLogService;
import com.opendynamic.om.service.OmPosiEmpService;
import com.opendynamic.om.service.OmService;

@Component
@Aspect
public class OdControllerWrapperAspect {
    @Autowired
    private LogService logService;
    @Autowired
    private OmLogService omLogService;
    @Autowired
    private OmService omService;
    @Autowired
    private OmEmpService omEmpService;
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

    private static Logger _logger = Logger.getLogger(OdControllerWrapperAspect.class);

    @SuppressWarnings("unchecked")
    @Around("@annotation(com.opendynamic.OdControllerWrapper)")
    public Object wrapper(ProceedingJoinPoint point) throws Throwable {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();// 获取request和session
        HttpSession session = request.getSession(true);

        MethodSignature signature = (MethodSignature) point.getSignature();
        Method method = signature.getMethod();
        OdControllerWrapper annotation = method.getAnnotation(OdControllerWrapper.class);
        String[] parameterNames = signature.getParameterNames();
        Object[] arguments = point.getArgs();
        Map<String, Object> operator = (Map<String, Object>) session.getAttribute("operator");

        boolean loginRequired = annotation.loginRequired();
        boolean accessRequired = annotation.accessRequired();
        String logCategory = annotation.logCategory();
        String businessKeyParameterName = annotation.businessKeyParameterName();
        boolean businessKeyInitRequired = annotation.businessKeyInitRequired();
        String logger = annotation.logger();
        boolean _loginRequired = loginRequired;
        boolean _accessRequired = accessRequired;

        if (operator != null) {// 有session，无需登录
            _loginRequired = false;
        }
        if (operator == null && (loginRequired || accessRequired)) {// 检查登录
            // 尝试以数字证书登录
            X509Certificate[] certificate = (X509Certificate[]) request.getAttribute("javax.servlet.request.X509Certificate");
            if (certificate != null) {
                String EMP_CODE_ = null;
                LdapName ldapName = new LdapName(certificate[0].getSubjectDN().getName());
                for (Rdn rdn : ldapName.getRdns()) {
                    if (rdn.getType().equalsIgnoreCase("CN")) {
                        EMP_CODE_ = (String) rdn.getValue();
                        break;
                    }
                }

                Map<String, Object> emp = omEmpService.loadEmpByCode(OdConfig.getOrgnSetId(), null, EMP_CODE_, null, null);
                if (emp == null) {
                    throw new RuntimeException("errors.login");
                }
                List<Map<String, Object>> posiEmpList = omService.createPosiEmpQuery().setOrgnSetId(OdConfig.getOrgnSetId()).setEmpId((String) emp.get("EMP_ID_")).queryForMapList();
                if (posiEmpList.size() == 0) {
                    throw new RuntimeException("errors.posiRequired");
                }

                operator = initOperator(posiEmpList, null);
                session.setAttribute("operator", operator);

                _loginRequired = false;
            }
            // 尝试以token登录
            if (_loginRequired) {
                String token = request.getHeader("token");
                if (StringUtils.isEmpty(token)) {
                    token = request.getParameter("token");
                }
                if (StringUtils.isNotEmpty(token)) {
                    HttpSession sessionByToken = OdSessionListener.getSessionByToken(token);
                    if (sessionByToken != null) {
                        operator = (Map<String, Object>) sessionByToken.getAttribute("operator");
                        session.setAttribute("operator", operator);
                        session.setAttribute("token", sessionByToken.getAttribute("token"));

                        _loginRequired = false;
                    }
                }
            }
        }
        if (accessRequired) {// 检查访问权限
            if (operator != null) {
                List<Map<String, Object>> menuList = (List<Map<String, Object>>) operator.get("menuList");
                String url = method.getAnnotation(RequestMapping.class).value()[0] + ".do";
                if (menuList != null) {
                    for (Map<String, Object> menu : menuList) {
                        if (menu.get("URL_") != null && menu.get("URL_").equals(url)) {
                            _accessRequired = false;
                            break;
                        }
                    }
                }
            }
        }

        for (int i = 0; i < parameterNames.length; i++) {// 注入operator
            if (parameterNames[i].equals("operator") && arguments[i] instanceof Map) {
                arguments[i] = operator;
            }
        }

        int index = -1;
        if (StringUtils.isNotEmpty(businessKeyParameterName)) {
            for (int i = 0; i < parameterNames.length; i++) {
                if (parameterNames[i].equals(businessKeyParameterName)) {// 查找业务主键
                    index = i;
                    break;
                }
            }

            if (businessKeyInitRequired && StringUtils.isEmpty((String) arguments[index])) {// 初始化业务主键
                arguments[index] = OdUtils.getUuid();
            }
        }

        Object result = null;
        boolean jsonReturnType = false;
        if (method.getReturnType() == Map.class) {
            jsonReturnType = true;
        }

        String LOG_ID_ = OdUtils.getUuid();
        String CATEGORY_ = logCategory;
        String IP_ = OdUtils.getIpAddress(request);
        String USER_AGENT_ = request.getHeader("User-Agent");
        String URL_ = OdUtils.getUrl(request);
        String ACTION_ = point.getTarget().getClass().getSimpleName() + "." + signature.getName();
        String PARAMETER_MAP_ = OdUtils.getParameterMap(request);
        String BUSINESS_KEY_ = (index != -1) ? (String) arguments[index] : null;
        String ERROR_ = "0";
        String MESSAGE_ = null;
        String ORG_ID_ = (operator != null) ? (String) operator.get("ORG_ID_") : null;
        String ORG_NAME_ = (operator != null) ? (String) operator.get("ORG_NAME_") : null;
        String POSI_ID_ = (operator != null) ? (String) operator.get("POSI_ID_") : null;
        String POSI_NAME_ = (operator != null) ? (String) operator.get("POSI_NAME_") : null;
        String EMP_ID_ = (operator != null) ? (String) operator.get("EMP_ID_") : null;
        String EMP_NAME_ = (operator != null) ? (String) operator.get("EMP_NAME_") : null;
        Date CREATION_DATE_ = new Date();
        if (_loginRequired) {
            ERROR_ = "1";
            MESSAGE_ = getLocaleMessage("errors.loginRequired", null, request);

            if (jsonReturnType) {
                result = new HashMap<String, Object>();
                ((Map<String, Object>) result).put("message", MESSAGE_);
                ((Map<String, Object>) result).put("success", false);
            }
        }
        else
            if (_accessRequired) {
                ERROR_ = "1";
                MESSAGE_ = getLocaleMessage("errors.accessDenied", null, request);

                if (jsonReturnType) {
                    result = new HashMap<String, Object>();
                    ((Map<String, Object>) result).put("message", MESSAGE_);
                    ((Map<String, Object>) result).put("success", false);
                }
            }
            else {
                try {
                    result = point.proceed(arguments);// 执行原方法
                }
                catch (Exception e) {
                    _logger.error(e.getMessage(), e);

                    ERROR_ = "1";
                    StringWriter stringWriter = new StringWriter();
                    e.printStackTrace(new PrintWriter(stringWriter));
                    MESSAGE_ = stringWriter.toString();

                    if (jsonReturnType) {
                        result = new HashMap<String, Object>();
                        ((Map<String, Object>) result).put("message", getErrorMessage(e, request));
                        ((Map<String, Object>) result).put("success", false);
                    }
                    else {
                        throw new RuntimeException(getErrorMessage(e, request), e);
                    }
                }
            }

        if (logger.equals("")) {
            logService.insertLog(LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_);// 新增日志
        }
        else
            if (logger.equals("OM")) {
                omLogService.insertLog(LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_);// 新增日志
            }

        if (!jsonReturnType) {// 非JSON返回，抛出异常
            if (_loginRequired) {
                throw new RuntimeException(getLocaleMessage("errors.loginRequired", null, request));
            }
            if (_accessRequired) {
                throw new RuntimeException(getLocaleMessage("errors.accessDenied", null, request));
            }
        }

        return result;
    }

    private String getLocaleMessage(String code, Object[] args, HttpServletRequest request) {
        String message = null;

        if (StringUtils.isNotEmpty(code)) {
            message = new RequestContext(request).getMessage(code, args);
        }
        if (StringUtils.isEmpty(message)) {
            message = new RequestContext(request).getMessage("errors.unknown", args);
        }

        return message;
    }

    private String getErrorMessage(Exception e, HttpServletRequest request) {
        if (e instanceof DuplicateKeyException) {
            return getLocaleMessage("errors.duplicateKey", null, request);
        }
        if (e instanceof DataIntegrityViolationException) {
            return getLocaleMessage("errors.dataIntegrityViolation", null, request);
        }
        return getLocaleMessage(e.getMessage(), null, request);
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

    private List<Map<String, Object>> selectEmpMenu(String POSI_EMP_ID_, List<String> MENU_TYPE_LIST) {
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

        return dutyMenuService.selectDutyMenu(null, (String) posiEmp.get("DUTY_ID_"), null, null, null, null, MENU_TYPE_LIST, Arrays.asList("1"), null, 1, -1);
    }
}