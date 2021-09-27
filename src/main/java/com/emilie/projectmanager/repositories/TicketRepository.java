package com.emilie.projectmanager.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.emilie.projectmanager.models.Project;
import com.emilie.projectmanager.models.Ticket;

@Repository
public interface TicketRepository extends CrudRepository<Ticket, Long> {
	List<Ticket> findAll();
	List<Ticket> findAllByProject_idEquals(Long id);
}
