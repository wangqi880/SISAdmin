CREATE TABLE IF NOT EXISTS `t_admin_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '后台管理用户',
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `msisdn` VARCHAR(45) NULL,
  `insertTime` VARCHAR(45) NULL,
  `updateTime` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `msisdn_index` (`msisdn` ASC),
  INDEX `username_index` (`username` ASC))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `t_framework_conf` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '系统统一参数配置表',
  `conf_key` VARCHAR(45) NULL,
  `conf_value` VARCHAR(45) NULL,
  `insertTime` VARCHAR(45) NULL,
  `desc` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `conf_key_UNIQUE` (`conf_key` ASC))
ENGINE = InnoDB;

CREATE TABLE `t_record_print` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `studentId` varchar(100) DEFAULT NULL,
  `oprTime` varchar(100) DEFAULT NULL,
  `studentName` varchar(100) DEFAULT NULL,
  `classId` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO t_framework_conf(`conf_key`,
                             `conf_value`,

                             `insertTime`,
                           `desc`)
VALUES ('fix_is_show',
        '0',
        now(),
        '是否展示维护界面');
        
#插入管理员账户

insert into t_admin_user(username,`password`,name,msisdn,role) values('wangqi','cd_wangqi','王琪','15682051518','1');
insert into t_admin_user(username,`password`,name,msisdn,role) values('chenqiao','cd_chenqiao','王琪','15682051518','1');
INSERT INTO t_framework_conf(`conf_key`,`conf_value`,`insertTime`,`desc`) VALUES ("print_count","2","2017-12-13 11:04:14","每个人允许打印次数");

INSERT INTO t_framework_conf(`conf_key`,`conf_value`,`insertTime`,`desc`) VALUES ("print_count_day","1","2017-12-14 09:15:14","每个人每天允许打印次数");
