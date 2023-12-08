package com.opendynamic.k.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface CustomApprovalMemoService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectCustomApprovalMemoByIdList(List<String> CUSTOM_APPROVAL_MEMO_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_, String APPROVAL_MEMO_, String DEFAULT_, Integer ORDER_);

    /**
     * 修改对象。
     */
    public int updateCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, String EMP_ID_, String APPROVAL_MEMO_, String DEFAULT_, Integer ORDER_);

    /**
     * 拖动排序。
     */
    public int updateCustomApprovalMemoOrder(List<String> CUSTOM_APPROVAL_MEMO_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteCustomApprovalMemo(String CUSTOM_APPROVAL_MEMO_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}