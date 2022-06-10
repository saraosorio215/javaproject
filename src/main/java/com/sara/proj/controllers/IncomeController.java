package com.sara.proj.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Income;
import com.sara.proj.services.IncomeService;

@Controller
public class IncomeController {
	
	@Autowired
	private IncomeService incomeServ;
	
	//POST METHOD
	@PostMapping("/new/income/")
	public String newIncome(@Valid @ModelAttribute("income") Income income, BindingResult result) {
		if(result.hasErrors()) {
			return "main.jsp";
		}
		else {
			incomeServ.createIncome(income);
			return "redirect:/";
		}
	}
}
