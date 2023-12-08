package com.opendynamic.cb.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface NoticeService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadNotice(String NOTICE_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String SOURCE_, String IDENTITY_, Date FROM_EXP_DATE_, Date TO_EXP_DATE_, List<String> NOTICE_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String SOURCE_, String IDENTITY_, Date FROM_EXP_DATE_, Date TO_EXP_DATE_, List<String> NOTICE_STATUS_LIST, Date FROM_CREATION_DATE_, Date TO_CREATION_DATE_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectNoticeByIdList(List<String> NOTICE_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String EMP_NAME_, String CONTENT_, String SOURCE_, String IDENTITY_, String REDIRECT_URL_, String BIZ_URL_, Date EXP_DATE_, String NOTICE_STATUS_, Date CREATION_DATE_);

    /**
     * 修改对象。
     */
    public int updateNotice(String NOTICE_ID_, String POSI_EMP_ID_, String EMP_ID_, String EMP_CODE_, String EMP_NAME_, String CONTENT_, String SOURCE_, String IDENTITY_, String REDIRECT_URL_, String BIZ_URL_, Date EXP_DATE_);

    public int updateNoticeStatus(String NOTICE_ID_, String NOTICE_STATUS_);

    /**
     * 删除对象。
     */
    public int deleteNotice(String NOTICE_ID_);
}