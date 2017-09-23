<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<!-- 功能模块: ${codeName} -->
<mapper namespace="${mapperPackage}.${className}DAO" >

	<!--通用表字段列表-->
	<resultMap id="BaseResultMap" type="${entityPackage}.${className}Entity">
		<#list columnDatas as item>
        <result column="${item.columnName}" property="${item.domainPropertyName}" <#if item.jdbcDataType?length gt 0>jdbcType="${item.jdbcDataType}"</#if>/>
		</#list>
    </resultMap>
    <!--通用表字段列表-->
    
	<!--user customize code start-->
${userCustomCode}
	<!--user customize code end  -->
    
	<!--通用查询条件组装-->
	<sql id="whereContation">
		<#list columnDatas as item>
			<if test="${item.domainPropertyName} != null">
				AND  ${item.columnName}=${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}  
			</if>
		</#list>
	</sql>
	
	<!--查询字段列表拼装-->
	<sql id="baseColumnList">
		<#list columnDatas as item>
			<#if item_index==0>
			 ${item.columnName}		 
			<#else>
			,${item.columnName}		 
			</#if>
		</#list> 	
	</sql>
	
	<!--
	方法名称: insert
	调用路径: ${className}Mapper.insert
	开发信息: 
	处理信息: 保存记录
	-->
 	<insert id="insert" parameterType="${entityPackage}.${className}Entity" >
	 	INSERT  INTO  ${tableNameUpper}
	 		<trim prefix="(" suffix=")" suffixOverrides=",">
				<#list columnDatas as item>
					<if test="${item.domainPropertyName} != null">
					${item.columnName},
					</if>
				</#list>
			</trim>
			<trim prefix="values (" suffix=")" suffixOverrides=",">
				 <#list columnDatas as item>
					<if test="${item.domainPropertyName} != null">
					 ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>},
					</if>
				 </#list>
			</trim>
	</insert>
	
	<!--
	方法名称: update
	调用路径: ${className}Mapper.update
	开发信息: 
	处理信息: 修改记录
	-->
 	<update id="update" parameterType="${entityPackage}.${className}Entity" >
		UPDATE   ${tableNameUpper}  	 
	  	<set> 
		<#list columnDatas as item>
			<#if item.columnKey !='PRI' >
				<#if item.columnName == 'LAST_UPDATE_NO'>
				<if test="${item.domainPropertyName} != null">
			 		${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}+1,
			 	</if>
				<#else>
				<if test="${item.domainPropertyName} != null">
			 		${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>},
			 	</if>
			 	</#if>
			</#if>
		</#list>
		</set>
		WHERE  
		<#list columnKeyDatas as item>
			<#if item_index==0>
			${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType} </#if>}		 
			<#else>
		 	AND ${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
			</#if>
		</#list>
		<#list columnDatas as item>
			<#if item.columnName == 'LAST_UPDATE_NO'>
		<if test="${item.domainPropertyName} != null">
	 		AND ${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}  
	 	</if>
		 	</#if>
		</#list>
	</update>
	
	<#if columnKeyParam !="">
	<!--
	方法名称: deleteByPriKey
	调用路径:${className}Mapper.deleteByPriKey
	开发信息: 
	处理信息: 删除记录
	-->
	<delete id="deleteByPriKey" parameterType="java.lang.${primaryKeyType}">
		DELETE 	FROM ${tableNameUpper} 	 
		WHERE 
		<#list columnKeyDatas as item>
			<#if item_index==0>
			${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
			<#else>
		 	AND ${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
			</#if>
		</#list>
	</delete>
	</#if>
	
	<#if columnKeyParam !="">
	<!--
	方法名称: findByPriKey
	调用路径: ${className}Mapper.findByPriKey
	开发信息: 
	处理信息: 根据主键查询记录
	-->
	<select id="findByPriKey" parameterType="java.lang.${primaryKeyType}"  resultType="${entityPackage}.${className}Entity">
		SELECT   
		   <include refid="baseColumnList"/>
		FROM   ${tableNameUpper}         
		WHERE
		<#list columnKeyDatas as item>
				<#if item_index==0>
				${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
				<#else>
			 	AND ${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
				</#if>
		</#list>
	</select>
	</#if>
	
	<!--
	方法名称: getList
	调用路径: ${className}Mapper.getList
	开发信息: 
	处理信息: 根据条件查询记录
	-->
	<select id="getList" parameterType="${entityPackage}.${className}Entity"  resultType="${entityPackage}.${className}Entity">
	   SELECT   
	   		<include refid="baseColumnList"/>
	   FROM   ${tableNameUpper}           
	   WHERE 1=1
		<include refid="whereContation"/>
		<if test="columnSort != null">
		 	ORDER BY ${"$"}{columnSort}
		</if>
		limit 0,100
	</select>
	

	<#if columnKeyParam !="">
	<!--
	方法名称: getRowLock
	调用路径: ${className}Mapper.getRowLock
	开发信息: 
	处理信息: 获取行级锁
	-->
	<select id="getRowLock" parameterType="${entityPackage}.${className}Entity">
		SELECT   
		   *
		FROM   ${tableNameUpper}         
		WHERE
		<#list columnKeyDatas as item>
				<#if item_index==0>
				${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
				<#else>
			 	AND ${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
				</#if>
		</#list>
		FOR UPDATE
	</select>
	</#if>
	<#--
	<!--
	方法名称: batchInsert
	调用路径: ${className}Mapper.batchInsert
	开发信息: 
	处理信息: 保存记录
	-->
	<#--
 	<insert id="batchInsert" parameterType="java.util.List" >
	 	INSERT  INTO  ${tableNameUpper}
	 		<trim prefix="(" suffix=")" suffixOverrides=",">
				<#list columnDatas as item>
					${item.columnName},
				</#list>
			</trim>
			values
			<foreach collection="list" item="entity" separator=",">
			<trim prefix="(" suffix=")" suffixOverrides=",">
				 <#list columnDatas as item>
					 ${"#"}{entity.${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>},
				 </#list>
			</trim>
			</foreach>
	</insert>
	-->
	<#--
	<!--
	方法名称: batchUpdate
	调用路径: ${className}Mapper.batchUpdate
	开发信息: 
	处理信息: 修改记录
	-->
	<#--
 	<update id="batchUpdate" parameterType="java.util.List" >
 		<foreach collection="list" item="entity" separator=",">
		UPDATE   ${tableNameUpper}  	 
	  	<set> 
		<#list columnDatas as item>
			<#if item.columnKey !='PRI' >
				<#if item.columnName == 'LAST_UPDATE_NO'>
				<if test="${item.domainPropertyName} != null">
			 		${item.columnName} = ${"#"}{entity.${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}+1,
			 	</if>
				<#else>
				<if test="${item.domainPropertyName} != null">
			 		${item.columnName} = ${"#"}{entity.${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>},
			 	</if>
			 	</#if>
			</#if>
		</#list>
		</set>
		WHERE  
		<#list columnKeyDatas as item>
			<#if item_index==0>
			${item.columnName} = ${"#"}{${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
			<#else>
		 	AND ${item.columnName} = ${"#"}{entity.${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}		 
			</#if>
		</#list>
		<#list columnDatas as item>
			<#if item.columnName == 'LAST_UPDATE_NO'>
		<if test="${item.domainPropertyName} != null">
	 		AND ${item.columnName} = ${"#"}{entity.${item.domainPropertyName}<#if item.jdbcDataType?length gt 0>,jdbcType=${item.jdbcDataType}</#if>}  
	 	</if>
		 	</#if>
		</#list>
		</foreach>
	</update>
	-->
</mapper>