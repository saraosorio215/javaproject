package com.sara.proj.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Category;
import com.sara.proj.services.CategoryService;

@Controller
public class CatController {

	@Autowired
	private CategoryService catServ;
	
	//POST METHOD
	@PostMapping("/new/cat/")
	public String createCat(@Valid @ModelAttribute("cat") Category cat, BindingResult result) {
		if(result.hasErrors()) {
			return "main.jsp";
		}
		else {
			catServ.createCat(cat);
			return "redirect:/";
		}
	}
}
