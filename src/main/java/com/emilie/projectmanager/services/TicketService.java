package com.emilie.projectmanager.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.emilie.projectmanager.models.Project;
import com.emilie.projectmanager.models.Ticket;
import com.emilie.projectmanager.models.User;
import com.emilie.projectmanager.repositories.ProjectRepository;
import com.emilie.projectmanager.repositories.TicketRepository;
import com.emilie.projectmanager.repositories.UserRepository;

@Service
public class TicketService {
	@Autowired
	UserRepository userRepo;
	
	@Autowired
	ProjectRepository projectRepo;
	
	@Autowired
	TicketRepository ticketRepo;
	
	// find all ticket
	public List<Ticket> findAllTicket() {
		return ticketRepo.findAll();
	}
	
	// find one ticket
	public Ticket findOneTicketById(Long id) {
		Optional<Ticket> t = ticketRepo.findById(id);
		if(t.isPresent()) {
			return t.get();
		} else {
			return null;
		}
	}
	// find all ticket of one project
	public List<Ticket> findprojectticket(Long projectId) {
		return ticketRepo.findAllByProject_idEquals(projectId);
	}
	// create
	public Ticket createNewTicket(Ticket t, Long projectId, Long userId) {
		User u = userRepo.findById(userId).get();
		Project p= projectRepo.findById(projectId).get();
		t.setTicketowner(u);
		t.setProject(p);		
		return ticketRepo.save(t);
	}
	
	// update
	public Ticket updateTicket(Ticket t) {
		return ticketRepo.save(t);
	}
	
	// delete
	public void deleteTicketById(Long id) {
		ticketRepo.deleteById(id);
	}
	

}
