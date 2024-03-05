package com.opendynamic.doc.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface DocDataService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadDocData(String DOC_DATA_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectDocDataByIdList(List<String> DOC_DATA_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertDocData(String DOC_DATA_ID_, String DOC_ID_, String BOOKMARK_, String VALUE_, String DATA_TYPE_, Integer ORDER_);

    /**
     * 修改对象。
     */
    public int updateDocData(String DOC_DATA_ID_, String BOOKMARK_, String VALUE_, String DATA_TYPE_, Integer ORDER_);

    /**
     * 拖动排序。
     */
    public int updateDocDataOrder(List<String> DOC_DATA_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDocData(String DOC_DATA_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDocDataByDocId(String DOC_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteDocDataByDocIdBookmark(String DOC_ID_, String BOOKMARK_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

}