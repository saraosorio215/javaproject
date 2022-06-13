package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.sara.proj.models.LoginUser;
import com.sara.proj.models.User;
import com.sara.proj.repositories.UserRepo;

@Service
public class UserService {
	
	@Autowired
	private UserRepo userRepo;
	
	//METHODS
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
