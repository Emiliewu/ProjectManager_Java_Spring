package com.emilie.projectmanager.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.emilie.projectmanager.models.Project;
import com.emilie.projectmanager.models.Ticket;
import com.emilie.projectmanager.models.User;
import com.emilie.projectmanager.services.ProjectService;
import com.emilie.projectmanager.services.TicketService;
import com.emilie.projectmanager.services.UserService;

@Controller
public class ProjectController {
	
	@Autowired
	UserService userServ;
	
	@Autowired
	ProjectService projectServ;
	
	@Autowired
	TicketService ticketServ;
	
	//****** all projects ******
	@GetMapping("/dashboard")
	public String projectDashboard(Model model, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		} else {			
			User user = userServ.findUserById(userId);
			List<Project> allprojects = projectServ.findAllProject();
			model.addAttribute("allprojects", allprojects);
			model.addAttribute("user", user);
			return "dashboard.jsp";
		}
	}
	
	//****** create new project ******
	@GetMapping("/projects/new")
	public String projectNew(HttpSession session, Model model) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		String todaydate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).format(new Date());
		Project newproject = new Project();
		model.addAttribute("newproject", newproject);
		model.addAttribute("todaydate", todaydate);
		return "newproject.jsp";
	}
	@PostMapping("/projects/create")
	public String createNewProject(@Valid @ModelAttribute("newproject") Project newproject, BindingResult result, HttpSession session, RedirectAttributes redirAttrs) {
		Long userId = (Long)session.getAttribute("user_id");
		if(result.hasErrors()) {
			return "newproject.jsp";
		} else {
			//as on jsp page already have setup a min value to prevent user enter a date before today,
			// the validation of the flash message will not be shown
			// either way works
			java.util.Date nowdate=new java.util.Date();
			java.util.Date d = newproject.getDuedate();
			System.out.println(d);
		    if(d.before(nowdate)) {
		    	 System.out.println("The due date must be after today");
		    	 redirAttrs.addFlashAttribute("duedateerror", "The due date must be after today");
		    	 return "redirect:/projects/new";
		    }
			newproject.setOwner(userServ.findUserById(userId));
			projectServ.createNewProject(newproject);
			return "redirect:/dashboard";
		}
	}
	
	//****** edit project ******
	@GetMapping("/projects/edit/{id}")
	public String editProject(Model model, HttpSession session, @PathVariable("id") Long projectId) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		User user = userServ.findUserById(userId);
		Project editproject = projectServ.findOneProjectById(projectId);
		model.addAttribute("user", user);
		model.addAttribute("editproject", editproject);
		String todaydate = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).format(new Date());
		model.addAttribute("todaydate", todaydate);
		return "editproject.jsp";
	}
	@PutMapping("/projects/update/{id}")
	public String updateProject(@Valid @ModelAttribute("editproject") Project editproject, BindingResult result, HttpSession session, RedirectAttributes redirAttrs) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "editroject.jsp";
		} else {
			//as on jsp page already have setup a min value to prevent user enter a date before today,
			// the validation of the flash message will not be shown
			// either way works
			java.util.Date nowdate=new java.util.Date();
			java.util.Date d = editproject.getDuedate();
			System.out.println(d);
		    if(d.before(nowdate)) {
		    	 System.out.println("The due date must be after today");
		    	 redirAttrs.addFlashAttribute("duedateerror", "The due date must be after today");
		    	 return "redirect:/projects/new";
		    }
		projectServ.updateProject(editproject);
		return "redirect:/dashboard";
		}
	}
	
	//****** project detail ******
	@GetMapping("/projects/{id}")
	public String projectDetail(Model model, HttpSession session, @PathVariable("id") Long projectId) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		User user = userServ.findUserById(userId);
		Project projectDetail = projectServ.findOneProjectById(projectId);
		model.addAttribute("projectDetail", projectDetail);
		model.addAttribute("user", user);
		return "projectdetail.jsp";
	}
	
	//****** add a ticket ******
	//****** only the team leader and team members can add a task ticket ***/
	@GetMapping("/projects/{id}/tasks")
	public String projectTickets(Model model, HttpSession session, @PathVariable("id") Long projectId) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		User user = userServ.findUserById(userId);
		Project projectDetail = projectServ.findOneProjectById(projectId);
		List<Ticket> tickets = ticketServ.findprojectticket(projectId);
		Ticket newticket = new Ticket();
		model.addAttribute("newticket", newticket);
		model.addAttribute("projectDetail", projectDetail);
		model.addAttribute("user", user);
		model.addAttribute("tickets", tickets);
		return "newticket.jsp";
	}
	@PostMapping("/projects/{id}/tasks/new")
	public String newTicket(@Valid @ModelAttribute("newticket") Ticket newticket, BindingResult result, HttpSession session, @PathVariable("id") Long projectId) {
		System.out.println(newticket.getId());
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		if(result.hasErrors()) {
			return "newticket.jsp";
		} else {
			ticketServ.createNewTicket(newticket, projectId, userId);
			return "redirect:/projects/"+projectId+"/tasks";
		}
	}
	
	//****** delete a project ******
	@GetMapping("/projects/{id}/delete")
	public String deleteProject(@PathVariable("id") Long projectId, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		User user = userServ.findUserById(userId);
		Project project = projectServ.findOneProjectById(projectId);
		if(project.getOwner().getId()==user.getId()) {
			projectServ.deleteProjectById(projectId);
		}
		return "redirect:/dashboard";
	}
	
	//****** join a project ******
	@GetMapping("/projects/{id}/join")
	public String joinProject(@PathVariable("id") Long projectId, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		projectServ.joinProject(projectId, userId);
		return "redirect:/dashboard";
	}
	
	//****** leave a project ******
	@GetMapping("/projects/{id}/leave")
	public String leaveProject(@PathVariable("id") Long projectId, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		projectServ.leaveProject(projectId, userId);
		return "redirect:/dashboard";
	}
	
	//******* delete a task *******
	@GetMapping("/projects/{projectid}/tasks/{taskid}/delete")
	public String deleteTask(@PathVariable("projectid") Long projectId, @PathVariable("taskid") Long taskid, HttpSession session) {
		Long userId = (Long)session.getAttribute("user_id");
		if(userId == null ) {
			return "redirect:/";
		}
		User user = userServ.findUserById(userId);
		Ticket t = ticketServ.findOneTicketById(taskid);
		Project p = projectServ.findOneProjectById(projectId);
		if(t.getTicketowner().getId()==user.getId() || p.getTeammembers().contains(user)) {
			ticketServ.deleteTicketById(taskid);
		}
		return "redirect:/projects/" + projectId + "/tasks";
	}
	
	// Date format
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(true);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }
}
