/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.tospur.modules.basetest.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;


/**
 * 基线测试Entity
 * @author jinyin
 * @version 2017-09-18
 */
public class BaseTest extends DataEntity<BaseTest> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 基线标题
	private String testMan;		// 系统测试人员
	private String product;		// 产品名称
	private String dataupdate;		// 是否跟新数据库
	private String testtime;		// 测试次数
	private String testDescribe;		// 测试描述
	private String workload;		// 测试工作量
	private String testExecute;		// 第一轮执行用例数
	private String pass;		// 第一轮通过用例数
	private String casenumber;		// 第一轮N/A用例数
	private String newbug;		// 新增Bug数
	private String seriousbug;		// 严重Bug数
	private String commonbug;		// 一般Bug数
	private String slightbug;		// 轻微Bug数
	private String suggestbug;		// 建议Bug数
	private String conclusion;		// 测试结论
	private Date finishtime;		// 系统测试完成时间
	private String edition;		// 发布版本号
	
	public BaseTest() {
		super();
	}

	public BaseTest(String id){
		super(id);
	}

	@Length(min=0, max=64, message="基线标题长度必须介于 0 和 64 之间")
	@ExcelField(title="基线标题", align=2, sort=1)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Length(min=0, max=64, message="系统测试人员长度必须介于 0 和 64 之间")
	@ExcelField(title="系统测试人员", align=2, sort=2)
	public String getTestMan() {
		return testMan;
	}

	public void setTestMan(String testMan) {
		this.testMan = testMan;
	}
	
	@Length(min=0, max=64, message="产品名称长度必须介于 0 和 64 之间")
	@ExcelField(title="产品名称", align=2, sort=3)
	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}
	
	@Length(min=0, max=64, message="是否跟新数据库长度必须介于 0 和 64 之间")
	@ExcelField(title="是否跟新数据库", align=2, sort=4)
	public String getDataupdate() {
		return dataupdate;
	}

	public void setDataupdate(String dataupdate) {
		this.dataupdate = dataupdate;
	}
	
	@Length(min=0, max=64, message="测试次数长度必须介于 0 和 64 之间")
	@ExcelField(title="测试次数", align=2, sort=5)
	public String getTesttime() {
		return testtime;
	}

	public void setTesttime(String testtime) {
		this.testtime = testtime;
	}
	
	@Length(min=0, max=1024, message="测试描述长度必须介于 0 和 1024之间")
	@ExcelField(title="测试描述", align=2, sort=6)
	public String getTestDescribe() {
		return testDescribe;
	}

	public void setTestDescribe(String testDescribe) {
		this.testDescribe = testDescribe;
	}
	
	@Length(min=0, max=64, message="测试工作量长度必须介于 0 和 64 之间")
	@ExcelField(title="测试工作量", align=2, sort=7)
	public String getWorkload() {
		return workload;
	}

	public void setWorkload(String workload) {
		this.workload = workload;
	}
	
	@Length(min=0, max=64, message="第一轮执行用例数长度必须介于 0 和 64 之间")
	@ExcelField(title="第一轮执行用例数", align=2, sort=8)
	public String getTestExecute() {
		return testExecute;
	}

	public void setTestExecute(String testExecute) {
		this.testExecute = testExecute;
	}
	
	@Length(min=0, max=64, message="第一轮通过用例数长度必须介于 0 和 64 之间")
	@ExcelField(title="第一轮通过用例数", align=2, sort=9)
	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}
	
	@Length(min=0, max=64, message="第一轮N/A用例数长度必须介于 0 和 64 之间")
	@ExcelField(title="第一轮N/A用例数", align=2, sort=10)
	public String getCasenumber() {
		return casenumber;
	}

	public void setCasenumber(String casenumber) {
		this.casenumber = casenumber;
	}
	
	@Length(min=0, max=64, message="新增Bug数长度必须介于 0 和 64 之间")
	@ExcelField(title="新增Bug数", align=2, sort=11)
	public String getNewbug() {
		return newbug;
	}

	public void setNewbug(String newbug) {
		this.newbug = newbug;
	}
	
	@Length(min=0, max=64, message="严重Bug数长度必须介于 0 和 64 之间")
	@ExcelField(title="严重Bug数", align=2, sort=12)
	public String getSeriousbug() {
		return seriousbug;
	}

	public void setSeriousbug(String seriousbug) {
		this.seriousbug = seriousbug;
	}
	
	@Length(min=0, max=64, message="一般Bug数长度必须介于 0 和 64 之间")
	@ExcelField(title="一般Bug数", align=2, sort=13)
	public String getCommonbug() {
		return commonbug;
	}

	public void setCommonbug(String commonbug) {
		this.commonbug = commonbug;
	}
	
	@Length(min=0, max=64, message="轻微Bug数长度必须介于 0 和 64 之间")
	@ExcelField(title="轻微Bug数", align=2, sort=14)
	public String getSlightbug() {
		return slightbug;
	}

	public void setSlightbug(String slightbug) {
		this.slightbug = slightbug;
	}
	
	@Length(min=0, max=64, message="建议Bug数长度必须介于 0 和 64 之间")
	@ExcelField(title="建议Bug数", align=2, sort=15)
	public String getSuggestbug() {
		return suggestbug;
	}

	public void setSuggestbug(String suggestbug) {
		this.suggestbug = suggestbug;
	}
	
	@Length(min=0, max=1024, message="测试结论长度必须介于 0 和 1024 之间")
	@ExcelField(title="测试结论", align=2, sort=16)
	public String getConclusion() {
		return conclusion;
	}

	public void setConclusion(String conclusion) {
		this.conclusion = conclusion;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="系统测试完成时间", align=2, sort=17)
	public Date getFinishtime() {
		return finishtime;
	}

	public void setFinishtime(Date finishtime) {
		this.finishtime = finishtime;
	}

    public String getEdition()
    {
        return edition;
    }

    public void setEdition(String edition)
    {
        this.edition = edition;
    }

    @Override
    public String toString()
    {
        return "BaseTest [title=" + title + ", testMan=" + testMan
                + ", product=" + product + ", dataupdate=" + dataupdate
                + ", testtime=" + testtime + ", testDescribe=" + testDescribe
                + ", workload=" + workload + ", testExecute=" + testExecute
                + ", pass=" + pass + ", casenumber=" + casenumber + ", newbug="
                + newbug + ", seriousbug=" + seriousbug + ", commonbug="
                + commonbug + ", slightbug=" + slightbug + ", suggestbug="
                + suggestbug + ", conclusion=" + conclusion + ", finishtime="
                + finishtime + ", edition=" + edition + "]";
    }

}