package com.tospur.modules.niche.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.tospur.common.persistence.Page;
import com.tospur.common.web.BaseController;
import com.tospur.modules.niche.entity.InvestmentInfo;
import com.tospur.modules.niche.service.InvestmentInfoService;

/**
 * 招标信息Controller
 * @author canyu
 * @version 2016-08-12
 */
@Controller
@RequestMapping(value = "${adminPath}/niche/investmentInfo")
public class InvestmentInfoController extends BaseController {

	@Autowired
	private InvestmentInfoService investmentInfoService;
	
	/**
	 * 招标信息列表页面
	 */
	@RequiresPermissions("niche:investmentInfo:list")
	@RequestMapping(value = {"list", ""})
	public String list(InvestmentInfo investmentInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InvestmentInfo> page = investmentInfoService.findPage(new Page<InvestmentInfo>(request, response), investmentInfo);
		model.addAttribute("page", page);
		return "modules/niche/investmentInfoList";
	}
	/**
     * 招标信息录入
     * 
     *  #{programName},
        #{projectType},
        #{url},
        #{time},
        #{content},
        #{trade},
        #{companyBelong}
     */
    @RequestMapping(value = "save")///niche/investmentInfo/save
    @ResponseBody
    public JSONObject save(InvestmentInfo investmentInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        JSONObject data= new JSONObject();
        try
        {
            investmentInfoService.save(investmentInfo);
            data.put("msg", "保存成功");
            data.put("success", true);
        }
        catch (Exception e)
        {
            data.put("msg", e.getMessage());
            data.put("success", false);
            e.printStackTrace();
        }
        return data;
    }

}