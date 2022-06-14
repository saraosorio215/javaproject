package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.sara.proj.models.Account;
import com.sara.proj.models.Bill;
import com.sara.proj.models.Category;
import com.sara.proj.models.Income;
import com.sara.proj.models.LoginUser;
import com.sara.proj.models.User;
import com.sara.proj.repositories.BillRepo;
import com.sara.proj.repositories.CategoryRepo;
import com.sara.proj.repositories.UserRepo;

@Service
public class UserService {
	
	@Autowired
	private UserRepo userRepo;

	
	//METHODS
	public Double totalBills(Long id) {
		List<Category> allCats = userRepo.findById(id).get().getCategories();
		Double total = 0.0;
		for(int i=0; i<allCats.size(); i++) {
			List<Bill> allBills = allCats.get(i).getBills();
			for(int j=0; j<allBills.size(); j++) {
				total += allBills.get(i).getAmount();
			}
		}
		return total;
	}
	
	public Double totalIncome(Long id) {
		List<Account> allAccts = userRepo.findById(id).get().getAccounts();
		Double total = 0.0;
		for(int i=0; i<allAccts.size(); i++) {
			List<Income> allIncome = allAccts.get(i).getIncomes();
			for(int j=0; j<allIncome.size(); j++) {
				total += allIncome.get(i).getAmount();
			}
		}
		return total;
	}
	
	//FIND ALL
	public List<User> allUsers() {
		return userRepo.findAll();
	}
	
	//FIND ONE
	public User findOneById(Long id) {
		Optional<User> optionalUser = userRepo.findById(id);
		if(optionalUser.isPresent()) {
			return optionalUser.get();
		}
		else {
			return null;
		}
	}
	
	//CREATE
	public User registerUser(User newUser, BindingResult result) {
		String email = newUser.getEmail();
		Optional<User> potentialUser = userRepo.findByEmail(email);
		if(potentialUser.isPresent()) {
			result.rejectValue("email", "registerErrors", "Registration information not valid");
		}
		if(!newUser.getPassword().equals(newUser.getConfirm())) {
			result.rejectValue("confirm", "registerErrors", "Passwords must match");
		}
		if(result.hasErrors()) {
			return null;
		}
		else {
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);
			return userRepo.save(newUser);
		}
	}
	
	//LOGIN
	public User loginUser(LoginUser newLogin, BindingResult result) {
		Optional<User> currentUser = userRepo.findByEmail(newLogin.getEmail());
		if(!currentUser.isPresent()) {
			result.rejectValue("email", "loginErrors", "Login information incorrect");
		}
		else {
			User user = currentUser.get();
			if(!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
				result.rejectValue("password", "loginErrors", "Login information incorrect");
			}
			if(result.hasErrors()) {
				return null;
			}
			else {
				return user;
			}
		}
		return null;
	}
	
	
	//UPDATE
	public User updateUser(User user) {
		return userRepo.save(user);
	}
	
	//DELETE
	public void deleteUser(Long id) {
		userRepo.deleteById(id);
		return;
	}
}
