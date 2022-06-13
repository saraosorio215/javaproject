package com.sara.proj.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.LoginUser;
import com.sara.proj.models.User;
import com.sara.proj.services.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userServ;
	
	//GET MAPPING
	@GetMapping("/logout/")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/loginreg/";
	}
	
	
	//POST MAPPING
	@PostMapping("/register/")
	public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, Model model, HttpSession session) {
		userServ.registerUser(newUser, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "loginreg.jsp";
		}
		else {
			session.setAttribute("user_id", newUser.getId());
			return "redirect:/overview/";
		}
	}
	
	@PostMapping("/login/")
	public String loginUser(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		User user = userServ.loginUser(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "loginreg.jsp";
		}
		else {
			session.setAttribute("user_id", user.getId());
			return "redirect:/overview/";
		}
	}
}
