package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sara.proj.models.Income;
import com.sara.proj.repositories.IncomeRepo;

@Service
public class IncomeService {
	
	@Autowired
	private final IncomeRepo incomeRepo;
	
	//CONSTRUCTOR
	public IncomeService(IncomeRepo incomeRepo) {
		this.incomeRepo = incomeRepo;
	}
	
	//METHODS
	//FIND ALL
	public List<Income> allIncome(){
		return incomeRepo.findAll();
	}
	
	//FIND ONE
	public Income findById(Long id) {
		Optional<Income> optionalIncome = incomeRepo.findById(id);
		if(optionalIncome.isPresent()) {
			return optionalIncome.get();
		}
		else {
			return null;
		}
	}
	
	//CREATE
	public Income createIncome(Income income) {
		return incomeRepo.save(income);
	}
	
	//UPDATE
	public Income updateIncome(Income income) {
		return incomeRepo.save(income);
	}
	
	//DELETE
	public void deleteIncome(Long id) {
		incomeRepo.deleteById(id);
		return;
	}
}
