package com.opendynamic.cb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface CustomThemeService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadCustomTheme(String CUSTOM_THEME_ID_);

    /**
     * 按编码查询,返回单个对象。
     */
    public Map<String, Object> loadCustomThemeByOperatorId(String OPERATOR_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectCustomThemeByIdList(List<String> CUSTOM_THEME_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertCustomTheme(String CUSTOM_THEME_ID_, String OPERATOR_ID_, String CSS_HREF_);

    /**
     * 修改对象。
     */
    public int updateCustomTheme(String CUSTOM_THEME_ID_, String CSS_HREF_);

    /**
     * 删除对象。
     */
    public int deleteCustomTheme(String CUSTOM_THEME_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}