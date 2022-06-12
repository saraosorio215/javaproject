package com.sara.proj.controllers;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.sara.proj.models.Bill;
import com.sara.proj.models.Category;
import com.sara.proj.models.Income;
import com.sara.proj.services.BillService;
import com.sara.proj.services.CategoryService;
import com.sara.proj.services.IncomeService;

@Controller
public class MainController {
	
	@Autowired
	private BillService billServ;
	
	@Autowired
	private CategoryService catServ;
	
	@Autowired
	private IncomeService incomeServ;
	
	
	
	@GetMapping("/")
	public String mainPage(@ModelAttribute("bill") Bill bill, @ModelAttribute("cat") Category cat, @ModelAttribute("income") Income income, Model model) {
		List<Category> allCats = catServ.allCategories();
		model.addAttribute("allcats", allCats);
		Double totalDue = billServ.totalDue();
		model.addAttribute("totalDue", totalDue);
		Double totalPaid = billServ.totalPaid();
		model.addAttribute("totalPaid", totalPaid);
		Double totalIncome = incomeServ.totalIncome();
		model.addAttribute("totalIncome", totalIncome);
		List<Bill> allBills = billServ.allBills();
		model.addAttribute("allBills", allBills);
		HashMap<String, Double> currPercent = billServ.moneySpent();
		model.addAttribute("currPercent", currPercent);
		return "main.jsp";
	}
}
