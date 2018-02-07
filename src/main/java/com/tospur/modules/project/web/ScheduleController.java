package com.tospur.modules.project.web;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tospur.common.persistence.Page;
import com.tospur.common.utils.DateUtils;
import com.tospur.common.web.BaseController;
import com.tospur.modules.project.entity.Bug;
import com.tospur.modules.project.entity.Project;
import com.tospur.modules.project.entity.Task;
import com.tospur.modules.project.entity.TaskReport;
import com.tospur.modules.project.service.ProjectService;

/**
 * 项目信息Controller
 * @author kiss
 * @version 2017-02-14
 */
@Controller
@RequestMapping(value = "${adminPath}/project/project")
public class ScheduleController extends BaseController {

	@Autowired
	private ProjectService projectService;

	
	@RequestMapping(value = "projects")
	public String findProjects(Project project, Model model) {
        try {
            List<Map<String,Object>>  projects=projectService.findProjectProcess(project);
            model.addAttribute("projects", projects);
            String username=project.getCreateBy().getName();
           // model.addAttribute("pms", projectService.fundPms());
            model.addAttribute("username", username);
        } catch (Exception e) {
            model.addAttribute("message", "");
        }
        return "modules/schedule/process";
    }
	@RequestMapping(value = "projects-process")
    public String findProjectsProcess(Project project, Model model) {
        try {
            String account=project.getName();
            String workdate=null;
            if(project.getOrderDate()!=null){
                workdate=DateUtils.getDate("yyyy-MM-dd", project.getOrderDate());
            } 
            List<Map<String,Object>>  projects=projectService.findPersonProcess(account, workdate);
            model.addAttribute("projects", projects);
            //String username=project.getName();
            model.addAttribute("username", account);
            model.addAttribute("workdate", workdate);
           // model.addAttribute("pms", projectService.fundPms());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "");
        }
        return "modules/schedule/schedule";
    }
	@RequestMapping(value = "jobs")
    public String findJobs(Task task, HttpServletRequest request, HttpServletResponse response, Model model) {
        try {
           
            Page<Task>  page=projectService.findJobs(new Page<Task>(request, response), task);
            model.addAttribute("page", page);
            model.addAttribute("task", task);
            model.addAttribute("project", projectService.findProjectById(task.getId(),task.getCreateBy().getName()));
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", e.getMessage());
        }
        return "modules/schedule/job";
    }
	
	@RequestMapping(value = "task-report")
    public String taskReport(TaskReport task, HttpServletRequest request, HttpServletResponse response, Model model) {
     try{
            Page<TaskReport>  page=projectService.taskReport(new Page<TaskReport>(request, response), task);
            model.addAttribute("page", page);
            model.addAttribute("task", task);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", e.getMessage());
        }
        return "modules/schedule/taskReportList";
    }
	
	@RequestMapping(value = "bugs")
    public String findBugs(Bug bug, HttpServletRequest request, HttpServletResponse response, Model model) {
        try {
            Page<Bug>  page =projectService.findBugs(new Page<Bug>(request, response),bug);
            model.addAttribute("page", page);
            model.addAttribute("bug", bug);
            model.addAttribute("project", projectService.findProjectById(bug.getId(),bug.getCreateBy().getName()));
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message", "");
        }
        return "modules/schedule/bug";
    }

}