prompt PL/SQL Developer Export User Objects for user DOC@DOC
prompt Created by Administrator on 2023年12月8日
set define off
spool 1.log

prompt
prompt Creating table CB_CODE
prompt ======================
prompt
create table CB_CODE
(
  code_id_        VARCHAR2(40) not null,
  parent_code_id_ VARCHAR2(40),
  category_       VARCHAR2(40) not null,
  code_           VARCHAR2(60) not null,
  name_           VARCHAR2(60),
  ext_attr_1_     VARCHAR2(60),
  ext_attr_2_     VARCHAR2(60),
  ext_attr_3_     VARCHAR2(60),
  ext_attr_4_     VARCHAR2(60),
  ext_attr_5_     VARCHAR2(60),
  ext_attr_6_     VARCHAR2(60),
  order_          INTEGER
)
;
comment on table CB_CODE
  is '代码';
comment on column CB_CODE.code_id_
  is '代码ID';
comment on column CB_CODE.parent_code_id_
  is '上级代码ID';
comment on column CB_CODE.category_
  is '分类';
comment on column CB_CODE.code_
  is '代码';
comment on column CB_CODE.name_
  is '名称';
comment on column CB_CODE.ext_attr_1_
  is '扩展属性1';
comment on column CB_CODE.ext_attr_2_
  is '扩展属性2';
comment on column CB_CODE.ext_attr_3_
  is '扩展属性3';
comment on column CB_CODE.ext_attr_4_
  is '扩展属性4';
comment on column CB_CODE.ext_attr_5_
  is '扩展属性5';
comment on column CB_CODE.ext_attr_6_
  is '扩展属性6';
comment on column CB_CODE.order_
  is '排序';
alter table CB_CODE
  add constraint PK_CODE primary key (CODE_ID_);
alter table CB_CODE
  add constraint UQ_CODE unique (CATEGORY_, CODE_);
alter table CB_CODE
  add constraint FK_CODE foreign key (PARENT_CODE_ID_)
  references CB_CODE (CODE_ID_);

prompt
prompt Creating table CB_CUSTOM_THEME
prompt ==============================
prompt
create table CB_CUSTOM_THEME
(
  custom_theme_id_ VARCHAR2(40) not null,
  operator_id_     VARCHAR2(40),
  css_href_        VARCHAR2(60)
)
;
comment on table CB_CUSTOM_THEME
  is '定制主题';
comment on column CB_CUSTOM_THEME.custom_theme_id_
  is '定制主题ID';
comment on column CB_CUSTOM_THEME.operator_id_
  is '操作人员ID';
comment on column CB_CUSTOM_THEME.css_href_
  is 'CSS链接';
alter table CB_CUSTOM_THEME
  add constraint PK_CUSTOM_THEME primary key (CUSTOM_THEME_ID_);
alter table CB_CUSTOM_THEME
  add constraint UQ_CUSTOM_THEME unique (OPERATOR_ID_);

prompt
prompt Creating table CB_DASHBOARD_MODULE
prompt ==================================
prompt
create table CB_DASHBOARD_MODULE
(
  dashboard_module_id_     VARCHAR2(40) not null,
  dashboard_module_name_   VARCHAR2(60) not null,
  dashboard_module_type_   VARCHAR2(60),
  default_url_             VARCHAR2(300) not null,
  default_width_           VARCHAR2(10) not null,
  default_height_          VARCHAR2(10) not null,
  dashboard_module_tag_    VARCHAR2(60),
  order_                   INTEGER,
  dashboard_module_status_ VARCHAR2(20) not null
)
;
comment on table CB_DASHBOARD_MODULE
  is '仪表盘模块';
comment on column CB_DASHBOARD_MODULE.dashboard_module_id_
  is '仪表盘模块ID';
comment on column CB_DASHBOARD_MODULE.dashboard_module_name_
  is '仪表盘模块名称';
comment on column CB_DASHBOARD_MODULE.dashboard_module_type_
  is '仪表盘模块类型';
comment on column CB_DASHBOARD_MODULE.default_url_
  is '默认链接';
comment on column CB_DASHBOARD_MODULE.default_width_
  is '默认宽度';
comment on column CB_DASHBOARD_MODULE.default_height_
  is '默认高度';
comment on column CB_DASHBOARD_MODULE.dashboard_module_tag_
  is '仪表盘模块标签';
comment on column CB_DASHBOARD_MODULE.order_
  is '排序';
comment on column CB_DASHBOARD_MODULE.dashboard_module_status_
  is '仪表盘模块状态';
alter table CB_DASHBOARD_MODULE
  add constraint PK_DASHBOARD_MODULE primary key (DASHBOARD_MODULE_ID_);

prompt
prompt Creating table CB_DASHBOARD
prompt ===========================
prompt
create table CB_DASHBOARD
(
  dashboard_id_          VARCHAR2(40) not null,
  dashboard_module_id_   VARCHAR2(40) not null,
  posi_emp_id_           VARCHAR2(40),
  dashboard_module_name_ VARCHAR2(60) not null,
  url_                   VARCHAR2(300) not null,
  width_                 VARCHAR2(10) not null,
  height_                VARCHAR2(10) not null,
  order_                 INTEGER
)
;
comment on table CB_DASHBOARD
  is '仪表盘';
comment on column CB_DASHBOARD.dashboard_id_
  is '仪表盘ID';
comment on column CB_DASHBOARD.dashboard_module_id_
  is '仪表盘模块ID';
comment on column CB_DASHBOARD.posi_emp_id_
  is '岗位人员ID';
comment on column CB_DASHBOARD.dashboard_module_name_
  is '仪表盘模块名称';
comment on column CB_DASHBOARD.url_
  is '链接';
comment on column CB_DASHBOARD.width_
  is '宽度';
comment on column CB_DASHBOARD.height_
  is '高度';
comment on column CB_DASHBOARD.order_
  is '排序';
alter table CB_DASHBOARD
  add constraint PK_DASHBOARD primary key (DASHBOARD_ID_);
alter table CB_DASHBOARD
  add constraint FK_DASHBOARD_DASHBOARD_MODULE foreign key (DASHBOARD_MODULE_ID_)
  references CB_DASHBOARD_MODULE (DASHBOARD_MODULE_ID_);

prompt
prompt Creating table CB_DUTY_MENU
prompt ===========================
prompt
create table CB_DUTY_MENU
(
  duty_menu_id_  VARCHAR2(40) not null,
  duty_id_       VARCHAR2(40) not null,
  duty_name_     VARCHAR2(60),
  menu_id_       VARCHAR2(40) not null,
  creation_date_ TIMESTAMP(6),
  update_date_   TIMESTAMP(6),
  operator_id_   VARCHAR2(40),
  operator_name_ VARCHAR2(60)
)
compress for all operations;
comment on table CB_DUTY_MENU
  is '职务菜单';
comment on column CB_DUTY_MENU.duty_menu_id_
  is '职务菜单ID';
comment on column CB_DUTY_MENU.duty_id_
  is '职务ID';
comment on column CB_DUTY_MENU.duty_name_
  is '职务名称';
comment on column CB_DUTY_MENU.menu_id_
  is '菜单ID';
comment on column CB_DUTY_MENU.creation_date_
  is '创建日期';
comment on column CB_DUTY_MENU.update_date_
  is '更新日期';
comment on column CB_DUTY_MENU.operator_id_
  is '操作人员ID';
comment on column CB_DUTY_MENU.operator_name_
  is '操作人员名称';
create index IX_DUTY_MENU_DUTY on CB_DUTY_MENU (DUTY_ID_);
alter table CB_DUTY_MENU
  add constraint PK_DUTY_MENU primary key (DUTY_MENU_ID_);
alter table CB_DUTY_MENU
  add constraint UQ_DUTY_MENU unique (DUTY_ID_, MENU_ID_);

prompt
prompt Creating table CB_LOG
prompt =====================
prompt
create table CB_LOG
(
  log_id_        VARCHAR2(40) not null,
  category_      VARCHAR2(60),
  ip_            VARCHAR2(60),
  url_           CLOB,
  action_        VARCHAR2(200),
  parameter_map_ CLOB,
  business_key_  VARCHAR2(100),
  error_         VARCHAR2(20),
  message_       CLOB,
  org_id_        VARCHAR2(40),
  org_name_      VARCHAR2(60),
  posi_id_       VARCHAR2(40),
  posi_name_     VARCHAR2(60),
  emp_id_        VARCHAR2(40),
  emp_name_      VARCHAR2(60),
  creation_date_ TIMESTAMP(6) not null,
  user_agent_    VARCHAR2(400)
)
;
comment on table CB_LOG
  is '日志';
comment on column CB_LOG.log_id_
  is '日志ID';
comment on column CB_LOG.category_
  is '分类';
comment on column CB_LOG.ip_
  is 'IP';
comment on column CB_LOG.url_
  is '调用URL';
comment on column CB_LOG.action_
  is '调用控制层接口';
comment on column CB_LOG.parameter_map_
  is '调用参数';
comment on column CB_LOG.business_key_
  is '业务主键';
comment on column CB_LOG.error_
  is '错误';
comment on column CB_LOG.message_
  is '信息';
comment on column CB_LOG.org_id_
  is '机构ID';
comment on column CB_LOG.org_name_
  is '机构名称';
comment on column CB_LOG.posi_id_
  is '岗位ID';
comment on column CB_LOG.posi_name_
  is '岗位名称';
comment on column CB_LOG.emp_id_
  is '人员ID';
comment on column CB_LOG.emp_name_
  is '人员名称';
comment on column CB_LOG.creation_date_
  is '创建日期';
comment on column CB_LOG.user_agent_
  is '用户代理';
create index IX_LOG_ACTION on CB_LOG (ACTION_);
create index IX_LOG_BUSINESS_KEY on CB_LOG (BUSINESS_KEY_);
create index IX_LOG_CREATION_DATE on CB_LOG (CREATION_DATE_);
alter table CB_LOG
  add constraint PK_LOG primary key (LOG_ID_);

prompt
prompt Creating table CB_MENU
prompt ======================
prompt
create table CB_MENU
(
  menu_id_        VARCHAR2(40) not null,
  parent_menu_id_ VARCHAR2(40),
  menu_name_      VARCHAR2(60) not null,
  menu_type_      VARCHAR2(20) not null,
  url_            VARCHAR2(200),
  order_          INTEGER,
  menu_status_    VARCHAR2(20) not null,
  creation_date_  TIMESTAMP(6),
  update_date_    TIMESTAMP(6),
  operator_id_    VARCHAR2(40),
  operator_name_  VARCHAR2(60),
  icon_           VARCHAR2(40)
)
;
comment on table CB_MENU
  is '菜单';
comment on column CB_MENU.menu_id_
  is '菜单ID';
comment on column CB_MENU.parent_menu_id_
  is '上级菜单ID';
comment on column CB_MENU.menu_name_
  is '菜单名称';
comment on column CB_MENU.menu_type_
  is '菜单类型';
comment on column CB_MENU.url_
  is '链接地址';
comment on column CB_MENU.order_
  is '排序';
comment on column CB_MENU.menu_status_
  is '菜单状态';
comment on column CB_MENU.creation_date_
  is '创建日期';
comment on column CB_MENU.update_date_
  is '更新日期';
comment on column CB_MENU.operator_id_
  is '操作人员ID';
comment on column CB_MENU.operator_name_
  is '操作人员名称';
comment on column CB_MENU.icon_
  is '图标地址';
alter table CB_MENU
  add constraint PK_MENU primary key (MENU_ID_);
alter table CB_MENU
  add constraint FK_MENU_PARENT foreign key (PARENT_MENU_ID_)
  references CB_MENU (MENU_ID_);

prompt
prompt Creating table CB_NOTICE
prompt ========================
prompt
create table CB_NOTICE
(
  notice_id_     VARCHAR2(40) not null,
  posi_emp_id_   VARCHAR2(40),
  emp_id_        VARCHAR2(40),
  emp_code_      VARCHAR2(60),
  emp_name_      VARCHAR2(60),
  content_       VARCHAR2(600) not null,
  source_        VARCHAR2(60),
  identity_      VARCHAR2(40),
  redirect_url_  VARCHAR2(200),
  biz_url_       VARCHAR2(500),
  exp_date_      TIMESTAMP(6),
  notice_status_ VARCHAR2(20) not null,
  creation_date_ TIMESTAMP(6) not null
)
;
comment on table CB_NOTICE
  is '通知';
comment on column CB_NOTICE.notice_id_
  is '通知ID';
comment on column CB_NOTICE.posi_emp_id_
  is '岗位人员ID';
comment on column CB_NOTICE.emp_id_
  is '人员ID';
comment on column CB_NOTICE.emp_code_
  is '人员编码';
comment on column CB_NOTICE.emp_name_
  is '人员名称';
comment on column CB_NOTICE.content_
  is '内容';
comment on column CB_NOTICE.source_
  is '来源';
comment on column CB_NOTICE.identity_
  is '令牌';
comment on column CB_NOTICE.redirect_url_
  is '重定向链接';
comment on column CB_NOTICE.biz_url_
  is '业务链接';
comment on column CB_NOTICE.exp_date_
  is '过期日期';
comment on column CB_NOTICE.notice_status_
  is '通知状态';
comment on column CB_NOTICE.creation_date_
  is '创建日期';
alter table CB_NOTICE
  add constraint PK_ALERT primary key (NOTICE_ID_);

prompt
prompt Creating table CB_POSI_EMP_MENU
prompt ===============================
prompt
create table CB_POSI_EMP_MENU
(
  posi_emp_menu_id_ VARCHAR2(40) not null,
  posi_emp_id_      VARCHAR2(40) not null,
  posi_name_        VARCHAR2(60),
  emp_name_         VARCHAR2(60),
  menu_id_          VARCHAR2(40) not null,
  creation_date_    TIMESTAMP(6),
  update_date_      TIMESTAMP(6),
  operator_id_      VARCHAR2(40),
  operator_name_    VARCHAR2(60)
)
;
comment on table CB_POSI_EMP_MENU
  is '岗位人员菜单';
comment on column CB_POSI_EMP_MENU.posi_emp_menu_id_
  is '岗位人员菜单ID';
comment on column CB_POSI_EMP_MENU.posi_emp_id_
  is '岗位人员ID';
comment on column CB_POSI_EMP_MENU.posi_name_
  is '岗位名称';
comment on column CB_POSI_EMP_MENU.emp_name_
  is '人员名称';
comment on column CB_POSI_EMP_MENU.menu_id_
  is '菜单ID';
comment on column CB_POSI_EMP_MENU.creation_date_
  is '创建日期';
comment on column CB_POSI_EMP_MENU.update_date_
  is '更新日期';
comment on column CB_POSI_EMP_MENU.operator_id_
  is '操作人员ID';
comment on column CB_POSI_EMP_MENU.operator_name_
  is '操作人员名称';
create index IX_POSI_EMP_MENU_POSI on CB_POSI_EMP_MENU (POSI_EMP_ID_);
alter table CB_POSI_EMP_MENU
  add constraint PK_POSI_EMP_MENU primary key (POSI_EMP_MENU_ID_);

prompt
prompt Creating table CB_POSI_MENU
prompt ===========================
prompt
create table CB_POSI_MENU
(
  posi_menu_id_  VARCHAR2(40) not null,
  posi_id_       VARCHAR2(40) not null,
  posi_name_     VARCHAR2(60),
  menu_id_       VARCHAR2(40) not null,
  creation_date_ TIMESTAMP(6),
  update_date_   TIMESTAMP(6),
  operator_id_   VARCHAR2(40),
  operator_name_ VARCHAR2(60)
)
;
comment on table CB_POSI_MENU
  is '岗位菜单';
comment on column CB_POSI_MENU.posi_menu_id_
  is '岗位菜单ID';
comment on column CB_POSI_MENU.posi_id_
  is '岗位ID';
comment on column CB_POSI_MENU.posi_name_
  is '岗位名称';
comment on column CB_POSI_MENU.menu_id_
  is '菜单ID';
comment on column CB_POSI_MENU.creation_date_
  is '创建日期';
comment on column CB_POSI_MENU.update_date_
  is '更新日期';
comment on column CB_POSI_MENU.operator_id_
  is '操作人员ID';
comment on column CB_POSI_MENU.operator_name_
  is '操作人员名称';
create index IX_POSI_MENU_POSI on CB_POSI_MENU (POSI_ID_);
alter table CB_POSI_MENU
  add constraint PK_POSI_MENU primary key (POSI_MENU_ID_);

prompt
prompt Creating table CB_RIDER
prompt =======================
prompt
create table CB_RIDER
(
  rider_id_          VARCHAR2(40) not null,
  obj_id_            VARCHAR2(40),
  rider_file_        BLOB not null,
  rider_file_name_   VARCHAR2(300),
  rider_file_length_ INTEGER,
  memo_              VARCHAR2(300),
  rider_tag_         VARCHAR2(120),
  order_             INTEGER,
  rider_status_      VARCHAR2(20) not null,
  creation_date_     TIMESTAMP(6),
  update_date_       TIMESTAMP(6),
  operator_id_       VARCHAR2(40),
  operator_name_     VARCHAR2(60)
)
;
comment on table CB_RIDER
  is '附件';
comment on column CB_RIDER.rider_id_
  is '附件ID';
comment on column CB_RIDER.obj_id_
  is '对象ID';
comment on column CB_RIDER.rider_file_
  is '附件文件';
comment on column CB_RIDER.rider_file_name_
  is '附件文件名称';
comment on column CB_RIDER.rider_file_length_
  is '附件文件长度';
comment on column CB_RIDER.memo_
  is '备注';
comment on column CB_RIDER.rider_tag_
  is '附件标签';
comment on column CB_RIDER.order_
  is '排序';
comment on column CB_RIDER.rider_status_
  is '附件状态';
comment on column CB_RIDER.creation_date_
  is '创建日期';
comment on column CB_RIDER.update_date_
  is '更新日期';
comment on column CB_RIDER.operator_id_
  is '操作人员ID';
comment on column CB_RIDER.operator_name_
  is '操作人员名称';
alter table CB_RIDER
  add constraint PK_RIDER primary key (RIDER_ID_);

prompt
prompt Creating table CB_TAG
prompt =====================
prompt
create table CB_TAG
(
  tag_id_   VARCHAR2(40) not null,
  obj_id_   VARCHAR2(40) not null,
  obj_type_ VARCHAR2(60),
  tag_      VARCHAR2(60) not null
)
;
comment on table CB_TAG
  is '标签';
comment on column CB_TAG.tag_id_
  is '标签ID';
comment on column CB_TAG.obj_id_
  is '对象ID';
comment on column CB_TAG.obj_type_
  is '对象类型';
comment on column CB_TAG.tag_
  is '标签';
alter table CB_TAG
  add constraint PK_TAG primary key (TAG_ID_);

prompt
prompt Creating table CB_WORKING_CALENDAR
prompt ==================================
prompt
create table CB_WORKING_CALENDAR
(
  working_calendar_id_ VARCHAR2(40) not null,
  emp_id_              VARCHAR2(40),
  date_                DATE not null,
  working_day_         VARCHAR2(20) not null,
  mark_                VARCHAR2(300)
)
;
comment on table CB_WORKING_CALENDAR
  is '工作日历';
comment on column CB_WORKING_CALENDAR.working_calendar_id_
  is '工作日历ID';
comment on column CB_WORKING_CALENDAR.emp_id_
  is '人员ID';
comment on column CB_WORKING_CALENDAR.date_
  is '日期';
comment on column CB_WORKING_CALENDAR.working_day_
  is '工作日';
comment on column CB_WORKING_CALENDAR.mark_
  is '标注';
alter table CB_WORKING_CALENDAR
  add constraint PK_WORKING_CALENDAR primary key (WORKING_CALENDAR_ID_);
alter table CB_WORKING_CALENDAR
  add constraint UQ_WORKING_CALENDAR unique (EMP_ID_, DATE_);

prompt
prompt Creating table FF_PROC_DEF
prompt ==========================
prompt
create table FF_PROC_DEF
(
  proc_def_id_                  VARCHAR2(40) not null,
  proc_def_code_                VARCHAR2(60) not null,
  proc_def_name_                VARCHAR2(60) not null,
  proc_def_cat_                 VARCHAR2(100),
  proc_def_model_               CLOB not null,
  proc_def_diagram_file_        BLOB,
  proc_def_diagram_file_name_   VARCHAR2(300),
  proc_def_diagram_file_length_ INTEGER,
  proc_def_diagram_width_       INTEGER,
  proc_def_diagram_height_      INTEGER,
  memo_                         VARCHAR2(300),
  version_                      INTEGER not null,
  proc_def_status_              VARCHAR2(20) not null,
  creation_date_                TIMESTAMP(6),
  update_date_                  TIMESTAMP(6),
  operator_id_                  VARCHAR2(40),
  operator_name_                VARCHAR2(60)
)
;
comment on table FF_PROC_DEF
  is '流程定义';
comment on column FF_PROC_DEF.proc_def_id_
  is '流程定义ID';
comment on column FF_PROC_DEF.proc_def_code_
  is '流程定义编码';
comment on column FF_PROC_DEF.proc_def_name_
  is '流程定义名称';
comment on column FF_PROC_DEF.proc_def_cat_
  is '流程定义分类';
comment on column FF_PROC_DEF.proc_def_model_
  is '流程定义模型';
comment on column FF_PROC_DEF.proc_def_diagram_file_
  is '流程定义图文件';
comment on column FF_PROC_DEF.proc_def_diagram_file_name_
  is '流程定义图文件名称';
comment on column FF_PROC_DEF.proc_def_diagram_file_length_
  is '流程定义图文件长度';
comment on column FF_PROC_DEF.proc_def_diagram_width_
  is '流程定义图宽度';
comment on column FF_PROC_DEF.proc_def_diagram_height_
  is '流程定义图高度';
comment on column FF_PROC_DEF.memo_
  is '备注';
comment on column FF_PROC_DEF.version_
  is '版本';
comment on column FF_PROC_DEF.proc_def_status_
  is '流程定义状态';
comment on column FF_PROC_DEF.creation_date_
  is '创建日期';
comment on column FF_PROC_DEF.update_date_
  is '更新日期';
comment on column FF_PROC_DEF.operator_id_
  is '操作人员ID';
comment on column FF_PROC_DEF.operator_name_
  is '操作人员名称';
alter table FF_PROC_DEF
  add constraint PK_FF_PROC_DEF primary key (PROC_DEF_ID_);
alter table FF_PROC_DEF
  add constraint UQ_FF_PROC_DEF unique (PROC_DEF_CODE_, VERSION_);

prompt
prompt Creating table FF_ADJUST_PROC_DEF
prompt =================================
prompt
create table FF_ADJUST_PROC_DEF
(
  adjust_proc_def_id_           VARCHAR2(40) not null,
  proc_def_id_                  VARCHAR2(40) not null,
  proc_def_model_               CLOB not null,
  proc_def_diagram_file_        BLOB,
  proc_def_diagram_file_name_   VARCHAR2(300),
  proc_def_diagram_file_length_ INTEGER,
  proc_def_diagram_width_       INTEGER,
  proc_def_diagram_height_      INTEGER,
  creation_date_                TIMESTAMP(6),
  update_date_                  TIMESTAMP(6),
  operator_id_                  VARCHAR2(40),
  operator_name_                VARCHAR2(60)
)
;
comment on table FF_ADJUST_PROC_DEF
  is '调整流程定义';
comment on column FF_ADJUST_PROC_DEF.adjust_proc_def_id_
  is '调整流程定义ID';
comment on column FF_ADJUST_PROC_DEF.proc_def_id_
  is '流程定义ID';
comment on column FF_ADJUST_PROC_DEF.proc_def_model_
  is '流程定义模型';
comment on column FF_ADJUST_PROC_DEF.proc_def_diagram_file_
  is '流程定义图文件';
comment on column FF_ADJUST_PROC_DEF.proc_def_diagram_file_name_
  is '流程定义图文件名称';
comment on column FF_ADJUST_PROC_DEF.proc_def_diagram_file_length_
  is '流程定义图文件长度';
comment on column FF_ADJUST_PROC_DEF.proc_def_diagram_width_
  is '流程定义图宽度';
comment on column FF_ADJUST_PROC_DEF.proc_def_diagram_height_
  is '流程定义图高度';
comment on column FF_ADJUST_PROC_DEF.creation_date_
  is '创建日期';
comment on column FF_ADJUST_PROC_DEF.update_date_
  is '更新日期';
comment on column FF_ADJUST_PROC_DEF.operator_id_
  is '操作人员ID';
comment on column FF_ADJUST_PROC_DEF.operator_name_
  is '操作人员名称';
alter table FF_ADJUST_PROC_DEF
  add constraint PK_FF_ADJUST_PROC_DEF primary key (ADJUST_PROC_DEF_ID_);
alter table FF_ADJUST_PROC_DEF
  add constraint FK_FF_ADJUST_PROC_DEF_PROC_DEF foreign key (PROC_DEF_ID_)
  references FF_PROC_DEF (PROC_DEF_ID_);

prompt
prompt Creating table FF_DELEGATE
prompt ==========================
prompt
create table FF_DELEGATE
(
  delegate_id_    VARCHAR2(40) not null,
  assignee_       VARCHAR2(60),
  assignee_name_  VARCHAR2(60),
  delegator_      VARCHAR2(60) not null,
  delegator_name_ VARCHAR2(60),
  start_date_     TIMESTAMP(6),
  end_date_       TIMESTAMP(6)
)
;
comment on table FF_DELEGATE
  is '代理';
comment on column FF_DELEGATE.delegate_id_
  is '代理ID';
comment on column FF_DELEGATE.assignee_
  is '办理人';
comment on column FF_DELEGATE.assignee_name_
  is '办理人名称';
comment on column FF_DELEGATE.delegator_
  is '代理人';
comment on column FF_DELEGATE.delegator_name_
  is '代理人名称';
comment on column FF_DELEGATE.start_date_
  is '开始日期';
comment on column FF_DELEGATE.end_date_
  is '结束日期';
alter table FF_DELEGATE
  add constraint PK_FF_DELEGATE primary key (DELEGATE_ID_);

prompt
prompt Creating table FF_PROC
prompt ======================
prompt
create table FF_PROC
(
  proc_id_                  VARCHAR2(40) not null,
  proc_def_id_              VARCHAR2(40) not null,
  adjust_proc_def_id_       VARCHAR2(40),
  isolate_sub_proc_node_id_ VARCHAR2(40),
  biz_id_                   VARCHAR2(40),
  biz_type_                 VARCHAR2(60),
  biz_code_                 VARCHAR2(100),
  biz_name_                 VARCHAR2(100),
  biz_desc_                 VARCHAR2(300),
  proc_start_user_          VARCHAR2(40),
  proc_start_user_name_     VARCHAR2(60),
  proc_end_user_            VARCHAR2(40),
  proc_end_user_name_       VARCHAR2(60),
  proc_end_date_            TIMESTAMP(6),
  proc_status_              VARCHAR2(20) not null,
  creation_date_            TIMESTAMP(6) not null
)
;
comment on table FF_PROC
  is '流程';
comment on column FF_PROC.proc_id_
  is '流程ID';
comment on column FF_PROC.proc_def_id_
  is '流程定义ID';
comment on column FF_PROC.adjust_proc_def_id_
  is '调整流程定义ID';
comment on column FF_PROC.isolate_sub_proc_node_id_
  is '独立子流程所属节点ID';
comment on column FF_PROC.biz_id_
  is '业务主键';
comment on column FF_PROC.biz_type_
  is '业务类型';
comment on column FF_PROC.biz_code_
  is '业务编码';
comment on column FF_PROC.biz_name_
  is '业务名称';
comment on column FF_PROC.biz_desc_
  is '业务备注';
comment on column FF_PROC.proc_start_user_
  is '流程开始人员';
comment on column FF_PROC.proc_start_user_name_
  is '流程开始人员名称';
comment on column FF_PROC.proc_end_user_
  is '流程完成人员';
comment on column FF_PROC.proc_end_user_name_
  is '流程完成人员名称';
comment on column FF_PROC.proc_end_date_
  is '流程完成日期';
comment on column FF_PROC.proc_status_
  is '流程状态';
comment on column FF_PROC.creation_date_
  is '创建日期';
create index FK_PROC_DEF on FF_PROC (PROC_DEF_ID_);
alter table FF_PROC
  add constraint PK_FF_PROC primary key (PROC_ID_);
alter table FF_PROC
  add constraint FK_FF_PROC_PROC_DEF foreign key (PROC_DEF_ID_)
  references FF_PROC_DEF (PROC_DEF_ID_);

prompt
prompt Creating table FF_NODE
prompt ======================
prompt
create table FF_NODE
(
  node_id_                      VARCHAR2(40) not null,
  parent_node_id_               VARCHAR2(40),
  proc_id_                      VARCHAR2(40) not null,
  previous_node_ids_            VARCHAR2(280),
  last_complete_node_ids_       VARCHAR2(280),
  sub_proc_def_id_              VARCHAR2(40),
  adjust_sub_proc_def_id_       VARCHAR2(40),
  node_type_                    VARCHAR2(20) not null,
  node_code_                    VARCHAR2(60),
  node_name_                    VARCHAR2(60),
  parent_node_code_             VARCHAR2(100),
  candidate_assignee_           VARCHAR2(200),
  complete_expression_          VARCHAR2(200),
  complete_return_              VARCHAR2(200),
  exclusive_                    VARCHAR2(200),
  auto_complete_same_assignee_  VARCHAR2(200),
  auto_complete_empty_assignee_ VARCHAR2(200),
  inform_                       VARCHAR2(200),
  assignee_                     VARCHAR2(200),
  action_                       VARCHAR2(300),
  due_date_                     VARCHAR2(200),
  claim_                        VARCHAR2(200),
  forwardable_                  VARCHAR2(200),
  priority_                     VARCHAR2(200),
  node_end_user_                VARCHAR2(40),
  node_end_user_name_           VARCHAR2(60),
  node_end_date_                TIMESTAMP(6),
  next_candidate_               CLOB,
  isolate_sub_proc_def_code_    VARCHAR2(60),
  isolate_sub_proc_candidate_   VARCHAR2(500),
  isolate_sub_proc_status_      VARCHAR2(60),
  node_status_                  VARCHAR2(20) not null,
  creation_date_                TIMESTAMP(6) not null
)
;
comment on table FF_NODE
  is '节点';
comment on column FF_NODE.node_id_
  is '节点ID';
comment on column FF_NODE.parent_node_id_
  is '上级节点ID';
comment on column FF_NODE.proc_id_
  is '流程ID';
comment on column FF_NODE.previous_node_ids_
  is '前节点IDs';
comment on column FF_NODE.last_complete_node_ids_
  is '最后完成节点IDs';
comment on column FF_NODE.sub_proc_def_id_
  is '子流程定义ID';
comment on column FF_NODE.adjust_sub_proc_def_id_
  is '调整子流程定义ID';
comment on column FF_NODE.node_type_
  is '节点类型';
comment on column FF_NODE.node_code_
  is '节点编码';
comment on column FF_NODE.node_name_
  is '节点名称';
comment on column FF_NODE.parent_node_code_
  is '上级节点编码';
comment on column FF_NODE.candidate_assignee_
  is '候选人';
comment on column FF_NODE.complete_expression_
  is '完成表达式';
comment on column FF_NODE.complete_return_
  is '完成后返回前一个节点';
comment on column FF_NODE.exclusive_
  is '排他';
comment on column FF_NODE.auto_complete_same_assignee_
  is '自动完成相同办理人任务';
comment on column FF_NODE.auto_complete_empty_assignee_
  is '自动完成没有办理人节点';
comment on column FF_NODE.inform_
  is '通知';
comment on column FF_NODE.assignee_
  is '办理人';
comment on column FF_NODE.action_
  is '业务行为';
comment on column FF_NODE.due_date_
  is '截止日期';
comment on column FF_NODE.claim_
  is '认领';
comment on column FF_NODE.forwardable_
  is '可转发';
comment on column FF_NODE.priority_
  is '优先级';
comment on column FF_NODE.node_end_user_
  is '节点完成人员';
comment on column FF_NODE.node_end_user_name_
  is '节点完成人员名称';
comment on column FF_NODE.node_end_date_
  is '节点完成日期';
comment on column FF_NODE.next_candidate_
  is '下个候选人';
comment on column FF_NODE.isolate_sub_proc_def_code_
  is '独立子流程定义编码';
comment on column FF_NODE.isolate_sub_proc_candidate_
  is '独立子流程候选人';
comment on column FF_NODE.isolate_sub_proc_status_
  is '独立子流程状态';
comment on column FF_NODE.node_status_
  is '节点状态';
comment on column FF_NODE.creation_date_
  is '创建日期';
alter table FF_NODE
  add constraint PK_FF_NODE primary key (NODE_ID_);
alter table FF_NODE
  add constraint FK_FF_NODE_ADJUST_PROC_DEF foreign key (ADJUST_SUB_PROC_DEF_ID_)
  references FF_ADJUST_PROC_DEF (ADJUST_PROC_DEF_ID_);
alter table FF_NODE
  add constraint FK_FF_NODE_PARENT foreign key (PARENT_NODE_ID_)
  references FF_NODE (NODE_ID_);
alter table FF_NODE
  add constraint FK_FF_NODE_PROC foreign key (PROC_ID_)
  references FF_PROC (PROC_ID_);
alter table FF_NODE
  add constraint FK_FF_NODE_PROC_DEF foreign key (SUB_PROC_DEF_ID_)
  references FF_PROC_DEF (PROC_DEF_ID_);

prompt
prompt Creating table FF_OPERATION
prompt ===========================
prompt
create table FF_OPERATION
(
  operation_id_     VARCHAR2(40) not null,
  operation_        VARCHAR2(40) not null,
  proc_id_          VARCHAR2(40),
  node_id_          VARCHAR2(40),
  task_id_          VARCHAR2(40),
  memo_             VARCHAR2(1000),
  operator_         VARCHAR2(40),
  operator_name_    VARCHAR2(60),
  operation_date_   TIMESTAMP(6) not null,
  operation_status_ VARCHAR2(20) not null
)
;
comment on table FF_OPERATION
  is '操作';
comment on column FF_OPERATION.operation_id_
  is '操作ID';
comment on column FF_OPERATION.operation_
  is '操作';
comment on column FF_OPERATION.proc_id_
  is '流程ID';
comment on column FF_OPERATION.node_id_
  is '节点ID';
comment on column FF_OPERATION.task_id_
  is '任务ID';
comment on column FF_OPERATION.memo_
  is '备注';
comment on column FF_OPERATION.operator_
  is '操作人';
comment on column FF_OPERATION.operator_name_
  is '操作人名称';
comment on column FF_OPERATION.operation_date_
  is '操作日期';
comment on column FF_OPERATION.operation_status_
  is '操作状态';
alter table FF_OPERATION
  add constraint FF_FF_OPERATION primary key (OPERATION_ID_);

prompt
prompt Creating table FF_NODE_OP
prompt =========================
prompt
create table FF_NODE_OP
(
  node_op_id_                   VARCHAR2(40) not null,
  operation_id_                 VARCHAR2(40) not null,
  operation_type_               VARCHAR2(20) not null,
  operation_order_              INTEGER,
  operation_date_               TIMESTAMP(6),
  operation_status_             VARCHAR2(20),
  node_id_                      VARCHAR2(40) not null,
  parent_node_id_               VARCHAR2(40),
  proc_id_                      VARCHAR2(40),
  previous_node_ids_            VARCHAR2(280),
  last_complete_node_ids_       VARCHAR2(280),
  sub_proc_def_id_              VARCHAR2(40),
  adjust_sub_proc_def_id_       VARCHAR2(40),
  node_type_                    VARCHAR2(20),
  node_code_                    VARCHAR2(60),
  node_name_                    VARCHAR2(60),
  parent_node_code_             VARCHAR2(60),
  candidate_assignee_           VARCHAR2(200),
  complete_expression_          VARCHAR2(200),
  complete_return_              VARCHAR2(200),
  exclusive_                    VARCHAR2(200),
  auto_complete_same_assignee_  VARCHAR2(200),
  auto_complete_empty_assignee_ VARCHAR2(200),
  inform_                       VARCHAR2(200),
  assignee_                     VARCHAR2(200),
  action_                       VARCHAR2(200),
  due_date_                     VARCHAR2(200),
  claim_                        VARCHAR2(200),
  forwardable_                  VARCHAR2(200),
  priority_                     VARCHAR2(200),
  node_end_user_                VARCHAR2(40),
  node_end_user_name_           VARCHAR2(60),
  node_end_date_                TIMESTAMP(6),
  next_candidate_               CLOB,
  isolate_sub_proc_def_code_    VARCHAR2(60),
  isolate_sub_proc_candidate_   VARCHAR2(500),
  isolate_sub_proc_status_      VARCHAR2(60),
  node_status_                  VARCHAR2(20),
  creation_date_                TIMESTAMP(6)
)
;
comment on table FF_NODE_OP
  is '节点操作';
comment on column FF_NODE_OP.node_op_id_
  is '节点操作ID';
comment on column FF_NODE_OP.operation_id_
  is '操作ID';
comment on column FF_NODE_OP.operation_type_
  is '操作类型';
comment on column FF_NODE_OP.operation_order_
  is '操作顺序';
comment on column FF_NODE_OP.operation_date_
  is '操作日期';
comment on column FF_NODE_OP.operation_status_
  is '操作状态';
comment on column FF_NODE_OP.node_id_
  is '节点ID';
comment on column FF_NODE_OP.parent_node_id_
  is '上级节点ID';
comment on column FF_NODE_OP.proc_id_
  is '流程ID';
comment on column FF_NODE_OP.previous_node_ids_
  is '前节点IDs';
comment on column FF_NODE_OP.last_complete_node_ids_
  is '最后完成节点IDs';
comment on column FF_NODE_OP.sub_proc_def_id_
  is '子流程定义ID';
comment on column FF_NODE_OP.adjust_sub_proc_def_id_
  is '调整子流程定义ID';
comment on column FF_NODE_OP.node_type_
  is '节点类型';
comment on column FF_NODE_OP.node_code_
  is '节点编码';
comment on column FF_NODE_OP.node_name_
  is '节点名称';
comment on column FF_NODE_OP.parent_node_code_
  is '上级节点编码';
comment on column FF_NODE_OP.candidate_assignee_
  is '候选人';
comment on column FF_NODE_OP.complete_expression_
  is '完成表达式';
comment on column FF_NODE_OP.complete_return_
  is '完成后返回前一个节点';
comment on column FF_NODE_OP.exclusive_
  is '排他';
comment on column FF_NODE_OP.auto_complete_same_assignee_
  is '自动完成相同办理人任务';
comment on column FF_NODE_OP.auto_complete_empty_assignee_
  is '自动完成没有办理人节点';
comment on column FF_NODE_OP.inform_
  is '通知';
comment on column FF_NODE_OP.assignee_
  is '办理人';
comment on column FF_NODE_OP.action_
  is '业务行为';
comment on column FF_NODE_OP.due_date_
  is '截止日期';
comment on column FF_NODE_OP.claim_
  is '认领';
comment on column FF_NODE_OP.forwardable_
  is '可转发';
comment on column FF_NODE_OP.priority_
  is '优先级';
comment on column FF_NODE_OP.node_end_user_
  is '节点完成人员';
comment on column FF_NODE_OP.node_end_user_name_
  is '节点完成人员名称';
comment on column FF_NODE_OP.node_end_date_
  is '节点完成日期';
comment on column FF_NODE_OP.next_candidate_
  is '下个候选人';
comment on column FF_NODE_OP.isolate_sub_proc_def_code_
  is '独立子流程定义编码';
comment on column FF_NODE_OP.isolate_sub_proc_candidate_
  is '独立子流程候选人';
comment on column FF_NODE_OP.isolate_sub_proc_status_
  is '独立子流程状态';
comment on column FF_NODE_OP.node_status_
  is '节点状态';
comment on column FF_NODE_OP.creation_date_
  is '创建日期';
alter table FF_NODE_OP
  add constraint PK_FF_NODE_OP primary key (NODE_OP_ID_);
alter table FF_NODE_OP
  add constraint FK_FF_NODE_OP_OPERATION foreign key (OPERATION_ID_)
  references FF_OPERATION (OPERATION_ID_);

prompt
prompt Creating table FF_NODE_VAR
prompt ==========================
prompt
create table FF_NODE_VAR
(
  node_var_id_   VARCHAR2(40) not null,
  node_id_       VARCHAR2(40) not null,
  var_type_      VARCHAR2(20) not null,
  var_name_      VARCHAR2(60) not null,
  value_         VARCHAR2(3000),
  obj_           BLOB,
  creation_date_ TIMESTAMP(6) not null
)
;
comment on table FF_NODE_VAR
  is '节点变量';
comment on column FF_NODE_VAR.node_var_id_
  is '节点变量ID';
comment on column FF_NODE_VAR.node_id_
  is '节点ID';
comment on column FF_NODE_VAR.var_type_
  is '变量类型';
comment on column FF_NODE_VAR.var_name_
  is '变量名称';
comment on column FF_NODE_VAR.value_
  is '值';
comment on column FF_NODE_VAR.obj_
  is '对象';
comment on column FF_NODE_VAR.creation_date_
  is '创建日期';
create index IX_SUB_PROC_VAR_NAME on FF_NODE_VAR (VAR_NAME_);
create index IX_SUB_PROC_VAR_VALUE on FF_NODE_VAR (VALUE_);
alter table FF_NODE_VAR
  add constraint PK_FF_NODE_VAR primary key (NODE_VAR_ID_);

prompt
prompt Creating table FF_NODE_VAR_OP
prompt =============================
prompt
create table FF_NODE_VAR_OP
(
  node_var_op_id_   VARCHAR2(40) not null,
  operation_id_     VARCHAR2(40) not null,
  operation_type_   VARCHAR2(20) not null,
  operation_order_  INTEGER,
  operation_date_   TIMESTAMP(6),
  operation_status_ VARCHAR2(20),
  node_var_id_      VARCHAR2(40) not null,
  node_id_          VARCHAR2(40),
  var_type_         VARCHAR2(20),
  var_name_         VARCHAR2(60),
  value_            VARCHAR2(3000),
  obj_              BLOB,
  creation_date_    TIMESTAMP(6)
)
;
comment on table FF_NODE_VAR_OP
  is '节点变量操作';
comment on column FF_NODE_VAR_OP.node_var_op_id_
  is '节点变量操作ID';
comment on column FF_NODE_VAR_OP.operation_id_
  is '操作ID';
comment on column FF_NODE_VAR_OP.operation_type_
  is '操作类型';
comment on column FF_NODE_VAR_OP.operation_order_
  is '操作顺序';
comment on column FF_NODE_VAR_OP.operation_date_
  is '操作日期';
comment on column FF_NODE_VAR_OP.operation_status_
  is '操作状态';
comment on column FF_NODE_VAR_OP.node_var_id_
  is '节点变量ID';
comment on column FF_NODE_VAR_OP.node_id_
  is '节点ID';
comment on column FF_NODE_VAR_OP.var_type_
  is '变量类型';
comment on column FF_NODE_VAR_OP.var_name_
  is '变量名称';
comment on column FF_NODE_VAR_OP.value_
  is '值';
comment on column FF_NODE_VAR_OP.obj_
  is '对象';
comment on column FF_NODE_VAR_OP.creation_date_
  is '创建日期';
alter table FF_NODE_VAR_OP
  add constraint PK_FF_NODE_VAR_OP primary key (NODE_VAR_OP_ID_);
alter table FF_NODE_VAR_OP
  add constraint FK_FF_NODE_VAR_OP_OPERATION foreign key (OPERATION_ID_)
  references FF_OPERATION (OPERATION_ID_);

prompt
prompt Creating table FF_OPERATION_FOLLOW_UP
prompt =====================================
prompt
create table FF_OPERATION_FOLLOW_UP
(
  operation_follow_up_id_ VARCHAR2(40) not null,
  operation_id_           VARCHAR2(40) not null,
  follow_up_operation_id_ VARCHAR2(40) not null,
  operation_date_         TIMESTAMP(6) not null
)
;
comment on table FF_OPERATION_FOLLOW_UP
  is '操作后续';
comment on column FF_OPERATION_FOLLOW_UP.operation_follow_up_id_
  is '操作后续ID';
comment on column FF_OPERATION_FOLLOW_UP.operation_id_
  is '操作ID';
comment on column FF_OPERATION_FOLLOW_UP.follow_up_operation_id_
  is '后续操作ID';
comment on column FF_OPERATION_FOLLOW_UP.operation_date_
  is '操作日期';
alter table FF_OPERATION_FOLLOW_UP
  add constraint PK_FF_OPERATION_FOLOW_UP primary key (OPERATION_FOLLOW_UP_ID_);
alter table FF_OPERATION_FOLLOW_UP
  add constraint FK_FF_OPERATION_FOLOW_UP_O foreign key (OPERATION_ID_)
  references FF_OPERATION (OPERATION_ID_);
alter table FF_OPERATION_FOLLOW_UP
  add constraint FK_FF_OPERATION_FOLOW_UP_OFU foreign key (FOLLOW_UP_OPERATION_ID_)
  references FF_OPERATION (OPERATION_ID_);

prompt
prompt Creating table FF_PROC_OP
prompt =========================
prompt
create table FF_PROC_OP
(
  proc_op_id_               VARCHAR2(40) not null,
  operation_id_             VARCHAR2(40) not null,
  operation_type_           VARCHAR2(20) not null,
  operation_order_          INTEGER,
  operation_date_           TIMESTAMP(6),
  operation_status_         VARCHAR2(20),
  proc_id_                  VARCHAR2(40) not null,
  proc_def_id_              VARCHAR2(40),
  adjust_proc_def_id_       VARCHAR2(40),
  isolate_sub_proc_node_id_ VARCHAR2(40),
  biz_id_                   VARCHAR2(40),
  biz_type_                 VARCHAR2(60),
  biz_code_                 VARCHAR2(100),
  biz_name_                 VARCHAR2(100),
  biz_desc_                 VARCHAR2(300),
  proc_start_user_          VARCHAR2(40),
  proc_start_user_name_     VARCHAR2(60),
  proc_end_user_            VARCHAR2(40),
  proc_end_user_name_       VARCHAR2(60),
  proc_end_date_            TIMESTAMP(6),
  proc_status_              VARCHAR2(20),
  creation_date_            TIMESTAMP(6)
)
;
comment on table FF_PROC_OP
  is '流程操作';
comment on column FF_PROC_OP.proc_op_id_
  is '流程操作ID';
comment on column FF_PROC_OP.operation_id_
  is '操作ID';
comment on column FF_PROC_OP.operation_type_
  is '操作类型';
comment on column FF_PROC_OP.operation_order_
  is '操作顺序';
comment on column FF_PROC_OP.operation_date_
  is '操作日期';
comment on column FF_PROC_OP.operation_status_
  is '操作状态';
comment on column FF_PROC_OP.proc_id_
  is '流程ID';
comment on column FF_PROC_OP.proc_def_id_
  is '流程定义ID';
comment on column FF_PROC_OP.adjust_proc_def_id_
  is '调整流程定义ID';
comment on column FF_PROC_OP.isolate_sub_proc_node_id_
  is '独立子流程所属节点ID';
comment on column FF_PROC_OP.biz_id_
  is '业务主键';
comment on column FF_PROC_OP.biz_type_
  is '业务类型';
comment on column FF_PROC_OP.biz_code_
  is '业务编码';
comment on column FF_PROC_OP.biz_name_
  is '业务名称';
comment on column FF_PROC_OP.biz_desc_
  is '业务备注';
comment on column FF_PROC_OP.proc_start_user_
  is '流程开始人员';
comment on column FF_PROC_OP.proc_start_user_name_
  is '流程开始人员名称';
comment on column FF_PROC_OP.proc_end_user_
  is '流程完成人员';
comment on column FF_PROC_OP.proc_end_user_name_
  is '流程完成人员名称';
comment on column FF_PROC_OP.proc_end_date_
  is '流程完成日期';
comment on column FF_PROC_OP.proc_status_
  is '流程状态';
comment on column FF_PROC_OP.creation_date_
  is '创建日期';
alter table FF_PROC_OP
  add constraint PK_FF_PROC_OP primary key (PROC_OP_ID_);
alter table FF_PROC_OP
  add constraint FK_FF_PROC_OP_OPERATION foreign key (OPERATION_ID_)
  references FF_OPERATION (OPERATION_ID_);

prompt
prompt Creating table FF_TASK
prompt ======================
prompt
create table FF_TASK
(
  task_id_            VARCHAR2(40) not null,
  node_id_            VARCHAR2(40),
  previous_task_id_   VARCHAR2(40),
  task_type_          VARCHAR2(20) not null,
  assignee_           VARCHAR2(40),
  assignee_name_      VARCHAR2(60),
  action_             VARCHAR2(300),
  due_date_           TIMESTAMP(6),
  claim_              VARCHAR2(20) not null,
  forwardable_        VARCHAR2(20) not null,
  priority_           INTEGER not null,
  forward_status_     VARCHAR2(20) not null,
  task_end_user_      VARCHAR2(40),
  task_end_user_name_ VARCHAR2(60),
  task_end_date_      TIMESTAMP(6),
  next_candidate_     CLOB,
  task_status_        VARCHAR2(20) not null,
  creation_date_      TIMESTAMP(6) not null
)
;
comment on table FF_TASK
  is '任务';
comment on column FF_TASK.task_id_
  is '任务ID';
comment on column FF_TASK.node_id_
  is '节点ID';
comment on column FF_TASK.previous_task_id_
  is '前一个任务ID';
comment on column FF_TASK.task_type_
  is '任务类型';
comment on column FF_TASK.assignee_
  is '办理人';
comment on column FF_TASK.assignee_name_
  is '办理人名称';
comment on column FF_TASK.action_
  is '业务行为';
comment on column FF_TASK.due_date_
  is '截止日期';
comment on column FF_TASK.claim_
  is '认领';
comment on column FF_TASK.forwardable_
  is '可转发';
comment on column FF_TASK.priority_
  is '优先级';
comment on column FF_TASK.forward_status_
  is '转发状态';
comment on column FF_TASK.task_end_user_
  is '任务完成人员';
comment on column FF_TASK.task_end_user_name_
  is '任务完成人员名称';
comment on column FF_TASK.task_end_date_
  is '任务完成日期';
comment on column FF_TASK.next_candidate_
  is '下个候选人';
comment on column FF_TASK.task_status_
  is '任务状态';
comment on column FF_TASK.creation_date_
  is '创建日期';
alter table FF_TASK
  add constraint PK_FF_TASK primary key (TASK_ID_);
alter table FF_TASK
  add constraint FK_FF_TASK_NODE foreign key (NODE_ID_)
  references FF_NODE (NODE_ID_);
alter table FF_TASK
  add constraint FK_FF_TASK_PARENT foreign key (PREVIOUS_TASK_ID_)
  references FF_TASK (TASK_ID_);

prompt
prompt Creating table FF_TASK_OP
prompt =========================
prompt
create table FF_TASK_OP
(
  task_op_id_         VARCHAR2(40) not null,
  operation_id_       VARCHAR2(40) not null,
  operation_type_     VARCHAR2(20) not null,
  operation_order_    INTEGER,
  operation_date_     TIMESTAMP(6),
  operation_status_   VARCHAR2(20),
  task_id_            VARCHAR2(40) not null,
  node_id_            VARCHAR2(40),
  previous_task_id_   VARCHAR2(40),
  task_type_          VARCHAR2(20),
  assignee_           VARCHAR2(40),
  assignee_name_      VARCHAR2(60),
  action_             VARCHAR2(300),
  due_date_           TIMESTAMP(6),
  claim_              VARCHAR2(20),
  forwardable_        VARCHAR2(20),
  priority_           INTEGER,
  forward_status_     VARCHAR2(20),
  task_end_user_      VARCHAR2(40),
  task_end_user_name_ VARCHAR2(60),
  task_end_date_      TIMESTAMP(6),
  next_candidate_     CLOB,
  task_status_        VARCHAR2(20),
  creation_date_      TIMESTAMP(6)
)
;
comment on table FF_TASK_OP
  is '任务操作';
comment on column FF_TASK_OP.task_op_id_
  is '任务操作ID';
comment on column FF_TASK_OP.operation_id_
  is '操作ID';
comment on column FF_TASK_OP.operation_type_
  is '操作类型';
comment on column FF_TASK_OP.operation_order_
  is '操作顺序';
comment on column FF_TASK_OP.operation_date_
  is '操作日期';
comment on column FF_TASK_OP.operation_status_
  is '操作状态';
comment on column FF_TASK_OP.task_id_
  is '任务ID';
comment on column FF_TASK_OP.node_id_
  is '节点ID';
comment on column FF_TASK_OP.previous_task_id_
  is '前一个任务ID';
comment on column FF_TASK_OP.task_type_
  is '任务类型';
comment on column FF_TASK_OP.assignee_
  is '办理人';
comment on column FF_TASK_OP.assignee_name_
  is '办理人名称';
comment on column FF_TASK_OP.action_
  is '业务行为';
comment on column FF_TASK_OP.due_date_
  is '截止日期';
comment on column FF_TASK_OP.claim_
  is '认领';
comment on column FF_TASK_OP.forwardable_
  is '可转发';
comment on column FF_TASK_OP.priority_
  is '优先级';
comment on column FF_TASK_OP.forward_status_
  is '转发状态';
comment on column FF_TASK_OP.task_end_user_
  is '任务完成人员';
comment on column FF_TASK_OP.task_end_user_name_
  is '任务完成人员名称';
comment on column FF_TASK_OP.task_end_date_
  is '任务完成日期';
comment on column FF_TASK_OP.next_candidate_
  is '下个候选人';
comment on column FF_TASK_OP.task_status_
  is '任务状态';
comment on column FF_TASK_OP.creation_date_
  is '创建日期';
alter table FF_TASK_OP
  add constraint PK_FF_TASK_OP primary key (TASK_OP_ID_);
alter table FF_TASK_OP
  add constraint FK_FF_TASK_OP_OPERATION foreign key (OPERATION_ID_)
  references FF_OPERATION (OPERATION_ID_);

prompt
prompt Creating table K_APPROVAL_MEMO
prompt ==============================
prompt
create table K_APPROVAL_MEMO
(
  approval_memo_id_     VARCHAR2(40) not null,
  task_id_              VARCHAR2(40),
  previous_task_id_     VARCHAR2(40),
  node_id_              VARCHAR2(40),
  node_type_            VARCHAR2(60),
  node_name_            VARCHAR2(60),
  parent_node_id_       VARCHAR2(40),
  proc_id_              VARCHAR2(40) not null,
  biz_id_               VARCHAR2(40),
  assignee_             VARCHAR2(40),
  assignee_code_        VARCHAR2(40),
  assignee_name_        VARCHAR2(60),
  executor_             VARCHAR2(40),
  executor_code_        VARCHAR2(40),
  executor_name_        VARCHAR2(60),
  org_id_               VARCHAR2(40),
  org_name_             VARCHAR2(60),
  com_id_               VARCHAR2(40),
  com_name_             VARCHAR2(60),
  creation_date_        TIMESTAMP(6) not null,
  due_date_             TIMESTAMP(6),
  approval_memo_type_   VARCHAR2(20),
  approval_memo_        VARCHAR2(1000),
  approval_date_        TIMESTAMP(6),
  approval_memo_source_ VARCHAR2(40),
  approval_memo_status_ VARCHAR2(20) not null,
  operation_id_         VARCHAR2(40)
)
;
comment on table K_APPROVAL_MEMO
  is '审批意见';
comment on column K_APPROVAL_MEMO.approval_memo_id_
  is '审批意见ID';
comment on column K_APPROVAL_MEMO.task_id_
  is '任务ID';
comment on column K_APPROVAL_MEMO.previous_task_id_
  is '前一个任务ID';
comment on column K_APPROVAL_MEMO.node_id_
  is '节点ID';
comment on column K_APPROVAL_MEMO.node_type_
  is '节点类型';
comment on column K_APPROVAL_MEMO.node_name_
  is '节点名称';
comment on column K_APPROVAL_MEMO.parent_node_id_
  is '上级节点ID';
comment on column K_APPROVAL_MEMO.proc_id_
  is '流程ID';
comment on column K_APPROVAL_MEMO.biz_id_
  is '业务ID';
comment on column K_APPROVAL_MEMO.assignee_
  is '办理人';
comment on column K_APPROVAL_MEMO.assignee_code_
  is '办理人编码';
comment on column K_APPROVAL_MEMO.assignee_name_
  is '办理人名称';
comment on column K_APPROVAL_MEMO.executor_
  is '执行人';
comment on column K_APPROVAL_MEMO.executor_code_
  is '执行人编码';
comment on column K_APPROVAL_MEMO.executor_name_
  is '执行人名称';
comment on column K_APPROVAL_MEMO.org_id_
  is '机构ID';
comment on column K_APPROVAL_MEMO.org_name_
  is '机构名称';
comment on column K_APPROVAL_MEMO.com_id_
  is '公司ID';
comment on column K_APPROVAL_MEMO.com_name_
  is '公司名称';
comment on column K_APPROVAL_MEMO.creation_date_
  is '创建日期';
comment on column K_APPROVAL_MEMO.due_date_
  is '截止日期';
comment on column K_APPROVAL_MEMO.approval_memo_type_
  is '审批意见类型';
comment on column K_APPROVAL_MEMO.approval_memo_
  is '审批意见';
comment on column K_APPROVAL_MEMO.approval_date_
  is '审批日期';
comment on column K_APPROVAL_MEMO.approval_memo_source_
  is '审批意见数据源';
comment on column K_APPROVAL_MEMO.approval_memo_status_
  is '审批状态';
comment on column K_APPROVAL_MEMO.operation_id_
  is '操作ID';
alter table K_APPROVAL_MEMO
  add constraint PK_APPROVAL_MEMO primary key (APPROVAL_MEMO_ID_);

prompt
prompt Creating table K_CUSTOM_APPROVAL_MEMO
prompt =====================================
prompt
create table K_CUSTOM_APPROVAL_MEMO
(
  custom_approval_memo_id_ VARCHAR2(40) not null,
  emp_id_                  VARCHAR2(40) not null,
  approval_memo_           VARCHAR2(300) not null,
  default_                 VARCHAR2(20),
  order_                   INTEGER
)
;
comment on table K_CUSTOM_APPROVAL_MEMO
  is '常用审批意见';
comment on column K_CUSTOM_APPROVAL_MEMO.custom_approval_memo_id_
  is '常用审批意见ID';
comment on column K_CUSTOM_APPROVAL_MEMO.emp_id_
  is '人员ID';
comment on column K_CUSTOM_APPROVAL_MEMO.approval_memo_
  is '审批意见';
comment on column K_CUSTOM_APPROVAL_MEMO.default_
  is '缺省';
comment on column K_CUSTOM_APPROVAL_MEMO.order_
  is '排序';
alter table K_CUSTOM_APPROVAL_MEMO
  add constraint PK_CUSTOM_APPROVAL_MEMO primary key (CUSTOM_APPROVAL_MEMO_ID_);

prompt
prompt Creating table K_CUSTOM_DOC_TYPE
prompt ================================
prompt
create table K_CUSTOM_DOC_TYPE
(
  custom_doc_type_id_ VARCHAR2(40) not null,
  emp_id_             VARCHAR2(40) not null,
  doc_type_id_        VARCHAR2(40) not null
)
;
comment on table K_CUSTOM_DOC_TYPE
  is '常用公文类型';
comment on column K_CUSTOM_DOC_TYPE.custom_doc_type_id_
  is '常用公文类型ID';
comment on column K_CUSTOM_DOC_TYPE.emp_id_
  is '人员ID';
comment on column K_CUSTOM_DOC_TYPE.doc_type_id_
  is '公文类型ID';
alter table K_CUSTOM_DOC_TYPE
  add constraint PK_CUSTOM_DOC_TYPE primary key (CUSTOM_DOC_TYPE_ID_);
alter table K_CUSTOM_DOC_TYPE
  add constraint UQ_CUSTOM_DOC_TYPE unique (EMP_ID_, DOC_TYPE_ID_);

prompt
prompt Creating table K_DOC
prompt ====================
prompt
create table K_DOC
(
  doc_id_               VARCHAR2(40) not null,
  doc_code_             VARCHAR2(60),
  doc_name_             VARCHAR2(60),
  doc_type_name_        VARCHAR2(60),
  owner_id_             VARCHAR2(40),
  owner_name_           VARCHAR2(60),
  owner_org_id_         VARCHAR2(40),
  owner_org_name_       VARCHAR2(60),
  memo_                 VARCHAR2(300),
  template_file_        BLOB,
  template_file_name_   VARCHAR2(300),
  template_file_length_ INTEGER,
  doc_file_             BLOB,
  doc_file_name_        VARCHAR2(300),
  doc_file_length_      INTEGER,
  html_                 CLOB,
  bookmark_             CLOB,
  index_                VARCHAR2(1000),
  using_template_       VARCHAR2(20) not null,
  proc_def_code_        VARCHAR2(60),
  proc_id_              VARCHAR2(40),
  proc_status_          VARCHAR2(20),
  version_              INTEGER not null,
  doc_status_           VARCHAR2(20) not null,
  creation_date_        TIMESTAMP(6),
  update_date_          TIMESTAMP(6),
  effective_date_       TIMESTAMP(6),
  operator_id_          VARCHAR2(40),
  operator_name_        VARCHAR2(60)
)
;
comment on table K_DOC
  is '公文';
comment on column K_DOC.doc_id_
  is '公文ID';
comment on column K_DOC.doc_code_
  is '公文编码';
comment on column K_DOC.doc_name_
  is '公文名称';
comment on column K_DOC.doc_type_name_
  is '公文类型名称';
comment on column K_DOC.owner_id_
  is '所有人ID';
comment on column K_DOC.owner_name_
  is '所有人名称';
comment on column K_DOC.owner_org_id_
  is '所有机构ID';
comment on column K_DOC.owner_org_name_
  is '所有机构名称';
comment on column K_DOC.memo_
  is '备注';
comment on column K_DOC.template_file_
  is '模版文件';
comment on column K_DOC.template_file_name_
  is '模版文件名称';
comment on column K_DOC.template_file_length_
  is '模版文件长度';
comment on column K_DOC.doc_file_
  is '公文文件';
comment on column K_DOC.doc_file_name_
  is '公文文件名称';
comment on column K_DOC.doc_file_length_
  is '公文文件长度';
comment on column K_DOC.html_
  is 'HTML';
comment on column K_DOC.bookmark_
  is '标签';
comment on column K_DOC.index_
  is '定位';
comment on column K_DOC.using_template_
  is '使用模板生成';
comment on column K_DOC.proc_def_code_
  is '流程定义编码';
comment on column K_DOC.proc_id_
  is '流程ID';
comment on column K_DOC.proc_status_
  is '流程状态(0草稿/1审批中/8审批驳回/9审批通过)';
comment on column K_DOC.version_
  is '版本';
comment on column K_DOC.doc_status_
  is '公文状态(1生效/0废弃)';
comment on column K_DOC.creation_date_
  is '创建日期';
comment on column K_DOC.update_date_
  is '更新日期';
comment on column K_DOC.effective_date_
  is '生效日期';
comment on column K_DOC.operator_id_
  is '操作人员ID';
comment on column K_DOC.operator_name_
  is '操作人员名称';
alter table K_DOC
  add constraint PK_DOC primary key (DOC_ID_);
alter table K_DOC
  add constraint UQ_DOC_CODE unique (DOC_CODE_);

prompt
prompt Creating table K_DOC_DATA
prompt =========================
prompt
create table K_DOC_DATA
(
  doc_data_id_ VARCHAR2(40) not null,
  doc_id_      VARCHAR2(40) not null,
  bookmark_    VARCHAR2(60) not null,
  value_       VARCHAR2(1000),
  data_type_   VARCHAR2(20),
  order_       INTEGER
)
;
comment on table K_DOC_DATA
  is '公文数据';
comment on column K_DOC_DATA.doc_data_id_
  is '公文数据ID';
comment on column K_DOC_DATA.doc_id_
  is '公文ID';
comment on column K_DOC_DATA.bookmark_
  is '标签';
comment on column K_DOC_DATA.value_
  is '内容';
comment on column K_DOC_DATA.data_type_
  is '数据类型';
comment on column K_DOC_DATA.order_
  is '排序';
alter table K_DOC_DATA
  add constraint PK_DOC_DATA primary key (DOC_DATA_ID_);
alter table K_DOC_DATA
  add constraint FK_DOC_DATA_DOC foreign key (DOC_ID_)
  references K_DOC (DOC_ID_);

prompt
prompt Creating table K_DOC_DATA_HIS
prompt =============================
prompt
create table K_DOC_DATA_HIS
(
  doc_data_his_id_ VARCHAR2(40) not null,
  doc_data_id_     VARCHAR2(40),
  doc_id_          VARCHAR2(40),
  bookmark_        VARCHAR2(60),
  value_           VARCHAR2(1000),
  data_type_       VARCHAR2(20),
  order_           INTEGER,
  version_         INTEGER,
  his_date_        TIMESTAMP(6)
)
;
comment on table K_DOC_DATA_HIS
  is '公文数据历史';
comment on column K_DOC_DATA_HIS.doc_data_his_id_
  is '公文数据历史ID';
comment on column K_DOC_DATA_HIS.doc_data_id_
  is '公文数据ID';
comment on column K_DOC_DATA_HIS.doc_id_
  is '公文ID';
comment on column K_DOC_DATA_HIS.bookmark_
  is '标签';
comment on column K_DOC_DATA_HIS.value_
  is '内容';
comment on column K_DOC_DATA_HIS.data_type_
  is '数据类型';
comment on column K_DOC_DATA_HIS.order_
  is '排序';
comment on column K_DOC_DATA_HIS.version_
  is '版本';
comment on column K_DOC_DATA_HIS.his_date_
  is '历史日期';
alter table K_DOC_DATA_HIS
  add constraint PK_DOC_DATA_HIS primary key (DOC_DATA_HIS_ID_);
alter table K_DOC_DATA_HIS
  add constraint FK_DOC_DATA_HIS_DOC foreign key (DOC_ID_)
  references K_DOC (DOC_ID_);

prompt
prompt Creating table K_DOC_HIS
prompt ========================
prompt
create table K_DOC_HIS
(
  doc_his_id_           VARCHAR2(40) not null,
  doc_id_               VARCHAR2(40) not null,
  doc_code_             VARCHAR2(60),
  doc_name_             VARCHAR2(60),
  doc_type_name_        VARCHAR2(60),
  owner_id_             VARCHAR2(40),
  owner_name_           VARCHAR2(60),
  owner_org_id_         VARCHAR2(40),
  owner_org_name_       VARCHAR2(60),
  memo_                 VARCHAR2(300),
  template_file_        BLOB,
  template_file_name_   VARCHAR2(300),
  template_file_length_ INTEGER,
  doc_file_             BLOB,
  doc_file_name_        VARCHAR2(300),
  doc_file_length_      INTEGER,
  html_                 CLOB,
  bookmark_             CLOB,
  index_                VARCHAR2(1000),
  using_template_       VARCHAR2(20) not null,
  proc_def_code_        VARCHAR2(60),
  proc_id_              VARCHAR2(40),
  proc_status_          VARCHAR2(20),
  version_              INTEGER not null,
  doc_status_           VARCHAR2(20) not null,
  creation_date_        TIMESTAMP(6),
  update_date_          TIMESTAMP(6),
  effective_date_       TIMESTAMP(6),
  operator_id_          VARCHAR2(40),
  operator_name_        VARCHAR2(60),
  his_date_             TIMESTAMP(6),
  doc_file_diff_        CLOB,
  doc_data_diff_        CLOB,
  doc_rider_diff_       VARCHAR2(1000)
)
;
comment on table K_DOC_HIS
  is '公文历史';
comment on column K_DOC_HIS.doc_his_id_
  is '公文历史ID';
comment on column K_DOC_HIS.doc_id_
  is '公文ID';
comment on column K_DOC_HIS.doc_code_
  is '公文编码';
comment on column K_DOC_HIS.doc_name_
  is '公文名称';
comment on column K_DOC_HIS.doc_type_name_
  is '公文类型名称';
comment on column K_DOC_HIS.owner_id_
  is '所有人ID';
comment on column K_DOC_HIS.owner_name_
  is '所有人名称';
comment on column K_DOC_HIS.owner_org_id_
  is '所有机构ID';
comment on column K_DOC_HIS.owner_org_name_
  is '所有机构名称';
comment on column K_DOC_HIS.memo_
  is '备注';
comment on column K_DOC_HIS.template_file_
  is '模版文件';
comment on column K_DOC_HIS.template_file_name_
  is '模版文件名称';
comment on column K_DOC_HIS.template_file_length_
  is '模版文件长度';
comment on column K_DOC_HIS.doc_file_
  is '公文文件';
comment on column K_DOC_HIS.doc_file_name_
  is '公文文件名称';
comment on column K_DOC_HIS.doc_file_length_
  is '公文文件长度';
comment on column K_DOC_HIS.html_
  is 'HTML';
comment on column K_DOC_HIS.bookmark_
  is '标签';
comment on column K_DOC_HIS.index_
  is '定位';
comment on column K_DOC_HIS.using_template_
  is '使用模板生成';
comment on column K_DOC_HIS.proc_def_code_
  is '流程定义编码';
comment on column K_DOC_HIS.proc_id_
  is '流程ID';
comment on column K_DOC_HIS.proc_status_
  is '流程状态(0草稿/1审批中/8审批驳回/9审批通过)';
comment on column K_DOC_HIS.version_
  is '版本';
comment on column K_DOC_HIS.doc_status_
  is '公文状态(1生效/0废弃)';
comment on column K_DOC_HIS.creation_date_
  is '创建日期';
comment on column K_DOC_HIS.update_date_
  is '更新日期';
comment on column K_DOC_HIS.effective_date_
  is '生效日期';
comment on column K_DOC_HIS.operator_id_
  is '操作人员ID';
comment on column K_DOC_HIS.operator_name_
  is '操作人员名称';
comment on column K_DOC_HIS.his_date_
  is '历史日期';
comment on column K_DOC_HIS.doc_file_diff_
  is '公文文件区别';
comment on column K_DOC_HIS.doc_data_diff_
  is '公文数据区别';
comment on column K_DOC_HIS.doc_rider_diff_
  is '公文附件区别';
alter table K_DOC_HIS
  add constraint PK_DOC_HIS primary key (DOC_HIS_ID_);
alter table K_DOC_HIS
  add constraint UQ_DOC_HIS unique (DOC_ID_, VERSION_);

prompt
prompt Creating table K_DOC_RIDER
prompt ==========================
prompt
create table K_DOC_RIDER
(
  doc_rider_id_          VARCHAR2(40) not null,
  doc_id_                VARCHAR2(40) not null,
  doc_rider_file_        BLOB not null,
  doc_rider_file_name_   VARCHAR2(300),
  doc_rider_file_length_ INTEGER,
  md5_                   VARCHAR2(40),
  creation_date_         TIMESTAMP(6),
  update_date_           TIMESTAMP(6),
  operator_id_           VARCHAR2(40),
  operator_name_         VARCHAR2(60)
)
;
comment on table K_DOC_RIDER
  is '公文附件';
comment on column K_DOC_RIDER.doc_rider_id_
  is '公文附件ID';
comment on column K_DOC_RIDER.doc_id_
  is '公文ID';
comment on column K_DOC_RIDER.doc_rider_file_
  is '公文附件文件';
comment on column K_DOC_RIDER.doc_rider_file_name_
  is '公文附件文件名称';
comment on column K_DOC_RIDER.doc_rider_file_length_
  is '公文附件文件长度';
comment on column K_DOC_RIDER.md5_
  is 'MD5';
comment on column K_DOC_RIDER.creation_date_
  is '创建日期';
comment on column K_DOC_RIDER.update_date_
  is '更新日期';
comment on column K_DOC_RIDER.operator_id_
  is '操作人员ID';
comment on column K_DOC_RIDER.operator_name_
  is '操作人员名称';
alter table K_DOC_RIDER
  add constraint PK_DOC_RIDER primary key (DOC_RIDER_ID_);
alter table K_DOC_RIDER
  add constraint FK_DOC_RIDER_DOC foreign key (DOC_ID_)
  references K_DOC (DOC_ID_);

prompt
prompt Creating table K_DOC_RIDER_HIS
prompt ==============================
prompt
create table K_DOC_RIDER_HIS
(
  doc_rider_his_id_      VARCHAR2(40) not null,
  doc_rider_id_          VARCHAR2(40),
  doc_id_                VARCHAR2(40),
  doc_rider_file_        BLOB,
  doc_rider_file_name_   VARCHAR2(300),
  doc_rider_file_length_ INTEGER,
  md5_                   VARCHAR2(40),
  version_               INTEGER,
  creation_date_         TIMESTAMP(6),
  update_date_           TIMESTAMP(6),
  operator_id_           VARCHAR2(40),
  operator_name_         VARCHAR2(60),
  his_date_              TIMESTAMP(6)
)
;
comment on table K_DOC_RIDER_HIS
  is '公文附件历史';
comment on column K_DOC_RIDER_HIS.doc_rider_his_id_
  is '公文附件历史ID';
comment on column K_DOC_RIDER_HIS.doc_rider_id_
  is '公文附件ID';
comment on column K_DOC_RIDER_HIS.doc_id_
  is '公文ID';
comment on column K_DOC_RIDER_HIS.doc_rider_file_
  is '公文附件文件';
comment on column K_DOC_RIDER_HIS.doc_rider_file_name_
  is '公文附件文件名称';
comment on column K_DOC_RIDER_HIS.doc_rider_file_length_
  is '公文附件文件长度';
comment on column K_DOC_RIDER_HIS.md5_
  is 'MD5';
comment on column K_DOC_RIDER_HIS.version_
  is '版本';
comment on column K_DOC_RIDER_HIS.creation_date_
  is '创建日期';
comment on column K_DOC_RIDER_HIS.update_date_
  is '更新日期';
comment on column K_DOC_RIDER_HIS.operator_id_
  is '操作人员ID';
comment on column K_DOC_RIDER_HIS.operator_name_
  is '操作人员名称';
comment on column K_DOC_RIDER_HIS.his_date_
  is '历史日期';
create index IX_CONTRACT_RIDER_HIS_CONTRACT on K_DOC_RIDER_HIS (DOC_ID_);
alter table K_DOC_RIDER_HIS
  add constraint PK_DOC_RIDER_HIS primary key (DOC_RIDER_HIS_ID_);
alter table K_DOC_RIDER_HIS
  add constraint UQ_DOC_RIDER_HIS unique (VERSION_, DOC_RIDER_ID_);
alter table K_DOC_RIDER_HIS
  add constraint FK_DOC_RIDER_HIS_DOC foreign key (DOC_ID_)
  references K_DOC (DOC_ID_);

prompt
prompt Creating table K_DOC_TYPE
prompt =========================
prompt
create table K_DOC_TYPE
(
  doc_type_id_          VARCHAR2(40) not null,
  doc_type_name_        VARCHAR2(60) not null,
  template_file_        BLOB,
  template_file_name_   VARCHAR2(300),
  template_file_length_ INTEGER,
  html_                 CLOB,
  bookmark_             CLOB,
  index_                VARCHAR2(1000),
  using_template_       VARCHAR2(20) not null,
  proc_def_code_        VARCHAR2(60) not null,
  desc_                 VARCHAR2(300),
  order_                INTEGER,
  doc_type_status_      VARCHAR2(20) not null,
  creation_date_        TIMESTAMP(6),
  update_date_          TIMESTAMP(6),
  operator_id_          VARCHAR2(40),
  operator_name_        VARCHAR2(60)
)
;
comment on table K_DOC_TYPE
  is '公文类型';
comment on column K_DOC_TYPE.doc_type_id_
  is '公文类型ID';
comment on column K_DOC_TYPE.doc_type_name_
  is '公文类型名称';
comment on column K_DOC_TYPE.template_file_
  is '模板文件';
comment on column K_DOC_TYPE.template_file_name_
  is '模板文件名称';
comment on column K_DOC_TYPE.template_file_length_
  is '模板文件长度';
comment on column K_DOC_TYPE.html_
  is 'HTML';
comment on column K_DOC_TYPE.bookmark_
  is '标签';
comment on column K_DOC_TYPE.index_
  is '定位';
comment on column K_DOC_TYPE.using_template_
  is '使用模板生成公文';
comment on column K_DOC_TYPE.proc_def_code_
  is '流程定义编码';
comment on column K_DOC_TYPE.desc_
  is '描述';
comment on column K_DOC_TYPE.order_
  is '排序';
comment on column K_DOC_TYPE.doc_type_status_
  is '公文类型状态';
comment on column K_DOC_TYPE.creation_date_
  is '创建日期';
comment on column K_DOC_TYPE.update_date_
  is '更新日期';
comment on column K_DOC_TYPE.operator_id_
  is '操作人员ID';
comment on column K_DOC_TYPE.operator_name_
  is '操作人员名称';
alter table K_DOC_TYPE
  add constraint PK_DOC_TYPE primary key (DOC_TYPE_ID_);
alter table K_DOC_TYPE
  add constraint UQ_DOC_TYPE_NAME unique (DOC_TYPE_NAME_);

prompt
prompt Creating table OM_CODE
prompt ======================
prompt
create table OM_CODE
(
  code_id_        VARCHAR2(40) not null,
  parent_code_id_ VARCHAR2(40),
  category_       VARCHAR2(20) not null,
  code_           VARCHAR2(60) not null,
  name_           VARCHAR2(60),
  ext_attr_1_     VARCHAR2(60),
  ext_attr_2_     VARCHAR2(60),
  ext_attr_3_     VARCHAR2(60),
  ext_attr_4_     VARCHAR2(60),
  ext_attr_5_     VARCHAR2(60),
  ext_attr_6_     VARCHAR2(60),
  order_          INTEGER
)
;
comment on table OM_CODE
  is '代码';
comment on column OM_CODE.code_id_
  is '代码ID';
comment on column OM_CODE.parent_code_id_
  is '上级代码ID';
comment on column OM_CODE.category_
  is '分类';
comment on column OM_CODE.code_
  is '代码';
comment on column OM_CODE.name_
  is '名称';
comment on column OM_CODE.ext_attr_1_
  is '扩展属性1';
comment on column OM_CODE.ext_attr_2_
  is '扩展属性2';
comment on column OM_CODE.ext_attr_3_
  is '扩展属性3';
comment on column OM_CODE.ext_attr_4_
  is '扩展属性4';
comment on column OM_CODE.ext_attr_5_
  is '扩展属性5';
comment on column OM_CODE.ext_attr_6_
  is '扩展属性6';
comment on column OM_CODE.order_
  is '排序';
alter table OM_CODE
  add constraint PK_OM_CODE primary key (CODE_ID_);
alter table OM_CODE
  add constraint UQ_OM_CODE unique (CATEGORY_, CODE_);
alter table OM_CODE
  add constraint FK_OM_CODE foreign key (PARENT_CODE_ID_)
  references OM_CODE (CODE_ID_);

prompt
prompt Creating table OM_ORGN_SET
prompt ==========================
prompt
create table OM_ORGN_SET
(
  orgn_set_id_        VARCHAR2(40) not null,
  parent_orgn_set_id_ VARCHAR2(40),
  orgn_set_code_      VARCHAR2(60) not null,
  orgn_set_name_      VARCHAR2(60) not null,
  allow_sync_         VARCHAR2(20) not null,
  memo_               VARCHAR2(300),
  order_              INTEGER,
  orgn_set_status_    VARCHAR2(20) not null,
  creation_date_      TIMESTAMP(6),
  update_date_        TIMESTAMP(6),
  operator_id_        VARCHAR2(40),
  operator_name_      VARCHAR2(60)
)
;
comment on table OM_ORGN_SET
  is '组织架构套';
comment on column OM_ORGN_SET.orgn_set_id_
  is '组织架构套ID';
comment on column OM_ORGN_SET.parent_orgn_set_id_
  is '上级组织架构套ID';
comment on column OM_ORGN_SET.orgn_set_code_
  is '组织架构套编码';
comment on column OM_ORGN_SET.orgn_set_name_
  is '组织架构套名称';
comment on column OM_ORGN_SET.allow_sync_
  is '允许同步';
comment on column OM_ORGN_SET.memo_
  is '备注';
comment on column OM_ORGN_SET.order_
  is '排序';
comment on column OM_ORGN_SET.orgn_set_status_
  is '组织架构套状态';
comment on column OM_ORGN_SET.creation_date_
  is '创建日期';
comment on column OM_ORGN_SET.update_date_
  is '修改日期';
comment on column OM_ORGN_SET.operator_id_
  is '操作人员ID';
comment on column OM_ORGN_SET.operator_name_
  is '操作人员名称';
alter table OM_ORGN_SET
  add constraint PK_OM_ORGN_SET primary key (ORGN_SET_ID_);
alter table OM_ORGN_SET
  add constraint UQ_OM_ORGN_SET_CODE unique (ORGN_SET_CODE_);
alter table OM_ORGN_SET
  add constraint FK_OM_ORGN_SET_PARENT foreign key (PARENT_ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);

prompt
prompt Creating table OM_DUTY
prompt ======================
prompt
create table OM_DUTY
(
  orgn_set_id_     VARCHAR2(40) not null,
  duty_id_         VARCHAR2(40) not null,
  duty_code_       VARCHAR2(60) not null,
  duty_name_       VARCHAR2(60) not null,
  duty_category_   VARCHAR2(20) not null,
  memo_            VARCHAR2(300),
  duty_tag_        VARCHAR2(120),
  duty_ext_attr_1_ VARCHAR2(120),
  duty_ext_attr_2_ VARCHAR2(120),
  duty_ext_attr_3_ VARCHAR2(120),
  duty_ext_attr_4_ VARCHAR2(120),
  duty_ext_attr_5_ VARCHAR2(120),
  duty_ext_attr_6_ VARCHAR2(120),
  duty_ext_attr_7_ VARCHAR2(120),
  duty_ext_attr_8_ VARCHAR2(120),
  order_           INTEGER,
  duty_status_     VARCHAR2(20) not null,
  creation_date_   TIMESTAMP(6),
  update_date_     TIMESTAMP(6),
  operator_id_     VARCHAR2(40),
  operator_name_   VARCHAR2(60)
)
;
comment on table OM_DUTY
  is '职务';
comment on column OM_DUTY.orgn_set_id_
  is '组织架构套ID';
comment on column OM_DUTY.duty_id_
  is '职务ID';
comment on column OM_DUTY.duty_code_
  is '职务编码';
comment on column OM_DUTY.duty_name_
  is '职务名称';
comment on column OM_DUTY.duty_category_
  is '分类';
comment on column OM_DUTY.memo_
  is '备注';
comment on column OM_DUTY.duty_tag_
  is '职务标签';
comment on column OM_DUTY.duty_ext_attr_1_
  is '职务扩展属性1';
comment on column OM_DUTY.duty_ext_attr_2_
  is '职务扩展属性2';
comment on column OM_DUTY.duty_ext_attr_3_
  is '职务扩展属性3';
comment on column OM_DUTY.duty_ext_attr_4_
  is '职务扩展属性4';
comment on column OM_DUTY.duty_ext_attr_5_
  is '职务扩展属性5';
comment on column OM_DUTY.duty_ext_attr_6_
  is '职务扩展属性6';
comment on column OM_DUTY.duty_ext_attr_7_
  is '职务扩展属性7';
comment on column OM_DUTY.duty_ext_attr_8_
  is '职务扩展属性8';
comment on column OM_DUTY.order_
  is '排序';
comment on column OM_DUTY.duty_status_
  is '职务状态';
comment on column OM_DUTY.creation_date_
  is '创建日期';
comment on column OM_DUTY.update_date_
  is '修改日期';
comment on column OM_DUTY.operator_id_
  is '操作人员ID';
comment on column OM_DUTY.operator_name_
  is '操作人员名称';
alter table OM_DUTY
  add constraint OK_OM_DUTY primary key (ORGN_SET_ID_, DUTY_ID_);
alter table OM_DUTY
  add constraint UQ_OM_DUTY_CODE unique (ORGN_SET_ID_, DUTY_CODE_);
alter table OM_DUTY
  add constraint FK_OM_DUTY_ORGN_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);

prompt
prompt Creating table OM_ORG
prompt =====================
prompt
create table OM_ORG
(
  orgn_set_id_    VARCHAR2(40) not null,
  org_id_         VARCHAR2(40) not null,
  parent_org_id_  VARCHAR2(40),
  org_code_       VARCHAR2(60) not null,
  org_name_       VARCHAR2(60) not null,
  org_abbr_name_  VARCHAR2(60),
  org_type_       VARCHAR2(20) not null,
  org_category_   VARCHAR2(20) not null,
  memo_           VARCHAR2(300),
  org_tag_        VARCHAR2(120),
  org_ext_attr_1_ VARCHAR2(120),
  org_ext_attr_2_ VARCHAR2(120),
  org_ext_attr_3_ VARCHAR2(120),
  org_ext_attr_4_ VARCHAR2(120),
  org_ext_attr_5_ VARCHAR2(120),
  org_ext_attr_6_ VARCHAR2(120),
  org_ext_attr_7_ VARCHAR2(120),
  org_ext_attr_8_ VARCHAR2(120),
  order_          INTEGER,
  org_status_     VARCHAR2(20) not null,
  creation_date_  TIMESTAMP(6),
  update_date_    TIMESTAMP(6),
  operator_id_    VARCHAR2(40),
  operator_name_  VARCHAR2(60)
)
;
comment on table OM_ORG
  is '机构';
comment on column OM_ORG.orgn_set_id_
  is '组织架构套ID';
comment on column OM_ORG.org_id_
  is '机构ID';
comment on column OM_ORG.parent_org_id_
  is '上级机构ID';
comment on column OM_ORG.org_code_
  is '机构编码';
comment on column OM_ORG.org_name_
  is '机构名称';
comment on column OM_ORG.org_abbr_name_
  is '机构简称';
comment on column OM_ORG.org_type_
  is '机构类型';
comment on column OM_ORG.org_category_
  is '分类';
comment on column OM_ORG.memo_
  is '备注';
comment on column OM_ORG.org_tag_
  is '机构标签';
comment on column OM_ORG.org_ext_attr_1_
  is '机构扩展属性1';
comment on column OM_ORG.org_ext_attr_2_
  is '机构扩展属性2';
comment on column OM_ORG.org_ext_attr_3_
  is '机构扩展属性3';
comment on column OM_ORG.org_ext_attr_4_
  is '机构扩展属性4';
comment on column OM_ORG.org_ext_attr_5_
  is '机构扩展属性5';
comment on column OM_ORG.org_ext_attr_6_
  is '机构扩展属性6';
comment on column OM_ORG.org_ext_attr_7_
  is '机构扩展属性7';
comment on column OM_ORG.org_ext_attr_8_
  is '机构扩展属性8';
comment on column OM_ORG.order_
  is '排序';
comment on column OM_ORG.org_status_
  is '机构状态';
comment on column OM_ORG.creation_date_
  is '创建日期';
comment on column OM_ORG.update_date_
  is '修改日期';
comment on column OM_ORG.operator_id_
  is '操作人员ID';
comment on column OM_ORG.operator_name_
  is '操作人员名称';
create index IX_OM_ORG_ORDER on OM_ORG (ORDER_);
alter table OM_ORG
  add constraint PK_OM_ORG primary key (ORGN_SET_ID_, ORG_ID_);
alter table OM_ORG
  add constraint UQ_OM_ORG_CODE unique (ORGN_SET_ID_, ORG_CODE_);
alter table OM_ORG
  add constraint FK_OM_ORG_ORGN_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);
alter table OM_ORG
  add constraint FK_OM_ORG_PARENT foreign key (ORGN_SET_ID_, PARENT_ORG_ID_)
  references OM_ORG (ORGN_SET_ID_, ORG_ID_);

prompt
prompt Creating table OM_EMP
prompt =====================
prompt
create table OM_EMP
(
  orgn_set_id_        VARCHAR2(40) not null,
  emp_id_             VARCHAR2(40) not null,
  org_id_             VARCHAR2(40) not null,
  emp_code_           VARCHAR2(60) not null,
  emp_name_           VARCHAR2(60) not null,
  password_           VARCHAR2(40),
  password_reset_req_ VARCHAR2(20) not null,
  party_              VARCHAR2(20),
  emp_level_          VARCHAR2(20),
  gender_             VARCHAR2(20),
  birth_date_         TIMESTAMP(6),
  tel_                VARCHAR2(60),
  email_              VARCHAR2(60),
  in_date_            TIMESTAMP(6),
  out_date_           TIMESTAMP(6),
  emp_category_       VARCHAR2(20) not null,
  memo_               VARCHAR2(300),
  emp_tag_            VARCHAR2(120),
  emp_ext_attr_1_     VARCHAR2(120),
  emp_ext_attr_2_     VARCHAR2(120),
  emp_ext_attr_3_     VARCHAR2(120),
  emp_ext_attr_4_     VARCHAR2(120),
  emp_ext_attr_5_     VARCHAR2(120),
  emp_ext_attr_6_     VARCHAR2(120),
  emp_ext_attr_7_     VARCHAR2(120),
  emp_ext_attr_8_     VARCHAR2(120),
  order_              INTEGER,
  emp_status_         VARCHAR2(20) not null,
  creation_date_      TIMESTAMP(6),
  update_date_        TIMESTAMP(6),
  operator_id_        VARCHAR2(40),
  operator_name_      VARCHAR2(60)
)
;
comment on table OM_EMP
  is '人员';
comment on column OM_EMP.orgn_set_id_
  is '组织架构套ID';
comment on column OM_EMP.emp_id_
  is '人员ID';
comment on column OM_EMP.org_id_
  is '机构ID';
comment on column OM_EMP.emp_code_
  is '人员编码';
comment on column OM_EMP.emp_name_
  is '人员名称';
comment on column OM_EMP.password_
  is '密码';
comment on column OM_EMP.password_reset_req_
  is '密码重置';
comment on column OM_EMP.party_
  is '政治面貌';
comment on column OM_EMP.emp_level_
  is '职级';
comment on column OM_EMP.gender_
  is '性别';
comment on column OM_EMP.birth_date_
  is '出生日期';
comment on column OM_EMP.tel_
  is '电话';
comment on column OM_EMP.email_
  is '电子邮箱';
comment on column OM_EMP.in_date_
  is '入职日期';
comment on column OM_EMP.out_date_
  is '离职日期';
comment on column OM_EMP.emp_category_
  is '分类';
comment on column OM_EMP.memo_
  is '备注';
comment on column OM_EMP.emp_tag_
  is '人员标签';
comment on column OM_EMP.emp_ext_attr_1_
  is '人员扩展属性1';
comment on column OM_EMP.emp_ext_attr_2_
  is '人员扩展属性2';
comment on column OM_EMP.emp_ext_attr_3_
  is '人员扩展属性3';
comment on column OM_EMP.emp_ext_attr_4_
  is '人员扩展属性4';
comment on column OM_EMP.emp_ext_attr_5_
  is '人员扩展属性5';
comment on column OM_EMP.emp_ext_attr_6_
  is '人员扩展属性6';
comment on column OM_EMP.emp_ext_attr_7_
  is '人员扩展属性7';
comment on column OM_EMP.emp_ext_attr_8_
  is '人员扩展属性8';
comment on column OM_EMP.order_
  is '排序';
comment on column OM_EMP.emp_status_
  is '人员状态';
comment on column OM_EMP.creation_date_
  is '创建日期';
comment on column OM_EMP.update_date_
  is '更新日期';
comment on column OM_EMP.operator_id_
  is '操作人员ID';
comment on column OM_EMP.operator_name_
  is '操作人员名称';
create index IX_OM_EMP_ORDER on OM_EMP (ORDER_);
alter table OM_EMP
  add constraint PK_OM_EMP primary key (ORGN_SET_ID_, EMP_ID_);
alter table OM_EMP
  add constraint UQ_OM_EMP_CODE unique (ORGN_SET_ID_, EMP_CODE_);
alter table OM_EMP
  add constraint FK_OM_EMP_ORG foreign key (ORGN_SET_ID_, ORG_ID_)
  references OM_ORG (ORGN_SET_ID_, ORG_ID_);
alter table OM_EMP
  add constraint FK_OM_EMP_ORGN_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);

prompt
prompt Creating table OM_EMP_RELATION
prompt ==============================
prompt
create table OM_EMP_RELATION
(
  orgn_set_id_             VARCHAR2(40) not null,
  emp_relation_id_         VARCHAR2(40) not null,
  upper_emp_id_            VARCHAR2(40) not null,
  lower_emp_id_            VARCHAR2(40) not null,
  emp_relation_            VARCHAR2(20) not null,
  emp_relation_category_   VARCHAR2(20),
  memo_                    VARCHAR2(300),
  emp_relation_tag_        VARCHAR2(120),
  emp_relation_ext_attr_1_ VARCHAR2(120),
  emp_relation_ext_attr_2_ VARCHAR2(120),
  emp_relation_ext_attr_3_ VARCHAR2(120),
  emp_relation_ext_attr_4_ VARCHAR2(120),
  emp_relation_ext_attr_5_ VARCHAR2(120),
  emp_relation_ext_attr_6_ VARCHAR2(120),
  emp_relation_ext_attr_7_ VARCHAR2(120),
  emp_relation_ext_attr_8_ VARCHAR2(120),
  order_                   INTEGER,
  emp_relation_status_     VARCHAR2(20) not null,
  creation_date_           TIMESTAMP(6),
  update_date_             TIMESTAMP(6),
  operator_id_             VARCHAR2(40),
  operator_name_           VARCHAR2(60)
)
;
comment on table OM_EMP_RELATION
  is '人员关系';
comment on column OM_EMP_RELATION.orgn_set_id_
  is '组织架构套ID';
comment on column OM_EMP_RELATION.emp_relation_id_
  is '人员关系ID';
comment on column OM_EMP_RELATION.upper_emp_id_
  is '上级人员ID';
comment on column OM_EMP_RELATION.lower_emp_id_
  is '下级人员ID';
comment on column OM_EMP_RELATION.emp_relation_
  is '人员关系';
comment on column OM_EMP_RELATION.emp_relation_category_
  is '分类';
comment on column OM_EMP_RELATION.memo_
  is '备注';
comment on column OM_EMP_RELATION.emp_relation_tag_
  is '人员关系标签';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_1_
  is '人员关系扩展属性1';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_2_
  is '人员关系扩展属性2';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_3_
  is '人员关系扩展属性3';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_4_
  is '人员关系扩展属性4';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_5_
  is '人员关系扩展属性5';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_6_
  is '人员关系扩展属性6';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_7_
  is '人员关系扩展属性7';
comment on column OM_EMP_RELATION.emp_relation_ext_attr_8_
  is '人员关系扩展属性8';
comment on column OM_EMP_RELATION.order_
  is '排序';
comment on column OM_EMP_RELATION.emp_relation_status_
  is '人员关系状态';
comment on column OM_EMP_RELATION.creation_date_
  is '创建日期';
comment on column OM_EMP_RELATION.update_date_
  is '修改日期';
comment on column OM_EMP_RELATION.operator_id_
  is '操作人员ID';
comment on column OM_EMP_RELATION.operator_name_
  is '操作人员名称';
alter table OM_EMP_RELATION
  add constraint PK_OM_EMP_RELATION primary key (ORGN_SET_ID_, EMP_RELATION_ID_);
alter table OM_EMP_RELATION
  add constraint UQ_OM_EMP_RELATION unique (ORGN_SET_ID_, UPPER_EMP_ID_, LOWER_EMP_ID_, EMP_RELATION_);
alter table OM_EMP_RELATION
  add constraint FK_OM_EMP_RELATION_LOWER_EMP foreign key (ORGN_SET_ID_, LOWER_EMP_ID_)
  references OM_EMP (ORGN_SET_ID_, EMP_ID_);
alter table OM_EMP_RELATION
  add constraint FK_OM_EMP_RELATION_ORNG_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);
alter table OM_EMP_RELATION
  add constraint FK_OM_EMP_RELATION_UPPER_EMP foreign key (ORGN_SET_ID_, UPPER_EMP_ID_)
  references OM_EMP (ORGN_SET_ID_, EMP_ID_);

prompt
prompt Creating table OM_LOG
prompt =====================
prompt
create table OM_LOG
(
  log_id_        VARCHAR2(40) not null,
  category_      VARCHAR2(60),
  ip_            VARCHAR2(60),
  user_agent_    VARCHAR2(200),
  url_           CLOB,
  action_        VARCHAR2(200),
  parameter_map_ CLOB,
  business_key_  VARCHAR2(40),
  error_         VARCHAR2(20),
  message_       CLOB,
  org_id_        VARCHAR2(40),
  org_name_      VARCHAR2(60),
  posi_id_       VARCHAR2(40),
  posi_name_     VARCHAR2(60),
  emp_id_        VARCHAR2(40),
  emp_name_      VARCHAR2(60),
  creation_date_ TIMESTAMP(6) not null
)
;
comment on table OM_LOG
  is '日志';
comment on column OM_LOG.log_id_
  is '日志ID';
comment on column OM_LOG.category_
  is '分类';
comment on column OM_LOG.ip_
  is 'IP';
comment on column OM_LOG.user_agent_
  is '用户代理';
comment on column OM_LOG.url_
  is '调用URL';
comment on column OM_LOG.action_
  is '调用控制层接口';
comment on column OM_LOG.parameter_map_
  is '调用参数';
comment on column OM_LOG.business_key_
  is '业务主键';
comment on column OM_LOG.error_
  is '错误';
comment on column OM_LOG.message_
  is '信息';
comment on column OM_LOG.org_id_
  is '机构ID';
comment on column OM_LOG.org_name_
  is '机构名称';
comment on column OM_LOG.posi_id_
  is '岗位ID';
comment on column OM_LOG.posi_name_
  is '岗位名称';
comment on column OM_LOG.emp_id_
  is '人员ID';
comment on column OM_LOG.emp_name_
  is '人员名称';
comment on column OM_LOG.creation_date_
  is '创建日期';
alter table OM_LOG
  add constraint PK_OM_LOG primary key (LOG_ID_);

prompt
prompt Creating table OM_MAIN_SERVER
prompt =============================
prompt
create table OM_MAIN_SERVER
(
  main_server_id_     VARCHAR2(40) not null,
  main_server_name_   VARCHAR2(60) not null,
  driver_class_name_  VARCHAR2(100) not null,
  url_                VARCHAR2(200) not null,
  username_           VARCHAR2(40) not null,
  password_           VARCHAR2(40) not null,
  memo_               VARCHAR2(300),
  last_sync_date_     TIMESTAMP(6),
  order_              INTEGER,
  main_server_status_ VARCHAR2(20) not null,
  creation_date_      TIMESTAMP(6),
  update_date_        TIMESTAMP(6),
  operator_id_        VARCHAR2(40),
  operator_name_      VARCHAR2(60)
)
;
comment on table OM_MAIN_SERVER
  is '主服务器';
comment on column OM_MAIN_SERVER.main_server_id_
  is '主服务器ID';
comment on column OM_MAIN_SERVER.main_server_name_
  is '主服务器名称';
comment on column OM_MAIN_SERVER.driver_class_name_
  is '驱动类名称';
comment on column OM_MAIN_SERVER.url_
  is '链接';
comment on column OM_MAIN_SERVER.username_
  is '用户名';
comment on column OM_MAIN_SERVER.password_
  is '密码';
comment on column OM_MAIN_SERVER.memo_
  is '备注';
comment on column OM_MAIN_SERVER.last_sync_date_
  is '上次同步日期';
comment on column OM_MAIN_SERVER.order_
  is '排序';
comment on column OM_MAIN_SERVER.main_server_status_
  is '主服务器状态';
comment on column OM_MAIN_SERVER.creation_date_
  is '创建日期';
comment on column OM_MAIN_SERVER.update_date_
  is '修改日期';
comment on column OM_MAIN_SERVER.operator_id_
  is '操作人员ID';
comment on column OM_MAIN_SERVER.operator_name_
  is '操作人员名称';
alter table OM_MAIN_SERVER
  add constraint PK_OM_MAIN_SERVER primary key (MAIN_SERVER_ID_);
alter table OM_MAIN_SERVER
  add constraint UQ_OM_MAIN_SERVER_NAME unique (MAIN_SERVER_NAME_);

prompt
prompt Creating table OM_MIRROR_SERVER
prompt ===============================
prompt
create table OM_MIRROR_SERVER
(
  mirror_server_id_     VARCHAR2(40) not null,
  mirror_server_name_   VARCHAR2(60) not null,
  driver_class_name_    VARCHAR2(100) not null,
  url_                  VARCHAR2(200) not null,
  username_             VARCHAR2(40) not null,
  password_             VARCHAR2(40) not null,
  memo_                 VARCHAR2(300),
  last_sync_date_       TIMESTAMP(6),
  order_                INTEGER,
  mirror_server_status_ VARCHAR2(20) not null,
  creation_date_        TIMESTAMP(6),
  update_date_          TIMESTAMP(6),
  operator_id_          VARCHAR2(40),
  operator_name_        VARCHAR2(60)
)
;
comment on table OM_MIRROR_SERVER
  is '镜像服务器';
comment on column OM_MIRROR_SERVER.mirror_server_id_
  is '镜像服务器ID';
comment on column OM_MIRROR_SERVER.mirror_server_name_
  is '镜像服务器名称';
comment on column OM_MIRROR_SERVER.driver_class_name_
  is '驱动类名称';
comment on column OM_MIRROR_SERVER.url_
  is '链接';
comment on column OM_MIRROR_SERVER.username_
  is '用户名';
comment on column OM_MIRROR_SERVER.password_
  is '密码';
comment on column OM_MIRROR_SERVER.memo_
  is '备注';
comment on column OM_MIRROR_SERVER.last_sync_date_
  is '上次同步日期';
comment on column OM_MIRROR_SERVER.order_
  is '排序';
comment on column OM_MIRROR_SERVER.mirror_server_status_
  is '镜像服务器状态';
comment on column OM_MIRROR_SERVER.creation_date_
  is '创建日期';
comment on column OM_MIRROR_SERVER.update_date_
  is '修改日期';
comment on column OM_MIRROR_SERVER.operator_id_
  is '操作人员ID';
comment on column OM_MIRROR_SERVER.operator_name_
  is '操作人员名称';
alter table OM_MIRROR_SERVER
  add constraint PK_OM_MIRROR_SERVER primary key (MIRROR_SERVER_ID_);
alter table OM_MIRROR_SERVER
  add constraint UQ_OM_MIRROR_SERVER_NAME unique (MIRROR_SERVER_NAME_);

prompt
prompt Creating table OM_POSI
prompt ======================
prompt
create table OM_POSI
(
  orgn_set_id_     VARCHAR2(40) not null,
  posi_id_         VARCHAR2(40) not null,
  org_id_          VARCHAR2(40) not null,
  duty_id_         VARCHAR2(40),
  posi_code_       VARCHAR2(60),
  posi_name_       VARCHAR2(60) not null,
  org_leader_type_ VARCHAR2(20),
  posi_category_   VARCHAR2(20) not null,
  memo_            VARCHAR2(300),
  posi_tag_        VARCHAR2(120),
  posi_ext_attr_1_ VARCHAR2(120),
  posi_ext_attr_2_ VARCHAR2(120),
  posi_ext_attr_3_ VARCHAR2(120),
  posi_ext_attr_4_ VARCHAR2(120),
  posi_ext_attr_5_ VARCHAR2(120),
  posi_ext_attr_6_ VARCHAR2(120),
  posi_ext_attr_7_ VARCHAR2(120),
  posi_ext_attr_8_ VARCHAR2(120),
  order_           INTEGER,
  posi_status_     VARCHAR2(20) not null,
  creation_date_   TIMESTAMP(6),
  update_date_     TIMESTAMP(6),
  operator_id_     VARCHAR2(40),
  operator_name_   VARCHAR2(60)
)
;
comment on table OM_POSI
  is '岗位';
comment on column OM_POSI.orgn_set_id_
  is '组织架构套ID';
comment on column OM_POSI.posi_id_
  is '岗位ID';
comment on column OM_POSI.org_id_
  is '机构ID';
comment on column OM_POSI.duty_id_
  is '职务ID';
comment on column OM_POSI.posi_code_
  is '岗位编码';
comment on column OM_POSI.posi_name_
  is '岗位名称';
comment on column OM_POSI.org_leader_type_
  is '机构领导类型';
comment on column OM_POSI.posi_category_
  is '分类';
comment on column OM_POSI.memo_
  is '备注';
comment on column OM_POSI.posi_tag_
  is '岗位标签';
comment on column OM_POSI.posi_ext_attr_1_
  is '岗位扩展属性1';
comment on column OM_POSI.posi_ext_attr_2_
  is '岗位扩展属性2';
comment on column OM_POSI.posi_ext_attr_3_
  is '岗位扩展属性3';
comment on column OM_POSI.posi_ext_attr_4_
  is '岗位扩展属性4';
comment on column OM_POSI.posi_ext_attr_5_
  is '岗位扩展属性5';
comment on column OM_POSI.posi_ext_attr_6_
  is '岗位扩展属性6';
comment on column OM_POSI.posi_ext_attr_7_
  is '岗位扩展属性7';
comment on column OM_POSI.posi_ext_attr_8_
  is '岗位扩展属性8';
comment on column OM_POSI.order_
  is '排序';
comment on column OM_POSI.posi_status_
  is '岗位状态';
comment on column OM_POSI.creation_date_
  is '创建日期';
comment on column OM_POSI.update_date_
  is '修改日期';
comment on column OM_POSI.operator_id_
  is '操作人员ID';
comment on column OM_POSI.operator_name_
  is '操作人员名称';
alter table OM_POSI
  add constraint PK_OM_POSI primary key (ORGN_SET_ID_, POSI_ID_);
alter table OM_POSI
  add constraint UQ_OM_POSI_CODE unique (ORGN_SET_ID_, POSI_CODE_)
  disable
  novalidate;
alter table OM_POSI
  add constraint FK_OM_POSI_DUTY foreign key (ORGN_SET_ID_, DUTY_ID_)
  references OM_DUTY (ORGN_SET_ID_, DUTY_ID_);
alter table OM_POSI
  add constraint FK_OM_POSI_ORG foreign key (ORGN_SET_ID_, ORG_ID_)
  references OM_ORG (ORGN_SET_ID_, ORG_ID_);
alter table OM_POSI
  add constraint FK_OM_POSI_ORGN_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);

prompt
prompt Creating table OM_POSI_EMP
prompt ==========================
prompt
create table OM_POSI_EMP
(
  orgn_set_id_         VARCHAR2(40) not null,
  posi_emp_id_         VARCHAR2(40) not null,
  posi_id_             VARCHAR2(40) not null,
  emp_id_              VARCHAR2(40) not null,
  main_                VARCHAR2(20) not null,
  posi_emp_category_   VARCHAR2(20),
  memo_                VARCHAR2(300),
  posi_emp_tag_        VARCHAR2(120),
  posi_emp_ext_attr_1_ VARCHAR2(120),
  posi_emp_ext_attr_2_ VARCHAR2(120),
  posi_emp_ext_attr_3_ VARCHAR2(120),
  posi_emp_ext_attr_4_ VARCHAR2(120),
  posi_emp_ext_attr_5_ VARCHAR2(120),
  posi_emp_ext_attr_6_ VARCHAR2(120),
  posi_emp_ext_attr_7_ VARCHAR2(120),
  posi_emp_ext_attr_8_ VARCHAR2(120),
  order_               INTEGER,
  posi_emp_status_     VARCHAR2(20) not null,
  creation_date_       TIMESTAMP(6),
  update_date_         TIMESTAMP(6),
  operator_id_         VARCHAR2(40),
  operator_name_       VARCHAR2(60)
)
;
comment on table OM_POSI_EMP
  is '岗位人员';
comment on column OM_POSI_EMP.orgn_set_id_
  is '组织架构套ID';
comment on column OM_POSI_EMP.posi_emp_id_
  is '岗位人员ID';
comment on column OM_POSI_EMP.posi_id_
  is '岗位ID';
comment on column OM_POSI_EMP.emp_id_
  is '人员ID';
comment on column OM_POSI_EMP.main_
  is '主岗位';
comment on column OM_POSI_EMP.posi_emp_category_
  is '分类';
comment on column OM_POSI_EMP.memo_
  is '备注';
comment on column OM_POSI_EMP.posi_emp_tag_
  is '岗位人员标签';
comment on column OM_POSI_EMP.posi_emp_ext_attr_1_
  is '岗位人员扩展属性1';
comment on column OM_POSI_EMP.posi_emp_ext_attr_2_
  is '岗位人员扩展属性2';
comment on column OM_POSI_EMP.posi_emp_ext_attr_3_
  is '岗位人员扩展属性3';
comment on column OM_POSI_EMP.posi_emp_ext_attr_4_
  is '岗位人员扩展属性4';
comment on column OM_POSI_EMP.posi_emp_ext_attr_5_
  is '岗位人员扩展属性5';
comment on column OM_POSI_EMP.posi_emp_ext_attr_6_
  is '岗位人员扩展属性6';
comment on column OM_POSI_EMP.posi_emp_ext_attr_7_
  is '岗位人员扩展属性7';
comment on column OM_POSI_EMP.posi_emp_ext_attr_8_
  is '岗位人员扩展属性8';
comment on column OM_POSI_EMP.order_
  is '排序';
comment on column OM_POSI_EMP.posi_emp_status_
  is '岗位人员状态';
comment on column OM_POSI_EMP.creation_date_
  is '创建日期';
comment on column OM_POSI_EMP.update_date_
  is '更新日期';
comment on column OM_POSI_EMP.operator_id_
  is '操作人员ID';
comment on column OM_POSI_EMP.operator_name_
  is '操作人员名称';
create index IX_POSI_EMP_EMP on OM_POSI_EMP (EMP_ID_);
create index IX_POSI_EMP_POSI on OM_POSI_EMP (POSI_ID_);
alter table OM_POSI_EMP
  add constraint PK_OM_POSI_EMP primary key (ORGN_SET_ID_, POSI_EMP_ID_);
alter table OM_POSI_EMP
  add constraint UQ_OM_POSI_EMP unique (ORGN_SET_ID_, POSI_ID_, EMP_ID_);
alter table OM_POSI_EMP
  add constraint FK_OM_POSI_EMP_EMP foreign key (ORGN_SET_ID_, EMP_ID_)
  references OM_EMP (ORGN_SET_ID_, EMP_ID_);
alter table OM_POSI_EMP
  add constraint FK_OM_POSI_EMP_ORGN_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);
alter table OM_POSI_EMP
  add constraint FK_OM_POSI_EMP_POSI foreign key (ORGN_SET_ID_, POSI_ID_)
  references OM_POSI (ORGN_SET_ID_, POSI_ID_);

prompt
prompt Creating table OM_TAG
prompt =====================
prompt
create table OM_TAG
(
  orgn_set_id_ VARCHAR2(40) not null,
  tag_id_      VARCHAR2(40) not null,
  obj_id_      VARCHAR2(40) not null,
  obj_type_    VARCHAR2(60),
  tag_         VARCHAR2(60) not null
)
;
comment on table OM_TAG
  is '标签';
comment on column OM_TAG.orgn_set_id_
  is '组织架构套ID';
comment on column OM_TAG.tag_id_
  is '标签ID';
comment on column OM_TAG.obj_id_
  is '对象ID';
comment on column OM_TAG.obj_type_
  is '对象类型';
comment on column OM_TAG.tag_
  is '标签';
alter table OM_TAG
  add constraint PK_OM_TAG primary key (ORGN_SET_ID_, TAG_ID_);
alter table OM_TAG
  add constraint FK_OM_TAG_ORGN_SET foreign key (ORGN_SET_ID_)
  references OM_ORGN_SET (ORGN_SET_ID_);

prompt
prompt Creating view CBV_CODE
prompt ======================
prompt
create or replace force view cbv_code as
select CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_ from CB_CODE;

prompt
prompt Creating view CBV_CUSTOM_THEME
prompt ==============================
prompt
create or replace force view cbv_custom_theme as
select CT.CUSTOM_THEME_ID_, CT.OPERATOR_ID_, CT.CSS_HREF_ from CB_CUSTOM_THEME CT;

prompt
prompt Creating view CBV_DASHBOARD
prompt ===========================
prompt
create or replace force view cbv_dashboard as
select D.DASHBOARD_ID_, D.DASHBOARD_MODULE_ID_, D.POSI_EMP_ID_, D.DASHBOARD_MODULE_NAME_, D.URL_, D.WIDTH_, D.HEIGHT_, D.ORDER_ from CB_DASHBOARD D;

prompt
prompt Creating view CBV_DASHBOARD_MODULE
prompt ==================================
prompt
create or replace force view cbv_dashboard_module as
select DM.DASHBOARD_MODULE_ID_, DM.DASHBOARD_MODULE_NAME_, DM.DASHBOARD_MODULE_TYPE_, DM.DEFAULT_URL_, DM.DEFAULT_WIDTH_, DM.DEFAULT_HEIGHT_, DM.DASHBOARD_MODULE_TAG_, DM.ORDER_, DM.DASHBOARD_MODULE_STATUS_ from CB_DASHBOARD_MODULE DM;

prompt
prompt Creating view CBV_DUTY_MENU
prompt ===========================
prompt
create or replace force view cbv_duty_menu as
select PM.DUTY_MENU_ID_, PM.DUTY_ID_, PM.DUTY_NAME_, PM.MENU_ID_, PM.CREATION_DATE_, PM.UPDATE_DATE_, PM.OPERATOR_ID_, PM.OPERATOR_NAME_, M.PARENT_MENU_ID_, M.MENU_NAME_, M.MENU_TYPE_, M.URL_, M.ORDER_, M.MENU_STATUS_, M.ICON_ from CB_DUTY_MENU PM inner join CB_MENU M on M.MENU_ID_ = PM.MENU_ID_;

prompt
prompt Creating view CBV_LOG
prompt =====================
prompt
create or replace force view cbv_log as
select LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_ from CB_LOG;

prompt
prompt Creating view CBV_MENU
prompt ======================
prompt
create or replace force view cbv_menu as
select MENU_ID_, PARENT_MENU_ID_, MENU_NAME_, MENU_TYPE_, URL_, ORDER_, MENU_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_, ICON_ from CB_MENU;

prompt
prompt Creating view CBV_NOTICE
prompt ========================
prompt
create or replace force view cbv_notice as
select N.NOTICE_ID_, N.POSI_EMP_ID_, N.EMP_ID_, N.EMP_CODE_, N.EMP_NAME_, N.CONTENT_, N.SOURCE_, N.IDENTITY_, N.REDIRECT_URL_, N.BIZ_URL_, N.EXP_DATE_, N.NOTICE_STATUS_, N.CREATION_DATE_ from CB_NOTICE N;

prompt
prompt Creating view CBV_POSI_EMP_MENU
prompt ===============================
prompt
create or replace force view cbv_posi_emp_menu as
select PEM.POSI_EMP_MENU_ID_, PEM.POSI_EMP_ID_, PEM.POSI_NAME_, PEM.EMP_NAME_, PEM.MENU_ID_, PEM.CREATION_DATE_, PEM.UPDATE_DATE_, PEM.OPERATOR_ID_, PEM.OPERATOR_NAME_, M.PARENT_MENU_ID_, M.MENU_NAME_, M.MENU_TYPE_, M.URL_, M.ORDER_, M.MENU_STATUS_, M.ICON_ from CB_POSI_EMP_MENU PEM inner join CB_MENU M on M.MENU_ID_ = PEM.MENU_ID_;

prompt
prompt Creating view CBV_POSI_MENU
prompt ===========================
prompt
create or replace force view cbv_posi_menu as
select PM.POSI_MENU_ID_, PM.POSI_ID_, PM.POSI_NAME_, PM.MENU_ID_, PM.CREATION_DATE_, PM.UPDATE_DATE_, PM.OPERATOR_ID_, PM.OPERATOR_NAME_, M.PARENT_MENU_ID_, M.MENU_NAME_, M.MENU_TYPE_, M.URL_, M.ORDER_, M.MENU_STATUS_, M.ICON_ from CB_POSI_MENU PM inner join CB_MENU M on M.MENU_ID_ = PM.MENU_ID_;

prompt
prompt Creating view CBV_RIDER
prompt =======================
prompt
create or replace force view cbv_rider as
select RIDER_ID_, OBJ_ID_, RIDER_FILE_NAME_, RIDER_FILE_LENGTH_, MEMO_, RIDER_TAG_, ORDER_, RIDER_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ from CB_RIDER;

prompt
prompt Creating view CBV_TAG
prompt =====================
prompt
create or replace force view cbv_tag as
select TAG_ID_, OBJ_ID_, OBJ_TYPE_, TAG_ from CB_TAG;

prompt
prompt Creating view CBV_WORKING_CALENDAR
prompt ==================================
prompt
create or replace force view cbv_working_calendar as
select WC.WORKING_CALENDAR_ID_, WC.EMP_ID_, WC.DATE_, WC.WORKING_DAY_, WC.MARK_ from CB_WORKING_CALENDAR WC;

prompt
prompt Creating view FFV_ADJUST_PROC_DEF
prompt =================================
prompt
create or replace force view ffv_adjust_proc_def as
select APD.ADJUST_PROC_DEF_ID_, APD.PROC_DEF_ID_, APD.PROC_DEF_MODEL_, APD.PROC_DEF_DIAGRAM_FILE_, APD.PROC_DEF_DIAGRAM_FILE_NAME_, APD.PROC_DEF_DIAGRAM_FILE_LENGTH_, APD.PROC_DEF_DIAGRAM_WIDTH_, APD.PROC_DEF_DIAGRAM_HEIGHT_, APD.CREATION_DATE_, APD.UPDATE_DATE_, APD.OPERATOR_ID_, APD.OPERATOR_NAME_ from FF_ADJUST_PROC_DEF APD;

prompt
prompt Creating view FFV_DELEGATE
prompt ==========================
prompt
create or replace force view ffv_delegate as
select D.DELEGATE_ID_, D.ASSIGNEE_, D.ASSIGNEE_NAME_, D.DELEGATOR_, D.DELEGATOR_NAME_, D.START_DATE_, D.END_DATE_ from FF_DELEGATE D;

prompt
prompt Creating view FFV_NODE
prompt ======================
prompt
create or replace force view ffv_node as
select N.NODE_ID_, N.PARENT_NODE_ID_, N.PROC_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.ASSIGNEE_, N.ACTION_, N.DUE_DATE_, N.CLAIM_, N.FORWARDABLE_, N.PRIORITY_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.NEXT_CANDIDATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ from FF_NODE N;

prompt
prompt Creating view FFV_NODE_P
prompt ========================
prompt
create or replace force view ffv_node_p as
select N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.ASSIGNEE_, N.ACTION_, N.DUE_DATE_, N.CLAIM_, N.FORWARDABLE_, N.PRIORITY_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.NEXT_CANDIDATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_, P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_
  from FF_NODE N
 inner join FF_PROC P
    on P.PROC_ID_ = N.PROC_ID_;

prompt
prompt Creating view FFV_NODE_PD
prompt =========================
prompt
create or replace force view ffv_node_pd as
select N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.ASSIGNEE_, N.ACTION_, N.DUE_DATE_, N.CLAIM_, N.FORWARDABLE_, N.PRIORITY_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.NEXT_CANDIDATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_, P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_, SPD.PROC_DEF_CODE_ as SUB_PROC_DEF_CODE_
  from FF_NODE N
 inner join FF_PROC P on P.PROC_ID_ = N.PROC_ID_
 inner join FF_PROC_DEF PD on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_
 inner join FF_PROC_DEF SPD on SPD.PROC_DEF_ID_ = N.SUB_PROC_DEF_ID_;

prompt
prompt Creating view FFV_NODE_VAR
prompt ==========================
prompt
create or replace force view ffv_node_var as
select PV.NODE_VAR_ID_, PV.NODE_ID_, PV.VAR_TYPE_, PV.VAR_NAME_, PV.VALUE_, PV.OBJ_, PV.CREATION_DATE_, N.PARENT_NODE_ID_, N.PROC_ID_ from FF_NODE_VAR PV inner join FF_NODE N on N.NODE_ID_ = PV.NODE_ID_;

prompt
prompt Creating view FFV_OPERATION
prompt ===========================
prompt
create or replace force view ffv_operation as
select O.OPERATION_ID_, O.OPERATION_, O.PROC_ID_, O.NODE_ID_, O.TASK_ID_, O.MEMO_, O.OPERATOR_, O.OPERATOR_NAME_, O.OPERATION_DATE_, O.OPERATION_STATUS_ from FF_OPERATION O;

prompt
prompt Creating view FFV_PROC
prompt ======================
prompt
create or replace force view ffv_proc as
select P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ from FF_PROC P;

prompt
prompt Creating view FFV_OPERATION_P
prompt =============================
prompt
create or replace force view ffv_operation_p as
select O.OPERATION_ID_, O.OPERATION_, O.NODE_ID_, O.TASK_ID_, O.MEMO_, O.OPERATOR_, O.OPERATOR_NAME_, O.OPERATION_DATE_, O.OPERATION_STATUS_, P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ from FF_OPERATION O left outer join FFV_PROC P on P.PROC_ID_ = O.PROC_ID_;

prompt
prompt Creating view FFV_OPERATION_PD
prompt ==============================
prompt
create or replace force view ffv_operation_pd as
select O.OPERATION_ID_, O.OPERATION_, O.NODE_ID_, O.TASK_ID_, O.MEMO_, O.OPERATOR_, O.OPERATOR_NAME_, O.OPERATION_DATE_, O.OPERATION_STATUS_, P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_ from FF_OPERATION O left outer join FFV_PROC P on P.PROC_ID_ = O.PROC_ID_ inner join FF_PROC_DEF PD on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_;

prompt
prompt Creating view FFV_PROC_DEF
prompt ==========================
prompt
create or replace force view ffv_proc_def as
select PROC_DEF_ID_, PROC_DEF_CODE_, PROC_DEF_NAME_, PROC_DEF_CAT_, PROC_DEF_MODEL_, PROC_DEF_DIAGRAM_FILE_, PROC_DEF_DIAGRAM_FILE_NAME_, PROC_DEF_DIAGRAM_FILE_LENGTH_, PROC_DEF_DIAGRAM_WIDTH_, PROC_DEF_DIAGRAM_HEIGHT_, MEMO_, VERSION_, PROC_DEF_STATUS_, CREATION_DATE_, UPDATE_DATE_, OPERATOR_ID_, OPERATOR_NAME_ from FF_PROC_DEF;

prompt
prompt Creating view FFV_PROC_PD
prompt =========================
prompt
create or replace force view ffv_proc_pd as
select P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_ from FF_PROC P inner join FF_PROC_DEF PD on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_;

prompt
prompt Creating view FFV_TASK
prompt ======================
prompt
create or replace force view ffv_task as
select T.TASK_ID_, T.NODE_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_ from FF_TASK T;

prompt
prompt Creating view FFV_TASK_N
prompt ========================
prompt
create or replace force view ffv_task_n as
select T.TASK_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_, N.NODE_ID_, N.PARENT_NODE_ID_, N.PROC_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ as NODE_CREATION_DATE_
  from FF_TASK T
 inner join FF_NODE N
    on N.NODE_ID_ = T.NODE_ID_;

prompt
prompt Creating view FFV_TASK_P
prompt ========================
prompt
create or replace force view ffv_task_p as
select T.TASK_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_, N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ as NODE_CREATION_DATE_, P.PROC_ID_, P.PROC_DEF_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_
  from FF_TASK T
 inner join FF_NODE N
    on N.NODE_ID_ = T.NODE_ID_
 inner join FF_PROC P
    on P.PROC_ID_ = N.PROC_ID_;

prompt
prompt Creating view FFV_TASK_PD
prompt =========================
prompt
create or replace force view ffv_task_pd as
select T.TASK_ID_, T.PREVIOUS_TASK_ID_, T.TASK_TYPE_, T.ASSIGNEE_, T.ASSIGNEE_NAME_, T.ACTION_, T.DUE_DATE_, T.CLAIM_, T.FORWARDABLE_, T.PRIORITY_, T.FORWARD_STATUS_, T.TASK_END_USER_, T.TASK_END_USER_NAME_, T.TASK_END_DATE_, T.NEXT_CANDIDATE_, T.TASK_STATUS_, T.CREATION_DATE_, N.NODE_ID_, N.PARENT_NODE_ID_, N.PREVIOUS_NODE_IDS_, N.LAST_COMPLETE_NODE_IDS_, N.SUB_PROC_DEF_ID_, N.ADJUST_SUB_PROC_DEF_ID_, N.NODE_TYPE_, N.NODE_CODE_, N.NODE_NAME_, N.PARENT_NODE_CODE_, N.CANDIDATE_ASSIGNEE_, N.COMPLETE_EXPRESSION_, N.COMPLETE_RETURN_, N.EXCLUSIVE_, N.AUTO_COMPLETE_SAME_ASSIGNEE_, N.AUTO_COMPLETE_EMPTY_ASSIGNEE_, N.INFORM_, N.NODE_END_USER_, N.NODE_END_USER_NAME_, N.NODE_END_DATE_, N.ISOLATE_SUB_PROC_DEF_CODE_, N.ISOLATE_SUB_PROC_CANDIDATE_, N.ISOLATE_SUB_PROC_STATUS_, N.NODE_STATUS_, N.CREATION_DATE_ as NODE_CREATION_DATE_, P.PROC_ID_, P.ADJUST_PROC_DEF_ID_, P.ISOLATE_SUB_PROC_NODE_ID_, P.BIZ_ID_, P.BIZ_TYPE_, P.BIZ_CODE_, P.BIZ_NAME_, P.BIZ_DESC_, P.PROC_START_USER_, P.PROC_START_USER_NAME_, P.PROC_END_USER_, P.PROC_END_USER_NAME_, P.PROC_END_DATE_, P.PROC_STATUS_, P.CREATION_DATE_ as PROC_CREATION_DATE_, PD.PROC_DEF_ID_, PD.PROC_DEF_CODE_, PD.PROC_DEF_NAME_, PD.PROC_DEF_CAT_, PD.VERSION_, PD.PROC_DEF_STATUS_
  from FF_TASK T
 inner join FF_NODE N
    on N.NODE_ID_ = T.NODE_ID_
 inner join FF_PROC P
    on P.PROC_ID_ = N.PROC_ID_
 inner join FF_PROC_DEF PD
    on PD.PROC_DEF_ID_ = P.PROC_DEF_ID_;

prompt
prompt Creating view KV_APPROVAL_MEMO
prompt ==============================
prompt
create or replace force view kv_approval_memo as
select AM.APPROVAL_MEMO_ID_, AM.TASK_ID_, AM.PREVIOUS_TASK_ID_, AM.NODE_ID_, AM.NODE_TYPE_, AM.NODE_NAME_, AM.PARENT_NODE_ID_, AM.PROC_ID_, AM.BIZ_ID_, AM.ASSIGNEE_, AM.ASSIGNEE_CODE_, AM.ASSIGNEE_NAME_, AM.EXECUTOR_, AM.EXECUTOR_CODE_, AM.EXECUTOR_NAME_, AM.ORG_ID_, AM.ORG_NAME_, AM.COM_ID_, AM.COM_NAME_, AM.CREATION_DATE_, AM.DUE_DATE_, AM.APPROVAL_MEMO_TYPE_, AM.APPROVAL_MEMO_, AM.APPROVAL_DATE_, AM.APPROVAL_MEMO_STATUS_, AM.APPROVAL_MEMO_SOURCE_ from K_APPROVAL_MEMO AM;

prompt
prompt Creating view KV_CUSTOM_APPROVAL_MEMO
prompt =====================================
prompt
create or replace force view kv_custom_approval_memo as
select CAM.CUSTOM_APPROVAL_MEMO_ID_, CAM.EMP_ID_, CAM.APPROVAL_MEMO_, CAM.DEFAULT_, CAM.ORDER_ from K_CUSTOM_APPROVAL_MEMO CAM;

prompt
prompt Creating view KV_CUSTOM_DOC_TYPE
prompt ================================
prompt
create or replace force view kv_custom_doc_type as
select CT.CUSTOM_DOC_TYPE_ID_, CT.EMP_ID_, CT.DOC_TYPE_ID_, DT.DOC_TYPE_NAME_, DT.TEMPLATE_FILE_NAME_, DT.TEMPLATE_FILE_LENGTH_, DT.HTML_, DT.BOOKMARK_, DT.INDEX_, DT.USING_TEMPLATE_, DT.PROC_DEF_CODE_, DT.DESC_, DT.ORDER_, DT.DOC_TYPE_STATUS_, DT.CREATION_DATE_, DT.UPDATE_DATE_, DT.OPERATOR_ID_, DT.OPERATOR_NAME_ from K_CUSTOM_DOC_TYPE CT inner join K_DOC_TYPE DT on DT.DOC_TYPE_ID_ = CT.DOC_TYPE_ID_;

prompt
prompt Creating view KV_DOC
prompt ====================
prompt
create or replace force view kv_doc as
select D.DOC_ID_, D.DOC_CODE_, D.DOC_NAME_, D.DOC_TYPE_NAME_, D.OWNER_ID_, D.OWNER_NAME_, D.OWNER_ORG_ID_, D.OWNER_ORG_NAME_, D.MEMO_, D.TEMPLATE_FILE_NAME_, D.TEMPLATE_FILE_LENGTH_, D.DOC_FILE_NAME_, D.DOC_FILE_LENGTH_, D.BOOKMARK_, D.INDEX_, D.USING_TEMPLATE_, D.PROC_DEF_CODE_, D.PROC_ID_, D.PROC_STATUS_, D.VERSION_, D.DOC_STATUS_, D.CREATION_DATE_, D.UPDATE_DATE_, D.EFFECTIVE_DATE_, D.OPERATOR_ID_, D.OPERATOR_NAME_ from K_DOC D;

prompt
prompt Creating view KV_DOC_DATA
prompt =========================
prompt
create or replace force view kv_doc_data as
select DD.DOC_DATA_ID_, DD.DOC_ID_, DD.BOOKMARK_, DD.VALUE_, DD.DATA_TYPE_, DD.ORDER_ from K_DOC_DATA DD;

prompt
prompt Creating view KV_DOC_RIDER
prompt ==========================
prompt
create or replace force view kv_doc_rider as
select DR.DOC_RIDER_ID_, DR.DOC_ID_, DR.DOC_RIDER_FILE_NAME_, DR.DOC_RIDER_FILE_LENGTH_, DR.MD5_, DR.CREATION_DATE_, DR.UPDATE_DATE_, DR.OPERATOR_ID_, DR.OPERATOR_NAME_ from K_DOC_RIDER DR;

prompt
prompt Creating view KV_DOC_TYPE
prompt =========================
prompt
create or replace force view kv_doc_type as
select DT.DOC_TYPE_ID_, DT.DOC_TYPE_NAME_, DT.TEMPLATE_FILE_NAME_, DT.TEMPLATE_FILE_LENGTH_, DT.HTML_, DT.BOOKMARK_, DT.INDEX_, DT.USING_TEMPLATE_, DT.PROC_DEF_CODE_, DT.DESC_, DT.ORDER_, DT.DOC_TYPE_STATUS_, DT.CREATION_DATE_, DT.UPDATE_DATE_, DT.OPERATOR_ID_, DT.OPERATOR_NAME_ from K_DOC_TYPE DT;

prompt
prompt Creating view OMV_CODE
prompt ======================
prompt
create or replace force view omv_code as
select CODE_ID_, PARENT_CODE_ID_, CATEGORY_, CODE_, NAME_, EXT_ATTR_1_, EXT_ATTR_2_, EXT_ATTR_3_, EXT_ATTR_4_, EXT_ATTR_5_, EXT_ATTR_6_, ORDER_ from OM_CODE;

prompt
prompt Creating view OMV_DUTY
prompt ======================
prompt
create or replace force view omv_duty as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, D.DUTY_ID_, D.DUTY_CODE_, D.DUTY_NAME_, D.DUTY_CATEGORY_, D.MEMO_, D.DUTY_TAG_, D.DUTY_EXT_ATTR_1_, D.DUTY_EXT_ATTR_2_, D.DUTY_EXT_ATTR_3_, D.DUTY_EXT_ATTR_4_, D.DUTY_EXT_ATTR_5_, D.DUTY_EXT_ATTR_6_, D.DUTY_EXT_ATTR_7_, D.DUTY_EXT_ATTR_8_, D.ORDER_, D.DUTY_STATUS_, D.CREATION_DATE_, D.UPDATE_DATE_, D.OPERATOR_ID_, D.OPERATOR_NAME_ from OM_DUTY D inner join OM_ORGN_SET ORGN_SET on ORGN_SET.ORGN_SET_ID_ = D.ORGN_SET_ID_;

prompt
prompt Creating view OMV_EMP
prompt =====================
prompt
create or replace force view omv_emp as
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

prompt
prompt Creating view OMV_EMP_RELATION
prompt ==============================
prompt
create or replace force view omv_emp_relation as
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

prompt
prompt Creating view OMV_LOG
prompt =====================
prompt
create or replace force view omv_log as
select LOG_ID_, CATEGORY_, IP_, USER_AGENT_, URL_, ACTION_, PARAMETER_MAP_, BUSINESS_KEY_, ERROR_, MESSAGE_, ORG_ID_, ORG_NAME_, POSI_ID_, POSI_NAME_, EMP_ID_, EMP_NAME_, CREATION_DATE_ from OM_LOG;

prompt
prompt Creating view OMV_MAIN_SERVER
prompt =============================
prompt
create or replace force view omv_main_server as
select MS.MAIN_SERVER_ID_, MS.MAIN_SERVER_NAME_, MS.DRIVER_CLASS_NAME_, MS.URL_, MS.USERNAME_, MS.PASSWORD_, MS.MEMO_, MS.LAST_SYNC_DATE_, MS.ORDER_, MS.MAIN_SERVER_STATUS_, MS.CREATION_DATE_, MS.UPDATE_DATE_, MS.OPERATOR_ID_, MS.OPERATOR_NAME_ from OM_MAIN_SERVER MS;

prompt
prompt Creating view OMV_MIRROR_SERVER
prompt ===============================
prompt
create or replace force view omv_mirror_server as
select MS.MIRROR_SERVER_ID_, MS.MIRROR_SERVER_NAME_, MS.DRIVER_CLASS_NAME_, MS.URL_, MS.USERNAME_, MS.PASSWORD_, MS.MEMO_, MS.LAST_SYNC_DATE_, MS.ORDER_, MS.MIRROR_SERVER_STATUS_, MS.CREATION_DATE_, MS.UPDATE_DATE_, MS.OPERATOR_ID_, MS.OPERATOR_NAME_ from OM_MIRROR_SERVER MS;

prompt
prompt Creating view OMV_ORG
prompt =====================
prompt
create or replace force view omv_org as
select ORGN_SET.ORGN_SET_ID_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_, O1.ORG_ID_, O1.PARENT_ORG_ID_, O1.ORG_CODE_, O1.ORG_NAME_, O1.ORG_ABBR_NAME_, O1.ORG_TYPE_, O1.ORG_CATEGORY_, O1.MEMO_, O1.ORG_TAG_, O1.ORG_EXT_ATTR_1_, O1.ORG_EXT_ATTR_2_, O1.ORG_EXT_ATTR_3_, O1.ORG_EXT_ATTR_4_, O1.ORG_EXT_ATTR_5_, O1.ORG_EXT_ATTR_6_, O1.ORG_EXT_ATTR_7_, O1.ORG_EXT_ATTR_8_, O1.ORDER_, O1.ORG_STATUS_, O1.CREATION_DATE_, O1.UPDATE_DATE_, O1.OPERATOR_ID_, O1.OPERATOR_NAME_, O2.ORG_CODE_ as PARENT_ORG_CODE_, O2.ORG_NAME_ as PARENT_ORG_NAME_
  from OM_ORG O1
 inner join OM_ORGN_SET ORGN_SET
    on ORGN_SET.ORGN_SET_ID_ = O1.ORGN_SET_ID_
  left outer join OM_ORG O2
    on O2.ORGN_SET_ID_ = O1.ORGN_SET_ID_
   and O2.ORG_ID_ = O1.PARENT_ORG_ID_;

prompt
prompt Creating view OMV_ORGN_SET
prompt ==========================
prompt
create or replace force view omv_orgn_set as
select OS1.ORGN_SET_ID_, OS1.PARENT_ORGN_SET_ID_, OS1.ORGN_SET_CODE_, OS1.ORGN_SET_NAME_, OS1.ALLOW_SYNC_, OS1.MEMO_, OS1.ORDER_, OS1.ORGN_SET_STATUS_, OS1.CREATION_DATE_, OS1.UPDATE_DATE_, OS1.OPERATOR_ID_, OS1.OPERATOR_NAME_, OS2.ORGN_SET_CODE_ as PARENT_ORGN_SET_CODE_, OS2.ORGN_SET_NAME_ as PARENT_ORGN_SET_NAME_ from OM_ORGN_SET OS1 left outer join OM_ORGN_SET OS2 on OS2.ORGN_SET_ID_ = OS1.PARENT_ORGN_SET_ID_;

prompt
prompt Creating view OMV_POSI
prompt ======================
prompt
create or replace force view omv_posi as
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

prompt
prompt Creating view OMV_POSI_EMP
prompt ==========================
prompt
create or replace force view omv_posi_emp as
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

prompt
prompt Creating view OMV_TAG
prompt =====================
prompt
create or replace force view omv_tag as
select T.ORGN_SET_ID_, T.TAG_ID_, T.OBJ_ID_, T.OBJ_TYPE_, T.TAG_, ORGN_SET.ORGN_SET_CODE_, ORGN_SET.ORGN_SET_NAME_ from OM_TAG T inner join OM_ORGN_SET ORGN_SET on ORGN_SET.ORGN_SET_ID_ = T.ORGN_SET_ID_;


prompt Done
spool off
set define on
