package com.brh.code.core;

import java.util.List;

import com.brh.code.model.CreateBean;
import com.brh.code.model.TableInfo;

public class QueryTable {

	private static String url;
	private static String username;
	private static String passWord;
	private static String databaseName;
	private static String databaseType;

	public QueryTable() {
	}

	public static String getAllTables(){
		String allTableStr = "";
		try {
			CreateBean createBean = new CreateBean();
			createBean.setDataBaseInfo(url, username, passWord,databaseName,databaseType);
			List<TableInfo> tableList = createBean.getTablesInfo();
			for(int i=0;i<tableList.size();i++){
				TableInfo tableInfo = tableList.get(i);
				if(i==0){
					allTableStr += tableInfo.getTableName();
				}else{
					allTableStr += ","+tableInfo.getTableName();
				}
			}
			System.out.println(allTableStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return allTableStr;
	}

	static {
		url = ResourceUtil.URL;
		username = ResourceUtil.USERNAME;
		passWord = ResourceUtil.PASSWORD;
		databaseName = ResourceUtil.DATABASE_NAME;
		databaseType = ResourceUtil.DATABASE_TYPE;
	}
}
