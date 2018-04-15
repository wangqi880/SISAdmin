-- 数据库初始化脚本

-- 创建数据库
CREATE DATABASE qsngcxj;
-- 使用数据库
use qsngcxj;
-- 创建打印记录表
CREATE TABLE t_qsng_print(
`print_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
`msisdn` VARCHAR(120) NOT NULL COMMENT '手机号',
`student_id` VARCHAR (50) not null comment '学生id',
`number` INT NOT NULL COMMENT '打印次数',
`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
PRIMARY KEY(print_id)
)ENGINE=INNODB AUTO_INCREMENT=1000 DEFAULT CHARSET=utf8 COMMENT='打印记录表';
