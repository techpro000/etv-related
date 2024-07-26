

------------------------------------------
--权限表
------------------------------------------
CREATE TABLE T_BS_AUTHORITY
(
  ID             NUMBER(9) NOT NULL,										
  AUTHORITY_NAME      VARCHAR2(20) NOT NULL,									--权限名
  PARENT_AUTHORITY_id NUMBER(9),												--父级权限id
  PARENT_AUTHORITY_url varchar2(100),											--父级权限url
  AUTHORITY_TYPE      VARCHAR2(2) NOT NULL,										--权限类型 0= 一级菜单 ,1=二级菜单 , 9=按钮
  MENU_URL       VARCHAR2(100),													--菜单(权限) URL
  STATE          VARCHAR2(2) NOT NULL,											--状态:0=禁用 , 1=正常 ,2=删除
  CREATE_DATE    DATE NOT NULL,													--创建时间
  MODIFY_DATE    DATE ,															--修改时间
  CONSTRAINT PK_T_BS_AUTHORITY PRIMARY KEY (ID),								--主键约束
  CONSTRAINT UK_T_BS_AUTHORITY_AUTHORITY_NAME UNIQUE (AUTHORITY_NAME)			--权限名唯一约束
);


------------------------------------------
--角色表
------------------------------------------
CREATE TABLE T_BS_ROLE
(
  ID          NUMBER(9) NOT NULL,
  ROLE_NAME   VARCHAR2(40) NOT NULL,											--角色名称
  CREATE_DATE DATE NOT NULL,													--创建时间
  STATE       VARCHAR2(2) NOT NULL,												--状态:0=禁用,1=正常 ,2=删除
  NOTE         VARCHAR2(100),													--备注
  MODIFY_DATE DATE ,															--修改时间
  CONSTRAINT PK_T_BS_ROLE PRIMARY KEY (ID)										--主键约束
);


------------------------------------------
--角色权限关联表
------------------------------------------
CREATE TABLE T_BS_ROLE_AUTHORITY
(
  ID          NUMBER(9) NOT NULL,
  ROLE_ID     NUMBER(9) NOT NULL,												--角色ID
  AUTHORITY_ID     NUMBER(9) NOT NULL,											--权限ID
  MODIFY_DATE DATE ,															--修改时间
  CREATE_DATE DATE NOT NULL,													--创建时间
  CONSTRAINT PK_T_BS_ROLE_AUTHORITY PRIMARY KEY (ID),							--主键约束
  CONSTRAINT FK_T_BS_ROLE_AUTHORITY_AUTHORITY_ID FOREIGN KEY (AUTHORITY_ID)		--权限外键约束
   REFERENCES T_BS_AUTHORITY (ID),
  CONSTRAINT FK_T_BS_ROLE_AUTHORITY_ROLE_ID FOREIGN KEY (ROLE_ID)				--角色外键约束
   REFERENCES T_BS_ROLE (ID)
);

------------------------------------------
--操作员表
------------------------------------------
CREATE TABLE T_BS_OPERATOR
(
  ID          NUMBER(9) NOT NULL,
  USER_NAME   VARCHAR2(40) NOT NULL,											--操作员名称
  ACCOUNT     VARCHAR2(20) NOT NULL,											--登录帐号
  PASSWORD    VARCHAR2(32) NOT NULL,											--密码
  ROLE_ID     NUMBER(9) NOT NULL,												--角色ID
  STATE       VARCHAR2(2) NOT NULL,												--状态: 0=禁用, 1=正常 ,2=删除
  CREATE_DATE DATE NOT NULL,													--创建时间
  MODIFY_DATE DATE ,															--修改时间
  SALT 		  VARCHAR2(10) NOT NULL,											--密码盐值
  CONSTRAINT PK_T_BS_OPERATOR PRIMARY KEY (ID),									--主键约束
  CONSTRAINT FK_T_BS_OPERATOR_ROLE_ID FOREIGN KEY (ROLE_ID)						--角色外键约束
	REFERENCES T_BS_ROLE (ID),
  CONSTRAINT UK_T_BS_OPERATOR_ACCOUNT UNIQUE (ACCOUNT)							--操作员帐号唯一约束
);

------------------------------------------
--广告信息表
------------------------------------------
CREATE TABLE T_BS_ADVERT
(
  ID          NUMBER(9) NOT NULL,
  ADVERT_NAME VARCHAR2(50) NOT NULL,											--广告名称
  CREATOR     NUMBER(9) NOT NULL,												--创建操作员ID
  CREATE_DATE DATE NOT NULL,													--创建时间
  MENDER      NUMBER(9),														--修改操作员ID
  MODIFY_DATE DATE,																--修改时间
  STATE       VARCHAR2(2) NOT NULL,												--状态 : 1=正常, 2=不显示, 3=删除
  URL         VARCHAR2(200),													--广告URL
  NOTE        VARCHAR2(500),													--备注
  IMG_URL     VARCHAR2(200),													--图片URL
  URL_TYPE	  VARCHAR2(2) NOT NULL,												--URL类型:1=上传图片地址, 2=输入图片地址
  CONSTRAINT PK_T_BS_ADVERT PRIMARY KEY (ID),									--主键约束
  CONSTRAINT FK_T_BS_ADVERT_CREATOR FOREIGN KEY (CREATOR)						--创建操作员外键约束
	REFERENCES T_BS_OPERATOR (ID),
  CONSTRAINT FK_T_BS_ADVERT_MENDER FOREIGN KEY (MENDER)							--修改操作员外键 约束
	REFERENCES T_BS_OPERATOR (ID),
);


------------------------------------------
--设备信息表
------------------------------------------
CREATE TABLE T_BS_DEVICE
(
  ID           NUMBER(9) NOT NULL,	
  DEVICE_NAME  VARCHAR2(20) NOT NULL,											--设备名称
  PHOTO_WIDTH  NUMBER(9) NOT NULL,												--图片高
  PHOTO_LENGTH NUMBER(9),														--图片长
  CREATOR      NUMBER(9),														--创建操作员
  CREATE_DATE  DATE,															--创建时间
  MENDER       NUMBER(9),														--修改操作员
  MODIFY_DATE  DATE,															--修改时间
  CONSTRAINT PK_T_BS_DEVICE PRIMARY KEY (ID),									--主键约束
  CONSTRAINT FK_T_BS_DEVICE_CREATOR FOREIGN KEY (CREATOR)						--创建操作员外键约束
	REFERENCES T_BS_OPERATOR (ID),
  CONSTRAINT FK_T_BS_DEVICE_MENDER FOREIGN KEY (MENDER)							--修改操作员外键 约束
	REFERENCES T_BS_OPERATOR (ID)
);

------------------------------------------
--页脚信息表
------------------------------------------
CREATE TABLE T_BS_FOOTER
(
  ID          NUMBER(9) NOT NULL,
  FOOTER_NO   VARCHAR2(10) NOT NULL,											--页脚编号
  TITLE       VARCHAR2(100) ,													--标题
  FOOTER_TYPE VARCHAR2(2) NOT NULL,												--页脚类型:0=首页广告 ,1=强制广告,2=联络,3=条款,4=条款,5=下载,6=常见问题,7=论坛
  FILE_URL    VARCHAR2(100),													--文件URL
  CONTENT     CLOB NOT NULL,													--内容
  NOTE        VARCHAR2(50),														--备注
  CREATOR     NUMBER(9) NOT NULL,												--创建操作员
  CREATE_DATE DATE NOT NULL,													--创建时间
  MENDER      NUMBER(9),														--修改操作员
  MODIFY_DATE DATE,																--修改时间
  FILE_TYPE   NUMBER(9),														--文件类型
  PROBLEM_TYPE VARCHAR2(2),														--问题类型
  STATE       VARCHAR2(2) NOT NULL,												--状态:1=正常 ,2=删除
  CONSTRAINT PK_T_BS_FOOTER PRIMARY KEY (ID),									--主键约束
  CONSTRAINT FK_T_BS_FOOTER_CREATOR FOREIGN KEY (CREATOR)						--创建操作员外键约束
   REFERENCES T_BS_OPERATOR (ID),
  CONSTRAINT FK_T_BS_FOOTER_MENDER FOREIGN KEY (MENDER)							--修改操作员外间约束
   REFERENCES T_BS_OPERATOR (ID)
);


------------------------------------------
--用户信息表
------------------------------------------
CREATE TABLE T_US_USER
(
  ID          NUMBER(9) NOT NULL,
  USER_NAME   VARCHAR2(40) NOT NULL ,											--用户名称
  ACCOUNT     VARCHAR2(10) ,													--登录帐号
  PASSWORD    VARCHAR2(32) NOT NULL,											--密码
  TELPHONE    VARCHAR2(13) NOT NULL,											--联系手机号码
  EMAIL       VARCHAR2(50),														--邮箱
  EMAIL_STATE VARCHAR2(2) ,														--邮箱验证状态:1=验证通过, 2=验证失败
  EMAIL_verify_date DATE ,														--邮箱验证时间
  STATE       VARCHAR2(2) NOT NULL,												--状态:0=拉黑,1=正常,2=删除 
  CREATE_TIME DATE NOT NULL,													--创建时间(注册时间)
  SALT        VARCHAR2(1) NOT NULL,												--密码盐值
  TYPE        NUMBER(9) NOT NULL,												--会员类型
  MODIFY_DATE DATE ,															--修改时间
  USER_INTRODUCTION VARCHAR2(240),												--用户简介
  COMPANY_OR_SCHOOL VARCHAR2(40),												--公司或者学校名称
  POSITION VARCHAR2(40),														--职位
  SEX VARCHAR2(1),																--性别:0=女, 1=男
  WECHAT VARCHAR2(20),															--微信
  QQ VARCHAR2(11),																--QQ
  CITY VARCHAR2(40),															--城市
  PIC_URL VARCHAR2(200)															--头像路径
  BIRTHDAY DATE,																--生日
  is_vip varchar2(2)															--是否为vip:0=否,1=是
  DOMAIN_NAME VARCHAR2(30),														--域名尾缀
  balance number(9,2) default 0 not null,										--当前余额
  total_balace number(9,2) default 0 not null,									--总余额(总充值金额)
  free_gp number(9,2) default 3 not null,										--免费gp数
  version number(1) default 0 not null,											--版本号
  CONSTRAINT PK_T_US_USER PRIMARY KEY (ID),										--主键约束
  CONSTRAINT UK_T_US_USER_ACCOUNT UNIQUE (ACCOUNT),								--登录帐号唯一约束
  CONSTRAINT UK_T_US_USER_ACCOUNT UNIQUE (USER_NAME),							--用户名称唯一约束
  CONSTRAINT UK_T_US_USER_TELPHONE UNIQUE (TELPHONE),							--手机号码唯一约束
  CONSTRAINT UK_T_US_USER_DOMAIN_NAME UNIQUE (DOMAIN_NAME),						--域名尾缀唯一约束
  constraint ck_us_user_balance check (balance >= 0),							--金额不能为负数检查约束
  constraint ck_us_user_free_gp check (free_gp >= 0),							--金额不能为负数检查约束
  constraint ck_us_user_total_balance check(total_balance >=0)					--金额不能为负数检查约束
);
------------------------------------------
--短信记录表
------------------------------------------
create table T_US_SMS_RECORD
(
  ID           NUMBER(9) not null,
  CONTENT      VARCHAR2(560) not null,											--内容
  RESULT_STATE VARCHAR2(2) not null,											--返回状态
  SEND_DATE    DATE not null,													--发送时间
  SEND_I_P     VARCHAR2(20),													--发送ip
  user_name VARCHAR2(20),													--用户帐号
  TELEPHONE    VARCHAR2(11),													--手机号码
  BIZ_ID       VARCHAR2(20),													--发送回执id
  CODE         VARCHAR2(30),													--状态码  https://help.aliyun.com/document_detail/55323.html?spm=5176.doc55496.6.582.HU44WP
  MESSAGE      VARCHAR2(100),													--状态码的描述
  REQUEST_ID   VARCHAR2(40),													--请求id
  CONSTRAINT PK_US_SMS_RECORD PRIMARY KEY (ID),									--主键约束
  constraint FK_US_SMS_RECORD_USER_ACCOUNT foreign key (user_name)			--用户名外键约束
  	references T_US_USER (user_name)
)
------------------------------------------
--消息记录表
------------------------------------------
CREATE TABLE T_BS_MSG_RECORD
(
  ID          NUMBER(9) NOT NULL,
  SENDER      NUMBER(9) NOT NULL,												--发送操作员
  SENDER_DATE DATE NOT NULL,													--发送时间
  TITLE       VARCHAR2(20) NOT NULL,											--标题
  CONTENT     CLOB NOT NULL,													--内容
  msg_template_id number(9),													--消息模版id
  user_type	  varchar2(2)													,	--用户类型:0=所有人,1=部分,2=单个用户
  STATE       VARCHAR2(2)  NOT NULL,											--状态:1=正常, 2=删除
  MSG_TYPE    VARCHAR2(2) NOT NULL,												--消息类型:0=站内信,1=邮箱,2=站内信+邮箱
  SEND_STATE  VARCHAR2(2) NOT NULL,												--发送状态
  send_num	  number(9),														--发送数量
  CONSTRAINT PK_T_BS_MSG_RECORD PRIMARY KEY (ID),								--主键约束
  CONSTRAINT FK_T_BS_MSG_RECORD_RECEIVER FOREIGN KEY (RECEIVER)					--接收用户外键 约束
	REFERENCES T_US_USER (ID),
  CONSTRAINT FK_T_BS_MSG_RECORD_SENDER FOREIGN KEY (SENDER)						--发送操作员外键约束
  REFERENCES T_BS_OPERATOR (ID)
);

------------------------------------------
--消息记录详细表
------------------------------------------
CREATE TABLE T_BS_MSG_REc_detail
(
  ID          NUMBER(9) NOT NULL,
  msg_rec_id	number(9),														--消息记录id
  template_id	number(8),														--模版id
  user_id		number(9) not null,												--用户id
  msg_type		varchar2(2) not null,											--消息类型:0=站内信,1=邮件
  msg_content	CLOB not null,													--消息内容
  title			varchar2(100),													--标题
  read_state	varchar2(2) not null,											--查看状态
  read_date		date ,															--查看时间
  state			varchar2(2) ,													--状态
  send_date		date not null,													--发送时间
  modify_date	date,															--修改时间
  send_state	varchar2(2) not null,											--发送状态(邮件)
  CONSTRAINT PK_BS_MSG_REc_detail PRIMARY KEY (ID),								--主键约束
  CONSTRAINT FK_BS_MSG_REc_detail_user FOREIGN KEY (user_id)						--接收用户外键 约束
	REFERENCES T_US_USER (ID),
  CONSTRAINT FK_TBS_MSG_REc_detail_temp FOREIGN KEY (template_id)					--消息模版外键约束
  REFERENCES T_BS_MSG_TEMPLATE (ID)
);

------------------------------------------
--系统日志表
------------------------------------------
CREATE TABLE T_BS_SYS_LOG
(
  ID             NUMBER(9) NOT NULL,
  OPERATOR_ID    NUMBER(9),														--操作员ID
  USER_ID        NUMBER(9),														--用户ID
  OPERATION_TYPE VARCHAR2(2) NOT NULL,											--操作类型
  OPERATION_DATE DATE NOT NULL,													--操作时间
  module		 varchar2(40),													--模块名称
  LOGIN_IP       VARCHAR2(15) NOT NULL,											--登录IP
  OPERATIONINFO  VARCHAR2(500) NOT NULL,										--操作详细
  OPER_PARA      CLOB,															--操作
  REQ_URL        VARCHAR2(250) NOT NULL,										--请求URL
  STATE          VARCHAR2(2) NOT NULL,											--状态
  CONSTRAINT PK_T_BS_SYS_LOG PRIMARY KEY (ID),									--主键约束
  CONSTRAINT FK_T_BS_SYS_LOG_OPERATOR_ID FOREIGN KEY (OPERATOR_ID)				--操作员外键约束
	REFERENCES T_BS_OPERATOR (ID),
  CONSTRAINT FK_T_BS_SYS_LOG_USER_ID FOREIGN KEY (USER_ID)						--用户外键约束
	REFERENCES T_US_USER (ID)
);

------------------------------------------
--文件信息管理
------------------------------------------
CREATE TABLE T_BS_FILE_INFO
(
  ID             NUMBER(9) NOT NULL,                    
  FILE_NAME      VARCHAR2(255) NOT NULL,										--文件名
  REAL_NAME      VARCHAR2(255) NOT NULL,										--存储实际名称
  MIN_IMG_PATH   VARCHAR2(255) ,												--压缩文件
  SRC_FILE_PATH  VARCHAR2(255),													--原图路径
  VIEW_IMG_PATH  VARCHAR2(255),													--缩略图
  SUFFIX         VARCHAR2(50) NOT NULL,											--文件尾缀
  CREATE_DATE    DATE NOT NULL,                          						--创建时间
  FILE_TYPE      VARCHAR2(2) NOT NULL,											--文件类型:0=图片;
  SUP_MODULE     VARCHAR2(2) NOT NULL,											--所属模块:0=广告;
  DATA_ID		 NUMBER(9) NOT NULL,											--数据ID
  CONSTRAINT PK_T_BS_FILE_INFO PRIMARY KEY (ID)                					--主键约束
);

------------------------------------------
--消息模板
------------------------------------------
CREATE TABLE T_BS_MSG_TEMPLATE
(
  ID             	NUMBER(9) NOT NULL,                    
  TEMPLATE_TITLE    VARCHAR2(40) NOT NULL,                  					--模板标题
  TEMPLATE_ID	    VARCHAR2(20),			                  					--模板
  MSG_CONTONT 		VARCHAR2(1000),                        						--消息内容
  EMAIL_CONTENT     VARCHAR2(2000),                    							--邮件内容
  STATE          	VARCHAR2(2) NOT NULL,                      					--状态:0=禁用 , 1=正常 ,2=删除
  MSG_TYPE       	VARCHAR2(2) NOT NULL,                               		--消息内容：0=消息，1=邮件,3=消息+邮件
  TEMPLATE_TYPE  	VARCHAR2(2) NOT NULL,                               		--模板类型：0=手动模板，1=自动模板
  CREATE_DATE    	DATE NOT NULL,                          					--创建时间
  MODIFY_DATE    	DATE ,                              						--修改时间
  title 			varchar2(40),												--标题
  CONSTRAINT PK_T_BS_MSG_TEMPLATE PRIMARY KEY (ID),                				--主键约束
  CONSTRAINT UK_BS_MSG_TEMPLATE_temp_id UNIQUE (TEMPLATE_ID)					--项目用户联合唯一约束
);

------------------------------------------
--关注列表
------------------------------------------
CREATE TABLE T_US_SUBSCRIBER
(
  ID             	NUMBER(9) NOT NULL,                    
  BE_SUBSCRIBER  	NUMBER(9) NOT NULL,                  						--被关注用户
  SUBSCRIBER     	NUMBER(9) NOT NULL,                        					--关注用户
  SUBSCRIBER_DATE   DATE NOT NULL,                          					--关注时间
  STATE 			VARCHAR2(2) NOT NULL,										--状态:0=无效, 1=有效
  CANCEL_DATE    	DATE ,                              						--取消时间
  CONSTRAINT PK_T_US_SUBSCRIBER PRIMARY KEY (ID),                				--主键约束
  CONSTRAINT T_US_SUBSCRIBER_BE_SUBSCRIBER FOREIGN KEY (BE_SUBSCRIBER)			--用户外键
	REFERENCES T_US_USER (ID),
  CONSTRAINT T_US_SUBSCRIBER_SUBSCRIBER FOREIGN KEY (SUBSCRIBER)				--用户外键
	REFERENCES T_US_USER (ID)  
);


------------------------------------------
--用户反馈记录表
------------------------------------------
CREATE TABLE T_BS_FEEDBACK
(
  ID             	NUMBER(9) NOT NULL,                    
  USER_NAME		   	VARCHAR2(20) NOT NULL,                              		--用户姓名
  TELEPHONE		   	VARCHAR2(11) NOT NULL,                              		--用户手机号码
  EMAIL			   	VARCHAR2(50) NOT NULL,                              		--用户邮箱
  CONTENT		   	VARCHAR2(560) NOT NULL,                              		--用户邮箱
  CREATE_DATE   	DATE NOT NULL,                          					--创建时间(留言时间)
  STATE 			VARCHAR2(2) ,												--状态:0=已回复,1=未回复
  REPLY_TITLE		VARCHAR2(40),                              					--回复标题
  RECIPIENTS_EMAIL	VARCHAR2(50), 												--收件人邮箱
  REPLY_CONTENT		VARCHAR2(1000) ,                              				--回复内容
  REPLY_DATE		DATE ,														--回复时间
  REPLY_OPERATOR	NUMBER(9),													--回复操作员
  CONSTRAINT PK_T_BS_FEEDBACK PRIMARY KEY (ID),                					--主键约束
  CONSTRAINT FK_US_COMMENT_REPLY_OPERATOR FOREIGN KEY (REPLY_OPERATOR)			--操作员外键
	REFERENCES T_BS_OPERATOR (ID) 
);


------------------------------------------
--项目信息表
------------------------------------------
CREATE TABLE T_US_PROJECT
(
  ID             	NUMBER(9) NOT NULL,                    
  PROJECT_ID     	VARCHAR2(24) ,                        						--项目ID
  PROJECT_NAME   	VARCHAR2(80) NOT NULL,                              		--项目名称
  OWNER             NUMBER(9) NOT NULL,                    						--项目所有者
  PROJECT_TYPE 		VARCHAR2(2) NOT NULL,										--项目类型:0=免费, 1=收费
  VISIBILITY 		VARCHAR2(2) NOT NULL,										--可见情况:0=公开，1=私有，不可见,2=仅url 可见
  DESCRIPTION 		VARCHAR2(560) ,												--描述 
  old_owner			number(9),													--原所有者
  THUMB 			VARCHAR2(200) ,												--封面  
  VIEWS 			NUMBER(9) DEFAULT 0 NOT NULL,								--观看数  
  IMAGE_NUM			NUMBER(9) DEFAULT 0 NOT NULL,								--图片数量 
  SPACE_USAGE		NUMBER(9,2) DEFAULT 0 NOT NULL,								--储存大小  
  GIGA_PIXEL		NUMBER(9,2) DEFAULT 0 NOT NULL,								--数据大小  
  CREATE_DATE   	DATE NOT NULL,                          					--创建时间
  ALLOW_COMMENT 	VARCHAR2(2) DEFAULT '0' NOT NULL,							--是否允许评论  :0=是, 1=否
  SHOW_ALTI_LOGO 	VARCHAR2(2) DEFAULT '0' NOT NULL,							--是否显示LOGO:0=是, 1=否
  STATE 			VARCHAR2(2) DEFAULT '1' NOT NULL,							--删除状态: 0=是,1=否,3=altizure同步删除
  REVIEW_STATE 		VARCHAR2(2) default '0' not null ,							--审核状态:0=待审核,1=审核通过,2=审核不通过
  REVIEW_DATE   	DATE ,                          							--审核日期
  MODELING_DATE   	DATE ,                          							--建模日期
  MODIFY_DATE   	DATE ,                          							--修改日期
  TAGS 				VARCHAR2(2) NOT NULL,										--标签 :0=古遗迹,1=古墓葬,2=古建筑,3=石窟寺及石刻,4=近现代重要,5=可移动文物,6=其他
  FAVOURITE 		VARCHAR2(2) DEFAULT 1 NOT NULL,								--是否加入自己的收藏夹 :0=是, 1=否
  PROJECT_CATEGORY 	VARCHAR2(2) NOT NULL,										--项目类型:0=个人, 1=团队
  DEVICES_ID		NUMBER(9) ,													--项目照片的来 源设备
  COLLECTION_NUM	NUMBER(9) DEFAULT 0 NOT NULL,								--收藏数量
  PARENT_PROJECT_ID	NUMBER(9) ,													--父项目[其他项目ID]
  IS_FEATURED		VARCHAR2(2) DEFAULT 1 NOT NULL,								--是否为精选:0=是,1=否
  lng				varchar2(20) ,												--经度
  lat				varchar2(20),												--纬度
  MODEL_STATE		varchar2(20),												--建模状态
  CONSTRAINT PK_US_PROJECT PRIMARY KEY (ID),                					--主键约束
  CONSTRAINT FK__US_PROJECT_OWNER FOREIGN KEY (OWNER)							--用户外键(项目拥有者)
	REFERENCES T_US_USER (ID),
  CONSTRAINT FK__US_PROJECT_old_OWNER FOREIGN KEY (old_OWNER)					--用户外键(项目拥有者)
	REFERENCES T_US_USER (ID),
  CONSTRAINT FK_US_PROJECT_DEVICES_ID FOREIGN KEY (DEVICES_ID)					--设备外键(项目照片的来源设备)
	REFERENCES T_BS_DEVICE (ID)  
);

------------------------------------------
--项目评论信息表
------------------------------------------
CREATE TABLE T_US_PROJECT_COMMENT
(
  ID             	NUMBER(9) NOT NULL,                    
  COMMENTER  		NUMBER(9) NOT NULL,                  						--模板标题
  PROJECT_ID     	NUMBER(9) NOT NULL,                        					--消息内容
  COMMENT_DATE   	DATE NOT NULL,                          					--创建时间(评论时间)
  STATE 			VARCHAR2(2) NOT NULL,										--状态:0=无效, 1=有效
  COMMENT_CONTENT   VARCHAR2(560) NOT NULL,                              		--评论内容
  COMMENT_STATE   	VARCHAR2(560) NOT NULL,                              		--审核状态:0=待审核,1=审核通过,2=审核不通过
  parent_id			number(9),													--父级
  CONSTRAINT PK_US_PROJECT_COMMENT PRIMARY KEY (ID),                			--主键约束
  CONSTRAINT FK_US_PROJECT_COMMENT_COMMER FOREIGN KEY (COMMENTER)				--用户外键
	REFERENCES T_US_USER (ID),
  CONSTRAINT FK_US_PROJECT_COMMENT_COMMER FOREIGN KEY (parent_id)				--自关联外键
	REFERENCES T_US_PROJECT_COMMENT (ID),
  CONSTRAINT FK_US_PROJECT_COMMENT_PROJECT FOREIGN KEY (PROJECT_ID)				--项目外键
	REFERENCES T_US_PROJECT (ID)  
);
------------------------------------------
--项目浏览记录表
------------------------------------------
CREATE TABLE T_US_PROJECT_BROWSES
(
  ID               NUMBER(9) NOT NULL,                    
  BROWSE_USER  NUMBER(9) ,                              						--用户ID
  PROJECT_ID       NUMBER(9) NOT NULL,                                  		--项目ID
  BROWSE_DATE   DATE NOT NULL,                                 					--创建时间(浏览时间)
  BROWSE_I_P     DATE ,                                    						--浏览ip
  CONSTRAINT PK_US_PROJECT_BROWSES PRIMARY KEY (ID),                      		--主键约束
  CONSTRAINT FK_US_PROJECT_BROWSES_PRO FOREIGN KEY (PROJECT_ID)        			--项目外键
  	REFERENCES T_US_PROJECT (ID), 
  CONSTRAINT FK_US_PROJECT_BROWSES_USER FOREIGN KEY (BROWSE_USER)        		--用户外键
  	REFERENCES T_US_USER (ID)
);


------------------------------------------
--项目精选记录表
------------------------------------------
CREATE TABLE T_US_PROJECT_FEATUREDS
(
  ID             	NUMBER(9) NOT NULL,                    
  OPERATOR_ID  		NUMBER(9) NOT NULL,                  						--操作员ID
  PROJECT_ID     	NUMBER(9) NOT NULL,                        					--项目ID
  FEATURED_DATE   	DATE NOT NULL,                          					--精选时间
  STATE 			VARCHAR2(2) NOT NULL,										--状态:0=无效, 1=有效
  FEATURED_INDEX   	NUMBER(2) NOT NULL,                              			--精选索引(索引从1开始)
  CREATE_DATE		DATE NOT NULL,                              				--创建时间
  MODIFY_DATE		DATE ,                              						--修改时间
  CONSTRAINT PK_US_PROJECT_FEATUREDS PRIMARY KEY (ID),                			--主键约束
  CONSTRAINT FK_US_PROJECT_FEATUREDS_OPER FOREIGN KEY (OPERATOR_ID)				--操作员外键
	REFERENCES T_BS_OPERATOR (ID),
  CONSTRAINT FK_US_PROJECT_FEATUREDS_PROJ FOREIGN KEY (PROJECT_ID)				--项目外键
	REFERENCES T_US_PROJECT (ID)  
);

------------------------------------------
--项目收藏表
------------------------------------------
CREATE TABLE T_US_PROJECT_COLLECTION (
  ID NUMBER(9,0) NOT NULL , 
  COLLECTION_USER NUMBER(9,0) NOT NULL , 										--收藏用户
  PROJECT_ID NUMBER(9,0) NOT NULL , 											--项目id
  COLLECTION_DATE DATE NOT NULL , 												--收藏时间
  STATE VARCHAR2(2) DEFAULT '1', 												--状态：0=无效，1=有效
  CANCEL_DATE DATE, 															--取消收藏时间
  CONSTRAINT PK_US_PROJECT_COLLECTION PRIMARY KEY (ID),
  CONSTRAINT FK_US_PROJECT_COLLECTION_USER FOREIGN KEY (COLLECTION_USER)
  	REFERENCES T_US_USER (ID) , 
  CONSTRAINT FK_US_PROJECT_COLLECTION_PRO FOREIGN KEY (PROJECT_ID)
    REFERENCES T_US_PROJECT (ID),
  CONSTRAINT UK_US_PROJECT_COLL_us_Proj UNIQUE (COLLECTION_USER,PROJECT_ID)		--项目用户联合唯一约束
); 
   
   
------------------------------------------
--邮箱验证记录表
------------------------------------------
CREATE TABLE T_US_EMAIL_VERIFY
(
  ID             	NUMBER(9) NOT NULL,                    
  NUIQUE_CODE		VARCHAR2(40) ,                             					--唯一码
  VERIFY_STATE		VARCHAR2(2) ,                              					--验证状态:0=未验证,1=已验证
  USER_ID			NUMBER(9) NOT NULL,                              			--用户ID
  CREATION_TIME		DATE NOT NULL,                              				--创建时间
  VERIFY_TIME		DATE ,														--验证时间
  VALID_TIME   	    DATE NOT NULL,                      						--有效时间(15分钟)
  IP				VARCHAR2(40),                              					--IP地址
  EMAIL				VARCHAR2(50), 												--邮箱地址
  CONSTRAINT PK_US_EMAILVERIFY PRIMARY KEY (ID),                				--主键约束
  CONSTRAINT FK_US_EMAILVERIFY_user_id FOREIGN KEY (user_id)					--用户外键
	REFERENCES T_US_user (ID)  
);

------------------------------------------
--充值记录表
------------------------------------------

create table t_bs_recharge_rec
(
  ID               number(9) not null,
  OPERATOR         number(9),													--操作员
  USER_ID          number(9) not null,											--用户id
  GP               number(9,2),													--gp
  RECHARGE_MONENY  number(9,2),													--充值金额
  PAY_WAY          varchar2(1),													--支付方式 1支付宝 2微信 3手动充值
  PAY_STATE        varchar2(1),													--支付状态0待支付 1支付成功 2未支付 3支付已关闭  4支付失败
  PAY_DATE         date,														--支付日期
  STATE            varchar2(1),													--状态
  SETINVOICE_STATE varchar2(1),													--开票状态
  SETINVOICE_DATE  date,														--开票时间
  billing_info_id  number(9),													--开票记录id
  DOWN_DATE        date,														--发票下载时间
  invoice_url   varchar2(100),													--发票下载地址
  apply_invoice_state varchar2(2)	,											--申请开票状态:0=未申请,待开票,已开票
  apply_date		date,														--申请时间
  recharge_type 	varchar2(2),												--充值类型:0=充值,赠送
  discount number(3,1) default 10 not null,										--折扣
  original_price number(9,2) not null,											--原价
  order_no			varchar2(20) not null,										--订单号
  gp_balance		number(9,2) default 0 not null ,							--gp余额
  constraint pk_bs_recharge_rec primary key (id),
  constraint UK_bs_recharge_rec_order_no UNIQUE (order_no),						--订单号唯一约束
  CONSTRAINT fk_bs_recharge_rec_user FOREIGN KEY (user_id)            			--用户外键约束
  REFERENCES T_US_USER (ID),
  CONSTRAINT fk_bs_recharge_rec_billing FOREIGN KEY (billing_info_id)            			--用户外键约束
  REFERENCES t_us_Billing_info (ID),
  CONSTRAINT fk_bs_recharge_rec_oper FOREIGN KEY (OPERATOR)            			--操作员外键约束
  REFERENCES t_bs_operator (ID),
  constraint ck_bs_recharge_rec_money check(RECHARGE_MONENY>=0)
);

------------------------------------------
--团队表
------------------------------------------
create table t_us_team
(
       id number(9),
       team_name varchar2(40) not null,													--团队名称
       user_id number(9) not null,														--用户id(团队 拥有者)
       create_date date  not null,														--创建时间
       state varchar2(2) default '0' not null ,									--状态:0=有效，1=无效
       CONSTRAINT PK_us_team PRIMARY KEY (ID),									--
       CONSTRAINT FK_us_team_user FOREIGN KEY (user_id)							--用户外键
   REFERENCES t_us_user (ID)
       
);


------------------------------------------
--团队成员表
------------------------------------------
create table t_us_team_personnel(
       id number(9),
       user_id number(9),														--用户id(团队成员)
       team_id number(9),														--团队id
       create_date date,														--创建时间(进入团队时间)
       state varchar2(2),														--状态:0=无效,1=有效
       view_auth varchar2(2) default '0',										--查看权限:0=不可查看,1=可查看
       CONSTRAINT PK_us_team_personnel PRIMARY KEY (ID),			
       CONSTRAINT FK_us_team_personnel_user FOREIGN KEY (user_id)				--用户外键约束
   REFERENCES t_us_user (ID),
   CONSTRAINT FK_us_team_personnel_team FOREIGN KEY (team_id)					--团队外键约束
   REFERENCES t_us_team (ID),
   CONSTRAINT UK_us_team_personnel_team_user UNIQUE (team_id,user_id)			--用户团队联合唯一约束
);

------------------------------------------
--团队项目表
------------------------------------------
create table t_us_team_project(
       id number(9),
       project_id number(9),													--项目id(项目)
       team_id number(9),														--团队id(项目所属团队)
       user_id number(9),														--用户id(项目拥有者)
       create_date date,														--创建时间
       CONSTRAINT PK_us_team_project PRIMARY KEY (ID),
       CONSTRAINT FK_us_team_project_project FOREIGN KEY (project_id)			--项目外键约束
   REFERENCES t_us_project (ID),
    CONSTRAINT FK_us_team_project_user FOREIGN KEY (user_id)					--用户外键约束
   REFERENCES t_us_user (ID),
   CONSTRAINT FK_us_team_project_team FOREIGN KEY (team_id)						--团队外键约束
   REFERENCES t_us_team (ID)
   
);

------------------------------------------
--vip申请记录表
------------------------------------------
create table t_us_apply_vip_rec(
   id number(9),
   company_name varchar2(40) not null,										--公司/单位名称
   main_service varchar2(200) not null,										--主业务
   linkman_name varchar2(20) not null,										--联系人姓名
   linkman_telephone varchar2(11) not null,									--联系人手机号码
   business_licence_pic_url varchar2(200) not null,							--营业执照图片url
   work_Prove_pic_url varchar2(200) not null,								--工作证明图片url
   user_id number(9) not null,												--申请用户id
   create_date date ,														--创建时间(申请时间)
   handle_state varchar2(2) default '0' not null,							--处理状态:0=待处理,1=申请通过,2=申请不通过
   handle_date date,														--处理申请时间
   note varchar2(2000),														--备注
   OPERATOR_ID number(9),													--处理申请操作员
   constraint pk_us_apply_rec primary key(id),
   CONSTRAINT FK_us_apply_vip_rec_USER FOREIGN KEY (user_id)				--申请用户id
			REFERENCES T_US_USER (ID) ,
	CONSTRAINT FK_us_apply_vip_rec_oper FOREIGN KEY (OPERATOR_ID)			--操作员id
			REFERENCES t_bs_operator (ID) 

);

------------------------------------------
--定价表
------------------------------------------
create table t_bs_gp_price(
       id number(9),
       gp number(9,2) default 0 not null ,									--gp
       discount number(3,1) default 10 not null,							--折扣
       original_price number(9,2) not null,									--原价
       current_price number(9,2),											--现价
       create_oper number(9) not null,										--创建人
       create_date date not null,											--创建时间
       modify_oper number(9),												--修改人
       modify_date date,													--修改时间
       state varchar2(2) default '0' not null,								--状态:0=正常,1=删除
       constraint pk_bs_gp_price primary key(id),
       constraint fk_bs_gp_price_create_oper foreign key(create_oper)		--操作员外键(创建操作员)
            references t_bs_operator (id),
        constraint fk_bs_gp_price_modify_oper foreign key(modify_oper)		--操作员外键(修改操作员)
            references t_bs_operator (id)
);

------------------------------------------
--支付宝查询订单记录表
------------------------------------------
create table t_bs_alipay_query_rec
(
  id               number(9) not null,
  recharge_id      number(9) not null,										--充值账本id
  code             varchar2(5),												--网关返回码
  msg              varchar2(15),											--网关返回码描述
  buyer_logon_id   varchar2(100),											--买家支付宝账号
  buyer_pay_amount number(11,2),											--买家实付金额
  buyer_user_id    varchar2(16),											--买家在支付宝的用户id
  invoice_amount   number(11,2),											--交易中用户支付的可开具发票的金额
  out_trade_no     varchar2(64),											--商家订单号
  point_amount     number(11,2),											--积分支付的金额
  receipt_amount   varchar2(11),											--实收金额
  send_pay_date    date,													--本次交易打款给卖家的时间
  total_amount     number(11,2),											--交易的订单金额
  trade_no         varchar2(64),											--支付宝交易号
  trade_status     varchar2(32),											--交易状态：WAIT_BUYER_PAY（交易创建，等待买家付款）、TRADE_CLOSED（未付款交易超时关闭，或支付完成后全额退款）、TRADE_SUCCESS（交易支付成功）、TRADE_FINISHED（交易结束，不可退款）
  CREATE_DATE      date,													--创建时间(查询时间)
  constraint pk_bs_alipay_query_rec primary key(id),
  constraint fk_bs_alipay_query_rec_rech foreign key(recharge_id)
             references t_bs_recharge_rec (id)
)
;

------------------------------------------
--微信支付结果查询记录表
------------------------------------------
create table T_BS_WXPAY_QUERY_REC
(
  id             number(9) not null,
  recharge_id    number(9) not null,
  return_msg     varchar2(128),
  is_subscribe   varchar2(1),
  appid          varchar2(32),
  fee_type       varchar2(8),
  out_trade_no   varchar2(32),
  nonce_str      varchar2(32),
  transaction_id varchar2(32),
  trade_type     varchar2(16),
  result_code    varchar2(16),
  mch_id         varchar2(32),
  attach         varchar2(128),
  total_fee      number(11),
  time_end       varchar2(14),
  openid         varchar2(128),
  return_code    varchar2(16),
  bank_type      varchar2(16),
  cash_fee       number(11),
  trade_state    varchar2(32),
  CREATE_DATE      date,													--创建时间(查询时间)
  constraint pk_us_wechat_pay_result_query primary key (id)
)
;
------------------------------------------
--开票信息表
------------------------------------------
create table t_us_Billing_info
(
  id             number(9) not null,
  billing_depa	 varchar2(40) not null,										--开票单位(发票抬头)
  Taxpayer_number 	varchar2(20) not null,									--纳税人编号
  billing_user	 number(9) not null,										--开票用户
  state    varchar2(32) default '0' not null,								--是否删除:0=否,1=是
  CREATE_DATE      date default sysdate not null,							--创建时间(查询时间)
  depa_telephone	varchar2(15) not null ,									--单位电话,
  depa_address		varchar2(200) not null,									--单位地址
  open_bank			varchar2(40) not null,									--开户行
  depa_account		varchar2(20) not null,									--单位帐号
  constraint pk_us_Billing_info primary key (id),
  constraint fk_us_Billing_info_user foreign key (billing_user)
  	references t_us_user (id)
)
;
------------------------------------------
--消费记录表
------------------------------------------
create table t_bs_consumption_rec(
       id number(9),
       project_id number(9) not null,										--项目id
       gp_num number(9,2) not null,											--金币数
       consu_date date default sysdate not null,							--消费时间
       user_balance number(9,2) not null,									--用户余额
       user_id number(9,2) not null,										--用户id
       gp number(9,2) not null,												--gp
       constraint pk_bs_consumption_rec primary key(id),
       constraint fk_bs_consumption_rec_proj foreign key (project_id)		--项目外键
            references t_us_project (id),									
       constraint fk_bs_consumption_rec_user foreign key (user_id)			--用户外键
            references t_us_user (id)
);

------------------------------------------
--gp变动记录表
------------------------------------------
create table t_bs_gp_change_rec(
         id number(9),
       user_id number(9) not null,											--用户id()
       project_id number(9) not null,										--项目id
       gp_num     number(9,2) not null,                       				--gp数
       create_date date default sysdate not null,							--创建时间(进入团队时间)
       state varchar2(2) default '1' not null,								--状态:0=无效,1=有效					
       constraint pk_bs_gp_change_rec primary key(id),
       CONSTRAINT FK_bs_gp_change_rec_project FOREIGN KEY (project_id)		--项目外键约束
                  REFERENCES t_us_project (ID),
       CONSTRAINT FK_bs_gp_change_rec_user FOREIGN KEY (user_id)			--用户外键约束
                  REFERENCES t_us_user (ID)
);


------------------------------------------
--gp变动记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_bs_gp_change_rec
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--消费记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_bs_consumption_rec
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--开票信息表序列
------------------------------------------
CREATE SEQUENCE SEQ_us_Billing_info
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--微信支付结果查询记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_WXPAY_QUERY_REC
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--支付宝查询订单记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_bs_alipay_query_rec
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--定价表序列
------------------------------------------
CREATE SEQUENCE SEQ_bs_gp_price
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--vip申请记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_us_apply_vip_rec
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--团队表序列
------------------------------------------
CREATE SEQUENCE SEQ_us_team
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--团队人员表序列
------------------------------------------
CREATE SEQUENCE seq_us_team_personnel
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--团队项目表序列
------------------------------------------
CREATE SEQUENCE seq_us_team_project
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--充值记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_bs_recharge_rec
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--消息记录详细表序列
------------------------------------------
CREATE SEQUENCE seq_bs_msg_rec_detail
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--短信记录表序列
------------------------------------------
CREATE SEQUENCE seq_US_SMS_RECORD
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--消息记录表序列
------------------------------------------
CREATE SEQUENCE seq_bs_msg_record
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--系统日志表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_SYS_LOG
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--邮箱 验证记录序列
------------------------------------------
CREATE SEQUENCE SEQ_US_EMAIL_VERIFY
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--项目精选记录序列
------------------------------------------
CREATE SEQUENCE SEQ_US_PROJECT_FEATUREDS
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--项目浏览记录序列
------------------------------------------
CREATE SEQUENCE SEQ_US_PROJECT_BROWSES
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--项目收藏表序列
------------------------------------------
CREATE SEQUENCE SEQ_US_PROJECT_COLLECTION
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--项目信息表序列
------------------------------------------
CREATE SEQUENCE SEQ_US_PROJECT
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--用户反馈记录表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_FEEDBACK
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--项目评论信息表序列
------------------------------------------
CREATE SEQUENCE SEQ_US_PROJECT_COMMENT
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--关注列表序列
------------------------------------------
CREATE SEQUENCE SEQ_US_SUBSCRIBER
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--消息模板序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_MSG_TEMPLATE
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--文件信息序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_FILE_INFO
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--操作员表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_OPERATOR
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--权限表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_AUTHORITY
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--角色表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_ROLE
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--广告表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_ADVERT
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--设备表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_DEVICE
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

------------------------------------------
--用户信息表序列
------------------------------------------
CREATE SEQUENCE SEQ_US_USER
INCREMENT BY 1
START WITH 1
NOMAXVALUE;
------------------------------------------
--用户信息表序列
------------------------------------------
CREATE SEQUENCE SEQ_BS_FOOTER
INCREMENT BY 1
START WITH 1
NOMAXVALUE;




create or replace trigger tr_update_sms_rec
after update of user_name on t_us_user
for each row
begin
     update t_us_sms_record sms_rec set sms_rec.user_name=:new.user_name where user_name=:old.user_name;
end;