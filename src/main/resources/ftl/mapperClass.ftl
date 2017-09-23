package ${mapperPackage};

import ${entityPackage}.${className}Entity;
import java.math.BigInteger;
import java.util.List;

/**
 * 描述：</b>${codeName}<br>
 * @author：系统生成
 * @version:1.0
 */
public interface ${className}DAO {
	<#---->
	/**
     * 描述: 插入${codeName}
     * <p>创建人：系统自动生成 , ${nowDate}</p>
     * @param ${lowerName}Entity 需要插入的实体信息
     * @return
     */
	public Integer insert(${className}Entity ${lowerName}Entity);
	
	/**
     * 描述: 更新${codeName}
     * <p>创建人：系统自动生成 , ${nowDate}</p>
     * @param ${lowerName}Entity 需要更新的实体信息
     * @return
     */
	public Integer update(${className}Entity ${lowerName}Entity);
	
	/**
     * 描述: 根据实体查询${codeName}
     * <p>创建人：系统自动生成 , ${nowDate}</p>
	 * @param ${lowerName}Entity
     * @return
     */
	public ${className}Entity findByPriKey(${columnKeyParam});
	
	<#if columnKeyParam !="">
	/**
     * 描述: 根据主键删除${codeName}
     * <p>创建人：系统自动生成 , ${nowDate}</p>
     	<#list columnKeyDatas as item>
	 * @param ${item.domainPropertyName} ${item.columnComment} 
		</#list>
     * @return
     */
	public Integer deleteByPriKey(${columnKeyParam});
	</#if>
	
	/**
     * 描述: 根据条件查询${codeName}
     * <p>创建人：系统自动生成 , ${nowDate}</p>
     * @param ${lowerName}Entity 查询条件对应的实体信息
     * @return
     */
	public List<${className}Entity> getList(${className}Entity ${lowerName}Entity);
	
	/*user customize code start*/
${userCustomCode}
	/*user customize code end*/
}
