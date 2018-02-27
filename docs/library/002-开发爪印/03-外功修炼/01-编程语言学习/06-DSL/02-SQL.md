##### 常用MySQL语句：
 - 登录MySQL（默认采用root权限）:`mysql -uroot -p密码`
 - 查询MySQL里的所有数据库:`show databases;`
 - 使用某个数据库:`use 数据库名;`
 - 查看当前数据库里面的所有表名:`show tables;`
 - 刷选查看数据库的表名:`select table_name from information_schema.tables where table_schema='dbname' and table_name like '%name%';`

 - 执行外部SQL语句（默认采用root权限）:将以下内容拷贝到bat文件之中执行，具体的SQL语句在.sql文件之中 `mysql -uroot -p密码 -e "use 数据库名; source sample.sql;"`

 - 限制显示查询结果:`select * from 子表名 limit 10` 
 - 条件查询:
  - `select * from 子表名 limit 10 where name = 'xxx'` 
  - `select * from 子表名 limit 10 where level >= 100` 