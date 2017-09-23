package ${requestPackage};

<#list beanFieldDataTypes as item>
<#if item == 'Date'>
import java.util.Date;
</#if>
<#if item == 'BigDecimal'>
import java.math.BigDecimal;
</#if>
<#if item == 'BigInteger'>
import java.math.BigInteger;
</#if>
</#list>
/**
 * 描述：</b>${codeName}<br>
 * @author：系统生成
 * @version:1.0
 */
public class ${className}VO {
	private static final long serialVersionUID = 1L;
	
	<#list columnDatas as item>
	<#if ignoreGenerateColumns?index_of(item.columnName) == -1>
	<#if item_index!=0><#--API项目请求类需要剔除数据库主键字段-->
	/**
	 *${item.columnComment}
	 */
	private ${item.dataType} ${item.domainPropertyName};
	</#if>
	</#if>
	</#list>
	
	<#list columnDatas as item>
	<#if ignoreGenerateColumns?index_of(item.columnName) == -1>
	<#if item_index!=0><#--API项目请求类需要剔除数据库主键字段-->
	/**
	 *获取${item.columnComment}
	 */
	public ${item.dataType} get${item.domainPropertyName?cap_first}(){
		return this.${item.domainPropertyName};
	}
	
	/**
	 *设置${item.columnComment}
	 */
	public void set${item.domainPropertyName?cap_first}(${item.dataType} ${item.domainPropertyName}){
		this.${item.domainPropertyName} = ${item.domainPropertyName};
	}
	</#if>
	</#if>
	</#list>
}

