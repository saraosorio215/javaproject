package com.sara.proj.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.sara.proj.models.Bill;

@Repository
public interface BillRepo extends CrudRepository<Bill, Long> {
	
	List<Bill> findAll();
}
