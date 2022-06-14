package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sara.proj.models.Account;
import com.sara.proj.models.Bill;
import com.sara.proj.models.Income;
import com.sara.proj.repositories.AccountRepo;

@Service
public class AccountService {
	
	@Autowired
	private AccountRepo acctRepo;
	
	//METHODS
	public Double totalIncome(Long id) {
		Double totalIncome = 0.0;
		List<Income> allIncome = acctRepo.findById(id).get().getIncomes();
		for(int i=0; i<allIncome.size(); i++) {
			totalIncome += allIncome.get(i).getAmount();
		}
		return totalIncome;
	}
	
	public Double totalDue(Long id) {
		Double totalAmt = 0.0;
		List<Bill> allBills = acctRepo.findById(id).get().getBills();
		for(int i=0; i<allBills.size(); i++) {
			if(allBills.get(i).getIsPaid() == false) {
				totalAmt += allBills.get(i).getAmount();				
			}
		}
		return totalAmt;
	}
	
	public Double totalPaid(Long id) {
		Double totalAmt = 0.0;
		List<Bill> allBills = acctRepo.findById(id).get().getBills();
		for(int i=0; i<allBills.size(); i++) {
			if(allBills.get(i).getIsPaid() == true) {
				totalAmt += allBills.get(i).getAmount();				
			}
		}
		return totalAmt;
	}
	
	
	//FIND ALL
	public List<Account> allAccounts(){
		return acctRepo.findAll();
	}
	
	//FIND ONE
	public Account findOneById(Long id) {
		Optional<Account> optionalAccount = acctRepo.findById(id);
		if(optionalAccount.isPresent()) {
			return optionalAccount.get();
		}
		else {
			return null;
		}
	}
	
	//CREATE
	public Account createAccount(Account acct) {
		return acctRepo.save(acct);
	}
	
	//UPDATE
	public Account updateAccount(Account acct) {
		return acctRepo.save(acct);
	}
	
	//DELETE
	public void deleteAccount(Long id) {
		acctRepo.deleteById(id);
		return;
	}
}

