package com.sara.proj.controllers;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.sara.proj.models.Account;
import com.sara.proj.models.Bill;
import com.sara.proj.models.Category;
import com.sara.proj.models.Income;
import com.sara.proj.models.LoginUser;
import com.sara.proj.models.User;
import com.sara.proj.services.AccountService;
import com.sara.proj.services.BillService;
import com.sara.proj.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private BillService billServ;
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private AccountService acctServ;
	
	
	@GetMapping("/acct/{id}/")
	public String mainPage(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long user_id = (Long) session.getAttribute("user_id");
		User currUser = userServ.findOneById(user_id);
		Account currAcct = acctServ.findOneById(id);
		model.addAttribute("currAcct", currAcct);
		model.addAttribute("allcats", currUser.getCategories());
		model.addAttribute("totalDue", acctServ.totalDue(id));
		model.addAttribute("totalPaid", acctServ.totalPaid(id));
		model.addAttribute("totalIncome", acctServ.totalIncome(id));
		model.addAttribute("allBills", currAcct.getBills());
		model.addAttribute("allAccounts", currUser.getAccounts());
		model.addAttribute("currPercent", billServ.moneySpent(id, user_id));
		model.addAttribute("income", new Income());
		model.addAttribute("bill", new Bill());
		return "main.jsp";
	}
	
	
	@GetMapping("/overview/")
	public String overview(Model model, HttpSession session) {
		Long userid = (Long) session.getAttribute("user_id");
		User currUser = userServ.findOneById(userid);
		model.addAttribute("currUser", currUser);
		model.addAttribute("newAccount", new Account());
		model.addAttribute("totalIncome", userServ.totalIncome(userid));
		model.addAttribute("totalBills", userServ.totalBills(userid));
		model.addAttribute("allAccounts", currUser.getAccounts());
		model.addAttribute("allCats", currUser.getCategories());
		model.addAttribute("cat", new Category());
		return "overview.jsp";
	}
	
	@GetMapping("/")
	public String loginReg(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "loginreg.jsp";
	}
}
