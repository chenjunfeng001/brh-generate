package com.brh.code.core;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreemarkerEngine{

	public FreemarkerEngine() {
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void createFileByFTL(Configuration cfg, Map root, String ftlName, String fileDirPath,
			String targetFile) {
		String encoding = ResourceUtil.getSYSTEM_ENCODING();
		String workspasePath = ResourceUtil.getConfigInfo("workspace_path");
		String userCustomCode = "";
		try {
			Template temp = cfg.getTemplate(ftlName, encoding);
			File file = new File((new StringBuilder(String.valueOf(workspasePath))).append(File.separator)
					.append(fileDirPath).append(File.separator).append(targetFile).toString());
			if (!file.exists()) {
				(new File(file.getParent())).mkdirs();
				System.out.println((new StringBuilder("生成文件:")).append(file.getAbsolutePath()).toString());
			} else {
				String lineData = "";
				BufferedReader bufferedReader = null;
				FileReader fileReader = null;
				try {
					fileReader = new java.io.FileReader(file);
					bufferedReader = new BufferedReader(fileReader);
					boolean startFlag = false;
					boolean isFirst = true;
					while((lineData = bufferedReader.readLine())!=null){
						if(lineData.contains("user customize code start")){
							startFlag = true;
							continue;
						}else if(lineData.contains("user customize code end")){
							startFlag = false;
							continue;
						}
						if(startFlag){
							if(isFirst){
								userCustomCode += lineData;
								isFirst = false;
							}else{
								userCustomCode += "\r\n" + lineData;
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					if(fileReader != null){
						fileReader.close();
					}
					if(bufferedReader != null){
						bufferedReader.close();
					}
				}
				System.out.println((new StringBuilder("替换文件:")).append(file.getAbsolutePath()).toString());
			}
			FileOutputStream os = new FileOutputStream(file);
			Writer out = new OutputStreamWriter(os, encoding);
			root.put("userCustomCode", userCustomCode);
			temp.process(root, out);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
	}

}
