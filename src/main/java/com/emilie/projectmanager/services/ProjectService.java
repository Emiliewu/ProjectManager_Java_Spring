package com.emilie.projectmanager.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.emilie.projectmanager.models.Project;
import com.emilie.projectmanager.models.User;
import com.emilie.projectmanager.repositories.ProjectRepository;
import com.emilie.projectmanager.repositories.TicketRepository;
import com.emilie.projectmanager.repositories.UserRepository;

@Service
public class ProjectService {
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private ProjectRepository projectRepo;
	
	@Autowired
	private TicketRepository ticketRepo;
	
	// find all projects
	public List<Project> findAllProject(){
		return projectRepo.findAll();
	}
	
	// find one project
	public Project findOneProjectById(Long id) {
		Optional<Project> p = projectRepo.findById(id);
		if(p.isPresent()) {
			return p.get();
		} else {
			return null;
		}
	}
	
	// create
	public Project createNewProject(Project p) {
		return projectRepo.save(p);
	}
	
	// update
	public Project updateProject(Project p) {
		return projectRepo.save(p);
	}
	
	// delete
	public void deleteProjectById(Long id) {
		projectRepo.deleteById(id);
	}
	
	// join a project
	public Project joinProject(Long projectId, Long userId) {
		Project p = projectRepo.findById(projectId).orElse(null);
		User u = userRepo.findById(userId).orElse(null);
		List<User> teammembers = p.getTeammembers();
		teammembers.add(u);
		p.setTeammembers(teammembers);
		return projectRepo.save(p);
	}
	
	// leave a project
	public Project leaveProject(Long projectId, Long userId) {
		Project p = projectRepo.findById(projectId).orElse(null);
		User u = userRepo.findById(userId).orElse(null);
		List<User> teammembers = p.getTeammembers();
		teammembers.remove(u);
		p.setTeammembers(teammembers);
		return projectRepo.save(p);
	}
	
}
