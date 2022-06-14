package com.sara.proj.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Account;
import com.sara.proj.models.Bill;
import com.sara.proj.models.Income;
import com.sara.proj.services.AccountService;
import com.sara.proj.services.BillService;

@Controller
public class BillController {
	
	@Autowired
	private BillService billServ;
	
	@Autowired
	private AccountService acctServ;
	
	//GET METHOD
	@GetMapping("/paid/{id}/")
	public String payBill(@PathVariable("id") Long id) {
		Bill currBill = billServ.findById(id);
		currBill.setIsPaid(true);
		billServ.updateBill(currBill);
		Long newId = currBill.getAccount().getId();
		return "redirect:/acct/" + newId + "/";
	}
	
	@GetMapping("/unpaid/{id}/")
	public String unpayBill(@PathVariable("id") Long id) {
		Bill currBill = billServ.findById(id);
		currBill.setIsPaid(false);
		billServ.updateBill(currBill);
		Long newId = currBill.getAccount().getId();
		return "redirect:/acct/" + newId + "/";
	}
	
	
	//POST METHOD
	@PostMapping("/new/bill/")
	public String newBill(@Valid @ModelAttribute("bill")Bill bill, BindingResult result, Model model) {
		if(result.hasErrors()) {
			model.addAttribute("income", new Income());
			return "main.jsp";
		}
		else {
			billServ.createBill(bill);
			Account acct = bill.getAccount();
			acct.getBills().add(bill);
			acctServ.updateAccount(acct);
			Long id = acct.getId();
			return "redirect:/acct/" + id + "/";
		}
	}
	
	//DELETE METHOD
	@DeleteMapping("/delete/bill/{id}/")
	public String deleteBill(@PathVariable("id") Long id) {
		Long newId = billServ.findById(id).getAccount().getId();
		billServ.deleteBill(id);
		return "redirect:/acct/" + newId + "/";
	}
}
