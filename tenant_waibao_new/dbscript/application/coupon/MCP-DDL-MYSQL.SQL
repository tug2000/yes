-- ------------------------------------
-- Table structure for `tenant_waiter`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_waiter`;
CREATE TABLE `tenant_waiter` (
  `TW_ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TW_TENANT_ID` varchar(32) NOT NULL COMMENT '租户ID',
  `TW_WAITER_NAME` varchar(32) NOT NULL COMMENT '店员名字',
  `TW_APP_USER` varchar(32) NOT NULL COMMENT 'APP用户名',
  `TW_APP_PWD` varchar(32) NOT NULL COMMENT 'APP密码',
  `TW_ACCESS_TOKEN` varchar(40) NOT NULL COMMENT 'APP接口调用令牌',
  `TW_CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`TW_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
-- Table structure for `tenant_customer`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_customer`;
CREATE TABLE `tenant_customer` (
  `TC_CUID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TC_QRCODE_NUM` bigint(32) NOT NULL COMMENT '二维码编号',
  `TC_QRCODE_IMGURL` varchar(100) NOT NULL COMMENT '二维码图片路径',
  `TC_CUSTOMER_SOURCE` int(10) NOT NULL COMMENT '顾客来源',
  `TC_OPENID` varchar(32) NOT NULL COMMENT 'openId',
  `TC_THIRDPARTY_NAME` varchar(32) COMMENT '第三方昵称',
  `TC_THIRDPARTY_ACCOUNT` varchar(32) COMMENT '第三方昵称',
  `TC_CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`TC_CUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
-- Table structure for `tenant_coupon`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_coupon`;
CREATE TABLE `tenant_coupon` (
  `TC_COID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TC_TENANT_ID` varchar(32) NOT NULL COMMENT '租户Id',
  `TC_COUPON_NAME` varchar(32) NOT NULL COMMENT '名称',
  `TC_COUPON_ICOURL` varchar(100) NOT NULL COMMENT '图标路径',
  `TC_COUPON_CONVERTIBLESUM` int(10) COMMENT '可兑换数',
  `TC_COUPON_CONVERTIBLENUM` int(10) COMMENT '兑换奖品个数',
  `TC_COUPON_VALID_BEGIN` datetime DEFAULT NULL COMMENT '有效期起始时间',
  `TC_COUPON_VALID_END` datetime DEFAULT NULL COMMENT '有效期截止时间',
  `TC_COUPON_PUBLISH_SUM` int(10) COMMENT '发行数量',
  `TC_COUPON_USERED_SUM` int(10) COMMENT '已用数量',
  `TC_COUPON_LIMIT_STATUS` int(10) COMMENT '用户限用次数',
  `TC_COUPON_ACTIVIYDES` varchar(200) NOT NULL COMMENT '规则说明',
  `TC_COUPON_PRIZEUNIT` varchar(32) NOT NULL COMMENT '奖品单位',
  `TC_COUPON_STATUS` int(10) DEFAULT 0 COMMENT '点券状态',
  `TC_COUPON_USER_SUM` int(10) DEFAULT 0 COMMENT '用户量',
  `TC_COUPON_SALE_SUM` int(10) DEFAULT 0 COMMENT '售出量',
  `TC_CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`TC_COID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
-- Table structure for `tenant_customer_coupon`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_customer_coupon`;
CREATE TABLE `tenant_customer_coupon` (
  `TCC_ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TCC_TENANT_ID` varchar(32) NOT NULL COMMENT '租户Id',
  `TCC_CUID` bigint(32) NOT NULL COMMENT '顾客Id',
  `TCC_COID` bigint(32) NOT NULL COMMENT '点券Id',
  `TCC_COUPONNUM` int(10) COMMENT '点券数量',
  `TCC_WAITCONVERNUM` int(10) COMMENT '待兑换数量 ',
  `TCC_CONVERTIBLENUM` int(10) COMMENT '已兑换数量',
  PRIMARY KEY (`TCC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
-- Table structure for `tenant_couponconsume`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_couponconsume`;
CREATE TABLE `tenant_couponconsume` (
  `TC_CCID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TC_TENANT_ID` varchar(32) NOT NULL COMMENT '租户Id',
  `TC_CUID` bigint(32) NOT NULL COMMENT '顾客Id',
  `TC_COID` bigint(32) NOT NULL COMMENT '点券Id',
  `TC_NUMBER` int(10) NOT NULL COMMENT '个数',
  `TC_WAITER_ID` bigint(32) NOT NULL COMMENT '店员Id ',
  `TC_DATE` datetime DEFAULT NULL  COMMENT '时间',
  PRIMARY KEY (`TC_CCID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
-- Table structure for `tenant_couponconver`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_couponconver`;
CREATE TABLE `tenant_couponconver` (
  `TC_CONVID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TC_TENANT_ID` varchar(32) NOT NULL COMMENT '租户Id',
  `TC_CUID` bigint(32) NOT NULL COMMENT '顾客Id',
  `TC_COID` bigint(32) NOT NULL COMMENT '点券Id',
  `TC_NUMBER` int(10) NOT NULL COMMENT '次数',
  `TC_WAITER_ID` bigint(32) NOT NULL COMMENT '店员Id ',
  `TC_DATE`  datetime DEFAULT NULL  COMMENT '时间',
  PRIMARY KEY (`TC_CONVID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ------------------------------------
-- Table structure for `tenant_businesses`
-- ------------------------------------
DROP TABLE IF EXISTS `tenant_businesses`;
CREATE TABLE `tenant_businesses` (
  `TB_ID` bigint(32) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `TB_TENANT_ID` varchar(32) NOT NULL COMMENT '租户Id',
  `TB_LOGOURL`  varchar(100) NOT NULL COMMENT 'LOGO路径',
  `TB_BUSNAME` varchar(32) NOT NULL COMMENT '商家名称',
  `TB_CONTACT_NUMBER` varchar(32) NOT NULL COMMENT '联系电话',
  `TB_ADDRESS` varchar(32) NOT NULL COMMENT '地址',
  PRIMARY KEY (`TB_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
