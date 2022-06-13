package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sara.proj.models.Account;
import com.sara.proj.repositories.AccountRepo;

@Service
public class AccountService {
	
	@Autowired
	private AccountRepo acctRepo;
	
	//METHODS
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

