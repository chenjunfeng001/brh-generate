package ${entityPackage};

<#list beanFieldDataTypes as item>
<#if item == 'Date'>
import java.util.Date;
</#if>
<#if item == 'BigDecimal'>
import java.math.BigDecimal;
</#if>
</#list>
/**
 * 描述：</b>${codeName}<br>
 * @author：系统生成
 * @since：${nowDate}
 * @version:1.0
 */
public class ${className}Entity extends BasicEntity {

	private static final long serialVersionUID = 1L;
	${feilds}
}

