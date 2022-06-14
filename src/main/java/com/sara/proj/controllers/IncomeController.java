package com.sara.proj.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Account;
import com.sara.proj.models.Bill;
import com.sara.proj.models.Income;
import com.sara.proj.services.AccountService;
import com.sara.proj.services.IncomeService;

@Controller
public class IncomeController {
	
	@Autowired
	private IncomeService incomeServ;
	
	@Autowired
	private AccountService acctServ;
	
	//POST METHOD
	@PostMapping("/new/income/")
	public String newIncome(@Valid @ModelAttribute("income") Income income, BindingResult result, Model model) {
		if(result.hasErrors()) {
			model.addAttribute("bill", new Bill());
			return "main.jsp";
		}
		else {
			incomeServ.createIncome(income);
			Account acct = income.getAccount();
			acct.getIncomes().add(income);
			acctServ.updateAccount(acct);
			Long id = acct.getId();
			return "redirect:/acct/" + id + "/";
		}
	}
}
