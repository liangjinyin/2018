package com.tospur.modules.statistics.web;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tospur.common.web.BaseController;
import com.tospur.modules.statistics.entity.EmployeeLoad;
import com.tospur.modules.statistics.entity.IterationTask;
import com.tospur.modules.statistics.entity.ProductIteration;
import com.tospur.modules.statistics.entity.TaskCollect;
import com.tospur.modules.statistics.service.StatisticsService;
import com.tospur.modules.task.entity.TaskInfo;

/**
 * 统计Controller
 * @author
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/statistics/statistics")
public class StatisticsController extends BaseController {

	@Autowired
	private StatisticsService statisticsService;

	
	@RequestMapping(value = "productIteration")
	public String findproductIterations(Model model, String product, Date beginTime, Date endTime ) {
        try {
            List<ProductIteration> productIterations = statisticsService.findAllList(product, beginTime, endTime);
            model.addAttribute("productIterations", productIterations);
            model.addAttribute("product", product);
            model.addAttribute("beginTime", beginTime);
            model.addAttribute("endTime", endTime);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "产品迭代统计信息获取失败");
        }
        return "modules/statistics/productIteration";
    }
	
	
	@RequestMapping(value = "taskCollect")
	public String findtaskCollects(Model model, Date finishedDate){
	    try{
	        List<TaskCollect> taskCollects = statisticsService.findTaskCollectList(finishedDate);
	        model.addAttribute("taskCollects", taskCollects);
	        model.addAttribute("finishedDate", finishedDate);
	    }catch(Exception e){
	        e.printStackTrace();
	        model.addAttribute("message", "任务汇总统计信息获取失败");
	    }
	    return "modules/statistics/taskCollect";
	}
	
	
	@RequestMapping(value = "employeeLoad")
	public String findemployeeLoads(Model model, String name, Date beginTime, Date endTime){
	    try
        {
            List<EmployeeLoad> employeeLoads = statisticsService.findEmployeeLoadList(name, beginTime, endTime);
            for (EmployeeLoad employeeLoad : employeeLoads)
            {
                int taskTotal = 0;
                double timeTotal = 0;
                for (IterationTask iterationTask : employeeLoad.getIterationTasks())
                {
                    double time = 0;
                    iterationTask.setTaskNum(iterationTask.getTaskInfos().size());
                    for (TaskInfo taskInfo : iterationTask.getTaskInfos())
                    {
                        if(taskInfo.getSurplus() == 0){
                            time += taskInfo.getEstimate();
                        }else{
                            time += taskInfo.getSurplus();
                        }
                    }
                   iterationTask.setTimeNum(time);
                   taskTotal += iterationTask.getTaskNum();
                   timeTotal += iterationTask.getTimeNum();
                }
                employeeLoad.setTaskTotal(taskTotal);
                employeeLoad.setTimeTotal(timeTotal);
            }
            model.addAttribute("employeeLoads", employeeLoads);
            model.addAttribute("name", name);
            model.addAttribute("beginTime", beginTime);
            model.addAttribute("endTime", endTime);
        }
        catch (Exception e)
        {
            e.printStackTrace();
            model.addAttribute("message", "员工负载统计信息获取失败");
        }
	    return "modules/statistics/employeeLoad";
	}
	

}