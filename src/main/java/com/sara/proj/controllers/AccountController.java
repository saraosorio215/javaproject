package com.sara.proj.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Account;
import com.sara.proj.models.User;
import com.sara.proj.services.AccountService;
import com.sara.proj.services.UserService;

@Controller
public class AccountController {

	@Autowired
	private AccountService acctServ;

	@Autowired
	private UserService userServ;
	
	//POST MAPPING
	@PostMapping("/new/account/")
	public String newAccount(@Valid @ModelAttribute("newAccount") Account account, BindingResult result, HttpSession session) {
		if(result.hasErrors()) {
			return "overview.jsp";
		}
		else {
			User currUser = userServ.findOneById((Long) session.getAttribute("user_id"));
			account.setUser(currUser);
			acctServ.createAccount(account);
			return "redirect:/overview/";
		}
	}
	
	//DELETE MAPPING

}
