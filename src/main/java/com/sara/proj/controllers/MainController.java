package com.sara.proj.controllers;

import java.util.HashMap;
import java.util.List;

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
import com.sara.proj.services.CategoryService;
import com.sara.proj.services.IncomeService;
import com.sara.proj.services.UserService;

@Controller
public class MainController {
	
	@Autowired
	private BillService billServ;
	
	@Autowired
	private CategoryService catServ;
	
	@Autowired
	private IncomeService incomeServ;
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private AccountService acctServ;
	
	
	@GetMapping("/acct/{id}/")
	public String mainPage(@PathVariable("id") Long id, Model model, HttpSession session) {
		User currUser = userServ.findOneById((Long) session.getAttribute("user_id"));
		Account currAcct = acctServ.findOneById(id);
		model.addAttribute("currAcct", currAcct);
		List<Category> allCats = currUser.getCategories();
		model.addAttribute("allcats", allCats);
		Double totalDue = billServ.totalDue();
		model.addAttribute("totalDue", totalDue);
		Double totalPaid = billServ.totalPaid();
		model.addAttribute("totalPaid", totalPaid);
		Double totalIncome = incomeServ.totalIncome();
		model.addAttribute("totalIncome", totalIncome);
		List<Bill> allBills = currAcct.getBills();
		model.addAttribute("allBills", allBills);
		HashMap<String, Double> currPercent = billServ.moneySpent();
		List<Account> allAccounts = currUser.getAccounts();
		model.addAttribute("allAccounts", allAccounts);
		model.addAttribute("currPercent", currPercent);
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
		Double totalBills = userServ.totalBills(userid);
		model.addAttribute("totalBills", totalBills);
		Double totalIncome = userServ.totalIncome(userid);
		model.addAttribute("totalIncome", totalIncome);
		List<Account> allAccounts = currUser.getAccounts();
		model.addAttribute("allAccounts", allAccounts);
		model.addAttribute("cat", new Category());
		return "overview.jsp";
	}
	
	@GetMapping("/loginreg/")
	public String loginReg(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "loginreg.jsp";
	}
}
