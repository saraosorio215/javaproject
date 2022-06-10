package com.sara.proj.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.sara.proj.models.Income;

@Repository
public interface IncomeRepo extends CrudRepository<Income, Long> {
	List<Income> findAll();
}
