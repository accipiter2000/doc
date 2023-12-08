package com.opendynamic.cb.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public interface TagService {
    /**
     * 按主键查询,返回单个对象。
     */
    public Map<String, Object> loadTag(String TAG_ID_);

    /**
     * 通用查询，返回对象列表。
     */
    public List<Map<String, Object>> selectTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_, Integer page, Integer limit);

    /**
     * 总数查询，在分页时与通用查询配套使用。
     */
    public int countTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_);

    /**
     * 按主键列表查询，返回对象列表，按主键列表顺序排序。
     */
    public List<Map<String, Object>> selectTagByIdList(List<String> TAG_ID_LIST);

    /**
     * 新增对象。
     */
    public int insertTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_);

    /**
     * 修改对象。
     */
    public int updateTag(String TAG_ID_, String OBJ_ID_, String OBJ_TYPE_, String TAG_);

    /**
     * 修改对象的所有标签。
     */
    public void updateTagByObjId(String OBJ_ID_, String OBJ_TYPE_, String TAG_);

    /**
     * 删除对象。
     */
    public int deleteTag(String TAG_ID_);

    /**
     * 删除对象。
     */
    public int deleteTagByObjId(String OBJ_ID_);

    /**
     * 分割标签字符串。
     */
    public List<String> splitTag(String TAG_);
}