package com.opendynamic.cb.service;

import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface RiderService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadRider(String RIDER_ID_);

    /**
     * 获取文件。
     */
    public InputStream loadRiderFile(String RIDER_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectRider(String RIDER_ID_, String OBJ_ID_, String RIDER_FILE_NAME_, String RIDER_TAG_, List<String> RIDER_STATUS_LIST, Boolean tagUnion, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countRider(String RIDER_ID_, String OBJ_ID_, String RIDER_FILE_NAME_, String RIDER_TAG_, List<String> RIDER_STATUS_LIST, Boolean tagUnion);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectRiderByIdList(List<String> RIDER_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertRider(String RIDER_ID_, String OBJ_ID_, InputStream RIDER_FILE_, String RIDER_FILE_NAME_, Integer RIDER_FILE_LENGTH_, String MEMO_, String RIDER_TAG_, Integer ORDER_, String RIDER_STATUS_, Date CREATION_DATE_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 修改对象。
     */
    public int updateRider(String RIDER_ID_, InputStream RIDER_FILE_, String RIDER_FILE_NAME_, Integer RIDER_FILE_LENGTH_, String MEMO_, String RIDER_TAG_, Integer ORDER_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 拖动排序。
     */
    public int updateRiderOrder(List<String> RIDER_ID_LIST, List<Integer> ORDER_LIST, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 废弃对象。
     */
    public int disableRider(String RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 恢复对象。
     */
    public int enableRider(String RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteRider(String RIDER_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);

    /**
     * 删除对象。
     */
    public int deleteRiderByObjId(String OBJ_ID_, Date UPDATE_DATE_, String OPERATOR_ID_, String OPERATOR_NAME_);
}