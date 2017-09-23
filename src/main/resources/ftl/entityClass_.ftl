package ${entityPackage};

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
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 描述：</b>${codeName}<br>
 * @author：系统生成
 * @version:1.0
 */
@Entity
@Table(name="${tableNameLower}")
public class ${className}Entity implements Serializable {

	private static final long serialVersionUID = 1L;
	
	<#list columnDatas as item>
	<#if ignoreGenerateColumns?index_of(item.columnName) == -1>
	/**
	 *${item.columnComment}
	 */
	@Column(name="${item.columnName?lower_case}")
	private ${item.dataType} ${item.domainPropertyName};
	</#if>
	</#list>
	
	<#list columnDatas as item>
	<#if ignoreGenerateColumns?index_of(item.columnName) == -1>
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
	</#list>
}

