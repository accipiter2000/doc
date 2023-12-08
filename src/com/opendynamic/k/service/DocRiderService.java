package com.opendynamic.k.service;

import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface DocRiderService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadDocRider(String DOC_RIDER_ID_);

    /**
     * 获取文件。
     */
    public InputStream loadDocRiderFile(String DOC_RIDER_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDocRider(String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDocRider(String DOC_RIDER_ID_, String DOC_ID_, String DOC_RIDER_FILE_NAME_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDocRiderByIdList(List<String> DOC_RIDER_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertDocRider(String DOC_RIDER_ID_, String DOC_ID_, InputStream DOC_RIDER_FILE_, String DOC_RIDER_FILE_NAME_, Integer DOC_RIDER_FILE_LENGTH_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updateDocRider(String DOC_RIDER_ID_, InputStream DOC_RIDER_FILE_, String DOC_RIDER_FILE_NAME_, Integer DOC_RIDER_FILE_LENGTH_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDocRider(String DOC_RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDocRiderByDocId(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}