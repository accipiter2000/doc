 
 

/*==============================================================*/
/* Table: CB_CODE                                               */
/*==============================================================*/
create table CB_CODE
(
   CODE_ID_             varchar(40) not null comment '代码ID',
   PARENT_CODE_ID_      varchar(40) comment '上级代码ID',
   CATEGORY_            varchar(40) not null comment '分类',
   CODE_                varchar(60) not null comment '代码',
   NAME_                varchar(60) comment '名称',
   EXT_ATTR_1_          varchar(60) comment '扩展属性1',
   EXT_ATTR_2_          varchar(60) comment '扩展属性2',
   EXT_ATTR_3_          varchar(60) comment '扩展属性3',
   EXT_ATTR_4_          varchar(60) comment '扩展属性4',
   EXT_ATTR_5_          varchar(60) comment '扩展属性5',
   EXT_ATTR_6_          varchar(60) comment '扩展属性6',
   ORDER_               numeric(8,0) comment '排序',
   primary key (CODE_ID_),
   key UQ_CODE (CATEGORY_, CODE_)
);

alter table CB_CODE comment '代码';

/*==============================================================*/
/* Table: CB_CUSTOM_THEME                                       */
/*==============================================================*/
create table CB_CUSTOM_THEME
(
   CUSTOM_THEME_ID_     varchar(40) not null comment '定制主题ID',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   CSS_HREF_            varchar(60) comment 'CSS链接',
   primary key (CUSTOM_THEME_ID_),
   key UQ_CUSTOM_THEME (OPERATOR_ID_)
);

alter table CB_CUSTOM_THEME comment '定制主题';

/*==============================================================*/
/* Table: CB_DASHBOARD                                          */
/*==============================================================*/
create table CB_DASHBOARD
(
   DASHBOARD_ID_        varchar(40) not null comment '仪表盘ID',
   DASHBOARD_MODULE_ID_ varchar(40) not null comment '仪表盘模块ID',
   POSI_EMP_ID_         varchar(40) comment '岗位人员ID',
   DASHBOARD_MODULE_NAME_ varchar(60) not null comment '仪表盘模块名称',
   URL_                 varchar(300) not null comment '链接',
   WIDTH_               varchar(10) not null comment '宽度',
   HEIGHT_              varchar(10) not null comment '高度',
   ORDER_               numeric(8,0) comment '排序',
   primary key (DASHBOARD_ID_)
);

alter table CB_DASHBOARD comment '仪表盘';

/*==============================================================*/
/* Table: CB_DASHBOARD_MODULE                                   */
/*==============================================================*/
create table CB_DASHBOARD_MODULE
(
   DASHBOARD_MODULE_ID_ varchar(40) not null comment '仪表盘模块ID',
   DASHBOARD_MODULE_NAME_ varchar(60) not null comment '仪表盘模块名称',
   DASHBOARD_MODULE_TYPE_ varchar(60) comment '仪表盘模块类型',
   DEFAULT_URL_         varchar(300) not null comment '默认链接',
   DEFAULT_WIDTH_       varchar(10) not null comment '默认宽度',
   DEFAULT_HEIGHT_      varchar(10) not null comment '默认高度',
   DASHBOARD_MODULE_TAG_ varchar(60) comment '仪表盘模块标签',
   ORDER_               numeric(8,0) comment '排序',
   DASHBOARD_MODULE_STATUS_ varchar(20) not null comment '仪表盘模块状态',
   primary key (DASHBOARD_MODULE_ID_)
);

alter table CB_DASHBOARD_MODULE comment '仪表盘模块';

/*==============================================================*/
/* Table: CB_DUTY_MENU                                          */
/*==============================================================*/
create table CB_DUTY_MENU
(
   DUTY_MENU_ID_        varchar(40) not null comment '职务菜单ID',
   DUTY_ID_             varchar(40) not null comment '职务ID',
   DUTY_NAME_           varchar(60) comment '职务名称',
   MENU_ID_             varchar(40) not null comment '菜单ID',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (DUTY_MENU_ID_),
   key UQ_DUTY_MENU (DUTY_ID_, MENU_ID_)
);

alter table CB_DUTY_MENU comment '职务菜单';

/*==============================================================*/
/* Index: IX_DUTY_MENU_DUTY                                     */
/*==============================================================*/
create index IX_DUTY_MENU_DUTY on CB_DUTY_MENU
(
   DUTY_ID_
);

/*==============================================================*/
/* Table: CB_LOG                                                */
/*==============================================================*/
create table CB_LOG
(
   LOG_ID_              varchar(40) not null comment '日志ID',
   CATEGORY_            varchar(60) comment '分类',
   IP_                  varchar(60) comment 'IP',
   URL_                 text comment '调用URL',
   ACTION_              varchar(200) comment '调用控制层接口',
   PARAMETER_MAP_       text comment '调用参数',
   BUSINESS_KEY_        varchar(100) comment '业务主键',
   ERROR_               varchar(20) comment '错误',
   MESSAGE_             text comment '信息',
   ORG_ID_              varchar(40) comment '机构ID',
   ORG_NAME_            varchar(60) comment '机构名称',
   POSI_ID_             varchar(40) comment '岗位ID',
   POSI_NAME_           varchar(60) comment '岗位名称',
   EMP_ID_              varchar(40) comment '人员ID',
   EMP_NAME_            varchar(60) comment '人员名称',
   CREATION_DATE_       datetime not null comment '创建日期',
   USER_AGENT_          varchar(400) comment '用户代理',
   primary key (LOG_ID_)
);

alter table CB_LOG comment '日志';

/*==============================================================*/
/* Index: IX_LOG_ACTION                                         */
/*==============================================================*/
create index IX_LOG_ACTION on CB_LOG
(
   ACTION_
);

/*==============================================================*/
/* Index: IX_LOG_BUSINESS_KEY                                   */
/*==============================================================*/
create index IX_LOG_BUSINESS_KEY on CB_LOG
(
   BUSINESS_KEY_
);

/*==============================================================*/
/* Index: IX_LOG_CREATION_DATE                                  */
/*==============================================================*/
create index IX_LOG_CREATION_DATE on CB_LOG
(
   CREATION_DATE_
);

/*==============================================================*/
/* Table: CB_MENU                                               */
/*==============================================================*/
create table CB_MENU
(
   MENU_ID_             varchar(40) not null comment '菜单ID',
   PARENT_MENU_ID_      varchar(40) comment '上级菜单ID',
   MENU_NAME_           varchar(60) not null comment '菜单名称',
   MENU_TYPE_           varchar(20) not null comment '菜单类型',
   URL_                 varchar(200) comment '链接地址',
   ORDER_               numeric(8,0) comment '排序',
   MENU_STATUS_         varchar(20) not null comment '菜单状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   ICON_                varchar(40) comment '图标地址',
   primary key (MENU_ID_)
);

alter table CB_MENU comment '菜单';

/*==============================================================*/
/* Table: CB_NOTICE                                             */
/*==============================================================*/
create table CB_NOTICE
(
   NOTICE_ID_           varchar(40) not null comment '通知ID',
   POSI_EMP_ID_         varchar(40) comment '岗位人员ID',
   EMP_ID_              varchar(40) comment '人员ID',
   EMP_CODE_            varchar(60) comment '人员编码',
   EMP_NAME_            varchar(60) comment '人员名称',
   CONTENT_             varchar(600) not null comment '内容',
   SOURCE_              varchar(60) comment '来源',
   IDENTITY_            varchar(40) comment '令牌',
   REDIRECT_URL_        varchar(200) comment '重定向链接',
   BIZ_URL_             varchar(500) comment '业务链接',
   EXP_DATE_            datetime comment '过期日期',
   NOTICE_STATUS_       varchar(20) not null comment '通知状态',
   CREATION_DATE_       datetime not null comment '创建日期',
   primary key (NOTICE_ID_)
);

alter table CB_NOTICE comment '通知';

/*==============================================================*/
/* Table: CB_POSI_EMP_MENU                                      */
/*==============================================================*/
create table CB_POSI_EMP_MENU
(
   POSI_EMP_MENU_ID_    varchar(40) not null comment '岗位人员菜单ID',
   POSI_EMP_ID_         varchar(40) not null comment '岗位人员ID',
   POSI_NAME_           varchar(60) comment '岗位名称',
   EMP_NAME_            varchar(60) comment '人员名称',
   MENU_ID_             varchar(40) not null comment '菜单ID',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (POSI_EMP_MENU_ID_)
);

alter table CB_POSI_EMP_MENU comment '岗位人员菜单';

/*==============================================================*/
/* Index: IX_POSI_EMP_MENU_POSI                                 */
/*==============================================================*/
create index IX_POSI_EMP_MENU_POSI on CB_POSI_EMP_MENU
(
   POSI_EMP_ID_
);

/*==============================================================*/
/* Table: CB_POSI_MENU                                          */
/*==============================================================*/
create table CB_POSI_MENU
(
   POSI_MENU_ID_        varchar(40) not null comment '岗位菜单ID',
   POSI_ID_             varchar(40) not null comment '岗位ID',
   POSI_NAME_           varchar(60) comment '岗位名称',
   MENU_ID_             varchar(40) not null comment '菜单ID',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (POSI_MENU_ID_)
);

alter table CB_POSI_MENU comment '岗位菜单';

/*==============================================================*/
/* Index: IX_POSI_MENU_POSI                                     */
/*==============================================================*/
create index IX_POSI_MENU_POSI on CB_POSI_MENU
(
   POSI_ID_
);

/*==============================================================*/
/* Table: CB_RIDER                                              */
/*==============================================================*/
create table CB_RIDER
(
   RIDER_ID_            varchar(40) not null comment '附件ID',
   OBJ_ID_              varchar(40) comment '对象ID',
   RIDER_FILE_          longblob not null comment '附件文件',
   RIDER_FILE_NAME_     varchar(300) comment '附件文件名称',
   RIDER_FILE_LENGTH_   numeric(8,0) comment '附件文件长度',
   MEMO_                varchar(300) comment '备注',
   RIDER_TAG_           varchar(120) comment '附件标签',
   ORDER_               numeric(8,0) comment '排序',
   RIDER_STATUS_        varchar(20) not null comment '附件状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (RIDER_ID_)
);

alter table CB_RIDER comment '附件';

/*==============================================================*/
/* Table: CB_TAG                                                */
/*==============================================================*/
create table CB_TAG
(
   TAG_ID_              varchar(40) not null comment '标签ID',
   OBJ_ID_              varchar(40) not null comment '对象ID',
   OBJ_TYPE_            varchar(60) comment '对象类型',
   TAG_                 varchar(60) not null comment '标签',
   primary key (TAG_ID_)
);

alter table CB_TAG comment '标签';

/*==============================================================*/
/* Table: CB_WORKING_CALENDAR                                   */
/*==============================================================*/
create table CB_WORKING_CALENDAR
(
   WORKING_CALENDAR_ID_ varchar(40) not null comment '工作日历ID',
   EMP_ID_              varchar(40) comment '人员ID',
   DATE_                datetime not null comment '日期',
   WORKING_DAY_         varchar(20) not null comment '工作日',
   MARK_                varchar(300) comment '标注',
   primary key (WORKING_CALENDAR_ID_),
   key UQ_WORKING_CALENDAR (EMP_ID_, DATE_)
);

alter table CB_WORKING_CALENDAR comment '工作日历';

/*==============================================================*/
/* Table: FF_ADJUST_PROC_DEF                                    */
/*==============================================================*/
create table FF_ADJUST_PROC_DEF
(
   ADJUST_PROC_DEF_ID_  varchar(40) not null comment '调整流程定义ID',
   PROC_DEF_ID_         varchar(40) not null comment '流程定义ID',
   PROC_DEF_MODEL_      text not null comment '流程定义模型',
   PROC_DEF_DIAGRAM_FILE_ longblob comment '流程定义图文件',
   PROC_DEF_DIAGRAM_FILE_NAME_ varchar(300) comment '流程定义图文件名称',
   PROC_DEF_DIAGRAM_FILE_LENGTH_ numeric(8,0) comment '流程定义图文件长度',
   PROC_DEF_DIAGRAM_WIDTH_ numeric(8,0) comment '流程定义图宽度',
   PROC_DEF_DIAGRAM_HEIGHT_ numeric(8,0) comment '流程定义图高度',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ADJUST_PROC_DEF_ID_)
);

alter table FF_ADJUST_PROC_DEF comment '调整流程定义';

/*==============================================================*/
/* Table: FF_DELEGATE                                           */
/*==============================================================*/
create table FF_DELEGATE
(
   DELEGATE_ID_         varchar(40) not null comment '代理ID',
   ASSIGNEE_            varchar(60) comment '办理人',
   ASSIGNEE_NAME_       varchar(60) comment '办理人名称',
   DELEGATOR_           varchar(60) not null comment '代理人',
   DELEGATOR_NAME_      varchar(60) comment '代理人名称',
   START_DATE_          datetime comment '开始日期',
   END_DATE_            datetime comment '结束日期',
   primary key (DELEGATE_ID_)
);

alter table FF_DELEGATE comment '代理';

/*==============================================================*/
/* Table: FF_NODE                                               */
/*==============================================================*/
create table FF_NODE
(
   NODE_ID_             varchar(40) not null comment '节点ID',
   PARENT_NODE_ID_      varchar(40) comment '上级节点ID',
   PROC_ID_             varchar(40) not null comment '流程ID',
   PREVIOUS_NODE_IDS_   varchar(280) comment '前节点IDs',
   LAST_COMPLETE_NODE_IDS_ varchar(280) comment '最后完成节点IDs',
   SUB_PROC_DEF_ID_     varchar(40) comment '子流程定义ID',
   ADJUST_SUB_PROC_DEF_ID_ varchar(40) comment '调整子流程定义ID',
   NODE_TYPE_           varchar(20) not null comment '节点类型',
   NODE_CODE_           varchar(60) comment '节点编码',
   NODE_NAME_           varchar(60) comment '节点名称',
   PARENT_NODE_CODE_    varchar(100) comment '上级节点编码',
   CANDIDATE_ASSIGNEE_  varchar(200) comment '候选人',
   COMPLETE_EXPRESSION_ varchar(200) comment '完成表达式',
   COMPLETE_RETURN_     varchar(200) comment '完成后返回前一个节点',
   EXCLUSIVE_           varchar(200) comment '排他',
   AUTO_COMPLETE_SAME_ASSIGNEE_ varchar(200) comment '自动完成相同办理人任务',
   AUTO_COMPLETE_EMPTY_ASSIGNEE_ varchar(200) comment '自动完成没有办理人节点',
   INFORM_              varchar(200) comment '通知',
   ASSIGNEE_            varchar(200) comment '办理人',
   ACTION_              varchar(300) comment '业务行为',
   DUE_DATE_            varchar(200) comment '截止日期',
   CLAIM_               varchar(200) comment '认领',
   FORWARDABLE_         varchar(200) comment '可转发',
   PRIORITY_            varchar(200) comment '优先级',
   NODE_END_USER_       varchar(40) comment '节点完成人员',
   NODE_END_USER_NAME_  varchar(60) comment '节点完成人员名称',
   NODE_END_DATE_       datetime comment '节点完成日期',
   NEXT_CANDIDATE_      text comment '下个候选人',
   ISOLATE_SUB_PROC_DEF_CODE_ varchar(60) comment '独立子流程定义编码',
   ISOLATE_SUB_PROC_CANDIDATE_ varchar(500) comment '独立子流程候选人',
   ISOLATE_SUB_PROC_STATUS_ varchar(60) comment '独立子流程状态',
   NODE_STATUS_         varchar(20) not null comment '节点状态',
   CREATION_DATE_       datetime not null comment '创建日期',
   primary key (NODE_ID_)
);

alter table FF_NODE comment '节点';

/*==============================================================*/
/* Table: FF_NODE_OP                                            */
/*==============================================================*/
create table FF_NODE_OP
(
   NODE_OP_ID_          varchar(40) not null comment '节点操作ID',
   OPERATION_ID_        varchar(40) not null comment '操作ID',
   OPERATION_TYPE_      varchar(20) not null comment '操作类型',
   OPERATION_ORDER_     numeric(8,0) comment '操作顺序',
   OPERATION_DATE_      datetime comment '操作日期',
   OPERATION_STATUS_    varchar(20) comment '操作状态',
   NODE_ID_             varchar(40) not null comment '节点ID',
   PARENT_NODE_ID_      varchar(40) comment '上级节点ID',
   PROC_ID_             varchar(40) comment '流程ID',
   PREVIOUS_NODE_IDS_   varchar(280) comment '前节点IDs',
   LAST_COMPLETE_NODE_IDS_ varchar(280) comment '最后完成节点IDs',
   SUB_PROC_DEF_ID_     varchar(40) comment '子流程定义ID',
   ADJUST_SUB_PROC_DEF_ID_ varchar(40) comment '调整子流程定义ID',
   NODE_TYPE_           varchar(20) comment '节点类型',
   NODE_CODE_           varchar(60) comment '节点编码',
   NODE_NAME_           varchar(60) comment '节点名称',
   PARENT_NODE_CODE_    varchar(60) comment '上级节点编码',
   CANDIDATE_ASSIGNEE_  varchar(200) comment '候选人',
   COMPLETE_EXPRESSION_ varchar(200) comment '完成表达式',
   COMPLETE_RETURN_     varchar(200) comment '完成后返回前一个节点',
   EXCLUSIVE_           varchar(200) comment '排他',
   AUTO_COMPLETE_SAME_ASSIGNEE_ varchar(200) comment '自动完成相同办理人任务',
   AUTO_COMPLETE_EMPTY_ASSIGNEE_ varchar(200) comment '自动完成没有办理人节点',
   INFORM_              varchar(200) comment '通知',
   ASSIGNEE_            varchar(200) comment '办理人',
   ACTION_              varchar(200) comment '业务行为',
   DUE_DATE_            varchar(200) comment '截止日期',
   CLAIM_               varchar(200) comment '认领',
   FORWARDABLE_         varchar(200) comment '可转发',
   PRIORITY_            varchar(200) comment '优先级',
   NODE_END_USER_       varchar(40) comment '节点完成人员',
   NODE_END_USER_NAME_  varchar(60) comment '节点完成人员名称',
   NODE_END_DATE_       datetime comment '节点完成日期',
   NEXT_CANDIDATE_      text comment '下个候选人',
   ISOLATE_SUB_PROC_DEF_CODE_ varchar(60) comment '独立子流程定义编码',
   ISOLATE_SUB_PROC_CANDIDATE_ varchar(500) comment '独立子流程候选人',
   ISOLATE_SUB_PROC_STATUS_ varchar(60) comment '独立子流程状态',
   NODE_STATUS_         varchar(20) comment '节点状态',
   CREATION_DATE_       datetime comment '创建日期',
   primary key (NODE_OP_ID_)
);

alter table FF_NODE_OP comment '节点操作';

/*==============================================================*/
/* Table: FF_NODE_VAR                                           */
/*==============================================================*/
create table FF_NODE_VAR
(
   NODE_VAR_ID_         varchar(40) not null comment '节点变量ID',
   NODE_ID_             varchar(40) not null comment '节点ID',
   VAR_TYPE_            varchar(20) not null comment '变量类型',
   VAR_NAME_            varchar(60) not null comment '变量名称',
   VALUE_               varchar(3000) comment '值',
   OBJ_                 longblob comment '对象',
   CREATION_DATE_       datetime not null comment '创建日期',
   primary key (NODE_VAR_ID_)
);

alter table FF_NODE_VAR comment '节点变量';

/*==============================================================*/
/* Index: IX_SUB_PROC_VAR_NAME                                  */
/*==============================================================*/
create index IX_SUB_PROC_VAR_NAME on FF_NODE_VAR
(
   VAR_NAME_
);

/*==============================================================*/
/* Table: FF_NODE_VAR_OP                                        */
/*==============================================================*/
create table FF_NODE_VAR_OP
(
   NODE_VAR_OP_ID_      varchar(40) not null comment '节点变量操作ID',
   OPERATION_ID_        varchar(40) not null comment '操作ID',
   OPERATION_TYPE_      varchar(20) not null comment '操作类型',
   OPERATION_ORDER_     numeric(8,0) comment '操作顺序',
   OPERATION_DATE_      datetime comment '操作日期',
   OPERATION_STATUS_    varchar(20) comment '操作状态',
   NODE_VAR_ID_         varchar(40) not null comment '节点变量ID',
   NODE_ID_             varchar(40) comment '节点ID',
   VAR_TYPE_            varchar(20) comment '变量类型',
   VAR_NAME_            varchar(60) comment '变量名称',
   VALUE_               varchar(3000) comment '值',
   OBJ_                 longblob comment '对象',
   CREATION_DATE_       datetime comment '创建日期',
   primary key (NODE_VAR_OP_ID_)
);

alter table FF_NODE_VAR_OP comment '节点变量操作';

/*==============================================================*/
/* Table: FF_OPERATION                                          */
/*==============================================================*/
create table FF_OPERATION
(
   OPERATION_ID_        varchar(40) not null comment '操作ID',
   OPERATION_           varchar(40) not null comment '操作',
   PROC_ID_             varchar(40) comment '流程ID',
   NODE_ID_             varchar(40) comment '节点ID',
   TASK_ID_             varchar(40) comment '任务ID',
   MEMO_                varchar(1000) comment '备注',
   OPERATOR_            varchar(40) comment '操作人',
   OPERATOR_NAME_       varchar(60) comment '操作人名称',
   OPERATION_DATE_      datetime not null comment '操作日期',
   OPERATION_STATUS_    varchar(20) not null comment '操作状态',
   primary key (OPERATION_ID_)
);

alter table FF_OPERATION comment '操作';

/*==============================================================*/
/* Table: FF_OPERATION_FOLLOW_UP                                */
/*==============================================================*/
create table FF_OPERATION_FOLLOW_UP
(
   OPERATION_FOLLOW_UP_ID_ varchar(40) not null comment '操作后续ID',
   OPERATION_ID_        varchar(40) not null comment '操作ID',
   FOLLOW_UP_OPERATION_ID_ varchar(40) not null comment '后续操作ID',
   OPERATION_DATE_      datetime not null comment '操作日期',
   primary key (OPERATION_FOLLOW_UP_ID_)
);

alter table FF_OPERATION_FOLLOW_UP comment '操作后续';

/*==============================================================*/
/* Table: FF_PROC                                               */
/*==============================================================*/
create table FF_PROC
(
   PROC_ID_             varchar(40) not null comment '流程ID',
   PROC_DEF_ID_         varchar(40) not null comment '流程定义ID',
   ADJUST_PROC_DEF_ID_  varchar(40) comment '调整流程定义ID',
   ISOLATE_SUB_PROC_NODE_ID_ varchar(40) comment '独立子流程所属节点ID',
   BIZ_ID_              varchar(40) comment '业务主键',
   BIZ_TYPE_            varchar(60) comment '业务类型',
   BIZ_CODE_            varchar(100) comment '业务编码',
   BIZ_NAME_            varchar(100) comment '业务名称',
   BIZ_DESC_            varchar(300) comment '业务备注',
   PROC_START_USER_     varchar(40) comment '流程开始人员',
   PROC_START_USER_NAME_ varchar(60) comment '流程开始人员名称',
   PROC_END_USER_       varchar(40) comment '流程完成人员',
   PROC_END_USER_NAME_  varchar(60) comment '流程完成人员名称',
   PROC_END_DATE_       datetime comment '流程完成日期',
   PROC_STATUS_         varchar(20) not null comment '流程状态',
   CREATION_DATE_       datetime not null comment '创建日期',
   primary key (PROC_ID_)
);

alter table FF_PROC comment '流程';

/*==============================================================*/
/* Table: FF_PROC_DEF                                           */
/*==============================================================*/
create table FF_PROC_DEF
(
   PROC_DEF_ID_         varchar(40) not null comment '流程定义ID',
   PROC_DEF_CODE_       varchar(60) not null comment '流程定义编码',
   PROC_DEF_NAME_       varchar(60) not null comment '流程定义名称',
   PROC_DEF_CAT_        varchar(100) comment '流程定义分类',
   PROC_DEF_MODEL_      text not null comment '流程定义模型',
   PROC_DEF_DIAGRAM_FILE_ longblob comment '流程定义图文件',
   PROC_DEF_DIAGRAM_FILE_NAME_ varchar(300) comment '流程定义图文件名称',
   PROC_DEF_DIAGRAM_FILE_LENGTH_ numeric(8,0) comment '流程定义图文件长度',
   PROC_DEF_DIAGRAM_WIDTH_ numeric(8,0) comment '流程定义图宽度',
   PROC_DEF_DIAGRAM_HEIGHT_ numeric(8,0) comment '流程定义图高度',
   MEMO_                varchar(300) comment '备注',
   VERSION_             numeric(8,0) not null comment '版本',
   PROC_DEF_STATUS_     varchar(20) not null comment '流程定义状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (PROC_DEF_ID_),
   key UQ_FF_PROC_DEF (PROC_DEF_CODE_, VERSION_)
);

alter table FF_PROC_DEF comment '流程定义';

/*==============================================================*/
/* Table: FF_PROC_OP                                            */
/*==============================================================*/
create table FF_PROC_OP
(
   PROC_OP_ID_          varchar(40) not null comment '流程操作ID',
   OPERATION_ID_        varchar(40) not null comment '操作ID',
   OPERATION_TYPE_      varchar(20) not null comment '操作类型',
   OPERATION_ORDER_     numeric(8,0) comment '操作顺序',
   OPERATION_DATE_      datetime comment '操作日期',
   OPERATION_STATUS_    varchar(20) comment '操作状态',
   PROC_ID_             varchar(40) not null comment '流程ID',
   PROC_DEF_ID_         varchar(40) comment '流程定义ID',
   ADJUST_PROC_DEF_ID_  varchar(40) comment '调整流程定义ID',
   ISOLATE_SUB_PROC_NODE_ID_ varchar(40) comment '独立子流程所属节点ID',
   BIZ_ID_              varchar(40) comment '业务主键',
   BIZ_TYPE_            varchar(60) comment '业务类型',
   BIZ_CODE_            varchar(100) comment '业务编码',
   BIZ_NAME_            varchar(100) comment '业务名称',
   BIZ_DESC_            varchar(300) comment '业务备注',
   PROC_START_USER_     varchar(40) comment '流程开始人员',
   PROC_START_USER_NAME_ varchar(60) comment '流程开始人员名称',
   PROC_END_USER_       varchar(40) comment '流程完成人员',
   PROC_END_USER_NAME_  varchar(60) comment '流程完成人员名称',
   PROC_END_DATE_       datetime comment '流程完成日期',
   PROC_STATUS_         varchar(20) comment '流程状态',
   CREATION_DATE_       datetime comment '创建日期',
   primary key (PROC_OP_ID_)
);

alter table FF_PROC_OP comment '流程操作';

/*==============================================================*/
/* Table: FF_TASK                                               */
/*==============================================================*/
create table FF_TASK
(
   TASK_ID_             varchar(40) not null comment '任务ID',
   NODE_ID_             varchar(40) comment '节点ID',
   PREVIOUS_TASK_ID_    varchar(40) comment '前一个任务ID',
   TASK_TYPE_           varchar(20) not null comment '任务类型',
   ASSIGNEE_            varchar(40) comment '办理人',
   ASSIGNEE_NAME_       varchar(60) comment '办理人名称',
   ACTION_              varchar(300) comment '业务行为',
   DUE_DATE_            datetime comment '截止日期',
   CLAIM_               varchar(20) not null comment '认领',
   FORWARDABLE_         varchar(20) not null comment '可转发',
   PRIORITY_            numeric(8,0) not null comment '优先级',
   FORWARD_STATUS_      varchar(20) not null comment '转发状态',
   TASK_END_USER_       varchar(40) comment '任务完成人员',
   TASK_END_USER_NAME_  varchar(60) comment '任务完成人员名称',
   TASK_END_DATE_       datetime comment '任务完成日期',
   NEXT_CANDIDATE_      text comment '下个候选人',
   TASK_STATUS_         varchar(20) not null comment '任务状态',
   CREATION_DATE_       datetime not null comment '创建日期',
   primary key (TASK_ID_)
);

alter table FF_TASK comment '任务';

/*==============================================================*/
/* Table: FF_TASK_OP                                            */
/*==============================================================*/
create table FF_TASK_OP
(
   TASK_OP_ID_          varchar(40) not null comment '任务操作ID',
   OPERATION_ID_        varchar(40) not null comment '操作ID',
   OPERATION_TYPE_      varchar(20) not null comment '操作类型',
   OPERATION_ORDER_     numeric(8,0) comment '操作顺序',
   OPERATION_DATE_      datetime comment '操作日期',
   OPERATION_STATUS_    varchar(20) comment '操作状态',
   TASK_ID_             varchar(40) not null comment '任务ID',
   NODE_ID_             varchar(40) comment '节点ID',
   PREVIOUS_TASK_ID_    varchar(40) comment '前一个任务ID',
   TASK_TYPE_           varchar(20) comment '任务类型',
   ASSIGNEE_            varchar(40) comment '办理人',
   ASSIGNEE_NAME_       varchar(60) comment '办理人名称',
   ACTION_              varchar(300) comment '业务行为',
   DUE_DATE_            datetime comment '截止日期',
   CLAIM_               varchar(20) comment '认领',
   FORWARDABLE_         varchar(20) comment '可转发',
   PRIORITY_            numeric(8,0) comment '优先级',
   FORWARD_STATUS_      varchar(20) comment '转发状态',
   TASK_END_USER_       varchar(40) comment '任务完成人员',
   TASK_END_USER_NAME_  varchar(60) comment '任务完成人员名称',
   TASK_END_DATE_       datetime comment '任务完成日期',
   NEXT_CANDIDATE_      text comment '下个候选人',
   TASK_STATUS_         varchar(20) comment '任务状态',
   CREATION_DATE_       datetime comment '创建日期',
   primary key (TASK_OP_ID_)
);

alter table FF_TASK_OP comment '任务操作';

/*==============================================================*/
/* Table: K_APPROVAL_MEMO                                       */
/*==============================================================*/
create table K_APPROVAL_MEMO
(
   APPROVAL_MEMO_ID_    varchar(40) not null comment '审批意见ID',
   TASK_ID_             varchar(40) comment '任务ID',
   PREVIOUS_TASK_ID_    varchar(40) comment '前一个任务ID',
   NODE_ID_             varchar(40) comment '节点ID',
   NODE_TYPE_           varchar(60) comment '节点类型',
   NODE_NAME_           varchar(60) comment '节点名称',
   PARENT_NODE_ID_      varchar(40) comment '上级节点ID',
   PROC_ID_             varchar(40) not null comment '流程ID',
   BIZ_ID_              varchar(40) comment '业务ID',
   ASSIGNEE_            varchar(40) comment '办理人',
   ASSIGNEE_CODE_       varchar(40) comment '办理人编码',
   ASSIGNEE_NAME_       varchar(60) comment '办理人名称',
   EXECUTOR_            varchar(40) comment '执行人',
   EXECUTOR_CODE_       varchar(40) comment '执行人编码',
   EXECUTOR_NAME_       varchar(60) comment '执行人名称',
   ORG_ID_              varchar(40) comment '机构ID',
   ORG_NAME_            varchar(60) comment '机构名称',
   COM_ID_              varchar(40) comment '公司ID',
   COM_NAME_            varchar(60) comment '公司名称',
   CREATION_DATE_       datetime not null comment '创建日期',
   DUE_DATE_            datetime comment '截止日期',
   APPROVAL_MEMO_TYPE_  varchar(20) comment '审批意见类型',
   APPROVAL_MEMO_       varchar(1000) comment '审批意见',
   APPROVAL_DATE_       datetime comment '审批日期',
   APPROVAL_MEMO_SOURCE_ varchar(40) comment '审批意见数据源',
   APPROVAL_MEMO_STATUS_ varchar(20) not null comment '审批状态',
   OPERATION_ID_        varchar(40) comment '操作ID',
   primary key (APPROVAL_MEMO_ID_)
);

alter table K_APPROVAL_MEMO comment '审批意见';

/*==============================================================*/
/* Table: K_CUSTOM_APPROVAL_MEMO                                */
/*==============================================================*/
create table K_CUSTOM_APPROVAL_MEMO
(
   CUSTOM_APPROVAL_MEMO_ID_ varchar(40) not null comment '常用审批意见ID',
   EMP_ID_              varchar(40) not null comment '人员ID',
   APPROVAL_MEMO_       varchar(300) not null comment '审批意见',
   DEFAULT_             varchar(20) comment '缺省',
   ORDER_               numeric(8,0) comment '排序',
   primary key (CUSTOM_APPROVAL_MEMO_ID_)
);

alter table K_CUSTOM_APPROVAL_MEMO comment '常用审批意见';

/*==============================================================*/
/* Table: K_CUSTOM_DOC_TYPE                                     */
/*==============================================================*/
create table K_CUSTOM_DOC_TYPE
(
   CUSTOM_DOC_TYPE_ID_  varchar(40) not null comment '常用公文类型ID',
   EMP_ID_              varchar(40) not null comment '人员ID',
   DOC_TYPE_ID_         varchar(40) not null comment '公文类型ID',
   primary key (CUSTOM_DOC_TYPE_ID_),
   key UQ_CUSTOM_DOC_TYPE (EMP_ID_, DOC_TYPE_ID_)
);

alter table K_CUSTOM_DOC_TYPE comment '常用公文类型';

/*==============================================================*/
/* Table: K_DOC                                                 */
/*==============================================================*/
create table K_DOC
(
   DOC_ID_              varchar(40) not null comment '公文ID',
   DOC_CODE_            varchar(60) comment '公文编码',
   DOC_NAME_            varchar(60) comment '公文名称',
   DOC_TYPE_NAME_       varchar(60) comment '公文类型名称',
   OWNER_ID_            varchar(40) comment '所有人ID',
   OWNER_NAME_          varchar(60) comment '所有人名称',
   OWNER_ORG_ID_        varchar(40) comment '所有机构ID',
   OWNER_ORG_NAME_      varchar(60) comment '所有机构名称',
   MEMO_                varchar(300) comment '备注',
   TEMPLATE_FILE_       longblob comment '模版文件',
   TEMPLATE_FILE_NAME_  varchar(300) comment '模版文件名称',
   TEMPLATE_FILE_LENGTH_ numeric(8,0) comment '模版文件长度',
   DOC_FILE_            longblob comment '公文文件',
   DOC_FILE_NAME_       varchar(300) comment '公文文件名称',
   DOC_FILE_LENGTH_     numeric(8,0) comment '公文文件长度',
   HTML_                text comment 'HTML',
   BOOKMARK_            text comment '标签',
   INDEX_               varchar(1000) comment '定位',
   USING_TEMPLATE_      varchar(20) not null comment '使用模板生成',
   PROC_DEF_CODE_       varchar(60) comment '流程定义编码',
   PROC_ID_             varchar(40) comment '流程ID',
   PROC_STATUS_         varchar(20) comment '流程状态(0草稿/1审批中/8审批驳回/9审批通过)',
   VERSION_             numeric(8,0) not null comment '版本',
   DOC_STATUS_          varchar(20) not null comment '公文状态(1生效/0废弃)',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   EFFECTIVE_DATE_      datetime comment '生效日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (DOC_ID_),
   key UQ_DOC_CODE (DOC_CODE_)
);

alter table K_DOC comment '公文';

/*==============================================================*/
/* Table: K_DOC_DATA                                            */
/*==============================================================*/
create table K_DOC_DATA
(
   DOC_DATA_ID_         varchar(40) not null comment '公文数据ID',
   DOC_ID_              varchar(40) not null comment '公文ID',
   BOOKMARK_            varchar(60) not null comment '标签',
   VALUE_               varchar(1000) comment '内容',
   DATA_TYPE_           varchar(20) comment '数据类型',
   ORDER_               numeric(8,0) comment '排序',
   primary key (DOC_DATA_ID_)
);

alter table K_DOC_DATA comment '公文数据';

/*==============================================================*/
/* Table: K_DOC_DATA_HIS                                        */
/*==============================================================*/
create table K_DOC_DATA_HIS
(
   DOC_DATA_HIS_ID_     varchar(40) not null comment '公文数据历史ID',
   DOC_DATA_ID_         varchar(40) comment '公文数据ID',
   DOC_ID_              varchar(40) comment '公文ID',
   BOOKMARK_            varchar(60) comment '标签',
   VALUE_               varchar(1000) comment '内容',
   DATA_TYPE_           varchar(20) comment '数据类型',
   ORDER_               numeric(8,0) comment '排序',
   VERSION_             numeric(8,0) comment '版本',
   HIS_DATE_            datetime comment '历史日期',
   primary key (DOC_DATA_HIS_ID_)
);

alter table K_DOC_DATA_HIS comment '公文数据历史';

/*==============================================================*/
/* Table: K_DOC_HIS                                             */
/*==============================================================*/
create table K_DOC_HIS
(
   DOC_HIS_ID_          varchar(40) not null comment '公文历史ID',
   DOC_ID_              varchar(40) not null comment '公文ID',
   DOC_CODE_            varchar(60) comment '公文编码',
   DOC_NAME_            varchar(60) comment '公文名称',
   DOC_TYPE_NAME_       varchar(60) comment '公文类型名称',
   OWNER_ID_            varchar(40) comment '所有人ID',
   OWNER_NAME_          varchar(60) comment '所有人名称',
   OWNER_ORG_ID_        varchar(40) comment '所有机构ID',
   OWNER_ORG_NAME_      varchar(60) comment '所有机构名称',
   MEMO_                varchar(300) comment '备注',
   TEMPLATE_FILE_       longblob comment '模版文件',
   TEMPLATE_FILE_NAME_  varchar(300) comment '模版文件名称',
   TEMPLATE_FILE_LENGTH_ numeric(8,0) comment '模版文件长度',
   DOC_FILE_            longblob comment '公文文件',
   DOC_FILE_NAME_       varchar(300) comment '公文文件名称',
   DOC_FILE_LENGTH_     numeric(8,0) comment '公文文件长度',
   HTML_                text comment 'HTML',
   BOOKMARK_            text comment '标签',
   INDEX_               varchar(1000) comment '定位',
   USING_TEMPLATE_      varchar(20) not null comment '使用模板生成',
   PROC_DEF_CODE_       varchar(60) comment '流程定义编码',
   PROC_ID_             varchar(40) comment '流程ID',
   PROC_STATUS_         varchar(20) comment '流程状态(0草稿/1审批中/8审批驳回/9审批通过)',
   VERSION_             numeric(8,0) not null comment '版本',
   DOC_STATUS_          varchar(20) not null comment '公文状态(1生效/0废弃)',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   EFFECTIVE_DATE_      datetime comment '生效日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   HIS_DATE_            datetime comment '历史日期',
   DOC_FILE_DIFF_       text comment '公文文件区别',
   DOC_DATA_DIFF_       text comment '公文数据区别',
   DOC_RIDER_DIFF_      varchar(1000) comment '公文附件区别',
   primary key (DOC_HIS_ID_),
   key UQ_DOC_HIS (DOC_ID_, VERSION_)
);

alter table K_DOC_HIS comment '公文历史';

/*==============================================================*/
/* Table: K_DOC_RIDER                                           */
/*==============================================================*/
create table K_DOC_RIDER
(
   DOC_RIDER_ID_        varchar(40) not null comment '公文附件ID',
   DOC_ID_              varchar(40) not null comment '公文ID',
   DOC_RIDER_FILE_      longblob not null comment '公文附件文件',
   DOC_RIDER_FILE_NAME_ varchar(300) comment '公文附件文件名称',
   DOC_RIDER_FILE_LENGTH_ numeric(8,0) comment '公文附件文件长度',
   MD5_                 varchar(40) comment 'MD5',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (DOC_RIDER_ID_)
);

alter table K_DOC_RIDER comment '公文附件';

/*==============================================================*/
/* Table: K_DOC_RIDER_HIS                                       */
/*==============================================================*/
create table K_DOC_RIDER_HIS
(
   DOC_RIDER_HIS_ID_    varchar(40) not null comment '公文附件历史ID',
   DOC_RIDER_ID_        varchar(40) comment '公文附件ID',
   DOC_ID_              varchar(40) comment '公文ID',
   DOC_RIDER_FILE_      longblob comment '公文附件文件',
   DOC_RIDER_FILE_NAME_ varchar(300) comment '公文附件文件名称',
   DOC_RIDER_FILE_LENGTH_ numeric(8,0) comment '公文附件文件长度',
   MD5_                 varchar(40) comment 'MD5',
   VERSION_             numeric(8,0) comment '版本',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   HIS_DATE_            datetime comment '历史日期',
   primary key (DOC_RIDER_HIS_ID_),
   key UQ_DOC_RIDER_HIS (VERSION_, DOC_RIDER_ID_)
);

alter table K_DOC_RIDER_HIS comment '公文附件历史';

/*==============================================================*/
/* Table: K_DOC_TYPE                                            */
/*==============================================================*/
create table K_DOC_TYPE
(
   DOC_TYPE_ID_         varchar(40) not null comment '公文类型ID',
   DOC_TYPE_NAME_       varchar(60) not null comment '公文类型名称',
   TEMPLATE_FILE_       longblob comment '模板文件',
   TEMPLATE_FILE_NAME_  varchar(300) comment '模板文件名称',
   TEMPLATE_FILE_LENGTH_ numeric(8,0) comment '模板文件长度',
   HTML_                text comment 'HTML',
   BOOKMARK_            text comment '标签',
   INDEX_               varchar(1000) comment '定位',
   USING_TEMPLATE_      varchar(20) not null comment '使用模板生成公文',
   PROC_DEF_CODE_       varchar(60) not null comment '流程定义编码',
   DESC_                varchar(300) comment '描述',
   ORDER_               numeric(8,0) comment '排序',
   DOC_TYPE_STATUS_     varchar(20) not null comment '公文类型状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (DOC_TYPE_ID_),
   key UQ_DOC_TYPE_NAME (DOC_TYPE_NAME_)
);

alter table K_DOC_TYPE comment '公文类型';

/*==============================================================*/
/* Table: OM_CODE                                               */
/*==============================================================*/
create table OM_CODE
(
   CODE_ID_             varchar(40) not null comment '代码ID',
   PARENT_CODE_ID_      varchar(40) comment '上级代码ID',
   CATEGORY_            varchar(20) not null comment '分类',
   CODE_                varchar(60) not null comment '代码',
   NAME_                varchar(60) comment '名称',
   EXT_ATTR_1_          varchar(60) comment '扩展属性1',
   EXT_ATTR_2_          varchar(60) comment '扩展属性2',
   EXT_ATTR_3_          varchar(60) comment '扩展属性3',
   EXT_ATTR_4_          varchar(60) comment '扩展属性4',
   EXT_ATTR_5_          varchar(60) comment '扩展属性5',
   EXT_ATTR_6_          varchar(60) comment '扩展属性6',
   ORDER_               numeric(8,0) comment '排序',
   primary key (CODE_ID_),
   key UQ_OM_CODE (CATEGORY_, CODE_)
);

alter table OM_CODE comment '代码';

/*==============================================================*/
/* Table: OM_DUTY                                               */
/*==============================================================*/
create table OM_DUTY
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   DUTY_ID_             varchar(40) not null comment '职务ID',
   DUTY_CODE_           varchar(60) not null comment '职务编码',
   DUTY_NAME_           varchar(60) not null comment '职务名称',
   DUTY_CATEGORY_       varchar(20) not null comment '分类',
   MEMO_                varchar(300) comment '备注',
   DUTY_TAG_            varchar(120) comment '职务标签',
   DUTY_EXT_ATTR_1_     varchar(120) comment '职务扩展属性1',
   DUTY_EXT_ATTR_2_     varchar(120) comment '职务扩展属性2',
   DUTY_EXT_ATTR_3_     varchar(120) comment '职务扩展属性3',
   DUTY_EXT_ATTR_4_     varchar(120) comment '职务扩展属性4',
   DUTY_EXT_ATTR_5_     varchar(120) comment '职务扩展属性5',
   DUTY_EXT_ATTR_6_     varchar(120) comment '职务扩展属性6',
   DUTY_EXT_ATTR_7_     varchar(120) comment '职务扩展属性7',
   DUTY_EXT_ATTR_8_     varchar(120) comment '职务扩展属性8',
   ORDER_               numeric(8,0) comment '排序',
   DUTY_STATUS_         varchar(20) not null comment '职务状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_, DUTY_ID_),
   key UQ_OM_DUTY_CODE (ORGN_SET_ID_, DUTY_CODE_)
);

alter table OM_DUTY comment '职务';

/*==============================================================*/
/* Table: OM_EMP                                                */
/*==============================================================*/
create table OM_EMP
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   EMP_ID_              varchar(40) not null comment '人员ID',
   ORG_ID_              varchar(40) not null comment '机构ID',
   EMP_CODE_            varchar(60) not null comment '人员编码',
   EMP_NAME_            varchar(60) not null comment '人员名称',
   PASSWORD_            varchar(40) comment '密码',
   PASSWORD_RESET_REQ_  varchar(20) not null comment '密码重置',
   PARTY_               varchar(20) comment '政治面貌',
   EMP_LEVEL_           varchar(20) comment '职级',
   GENDER_              varchar(20) comment '性别',
   BIRTH_DATE_          datetime comment '出生日期',
   TEL_                 varchar(60) comment '电话',
   EMAIL_               varchar(60) comment '电子邮箱',
   IN_DATE_             datetime comment '入职日期',
   OUT_DATE_            datetime comment '离职日期',
   EMP_CATEGORY_        varchar(20) not null comment '分类',
   MEMO_                varchar(300) comment '备注',
   EMP_TAG_             varchar(120) comment '人员标签',
   EMP_EXT_ATTR_1_      varchar(120) comment '人员扩展属性1',
   EMP_EXT_ATTR_2_      varchar(120) comment '人员扩展属性2',
   EMP_EXT_ATTR_3_      varchar(120) comment '人员扩展属性3',
   EMP_EXT_ATTR_4_      varchar(120) comment '人员扩展属性4',
   EMP_EXT_ATTR_5_      varchar(120) comment '人员扩展属性5',
   EMP_EXT_ATTR_6_      varchar(120) comment '人员扩展属性6',
   EMP_EXT_ATTR_7_      varchar(120) comment '人员扩展属性7',
   EMP_EXT_ATTR_8_      varchar(120) comment '人员扩展属性8',
   ORDER_               numeric(8,0) comment '排序',
   EMP_STATUS_          varchar(20) not null comment '人员状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_, EMP_ID_),
   key UQ_OM_EMP_CODE (ORGN_SET_ID_, EMP_CODE_)
);

alter table OM_EMP comment '人员';

/*==============================================================*/
/* Index: IX_OM_EMP_ORDER                                       */
/*==============================================================*/
create index IX_OM_EMP_ORDER on OM_EMP
(
   ORDER_
);

/*==============================================================*/
/* Table: OM_EMP_RELATION                                       */
/*==============================================================*/
create table OM_EMP_RELATION
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   EMP_RELATION_ID_     varchar(40) not null comment '人员关系ID',
   UPPER_EMP_ID_        varchar(40) not null comment '上级人员ID',
   LOWER_EMP_ID_        varchar(40) not null comment '下级人员ID',
   EMP_RELATION_        varchar(20) not null comment '人员关系',
   EMP_RELATION_CATEGORY_ varchar(20) comment '分类',
   MEMO_                varchar(300) comment '备注',
   EMP_RELATION_TAG_    varchar(120) comment '人员关系标签',
   EMP_RELATION_EXT_ATTR_1_ varchar(120) comment '人员关系扩展属性1',
   EMP_RELATION_EXT_ATTR_2_ varchar(120) comment '人员关系扩展属性2',
   EMP_RELATION_EXT_ATTR_3_ varchar(120) comment '人员关系扩展属性3',
   EMP_RELATION_EXT_ATTR_4_ varchar(120) comment '人员关系扩展属性4',
   EMP_RELATION_EXT_ATTR_5_ varchar(120) comment '人员关系扩展属性5',
   EMP_RELATION_EXT_ATTR_6_ varchar(120) comment '人员关系扩展属性6',
   EMP_RELATION_EXT_ATTR_7_ varchar(120) comment '人员关系扩展属性7',
   EMP_RELATION_EXT_ATTR_8_ varchar(120) comment '人员关系扩展属性8',
   ORDER_               numeric(8,0) comment '排序',
   EMP_RELATION_STATUS_ varchar(20) not null comment '人员关系状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_, EMP_RELATION_ID_),
   key UQ_OM_EMP_RELATION (ORGN_SET_ID_, UPPER_EMP_ID_, LOWER_EMP_ID_, EMP_RELATION_)
);

alter table OM_EMP_RELATION comment '人员关系';

/*==============================================================*/
/* Table: OM_LOG                                                */
/*==============================================================*/
create table OM_LOG
(
   LOG_ID_              varchar(40) not null comment '日志ID',
   CATEGORY_            varchar(60) comment '分类',
   IP_                  varchar(60) comment 'IP',
   USER_AGENT_          varchar(200) comment '用户代理',
   URL_                 text comment '调用URL',
   ACTION_              varchar(200) comment '调用控制层接口',
   PARAMETER_MAP_       text comment '调用参数',
   BUSINESS_KEY_        varchar(40) comment '业务主键',
   ERROR_               varchar(20) comment '错误',
   MESSAGE_             text comment '信息',
   ORG_ID_              varchar(40) comment '机构ID',
   ORG_NAME_            varchar(60) comment '机构名称',
   POSI_ID_             varchar(40) comment '岗位ID',
   POSI_NAME_           varchar(60) comment '岗位名称',
   EMP_ID_              varchar(40) comment '人员ID',
   EMP_NAME_            varchar(60) comment '人员名称',
   CREATION_DATE_       datetime not null comment '创建日期',
   primary key (LOG_ID_)
);

alter table OM_LOG comment '日志';

/*==============================================================*/
/* Table: OM_MAIN_SERVER                                        */
/*==============================================================*/
create table OM_MAIN_SERVER
(
   MAIN_SERVER_ID_      varchar(40) not null comment '主服务器ID',
   MAIN_SERVER_NAME_    varchar(60) not null comment '主服务器名称',
   DRIVER_CLASS_NAME_   varchar(100) not null comment '驱动类名称',
   URL_                 varchar(200) not null comment '链接',
   USERNAME_            varchar(40) not null comment '用户名',
   PASSWORD_            varchar(40) not null comment '密码',
   MEMO_                varchar(300) comment '备注',
   LAST_SYNC_DATE_      datetime comment '上次同步日期',
   ORDER_               numeric(8,0) comment '排序',
   MAIN_SERVER_STATUS_  varchar(20) not null comment '主服务器状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (MAIN_SERVER_ID_),
   key UQ_OM_MAIN_SERVER_NAME (MAIN_SERVER_NAME_)
);

alter table OM_MAIN_SERVER comment '主服务器';

/*==============================================================*/
/* Table: OM_MIRROR_SERVER                                      */
/*==============================================================*/
create table OM_MIRROR_SERVER
(
   MIRROR_SERVER_ID_    varchar(40) not null comment '镜像服务器ID',
   MIRROR_SERVER_NAME_  varchar(60) not null comment '镜像服务器名称',
   DRIVER_CLASS_NAME_   varchar(100) not null comment '驱动类名称',
   URL_                 varchar(200) not null comment '链接',
   USERNAME_            varchar(40) not null comment '用户名',
   PASSWORD_            varchar(40) not null comment '密码',
   MEMO_                varchar(300) comment '备注',
   LAST_SYNC_DATE_      datetime comment '上次同步日期',
   ORDER_               numeric(8,0) comment '排序',
   MIRROR_SERVER_STATUS_ varchar(20) not null comment '镜像服务器状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (MIRROR_SERVER_ID_),
   key UQ_OM_MIRROR_SERVER_NAME (MIRROR_SERVER_NAME_)
);

alter table OM_MIRROR_SERVER comment '镜像服务器';

/*==============================================================*/
/* Table: OM_ORG                                                */
/*==============================================================*/
create table OM_ORG
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   ORG_ID_              varchar(40) not null comment '机构ID',
   PARENT_ORG_ID_       varchar(40) comment '上级机构ID',
   ORG_CODE_            varchar(60) not null comment '机构编码',
   ORG_NAME_            varchar(60) not null comment '机构名称',
   ORG_ABBR_NAME_       varchar(60) comment '机构简称',
   ORG_TYPE_            varchar(20) not null comment '机构类型',
   ORG_CATEGORY_        varchar(20) not null comment '分类',
   MEMO_                varchar(300) comment '备注',
   ORG_TAG_             varchar(120) comment '机构标签',
   ORG_EXT_ATTR_1_      varchar(120) comment '机构扩展属性1',
   ORG_EXT_ATTR_2_      varchar(120) comment '机构扩展属性2',
   ORG_EXT_ATTR_3_      varchar(120) comment '机构扩展属性3',
   ORG_EXT_ATTR_4_      varchar(120) comment '机构扩展属性4',
   ORG_EXT_ATTR_5_      varchar(120) comment '机构扩展属性5',
   ORG_EXT_ATTR_6_      varchar(120) comment '机构扩展属性6',
   ORG_EXT_ATTR_7_      varchar(120) comment '机构扩展属性7',
   ORG_EXT_ATTR_8_      varchar(120) comment '机构扩展属性8',
   ORDER_               numeric(8,0) comment '排序',
   ORG_STATUS_          varchar(20) not null comment '机构状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_, ORG_ID_),
   key UQ_OM_ORG_CODE (ORGN_SET_ID_, ORG_CODE_)
);

alter table OM_ORG comment '机构';

/*==============================================================*/
/* Index: IX_OM_ORG_ORDER                                       */
/*==============================================================*/
create index IX_OM_ORG_ORDER on OM_ORG
(
   ORDER_
);

/*==============================================================*/
/* Table: OM_ORGN_SET                                           */
/*==============================================================*/
create table OM_ORGN_SET
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   PARENT_ORGN_SET_ID_  varchar(40) comment '上级组织架构套ID',
   ORGN_SET_CODE_       varchar(60) not null comment '组织架构套编码',
   ORGN_SET_NAME_       varchar(60) not null comment '组织架构套名称',
   ALLOW_SYNC_          varchar(20) not null comment '允许同步',
   MEMO_                varchar(300) comment '备注',
   ORDER_               numeric(8,0) comment '排序',
   ORGN_SET_STATUS_     varchar(20) not null comment '组织架构套状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_),
   key UQ_OM_ORGN_SET_CODE (ORGN_SET_CODE_)
);

alter table OM_ORGN_SET comment '组织架构套';

/*==============================================================*/
/* Table: OM_POSI                                               */
/*==============================================================*/
create table OM_POSI
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   POSI_ID_             varchar(40) not null comment '岗位ID',
   ORG_ID_              varchar(40) not null comment '机构ID',
   DUTY_ID_             varchar(40) comment '职务ID',
   POSI_CODE_           varchar(60) comment '岗位编码',
   POSI_NAME_           varchar(60) not null comment '岗位名称',
   ORG_LEADER_TYPE_     varchar(20) comment '机构领导类型',
   POSI_CATEGORY_       varchar(20) not null comment '分类',
   MEMO_                varchar(300) comment '备注',
   POSI_TAG_            varchar(120) comment '岗位标签',
   POSI_EXT_ATTR_1_     varchar(120) comment '岗位扩展属性1',
   POSI_EXT_ATTR_2_     varchar(120) comment '岗位扩展属性2',
   POSI_EXT_ATTR_3_     varchar(120) comment '岗位扩展属性3',
   POSI_EXT_ATTR_4_     varchar(120) comment '岗位扩展属性4',
   POSI_EXT_ATTR_5_     varchar(120) comment '岗位扩展属性5',
   POSI_EXT_ATTR_6_     varchar(120) comment '岗位扩展属性6',
   POSI_EXT_ATTR_7_     varchar(120) comment '岗位扩展属性7',
   POSI_EXT_ATTR_8_     varchar(120) comment '岗位扩展属性8',
   ORDER_               numeric(8,0) comment '排序',
   POSI_STATUS_         varchar(20) not null comment '岗位状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '修改日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_, POSI_ID_),
   key UQ_OM_POSI_CODE (ORGN_SET_ID_, POSI_CODE_)
);

alter table OM_POSI comment '岗位';

/*==============================================================*/
/* Table: OM_POSI_EMP                                           */
/*==============================================================*/
create table OM_POSI_EMP
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   POSI_EMP_ID_         varchar(40) not null comment '岗位人员ID',
   POSI_ID_             varchar(40) not null comment '岗位ID',
   EMP_ID_              varchar(40) not null comment '人员ID',
   MAIN_                varchar(20) not null comment '主岗位',
   POSI_EMP_CATEGORY_   varchar(20) comment '分类',
   MEMO_                varchar(300) comment '备注',
   POSI_EMP_TAG_        varchar(120) comment '岗位人员标签',
   POSI_EMP_EXT_ATTR_1_ varchar(120) comment '岗位人员扩展属性1',
   POSI_EMP_EXT_ATTR_2_ varchar(120) comment '岗位人员扩展属性2',
   POSI_EMP_EXT_ATTR_3_ varchar(120) comment '岗位人员扩展属性3',
   POSI_EMP_EXT_ATTR_4_ varchar(120) comment '岗位人员扩展属性4',
   POSI_EMP_EXT_ATTR_5_ varchar(120) comment '岗位人员扩展属性5',
   POSI_EMP_EXT_ATTR_6_ varchar(120) comment '岗位人员扩展属性6',
   POSI_EMP_EXT_ATTR_7_ varchar(120) comment '岗位人员扩展属性7',
   POSI_EMP_EXT_ATTR_8_ varchar(120) comment '岗位人员扩展属性8',
   ORDER_               numeric(8,0) comment '排序',
   POSI_EMP_STATUS_     varchar(20) not null comment '岗位人员状态',
   CREATION_DATE_       datetime comment '创建日期',
   UPDATE_DATE_         datetime comment '更新日期',
   OPERATOR_ID_         varchar(40) comment '操作人员ID',
   OPERATOR_NAME_       varchar(60) comment '操作人员名称',
   primary key (ORGN_SET_ID_, POSI_EMP_ID_),
   key UQ_OM_POSI_EMP (ORGN_SET_ID_, POSI_ID_, EMP_ID_)
);

alter table OM_POSI_EMP comment '岗位人员';

/*==============================================================*/
/* Index: IX_POSI_EMP_EMP                                       */
/*==============================================================*/
create index IX_POSI_EMP_EMP on OM_POSI_EMP
(
   EMP_ID_
);

/*==============================================================*/
/* Index: IX_POSI_EMP_POSI                                      */
/*==============================================================*/
create index IX_POSI_EMP_POSI on OM_POSI_EMP
(
   POSI_ID_
);

/*==============================================================*/
/* Table: OM_TAG                                                */
/*==============================================================*/
create table OM_TAG
(
   ORGN_SET_ID_         varchar(40) not null comment '组织架构套ID',
   TAG_ID_              varchar(40) not null comment '标签ID',
   OBJ_ID_              varchar(40) not null comment '对象ID',
   OBJ_TYPE_            varchar(60) comment '对象类型',
   TAG_                 varchar(60) not null comment '标签',
   primary key (ORGN_SET_ID_, TAG_ID_)
);

alter table OM_TAG comment '标签';

alter table CB_CODE add constraint FK_CODE foreign key (PARENT_CODE_ID_)
      references CB_CODE (CODE_ID_) on update restrict;

alter table CB_DASHBOARD add constraint FK_DASHBOARD_DASHBOARD_MODULE foreign key (DASHBOARD_MODULE_ID_)
      references CB_DASHBOARD_MODULE (DASHBOARD_MODULE_ID_) on update restrict;

alter table CB_MENU add constraint FK_MENU_PARENT foreign key (PARENT_MENU_ID_)
      references CB_MENU (MENU_ID_) on update restrict;

alter table FF_ADJUST_PROC_DEF add constraint FK_FF_ADJUST_PROC_DEF_PROC_DEF foreign key (PROC_DEF_ID_)
      references FF_PROC_DEF (PROC_DEF_ID_) on update restrict;

alter table FF_NODE add constraint FK_FF_NODE_ADJUST_PROC_DEF foreign key (ADJUST_SUB_PROC_DEF_ID_)
      references FF_ADJUST_PROC_DEF (ADJUST_PROC_DEF_ID_) on update restrict;

alter table FF_NODE add constraint FK_FF_NODE_PARENT foreign key (PARENT_NODE_ID_)
      references FF_NODE (NODE_ID_) on update restrict;

alter table FF_NODE add constraint FK_FF_NODE_PROC foreign key (PROC_ID_)
      references FF_PROC (PROC_ID_) on update restrict;

alter table FF_NODE add constraint FK_FF_NODE_PROC_DEF foreign key (SUB_PROC_DEF_ID_)
      references FF_PROC_DEF (PROC_DEF_ID_) on update restrict;

alter table FF_NODE_OP add constraint FK_FF_NODE_OP_OPERATION foreign key (OPERATION_ID_)
      references FF_OPERATION (OPERATION_ID_) on update restrict;

alter table FF_NODE_VAR_OP add constraint FK_FF_NODE_VAR_OP_OPERATION foreign key (OPERATION_ID_)
      references FF_OPERATION (OPERATION_ID_) on update restrict;

alter table FF_OPERATION_FOLLOW_UP add constraint FK_FF_OPERATION_FOLOW_UP_O foreign key (OPERATION_ID_)
      references FF_OPERATION (OPERATION_ID_) on update restrict;

alter table FF_OPERATION_FOLLOW_UP add constraint FK_FF_OPERATION_FOLOW_UP_OFU foreign key (FOLLOW_UP_OPERATION_ID_)
      references FF_OPERATION (OPERATION_ID_) on update restrict;

alter table FF_PROC add constraint FK_FF_PROC_PROC_DEF foreign key (PROC_DEF_ID_)
      references FF_PROC_DEF (PROC_DEF_ID_) on update restrict;

alter table FF_PROC_OP add constraint FK_FF_PROC_OP_OPERATION foreign key (OPERATION_ID_)
      references FF_OPERATION (OPERATION_ID_) on update restrict;

alter table FF_TASK add constraint FK_FF_TASK_NODE foreign key (NODE_ID_)
      references FF_NODE (NODE_ID_) on update restrict;

alter table FF_TASK add constraint FK_FF_TASK_PARENT foreign key (PREVIOUS_TASK_ID_)
      references FF_TASK (TASK_ID_) on update restrict;

alter table FF_TASK_OP add constraint FK_FF_TASK_OP_OPERATION foreign key (OPERATION_ID_)
      references FF_OPERATION (OPERATION_ID_) on update restrict;

alter table K_DOC_DATA add constraint FK_DOC_DATA_DOC foreign key (DOC_ID_)
      references K_DOC (DOC_ID_) on update restrict;

alter table K_DOC_DATA_HIS add constraint FK_DOC_DATA_HIS_DOC foreign key (DOC_ID_)
      references K_DOC (DOC_ID_) on update restrict;

alter table K_DOC_RIDER add constraint FK_DOC_RIDER_DOC foreign key (DOC_ID_)
      references K_DOC (DOC_ID_) on update restrict;

alter table K_DOC_RIDER_HIS add constraint FK_DOC_RIDER_HIS_DOC foreign key (DOC_ID_)
      references K_DOC (DOC_ID_) on update restrict;

alter table OM_CODE add constraint FK_OM_CODE foreign key (PARENT_CODE_ID_)
      references OM_CODE (CODE_ID_) on update restrict;

alter table OM_DUTY add constraint FK_OM_DUTY_ORGN_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_EMP add constraint FK_OM_EMP_ORG foreign key (ORGN_SET_ID_, ORG_ID_)
      references OM_ORG (ORGN_SET_ID_, ORG_ID_) on update restrict;

alter table OM_EMP add constraint FK_OM_EMP_ORGN_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_EMP_RELATION add constraint FK_OM_EMP_RELATION_LOWER_EMP foreign key (ORGN_SET_ID_, LOWER_EMP_ID_)
      references OM_EMP (ORGN_SET_ID_, EMP_ID_) on update restrict;

alter table OM_EMP_RELATION add constraint FK_OM_EMP_RELATION_ORNG_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_EMP_RELATION add constraint FK_OM_EMP_RELATION_UPPER_EMP foreign key (ORGN_SET_ID_, UPPER_EMP_ID_)
      references OM_EMP (ORGN_SET_ID_, EMP_ID_) on update restrict;

alter table OM_ORG add constraint FK_OM_ORG_ORGN_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_ORG add constraint FK_OM_ORG_PARENT foreign key (ORGN_SET_ID_, PARENT_ORG_ID_)
      references OM_ORG (ORGN_SET_ID_, ORG_ID_) on update restrict;

alter table OM_ORGN_SET add constraint FK_OM_ORGN_SET_PARENT foreign key (PARENT_ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_POSI add constraint FK_OM_POSI_DUTY foreign key (ORGN_SET_ID_, DUTY_ID_)
      references OM_DUTY (ORGN_SET_ID_, DUTY_ID_) on update restrict;

alter table OM_POSI add constraint FK_OM_POSI_ORG foreign key (ORGN_SET_ID_, ORG_ID_)
      references OM_ORG (ORGN_SET_ID_, ORG_ID_) on update restrict;

alter table OM_POSI add constraint FK_OM_POSI_ORGN_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_POSI_EMP add constraint FK_OM_POSI_EMP_EMP foreign key (ORGN_SET_ID_, EMP_ID_)
      references OM_EMP (ORGN_SET_ID_, EMP_ID_) on update restrict;

alter table OM_POSI_EMP add constraint FK_OM_POSI_EMP_ORGN_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

alter table OM_POSI_EMP add constraint FK_OM_POSI_EMP_POSI foreign key (ORGN_SET_ID_, POSI_ID_)
      references OM_POSI (ORGN_SET_ID_, POSI_ID_) on update restrict;

alter table OM_TAG add constraint FK_OM_TAG_ORGN_SET foreign key (ORGN_SET_ID_)
      references OM_ORGN_SET (ORGN_SET_ID_) on update restrict;

      

create or replace view CBV_CODE as
select CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_ from CB_CODE;

create or replace view CBV_CUSTOM_THEME as
select CT.CUSTOM_THEME_ID_, CT.OPERATOR_ID_, CT.CSS_HREF_ from CB_CUSTOM_THEME CT;

create or replace view CBV_DASHBOARD as
select D.DASHBOARD_ID_, D.DASHBOARD_MODULE_ID_, D.POSI_EMP_ID_, D.DASHBOARD_MODULE_NAME_, D.URL_, D.WIDTH_, D.HEIGHT_, D.ORDER_ from CB_DASHBOARD D;

create or replace view CBV_DASHBOARD_MODULE as
select DM.DASHBOARD_MODULE_ID_, DM.DASHBOARD_MODULE_NAME_, DM.DASHBOARD_MODULE_TYPE_, DM.DEFAULT_URL_, DM.DEFAULT_WIDTH_, DM.DEFAULT_HEIGHT_, DM.DASHBOARD_MODULE_TAG_, DM.ORDER_, DM.DASHBOARD_MODULE_STATUS_ from CB_DASHBOARD_MODULE DM;

create or replace view CBV_DUTY_MENU as
select PM.DUTY_MENU_ID_, PM.DUTY_ID_, PM.DUTY_NAME_, PM.MENU_ID_, PM.CREATION_DATE_, PM.UPDATE_DATE_, PM.OPERATOR_ID_, PM.OPERATOR_NAME_, M.PARENT_MENU_ID_, M.MENU_NAME_, M.MENU_TYPE_, M.URL_, M.ORDER_, M.MENU_STATUS_, M.ICON_ from CB_DUTY_MENU PM inner join CB_MENU M on M.MENU_ID_ = PM.MENU_ID_;

create or replace view CBV_LOG as
select LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_ from CB_LOG;

create or replace view CBV_MENU as
select MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_, URL_, ORDER_, MENU_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, ICON_ from CB_MENU;

create or replace view CBV_NOTICE as
select N.NOTICE_ID_, N.POSI_EMP_ID_, N.EMP_ID_, N.EMP_CODE_, N.EMP_NAME_, N.CONTENT_, N.SOURCE_, N.IDENTITY_, N.REDIRECT_URL_, N.BIZ_URL_, N.EXP_DATE_, N.NOTICE_STATUS_, N.CREATION_DATE_ from CB_NOTICE N;

create or replace view CBV_POSI_EMP_MENU as
select PEM.POSI_EMP_MENU_ID_, PEM.POSI_EMP_ID_, PEM.POSI_NAME_, PEM.EMP_NAME_, PEM.MENU_ID_, PEM.CREATION_DATE_, PEM.UPDATE_DATE_, PEM.OPERATOR_ID_, PEM.OPERATOR_NAME_, M.PARENT_MENU_ID_, M.MENU_NAME_, M.MENU_TYPE_, M.URL_, M.ORDER_, M.MENU_STATUS_, M.ICON_ from CB_POSI_EMP_MENU PEM inner join CB_MENU M on M.MENU_ID_ = PEM.MENU_ID_;

create or replace view CBV_POSI_MENU as
select PM.POSI_MENU_ID_, PM.POSI_ID_, PM.POSI_NAME_, PM.MENU_ID_, PM.CREATION_DATE_, PM.UPDATE_DATE_, PM.OPERATOR_ID_, PM.OPERATOR_NAME_, M.PARENT_MENU_ID_, M.MENU_NAME_, M.MENU_TYPE_, M.URL_, M.ORDER_, M.MENU_STATUS_, M.ICON_ from CB_POSI_MENU PM inner join CB_MENU M on M.MENU_ID_ = PM.MENU_ID_;

create or replace view CBV_RIDER as
select RIDER_ID_, OBJ_ID_, RIDER_FILE_NAME_, RIDER_FILE_LENGTH_, MEMO_, RIDER_TAG_, ORDER_, RIDER_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ from CB_RIDER;

create or replace view CBV_TAG as
select TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_ from CB_TAG;

create or replace view CBV_WORKING_CALENDAR as
select WC.WORKING_CALENDAR_ID_, WC.EMP_ID_, WC.DATE_, WC.WORKING_DAY_, WC.MARK_ from CB_WORKING_CALENDAR WC;

create or replace view FFV_ADJUST_PROC_DEF as
select APD.ADJUST_PROC_DEF_ID_, APD.PROC_DEF_ID_, APD.PROC_DEF_MODEL_, APD.PROC_DEF_DIAGRAM_FILE_, APD.PROC_DEF_DIAGRAM_FILE_NAME_, APD.PROC_DEF_DIAGRAM_FILE_LENGTH_, APD.PROC_DEF_DIAGRAM_WIDTH_, APD.PROC_DEF_DIAGRAM_HEIGHT_, APD.CREATION_DATE_, APD.UPDATE_DATE_, APD.OPERATOR_ID_, APD.OPERATOR_NAME_ from FF_ADJUST_PROC_DEF APD;

create or replace view FFV_DELEGATE as
select D.DELEGATE_ID_, D.ASSIGNEE_, D.ASSIGNEE_NAME_, D.DELEGATOR_, D.DELEGATOR_NAME_, D.START_DATE_, D.END_DATE_ from FF_DELEGATE D;

create or replace view FFV_NODE as
select N.NODE_ID_, N.PARENT_NODE_ID_, N.PROC_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.ASSIGNEE_, N.ACTION_, N.DUE_DATE_, N.CLAIM_, N.FORWARDABLE_, N.PRIORITY_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.NEXT_CANDIDATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ from FF_NODE N;

create or replace view FFV_NODE_P as
select N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.ASSIGNEE_, N.ACTION_, N.DUE_DATE_, N.CLAIM_, N.FORWARDABLE_, N.PRIORITY_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.NEXT_CANDIDATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_, P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_
  from FF_NODE N
 inner join FF_PROC P
    on P.PROC_ID_ = N.PROC_ID_;

create or replace view FFV_NODE_PD as
select N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.ASSIGNEE_, N.ACTION_, N.DUE_DATE_, N.CLAIM_, N.FORWARDABLE_, N.PRIORITY_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.NEXT_CANDIDATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_, P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_, SPD.PROC_DEF_CODE_ as SUB_PROC_DEF_CODE_
  from FF_NODE N
 inner join FF_PROC P on P.PROC_ID_ = N.PROC_ID_
 inner join FF_PROC_DEF PD on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_
 inner join FF_PROC_DEF SPD on SPD.PROC_DEF_ID_ = N.SUB_PROC_DEF_ID_;

create or replace view FFV_NODE_VAR as
select PV.NODE_VAR_ID_, PV.NODE_ID_, PV.VAR_TYPE_, PV.VAR_NAME_, PV.VALUE_, PV.OBJ_, PV.CREATION_DATE_, N.PARENT_NODE_ID_, N.PROC_ID_ from FF_NODE_VAR PV inner join FF_NODE N on N.NODE_ID_ = PV.NODE_ID_;

create or replace view FFV_OPERATION as
select O.OPERATION_ID_, O.OPERATION_, O.PROC_ID_, O.NODE_ID_, O.TASK_ID_, O.MEMO_, O.OPERATOR_, O.OPERATOR_NAME_, O.OPERATION_DATE_, O.OPERATION_STATUS_ from FF_OPERATION O;

create or replace view FFV_PROC as
select P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ from FF_PROC P;

create or replace view FFV_OPERATION_P as
select O.OPERATION_ID_, O.OPERATION_, O.NODE_ID_, O.TASK_ID_, O.MEMO_, O.OPERATOR_, O.OPERATOR_NAME_, O.OPERATION_DATE_, O.OPERATION_STATUS_, P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ from FF_OPERATION O left outer join FFV_PROC P on P.PROC_ID_ = O.PROC_ID_;

create or replace view FFV_OPERATION_PD as
select O.OPERATION_ID_, O.OPERATION_, O.NODE_ID_, O.TASK_ID_, O.MEMO_, O.OPERATOR_, O.OPERATOR_NAME_, O.OPERATION_DATE_, O.OPERATION_STATUS_, P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_ from FF_OPERATION O left outer join FFV_PROC P on P.PROC_ID_ = O.PROC_ID_ inner join FF_PROC_DEF PD on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_;

create or replace view FFV_PROC_DEF as
select PROC_DEF_ID_, PROC_DEF_CODE_, PROC_DEF_NAME_, PROC_DEF_CAT_, PROC_DEF_MODEL_, PROC_DEF_DIAGRAM_FILE_, PROC_DEF_DIAGRAM_FILE_NAME_, PROC_DEF_DIAGRAM_FILE_LENGTH_, PROC_DEF_DIAGRAM_WIDTH_, PROC_DEF_DIAGRAM_HEIGHT_, MEMO_, VERSION_, PROC_DEF_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ from FF_PROC_DEF;

create or replace view FFV_PROC_PD as
select P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_ from FF_PROC P inner join FF_PROC_DEF PD on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_;

create or replace view FFV_TASK as
select T.TASK_ID_, T.NODE_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_ from FF_TASK T;

create or replace view FFV_TASK_N as
select T.TASK_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_, N.NODE_ID_, N.PARENT_NODE_ID_, N.PROC_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ as NODE_CREATION_DATE_
  from FF_TASK T
 inner join FF_NODE N
    on N.NODE_ID_ = T.NODE_ID_;

create or replace view FFV_TASK_P as
select T.TASK_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_, N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ as NODE_CREATION_DATE_, P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_
  from FF_TASK T
 inner join FF_NODE N
    on N.NODE_ID_ = T.NODE_ID_
 inner join FF_PROC P
    on P.PROC_ID_ = N.PROC_ID_;

create or replace view FFV_TASK_PD as
select T.TASK_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_, N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ as NODE_CREATION_DATE_, P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_
  from FF_TASK T
 inner join FF_NODE N
    on N.NODE_ID_ = T.NODE_ID_
 inner join FF_PROC P
    on P.PROC_ID_ = N.PROC_ID_
 inner join FF_PROC_DEF PD
    on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_;

create or replace view KV_APPROVAL_MEMO as
select AM.APPROVAL_MEMO_ID_, AM.TASK_ID_, AM.PREVIOUS_TASK_ID_, AM.NODE_ID_, AM.NODE_TYPE_, AM.NODE_NAME_, AM.PARENT_NODE_ID_, AM.PROC_ID_, AM.BIZ_ID_, AM.ASSIGNEE_, AM.ASSIGNEE_CODE_, AM.ASSIGNEE_NAME_, AM.EXECUTOR_, AM.EXECUTOR_CODE_, AM.EXECUTOR_NAME_, AM.ORG_ID_, AM.ORG_NAME_, AM.COM_ID_, AM.COM_NAME_, AM.CREATION_DATE_, AM.DUE_DATE_, AM.APPROVAL_MEMO_TYPE_, AM.APPROVAL_MEMO_, AM.APPROVAL_DATE_, AM.APPROVAL_MEMO_STATUS_, AM.APPROVAL_MEMO_SOURCE_ from K_APPROVAL_MEMO AM;

create or replace view KV_CUSTOM_APPROVAL_MEMO as
select CAM.CUSTOM_APPROVAL_MEMO_ID_, CAM.EMP_ID_, CAM.APPROVAL_MEMO_, CAM.DEFAULT_, CAM.ORDER_ from K_CUSTOM_APPROVAL_MEMO CAM;

create or replace view KV_CUSTOM_DOC_TYPE as
select CT.CUSTOM_DOC_TYPE_ID_, CT.EMP_ID_, CT.DOC_TYPE_ID_, DT.DOC_TYPE_NAME_, DT.TEMPLATE_FILE_NAME_, DT.TEMPLATE_FILE_LENGTH_, DT.HTML_, DT.BOOKMARK_, DT.INDEX_, DT.USING_TEMPLATE_, DT.PROC_DEF_CODE_, DT.DESC_, DT.ORDER_, DT.DOC_TYPE_STATUS_, DT.CREATION_DATE_, DT.UPDATE_DATE_, DT.OPERATOR_ID_, DT.OPERATOR_NAME_ from K_CUSTOM_DOC_TYPE CT inner join K_DOC_TYPE DT on DT.DOC_TYPE_ID_ = CT.DOC_TYPE_ID_;

create or replace view KV_DOC as
select D.DOC_ID_, D.DOC_CODE_, D.DOC_NAME_, D.DOC_TYPE_NAME_, D.OWNER_ID_, D.OWNER_NAME_, D.OWNER_ORG_ID_, D.OWNER_ORG_NAME_, D.MEMO_, D.TEMPLATE_FILE_NAME_, D.TEMPLATE_FILE_LENGTH_, D.DOC_FILE_NAME_, D.DOC_FILE_LENGTH_, D.BOOKMARK_, D.INDEX_, D.USING_TEMPLATE_, D.PROC_DEF_CODE_, D.PROC_ID_, D.PROC_STATUS_, D.VERSION_, D.DOC_STATUS_, D.CREATION_DATE_, D.UPDATE_DATE_, D.EFFECTIVE_DATE_, D.OPERATOR_ID_, D.OPERATOR_NAME_ from K_DOC D;

create or replace view KV_DOC_DATA as
select DD.DOC_DATA_ID_, DD.DOC_ID_, DD.BOOKMARK_, DD.VALUE_, DD.DATA_TYPE_, DD.ORDER_ from K_DOC_DATA DD;

create or replace view KV_DOC_RIDER as
select DR.DOC_RIDER_ID_, DR.DOC_ID_, DR.DOC_RIDER_FILE_NAME_, DR.DOC_RIDER_FILE_LENGTH_, DR.MD5_, DR.CREATION_DATE_, DR.UPDATE_DATE_, DR.OPERATOR_ID_, DR.OPERATOR_NAME_ from K_DOC_RIDER DR;

create or replace view KV_DOC_TYPE as
select DT.DOC_TYPE_ID_, DT.DOC_TYPE_NAME_, DT.TEMPLATE_FILE_NAME_, DT.TEMPLATE_FILE_LENGTH_, DT.HTML_, DT.BOOKMARK_, DT.INDEX_, DT.USING_TEMPLATE_, DT.PROC_DEF_CODE_, DT.DESC_, DT.ORDER_, DT.DOC_TYPE_STATUS_, DT.CREATION_DATE_, DT.UPDATE_DATE_, DT.OPERATOR_ID_, DT.OPERATOR_NAME_ from K_DOC_TYPE DT;

create or replace view OMV_CODE as
select CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_ from OM_CODE;

create or replace view OMV_DUTY as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, D.DUTY_ID_, D.DUTY_CODE_, D.DUTY_NAME_, D.DUTY_CATEGORY_, D.MEMO_, D.DUTY_TAG_, D.DUTY_EXT_ATTR_1_, D.DUTY_EXT_ATTR_2_, D.DUTY_EXT_ATTR_3_, D.DUTY_EXT_ATTR_4_, D.DUTY_EXT_ATTR_5_, D.DUTY_EXT_ATTR_6_, D.DUTY_EXT_ATTR_7_, D.DUTY_EXT_ATTR_8_, D.ORDER_, D.DUTY_STATUS_, D.CREATION_DATE_, D.UPDATE_DATE_, D.OPERATOR_ID_, D.OPERATOR_NAME_ from OM_DUTY D inner join OM_ORGN_SET ORGN_SET on ORGN_SET.ORGN_SET_ID_ = D.ORGN_SET_ID_;

create or replace view OMV_EMP as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, E.EMP_ID_, E.EMP_CODE_, E.EMP_NAME_, E.PASSWORD_RESET_REQ_, E.PARTY_, E.EMP_LEVEL_, E.GENDER_, E.BIRTH_DATE_, E.TEL_, E.EMAIL_, E.IN_DATE_, E.OUT_DATE_, E.EMP_CATEGORY_, E.MEMO_, E.EMP_TAG_, E.EMP_EXT_ATTR_1_, E.EMP_EXT_ATTR_2_, E.EMP_EXT_ATTR_3_, E.EMP_EXT_ATTR_4_, E.EMP_EXT_ATTR_5_, E.EMP_EXT_ATTR_6_, E.EMP_EXT_ATTR_7_, E.EMP_EXT_ATTR_8_, E.ORDER_, E.EMP_STATUS_, E.CREATION_DATE_, E.UPDATE_DATE_, E.OPERATOR_ID_, E.OPERATOR_NAME_, O1.ORG_ID_, O1.PARENT_ORG_ID_, O1.ORG_CODE_, O1.ORG_NAME_, O1.ORG_ABBR_NAME_, O1.ORG_TYPE_, O1.ORG_CATEGORY_, O1.ORG_TAG_, O1.ORG_EXT_ATTR_1_, O1.ORG_EXT_ATTR_2_, O1.ORG_EXT_ATTR_3_, O1.ORG_EXT_ATTR_4_, O1.ORG_EXT_ATTR_5_, O1.ORG_EXT_ATTR_6_, O1.ORG_EXT_ATTR_7_, O1.ORG_EXT_ATTR_8_, O1.ORG_STATUS_, O2.ORG_CODE_ as PARENT_ORG_CODE_, O2.ORG_NAME_ as PARENT_ORG_NAME_
  from OM_EMP E
 inner join OM_ORGN_SET ORGN_SET
    on ORGN_SET.ORGN_SET_ID_ = E.ORGN_SET_ID_
  left outer join OM_ORG O1
    on O1.ORGN_SET_ID_ = E.ORGN_SET_ID_
   and O1.ORG_ID_ = E.ORG_ID_
  left outer join OM_ORG O2
    on O2.ORGN_SET_ID_ = O1.ORGN_SET_ID_
   and O2.ORG_ID_ = O1.PARENT_ORG_ID_;

create or replace view OMV_EMP_RELATION as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, ER.EMP_RELATION_ID_, ER.EMP_RELATION_, ER.EMP_RELATION_CATEGORY_, ER.MEMO_, ER.EMP_RELATION_TAG_, ER.EMP_RELATION_EXT_ATTR_1_, ER.EMP_RELATION_EXT_ATTR_2_, ER.EMP_RELATION_EXT_ATTR_3_, ER.EMP_RELATION_EXT_ATTR_4_, ER.EMP_RELATION_EXT_ATTR_5_, ER.EMP_RELATION_EXT_ATTR_6_, ER.EMP_RELATION_EXT_ATTR_7_, ER.EMP_RELATION_EXT_ATTR_8_, ER.ORDER_, ER.EMP_RELATION_STATUS_, ER.CREATION_DATE_, ER.UPDATE_DATE_, ER.OPERATOR_ID_, ER.OPERATOR_NAME_, UE.EMP_ID_ as UPPER_EMP_ID_, UE.EMP_CODE_ as UPPER_EMP_CODE_, UE.EMP_NAME_ as UPPER_EMP_NAME_, UE.PASSWORD_RESET_REQ_ as UPPER_PASSWORD_RESET_REQ_, UE.PARTY_ as UPPER_PARTY_, UE.EMP_LEVEL_ as UPPER_EMP_LEVEL_, UE.GENDER_ as UPPER_GENDER_, UE.BIRTH_DATE_ as UPPER_BIRTH_DATE_, UE.TEL_ as UPPER_TEL_, UE.EMAIL_ as UPPER_EMAIL_, UE.IN_DATE_ as UPPER_IN_DATE_, UE.OUT_DATE_ as UPPER_OUT_DATE_, UE.EMP_CATEGORY_ as UPPER_EMP_CATEGORY_, UE.EMP_TAG_ as UPPER_EMP_TAG_, UE.EMP_EXT_ATTR_1_ as UPPER_EMP_EXT_ATTR_1_, UE.EMP_EXT_ATTR_2_ as UPPER_EMP_EXT_ATTR_2_, UE.EMP_EXT_ATTR_3_ as UPPER_EMP_EXT_ATTR_3_, UE.EMP_EXT_ATTR_4_ as UPPER_EMP_EXT_ATTR_4_, UE.EMP_EXT_ATTR_5_ as UPPER_EMP_EXT_ATTR_5_, UE.EMP_EXT_ATTR_6_ as UPPER_EMP_EXT_ATTR_6_, UE.EMP_EXT_ATTR_7_ as UPPER_EMP_EXT_ATTR_7_, UE.EMP_EXT_ATTR_8_ as UPPER_EMP_EXT_ATTR_8_, UE.EMP_STATUS_ as UPPER_EMP_STATUS_, UO1.ORG_ID_ as UPPER_ORG_ID_, UO1.PARENT_ORG_ID_ as UPPER_PARENT_ORG_ID_, UO1.ORG_CODE_ as UPPER_ORG_CODE_, UO1.ORG_NAME_ as UPPER_ORG_NAME_, UO1.ORG_ABBR_NAME_ as UPPER_ORG_ABBR_NAME_, UO1.ORG_TYPE_ as UPPER_ORG_TYPE_, UO1.ORG_CATEGORY_ as UPPER_ORG_CATEGORY_, UO1.ORG_TAG_ as UPPER_ORG_TAG_, UO1.ORG_EXT_ATTR_1_ as UPPER_ORG_EXT_ATTR_1_, UO1.ORG_EXT_ATTR_2_ as UPPER_ORG_EXT_ATTR_2_, UO1.ORG_EXT_ATTR_3_ as UPPER_ORG_EXT_ATTR_3_, UO1.ORG_EXT_ATTR_4_ as UPPER_ORG_EXT_ATTR_4_, UO1.ORG_EXT_ATTR_5_ as UPPER_ORG_EXT_ATTR_5_, UO1.ORG_EXT_ATTR_6_ as UPPER_ORG_EXT_ATTR_6_, UO1.ORG_EXT_ATTR_7_ as UPPER_ORG_EXT_ATTR_7_, UO1.ORG_EXT_ATTR_8_ as UPPER_ORG_EXT_ATTR_8_, UO1.ORG_STATUS_ as UPPER_ORG_STATUS_, UO2.ORG_CODE_ as UPPER_PARENT_ORG_CODE_, UO2.ORG_NAME_ as UPPER_PARENT_ORG_NAME_, LE.EMP_ID_ as LOWER_EMP_ID_, LE.EMP_CODE_ as LOWER_EMP_CODE_, LE.EMP_NAME_ as LOWER_EMP_NAME_, LE.PASSWORD_RESET_REQ_ as LOWER_PASSWORD_RESET_REQ_, LE.PARTY_ as LOWER_PARTY_, LE.EMP_LEVEL_ as LOWER_EMP_LEVEL_, LE.GENDER_ as LOWER_GENDER_, LE.BIRTH_DATE_ as LOWER_BIRTH_DATE_, LE.TEL_ as LOWER_TEL_, LE.EMAIL_ as LOWER_EMAIL_, LE.IN_DATE_ as LOWER_IN_DATE_, LE.OUT_DATE_ as LOWER_OUT_DATE_, LE.EMP_CATEGORY_ as LOWER_EMP_CATEGORY_, LE.EMP_TAG_ as LOWER_EMP_TAG_, LE.EMP_EXT_ATTR_1_ as LOWER_EMP_EXT_ATTR_1_, LE.EMP_EXT_ATTR_2_ as LOWER_EMP_EXT_ATTR_2_, LE.EMP_EXT_ATTR_3_ as LOWER_EMP_EXT_ATTR_3_, LE.EMP_EXT_ATTR_4_ as LOWER_EMP_EXT_ATTR_4_, LE.EMP_EXT_ATTR_5_ as LOWER_EMP_EXT_ATTR_5_, LE.EMP_EXT_ATTR_6_ as LOWER_EMP_EXT_ATTR_6_, LE.EMP_EXT_ATTR_7_ as LOWER_EMP_EXT_ATTR_7_, LE.EMP_EXT_ATTR_8_ as LOWER_EMP_EXT_ATTR_8_, LE.EMP_STATUS_ as LOWER_EMP_STATUS_, LO1.ORG_ID_ as LOWER_ORG_ID_, LO1.PARENT_ORG_ID_ as LOWER_PARENT_ORG_ID_, LO1.ORG_CODE_ as LOWER_ORG_CODE_, LO1.ORG_NAME_ as LOWER_ORG_NAME_, LO1.ORG_ABBR_NAME_ as LOWER_ORG_ABBR_NAME_, LO1.ORG_TYPE_ as LOWER_ORG_TYPE_, LO1.ORG_CATEGORY_ as LOWER_ORG_CATEGORY_, LO1.ORG_TAG_ as LOWER_ORG_TAG_, LO1.ORG_EXT_ATTR_1_ as LOWER_ORG_EXT_ATTR_1_, LO1.ORG_EXT_ATTR_2_ as LOWER_ORG_EXT_ATTR_2_, LO1.ORG_EXT_ATTR_3_ as LOWER_ORG_EXT_ATTR_3_, LO1.ORG_EXT_ATTR_4_ as LOWER_ORG_EXT_ATTR_4_, LO1.ORG_EXT_ATTR_5_ as LOWER_ORG_EXT_ATTR_5_, LO1.ORG_EXT_ATTR_6_ as LOWER_ORG_EXT_ATTR_6_, LO1.ORG_EXT_ATTR_7_ as LOWER_ORG_EXT_ATTR_7_, LO1.ORG_EXT_ATTR_8_ as LOWER_ORG_EXT_ATTR_8_, LO1.ORG_STATUS_ as LOWER_ORG_STATUS_, LO2.ORG_CODE_ as LOWER_PARENT_ORG_CODE_, LO2.ORG_NAME_ as LOWER_PARENT_ORG_NAME_
  from OM_EMP_RELATION ER
 inner join OM_ORGN_SET ORGN_SET
    on ORGN_SET.ORGN_SET_ID_ = ER.ORGN_SET_ID_
 inner join OM_EMP UE
    on UE.ORGN_SET_ID_ = ER.ORGN_SET_ID_
   and UE.EMP_ID_ = ER.UPPER_EMP_ID_
 inner join OM_ORG UO1
    on UO1.ORGN_SET_ID_ = UE.ORGN_SET_ID_
   and UO1.ORG_ID_ = UE.ORG_ID_
  left outer join OM_ORG UO2
    on UO2.ORGN_SET_ID_ = UO1.ORGN_SET_ID_
   and UO2.ORG_ID_ = UO1.PARENT_ORG_ID_
 inner join OM_EMP LE
    on LE.ORGN_SET_ID_ = ER.ORGN_SET_ID_
   and LE.EMP_ID_ = ER.LOWER_EMP_ID_
 inner join OM_ORG LO1
    on LO1.ORGN_SET_ID_ = LE.ORGN_SET_ID_
   and LO1.ORG_ID_ = LE.ORG_ID_
  left outer join OM_ORG LO2
    on LO2.ORGN_SET_ID_ = LO1.ORGN_SET_ID_
   and LO2.ORG_ID_ = LO1.PARENT_ORG_ID_;

create or replace view OMV_LOG as
select LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_ from OM_LOG;

create or replace view OMV_MAIN_SERVER as
select MS.MAIN_SERVER_ID_, MS.MAIN_SERVER_NAME_, MS.DRIVER_CLASS_NAME_, MS.URL_, MS.USERNAME_, MS.PASSWORD_, MS.MEMO_, MS.LAST_SYNC_DATE_, MS.ORDER_, MS.MAIN_SERVER_STATUS_, MS.CREATION_DATE_, MS.UPDATE_DATE_, MS.OPERATOR_ID_, MS.OPERATOR_NAME_ from OM_MAIN_SERVER MS;

create or replace view OMV_MIRROR_SERVER as
select MS.MIRROR_SERVER_ID_, MS.MIRROR_SERVER_NAME_, MS.DRIVER_CLASS_NAME_, MS.URL_, MS.USERNAME_, MS.PASSWORD_, MS.MEMO_, MS.LAST_SYNC_DATE_, MS.ORDER_, MS.MIRROR_SERVER_STATUS_, MS.CREATION_DATE_, MS.UPDATE_DATE_, MS.OPERATOR_ID_, MS.OPERATOR_NAME_ from OM_MIRROR_SERVER MS;

create or replace view OMV_ORG as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, O1.ORG_ID_, O1.PARENT_ORG_ID_, O1.ORG_CODE_, O1.ORG_NAME_, O1.ORG_ABBR_NAME_, O1.ORG_TYPE_, O1.ORG_CATEGORY_, O1.MEMO_, O1.ORG_TAG_, O1.ORG_EXT_ATTR_1_, O1.ORG_EXT_ATTR_2_, O1.ORG_EXT_ATTR_3_, O1.ORG_EXT_ATTR_4_, O1.ORG_EXT_ATTR_5_, O1.ORG_EXT_ATTR_6_, O1.ORG_EXT_ATTR_7_, O1.ORG_EXT_ATTR_8_, O1.ORDER_, O1.ORG_STATUS_, O1.CREATION_DATE_, O1.UPDATE_DATE_, O1.OPERATOR_ID_, O1.OPERATOR_NAME_, O2.ORG_CODE_ as PARENT_ORG_CODE_, O2.ORG_NAME_ as PARENT_ORG_NAME_
  from OM_ORG O1
 inner join OM_ORGN_SET ORGN_SET
    on ORGN_SET.ORGN_SET_ID_ = O1.ORGN_SET_ID_
  left outer join OM_ORG O2
    on O2.ORGN_SET_ID_ = O1.ORGN_SET_ID_
   and O2.ORG_ID_ = O1.PARENT_ORG_ID_;

create or replace view OMV_ORGN_SET as
select OS1.ORGN_SET_ID_, OS1.PARENT_ORGN_SET_ID_, OS1.ORGN_SET_CODE_, OS1.ORGN_SET_NAME_, OS1.ALLOW_SYNC_, OS1.MEMO_, OS1.ORDER_, OS1.ORGN_SET_STATUS_, OS1.CREATION_DATE_, OS1.UPDATE_DATE_, OS1.OPERATOR_ID_, OS1.OPERATOR_NAME_, OS2.ORGN_SET_CODE_ as PARENT_ORGN_SET_CODE_, OS2.ORGN_SET_NAME_ as PARENT_ORGN_SET_NAME_ from OM_ORGN_SET OS1 left outer join OM_ORGN_SET OS2 on OS2.ORGN_SET_ID_ = OS1.PARENT_ORGN_SET_ID_;

create or replace view OMV_POSI as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, P.POSI_ID_, P.POSI_CODE_, P.POSI_NAME_, P.ORG_LEADER_TYPE_, P.POSI_CATEGORY_, P.MEMO_, P.POSI_TAG_, P.POSI_EXT_ATTR_1_, P.POSI_EXT_ATTR_2_, P.POSI_EXT_ATTR_3_, P.POSI_EXT_ATTR_4_, P.POSI_EXT_ATTR_5_, P.POSI_EXT_ATTR_6_, P.POSI_EXT_ATTR_7_, P.POSI_EXT_ATTR_8_, P.ORDER_, P.POSI_STATUS_, P.CREATION_DATE_, P.UPDATE_DATE_, P.OPERATOR_ID_, P.OPERATOR_NAME_, D.DUTY_ID_, D.DUTY_CODE_, D.DUTY_NAME_, D.DUTY_CATEGORY_, D.DUTY_TAG_, D.DUTY_EXT_ATTR_1_, D.DUTY_EXT_ATTR_2_, D.DUTY_EXT_ATTR_3_, D.DUTY_EXT_ATTR_4_, D.DUTY_EXT_ATTR_5_, D.DUTY_EXT_ATTR_6_, D.DUTY_EXT_ATTR_7_, D.DUTY_EXT_ATTR_8_, D.DUTY_STATUS_, O1.ORG_ID_, O1.PARENT_ORG_ID_, O1.ORG_CODE_, O1.ORG_NAME_, O1.ORG_ABBR_NAME_, O1.ORG_TYPE_, O1.ORG_CATEGORY_, O1.ORG_TAG_, O1.ORG_EXT_ATTR_1_, O1.ORG_EXT_ATTR_2_, O1.ORG_EXT_ATTR_3_, O1.ORG_EXT_ATTR_4_, O1.ORG_EXT_ATTR_5_, O1.ORG_EXT_ATTR_6_, O1.ORG_EXT_ATTR_7_, O1.ORG_EXT_ATTR_8_, O1.ORG_STATUS_, O2.ORG_CODE_ as PARENT_ORG_CODE_, O2.ORG_NAME_ as PARENT_ORG_NAME_
  from OM_POSI P
 inner join OM_ORGN_SET ORGN_SET
    on ORGN_SET.ORGN_SET_ID_ = P.ORGN_SET_ID_
  left outer join OM_DUTY D
    on D.ORGN_SET_ID_ = P.ORGN_SET_ID_
   and D.DUTY_ID_ = P.DUTY_ID_
 inner join OM_ORG O1
    on O1.ORGN_SET_ID_ = P.ORGN_SET_ID_
   and O1.ORG_ID_ = P.ORG_ID_
  left outer join OM_ORG O2
    on O2.ORGN_SET_ID_ = O1.ORGN_SET_ID_
   and O2.ORG_ID_ = O1.PARENT_ORG_ID_;

create or replace view OMV_POSI_EMP as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, PE.POSI_EMP_ID_, PE.MAIN_, PE.POSI_EMP_CATEGORY_, PE.MEMO_, PE.POSI_EMP_TAG_, PE.POSI_EMP_EXT_ATTR_1_, PE.POSI_EMP_EXT_ATTR_2_, PE.POSI_EMP_EXT_ATTR_3_, PE.POSI_EMP_EXT_ATTR_4_, PE.POSI_EMP_EXT_ATTR_5_, PE.POSI_EMP_EXT_ATTR_6_, PE.POSI_EMP_EXT_ATTR_7_, PE.POSI_EMP_EXT_ATTR_8_, PE.ORDER_, PE.POSI_EMP_STATUS_, PE.CREATION_DATE_, PE.UPDATE_DATE_, PE.OPERATOR_ID_, PE.OPERATOR_NAME_, E.EMP_ID_, E.EMP_CODE_, E.EMP_NAME_, E.PASSWORD_RESET_REQ_, E.PARTY_, E.EMP_LEVEL_, E.GENDER_, E.BIRTH_DATE_, E.TEL_, E.EMAIL_, E.IN_DATE_, E.OUT_DATE_, E.EMP_CATEGORY_, E.EMP_TAG_, E.EMP_EXT_ATTR_1_, E.EMP_EXT_ATTR_2_, E.EMP_EXT_ATTR_3_, E.EMP_EXT_ATTR_4_, E.EMP_EXT_ATTR_5_, E.EMP_EXT_ATTR_6_, E.EMP_EXT_ATTR_7_, E.EMP_EXT_ATTR_8_, E.EMP_STATUS_, P.POSI_ID_, P.POSI_CODE_, P.POSI_NAME_, P.ORG_LEADER_TYPE_, P.POSI_CATEGORY_, P.POSI_TAG_, P.POSI_EXT_ATTR_1_, P.POSI_EXT_ATTR_2_, P.POSI_EXT_ATTR_3_, P.POSI_EXT_ATTR_4_, P.POSI_EXT_ATTR_5_, P.POSI_EXT_ATTR_6_, P.POSI_EXT_ATTR_7_, P.POSI_EXT_ATTR_8_, P.POSI_STATUS_, D.DUTY_ID_, D.DUTY_CODE_, D.DUTY_NAME_, D.DUTY_CATEGORY_, D.DUTY_TAG_, D.DUTY_EXT_ATTR_1_, D.DUTY_EXT_ATTR_2_, D.DUTY_EXT_ATTR_3_, D.DUTY_EXT_ATTR_4_, D.DUTY_EXT_ATTR_5_, D.DUTY_EXT_ATTR_6_, D.DUTY_EXT_ATTR_7_, D.DUTY_EXT_ATTR_8_, D.DUTY_STATUS_, O1.ORG_ID_, O1.PARENT_ORG_ID_, O1.ORG_CODE_, O1.ORG_NAME_, O1.ORG_ABBR_NAME_, O1.ORG_TYPE_, O1.ORG_CATEGORY_, O1.ORG_TAG_, O1.ORG_EXT_ATTR_1_, O1.ORG_EXT_ATTR_2_, O1.ORG_EXT_ATTR_3_, O1.ORG_EXT_ATTR_4_, O1.ORG_EXT_ATTR_5_, O1.ORG_EXT_ATTR_6_, O1.ORG_EXT_ATTR_7_, O1.ORG_EXT_ATTR_8_, O1.ORG_STATUS_, O2.ORG_CODE_ as PARENT_ORG_CODE_, O2.ORG_NAME_ as PARENT_ORG_NAME_
  from OM_POSI_EMP PE
 inner join OM_ORGN_SET ORGN_SET
    on ORGN_SET.ORGN_SET_ID_ = PE.ORGN_SET_ID_
 inner join OM_EMP E
    on E.ORGN_SET_ID_ = PE.ORGN_SET_ID_
   and E.EMP_ID_ = PE.EMP_ID_
 inner join OM_POSI P
    on P.ORGN_SET_ID_ = PE.ORGN_SET_ID_
   and P.POSI_ID_ = PE.POSI_ID_
  left outer join OM_DUTY D
    on D.ORGN_SET_ID_ = P.ORGN_SET_ID_
   and D.DUTY_ID_ = P.DUTY_ID_
 inner join OM_ORG O1
    on O1.ORGN_SET_ID_ = P.ORGN_SET_ID_
   and O1.ORG_ID_ = P.ORG_ID_
  left outer join OM_ORG O2
    on O2.ORGN_SET_ID_ = O1.ORGN_SET_ID_
   and O2.ORG_ID_ = O1.PARENT_ORG_ID_;

create or replace view OMV_TAG as
select T.ORGN_SET_ID_, T.TAG_ID_, T.OBJ_ID_, T.OBJ_TYPE_, T.TAG_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_ from OM_TAG T inner join OM_ORGN_SET ORGN_SET on ORGN_SET.ORGN_SET_ID_ = T.ORGN_SET_ID_;
