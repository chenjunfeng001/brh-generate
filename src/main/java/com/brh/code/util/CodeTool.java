package com.brh.code.util;

import org.apache.commons.lang3.StringUtils;

import com.brh.code.core.FtlDef;
import com.brh.code.core.GenerateFactory;
import com.brh.code.core.QueryTable;
import com.brh.code.core.ResourceUtil;


public class CodeTool{
	/**
	 * 注意：在执行前，请确认ftl模板中引入的包结构是否正确
	 */
	public static void main(String args[]) {
		String codeCgTables = ResourceUtil.getConfigInfo("code_cg_tables");
		if (StringUtils.isEmpty(codeCgTables)) {
			if (ResourceUtil.getConfigInfo("genTablesAllIfUnDefindTables").toUpperCase().equals("Y")) {
				codeCgTables = QueryTable.getAllTables();
				if (StringUtils.isEmpty(codeCgTables)) {
					return;
				}
			} else {
				return;
			}
		}
		String tables[] = codeCgTables.split(",");
		for (int i = 0; i < tables.length; i++) {
			GenerateFactory.codeGenerateByFTL(tables[i], "", FtlDef.KEY_TYPE_02);
		}
	}
}
