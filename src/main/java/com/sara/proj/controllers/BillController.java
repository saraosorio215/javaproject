package com.sara.proj.controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.sara.proj.models.Account;
import com.sara.proj.models.Bill;
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
		return "redirect:/";
	}
	
	@GetMapping("/unpaid/{id}/")
	public String unpayBill(@PathVariable("id") Long id) {
		Bill currBill = billServ.findById(id);
		currBill.setIsPaid(false);
		billServ.updateBill(currBill);
		return "redirect:/";
	}
	
	
	//POST METHOD
	@PostMapping("/new/bill/{id}")
	public String newBill(@Valid @ModelAttribute("bill")Bill bill, BindingResult result, @PathVariable("id") Long id) {
		if(result.hasErrors()) {
			return "main.jsp";
		}
		else {
			Account currAcct = acctServ.findOneById(id);
			bill.setAccount(currAcct);
			billServ.createBill(bill);
			currAcct.getBills().add(bill);
			return "redirect:/overview/";
		}
	}
	
	//DELETE METHOD
	@DeleteMapping("/delete/bill/{id}/")
	public String deleteBill(@PathVariable("id") Long id) {
		billServ.deleteBill(id);
		return "redirect:/";
	}
}
