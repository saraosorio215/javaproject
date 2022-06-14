package com.sara.proj.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Category;
import com.sara.proj.models.User;
import com.sara.proj.services.CategoryService;
import com.sara.proj.services.UserService;

@Controller
public class CatController {

	@Autowired
	private CategoryService catServ;
	
	@Autowired
	private UserService userServ;
	
	//POST METHOD
	@PostMapping("/new/cat/")
	public String createCat(@Valid @ModelAttribute("cat") Category cat, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "main.jsp";
		}
		else {
			User currUser = userServ.findOneById((Long) session.getAttribute("user_id"));
			cat.setUser(currUser);
			catServ.createCat(cat);
			return "redirect:/overview/";
		}
	}
}
