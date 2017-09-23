# brh-gengerate支持功能详述 #
## 1. 支持mysql和oracle数据库 ##

## 2. 配置文件详解  ##

- database.properties 配置数据库连接

- config.properties	源码文件生成的相关信息

## 3. 程序入口 ##
- com.brh.code.util.CodeTool

## 4. 代码模版 ##

- ftl目录下，可根据GenerateFactory和FTL模版来修改最终代码的结构

----------
## 后续计划 ##

- 根据webos的结构，生成其他可以固化的代码

- 注释掉忽略的字段，该配置要仔细考虑使用场景
