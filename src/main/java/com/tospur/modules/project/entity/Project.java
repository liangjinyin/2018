package com.tospur.modules.project.entity;


import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Range;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.tospur.common.persistence.DataEntity;
import com.tospur.common.utils.excel.annotation.ExcelField;

/**
 * 项目信息Entity
 * @author kiss
 * @version 2017-02-15
 */
public class Project extends DataEntity<Project> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 项目名称
	private String requirements;		// 对应需求
	private String saleManager;		// 销售负责人
	private String preSaleManager;		// 售前负责人
	private String area;		// 项目区域
	private String type;		// 项目类型
	private String budget;		// 项目预算
	private String bid;		// 是否投标
	private Date coreDate;		// 项目关键时间点
	private String department;		// 需求部门
	private String decisionProcess;		// 决策流程
	private String decisionManager;		// 决策人(电话)
	private String coreManager;		// 关键人(电话)
	private String majorManager;		// 项目干系人
	private String relationship;		// 是否有内线 ，1 是 0 否
	private String stage;		// 项目所处阶段
	private String competitor;		// 竞争对手及动态
	private Date orderDate;		// 预计下单时间
	private Integer orderRate;		// 预计下单几率
	private String advanceService;		// 是否提前投入，1 是 0 否
	private String projectRisk;		// 项目风险
	private String copingStrategies;		// 应对策略
	private Date signingTime;		// 签约时间
	private String contractAmount;		// 合同金额
	private String remark;		// 备注
	private String saleStage; //销售阶段
	private String state;    //项目状态
	private String quotation;  //我方对外报价金额
	private String cost; //我方成本金额
	private String projectManager; //项目经理
	private String [] managers;
	private List<ProjectLog> logs=Lists.newArrayList();
	
	public String[] getManagers()
    {
        return managers;
    }

    public void setManagers(String[] managers)
    {
        this.managers = managers;
    }
    
    public List<ProjectLog> getLogs()
    {
        return logs;
    }

    public void setLogs(List<ProjectLog> logs)
    {
        this.logs = logs;
    }

    public Project() {
		super();
	}

	public Project(String id){
		super(id);
	}

	@ExcelField(title="项目名称", align=2, sort=1)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@ExcelField(title="对应需求", dictType="", align=2, sort=2)
	public String getRequirements() {
		return requirements;
	}

	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}
	
	//(min=1, max=64, message="销售负责人长度必须介于 1 和 64 之间")
	@ExcelField(title="销售负责人", align=2, sort=3)
	public String getSaleManager() {
		return saleManager;
	}

	public void setSaleManager(String saleManager) {
		this.saleManager = saleManager;
	}
	
	//(min=1, max=64, message="售前负责人长度必须介于 1 和 64 之间")
	@ExcelField(title="售前负责人", align=2, sort=4)
	public String getPreSaleManager() {
		return preSaleManager;
	}

	public void setPreSaleManager(String preSaleManager) {
		this.preSaleManager = preSaleManager;
	}
	
	//(min=0, max=64, message="项目区域长度必须介于 0 和 64 之间")
	@ExcelField(title="项目区域", align=2, sort=5)
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}
	
	//(min=0, max=64, message="项目类型长度必须介于 0 和 64 之间")
	@ExcelField(title="项目类型", dictType="", align=2, sort=6)
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	//(min=0, max=64, message="项目预算长度必须介于 0 和 64 之间")
	@ExcelField(title="项目预算", align=2, sort=7)
	public String getBudget() {
		return budget;
	}

	public void setBudget(String budget) {
		this.budget = budget;
	}
	
	//(min=0, max=64, message="是否投标长度必须介于 0 和 64 之间")
	@ExcelField(title="是否投标", align=2, sort=8)
	public String getBid() {
		return bid;
	}

	public void setBid(String bid) {
		this.bid = bid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="项目关键时间点不能为空")
	@ExcelField(title="项目关键时间点", align=2, sort=9)
	public Date getCoreDate() {
		return coreDate;
	}

	public void setCoreDate(Date coreDate) {
		this.coreDate = coreDate;
	}
	
	//(min=0, max=64, message="需求部门长度必须介于 0 和 64 之间")
	@ExcelField(title="需求部门", align=2, sort=10)
	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}
	
	//(min=0, max=500, message="决策流程长度必须介于 0 和 11 之间")
	@ExcelField(title="决策流程", align=2, sort=11)
	public String getDecisionProcess() {
		return decisionProcess;
	}

	public void setDecisionProcess(String decisionProcess) {
		this.decisionProcess = decisionProcess;
	}
	
	//(min=0, max=11, message="决策人(电话)长度必须介于 0 和 11 之间")
	@ExcelField(title="决策人(电话)", align=2, sort=12)
	public String getDecisionManager() {
		return decisionManager;
	}

	public void setDecisionManager(String decisionManager) {
		this.decisionManager = decisionManager;
	}
	
	//(min=0, max=11, message="关键人(电话)长度必须介于 0 和 11 之间")
	@ExcelField(title="关键人(电话)", align=2, sort=13)
	public String getCoreManager() {
		return coreManager;
	}

	public void setCoreManager(String coreManager) {
		this.coreManager = coreManager;
	}
	
	//(min=0, max=500, message="项目干系人长度必须介于 0 和 500 之间")
	@ExcelField(title="项目干系人", align=2, sort=14)
	public String getMajorManager() {
	    if(managers!=null){
            for (String s : managers)
            {
                majorManager+=s+",";
           }
	    }
		return majorManager;
	}

	public void setMajorManager(String majorManager) {
		this.majorManager = majorManager;
	}
	
	//(min=0, max=11, message="是否有内线 ，1 是 0 否长度必须介于 0 和 11 之间")
	@ExcelField(title="是否有内线 ", align=2, sort=15)
	public String getRelationship() {
		return relationship;
	}

	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	
	//(min=0, max=500, message="项目所处阶段长度必须介于 0 和 11 之间")
	@ExcelField(title="项目所处阶段", align=2, sort=16)
	public String getStage() {
		return stage;
	}

	public void setStage(String stage) {
		this.stage = stage;
	}
	
	//(min=0, max=500, message="竞争对手及动态长度必须介于 0 和 500 之间")
	@ExcelField(title="竞争对手及动态", align=2, sort=17)
	public String getCompetitor() {
		return competitor;
	}

	public void setCompetitor(String competitor) {
		this.competitor = competitor;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="预计下单时间", align=2, sort=18)
	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	
	@Range(max=100, min=0, message="预计下单几率应为0-100的数字")
	@ExcelField(title="预计下单几率(%)", sort=19)
	public Integer getOrderRate() {
		return orderRate;
	}

	public void setOrderRate(Integer orderRate) {
		this.orderRate = orderRate;
	}
	
	@ExcelField(title="是否提前投入", align=2, sort=20)
	public String getAdvanceService() {
		return advanceService;
	}

	public void setAdvanceService(String advanceService) {
		this.advanceService = advanceService;
	}
	
	//(min=0, max=500, message="项目风险长度必须介于 0 和 500 之间")
	@ExcelField(title="项目风险", align=2, sort=21)
	public String getProjectRisk() {
		return projectRisk;
	}

	public void setProjectRisk(String projectRisk) {
		this.projectRisk = projectRisk;
	}
	
	//(min=0, max=500, message="应对策略长度必须介于 0 和 500 之间")
	@ExcelField(title="应对策略", align=2, sort=22)
	public String getCopingStrategies() {
		return copingStrategies;
	}

	public void setCopingStrategies(String copingStrategies) {
		this.copingStrategies = copingStrategies;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="签约时间", align=2, sort=23)
	public Date getSigningTime() {
		return signingTime;
	}

	public void setSigningTime(Date signingTime) {
		this.signingTime = signingTime;
	}
	
	@ExcelField(title="合同金额(万)", align=2, sort=24)
	public String getContractAmount() {
		return contractAmount;
	}

	public void setContractAmount(String contractAmount) {
		this.contractAmount = contractAmount;
	}
	
	//(min=0, max=50000, message="备注长度必须介于 0 和 500 之间")
	@ExcelField(title="备注", align=2, sort=30)
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@ExcelField(title="销售阶段", align=2, sort=28)
    public String getSaleStage()
    {
        return saleStage;
    }

    public void setSaleStage(String saleStage)
    {
        this.saleStage = saleStage;
    }

    @ExcelField(title="项目状态", align=2, sort=27)
    public String getState()
    {
        return state;
    }

    public void setState(String state)
    {
        this.state = state;
    }

    @ExcelField(title="我方对外报价金额(万)", align=2, sort=26)
    public String getQuotation()
    {
        return quotation;
    }

    public void setQuotation(String quotation)
    {
        this.quotation = quotation;
    }

    @ExcelField(title="我方成本金额(万)", align=2, sort=25)
    public String getCost()
    {
        return cost;
    }

    public void setCost(String cost)
    {
        this.cost = cost;
    }

    @ExcelField(title="项目经理", align=2, sort=29)
    public String getProjectManager()
    {
        return projectManager;
    }

    public void setProjectManager(String projectManager)
    {
        this.projectManager = projectManager;
    }

    @Override
    public String toString()
    {
        return "Project [name=" + name + ", requirements=" + requirements
                + ", saleManager=" + saleManager + ", preSaleManager="
                + preSaleManager + ", area=" + area + ", type=" + type
                + ", budget=" + budget + ", bid=" + bid + ", coreDate="
                + coreDate + ", department=" + department + ", decisionProcess="
                + decisionProcess + ", decisionManager=" + decisionManager
                + ", coreManager=" + coreManager + ", majorManager="
                + majorManager + ", relationship=" + relationship + ", stage="
                + stage + ", competitor=" + competitor + ", orderDate="
                + orderDate + ", orderRate=" + orderRate + ", advanceService="
                + advanceService + ", projectRisk=" + projectRisk
                + ", copingStrategies=" + copingStrategies + ", signingTime="
                + signingTime + ", contractAmount=" + contractAmount
                + ", remark=" + remark + ", saleStage=" + saleStage + ", state="
                + state + ", quotation=" + quotation + ", cost=" + cost
                + ", projectManager=" + projectManager + ", managers="
                + Arrays.toString(managers) + ", logs=" + logs + "]";
    }
	
    
}