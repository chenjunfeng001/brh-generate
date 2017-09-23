package com.brh.code.core;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.brh.code.model.ColumnData;
import com.brh.code.model.CreateBean;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;

public class GenerateFactory{

	private static String url;
	private static String username;
	private static String passWord;
	private static String databaseName;
	private static String databaseType;

	public GenerateFactory() {
	}

	public static void codeGenerateByFTL(String tableName, String codeName, String keyType) {
		try {
			tableName = tableName==null?"":tableName.toUpperCase();
			System.out.println("----------------------------"+tableName+"持久化模板代码生成开始---------------------------");
			CreateBean createBean = new CreateBean();
			createBean.setDataBaseInfo(url, username, passWord,databaseName,databaseType);
			String className = createBean.getTablesNameToClassName(tableName);
			String lowerName = (new StringBuilder(String.valueOf(className.substring(0, 1).toLowerCase()))).append(
					className.substring(1, className.length())).toString();
			String tableNameUpper = tableName.toUpperCase();
			String tablesAsName = createBean.getTablesASName(tableName);
			if (StringUtils.isEmpty(codeName)) {
				Map<String, String> tableCommentMap = createBean.getTableCommentMap();
				codeName = tableCommentMap.get(tableName.toLowerCase());
				codeName = codeName== null ? "": codeName.trim();
			}
			String getBestMatchedTables = ResourceUtil.getConfigInfo("getBestMatched_tables");
			getBestMatchedTables = getBestMatchedTables== null ? "": getBestMatchedTables.trim().toUpperCase();
			String getBestMatchedFlag = "N";
			if(getBestMatchedTables!= null){
				getBestMatchedFlag = getBestMatchedTables.contains(tableNameUpper)?"Y":"N";
			}
			String resourcePathSrc = ResourceUtil.getConfigInfo("resource_path_src");
			String classPathSrc = ResourceUtil.getConfigInfo("class_path_src");

			String sqlMapperPackage = ResourceUtil.getConfigInfo("sqlMapper_path");
			String entityPackage = ResourceUtil.getConfigInfo("entity_path");
			String servicePackage = ResourceUtil.getConfigInfo("service_path");
			String serviceImpPackage = ResourceUtil.getConfigInfo("service_imp_path");
			String requestPackage = ResourceUtil.getConfigInfo("request_path");
			String mapperPackage = ResourceUtil.getConfigInfo("mapper_path");


			String sqlMapperPath = (new StringBuilder(String.valueOf(sqlMapperPackage.replace(".", "\\")))).append("\\")
					.append(className).append("EntityMapper.xml").toString();
			String entityPath = (new StringBuilder(String.valueOf(entityPackage.replace(".", "\\")))).append("\\")
					.append(className).append("Entity.java").toString();
			String mapperPath = (new StringBuilder(String.valueOf(mapperPackage.replace(".", "\\")))).append("\\")
					.append(className).append("DAO.java").toString();
			String servicePath = (new StringBuilder(String.valueOf(servicePackage.replace(".", "\\")))).append("\\")
					.append(className).append("Service.java").toString();
			String serviceImpPath = (new StringBuilder(String.valueOf(serviceImpPackage.replace(".", "\\")))).append("\\")
					.append(className).append("ServiceImpl.java").toString();
/*			String requestPath = (new StringBuilder(String.valueOf(requestPackage.replace(".", "\\")))).append("\\")
					.append(className).append("VO.java").toString();*/
			String requestPath = (new StringBuilder(String.valueOf(requestPackage.replace(".", "\\")))).append("\\")
					.append(className).append("Dto.java").toString();

			String sqlMapperFlag = ResourceUtil.getConfigInfo("sqlMapper_flag");
			String domainFlag = ResourceUtil.getConfigInfo("entity_flag");
			String serviceFlag = ResourceUtil.getConfigInfo("service_flag");
			String serviceImplFlag = ResourceUtil.getConfigInfo("service_imp_flag");
			String requestFlag = ResourceUtil.getConfigInfo("request_flag");
//			String voFlag = ResourceUtil.getConfigInfo("vo_flag");
			String mapperFlag = ResourceUtil.getConfigInfo("mapper_flag");

			Map<String, Object> sqlMap = createBean.getAutoCreateSql(tableName);
			List<ColumnData> columnDatas = createBean.getColumnDatas(tableName);
			List<ColumnData> columnKeyDatas = createBean.getColumnKeyDatas(columnDatas);
			String columnKeyParam = createBean.getColumnKeyParam(columnKeyDatas);
			String columnKeyUseParam = createBean.getColumnKeyUseParam(columnKeyDatas);
			String columnKeySort = createBean.getColumnKeySort(columnKeyDatas);
			String ignoreGenerateColumns = ResourceUtil.getConfigInfo("ignore_generate_columns");
			SimpleDateFormat dateformat = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒 E ");
			String nowDate = dateformat.format(new Date());
			System.out.println((new StringBuilder("开始生成时间:")).append(nowDate).toString());
			Map<String, Object> root = new HashMap<String, Object>();
			root.put("className", className);
			root.put("lowerName", lowerName);
			root.put("codeName", codeName);
			root.put("tableName", tableName);
			System.err.println("tableName:"+tableName);
			System.err.println("tableNameUpper:"+tableNameUpper);
			root.put("tableNameUpper", tableNameUpper);
			root.put("tableNameLower", tableName.toLowerCase());
			System.err.println("tableNameLower:"+tableName.toLowerCase());
			root.put("tablesAsName", tablesAsName);
			root.put("entityPackage", entityPackage);
			root.put("servicePackage", servicePackage);
			root.put("mapperPackage", mapperPackage);
			root.put("serviceImpPackage", serviceImpPackage);
			root.put("requestPackage", requestPackage);
			root.put("keyType", keyType);
			root.put("nowDate", nowDate);
			root.put("feilds", createBean.getBeanFeilds(tableName, className));
			//root.put("queryfeilds", createBean.getQueryBeanFeilds(tableName, className));
			root.put("columnDatas", columnDatas);
			root.put("columnKeyDatas", columnKeyDatas);
			root.put("primaryKeyType", columnKeyDatas.get(0).getDataType());
			root.put("columnKeyParam", columnKeyParam);
			root.put("columnKeyUseParam", columnKeyUseParam);
			root.put("columnKeySort", columnKeySort);
			root.put("beanFieldDataTypes", createBean.getBeanFieldDataTypes());
			root.put("SQL", sqlMap);
			root.put("getBestMatchedFlag", getBestMatchedFlag);
			root.put("columnKeyString", columnKeySort.replace(",", ":"));
			root.put("ignoreGenerateColumns", ignoreGenerateColumns);
			Configuration cfg = new Configuration();
			String templateBasePath = (new StringBuilder(String.valueOf(getProjectPath()))).append(
					ResourceUtil.getTEMPLATEPATH()).toString();
			cfg.setDirectoryForTemplateLoading(new File(templateBasePath));
			cfg.setObjectWrapper(new DefaultObjectWrapper());
			if ("Y".equals(sqlMapperFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "sqlMapper.ftl", resourcePathSrc, sqlMapperPath);
			}
			if ("Y".equals(domainFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "entityClass.ftl", classPathSrc, entityPath);
			}
			if ("Y".equals(serviceFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "serviceClass.ftl", classPathSrc, servicePath);
			}
			if ("Y".equals(serviceImplFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "serviceImplClass.ftl", classPathSrc, serviceImpPath);
			}
			if ("Y".equals(requestFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "requestClass.ftl", classPathSrc, requestPath);
			}
			/*if ("Y".equals(voFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "voClass.ftl", classPathSrc, requestPath);
			}*/
			if ("Y".equals(mapperFlag)){
				FreemarkerEngine.createFileByFTL(cfg, root, "mapperClass.ftl", classPathSrc, mapperPath);
			}
			System.out.println("----------------------------"+tableNameUpper+"持久化模板代码生成完毕---------------------------");
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

	public static String getProjectPath() {
		String path = (new StringBuilder(String.valueOf(System.getProperty("user.dir").replace("\\", "/"))))
				.append("/").toString();
		path += "target/classes/";
		System.out.println("模板路径："+path);
		return path;
	}

	static {
		url = ResourceUtil.URL;
		username = ResourceUtil.USERNAME;
		passWord = ResourceUtil.PASSWORD;
		databaseName = ResourceUtil.DATABASE_NAME;
		databaseType = ResourceUtil.DATABASE_TYPE;
	}
}
