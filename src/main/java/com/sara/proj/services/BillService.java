package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sara.proj.models.Bill;
import com.sara.proj.repositories.BillRepo;

@Service
public class BillService {
	
	@Autowired
	private final BillRepo billRepo;
	
	//CONSTRUCTOR
	public BillService(BillRepo billRepo) {
		this.billRepo = billRepo;
	}
	
	//METHODS
	public Double totalDue() {
		List<Bill> allBills = billRepo.findAll();
		Double totalAmt = 0.0;
		for(int i=0; i<allBills.size(); i++) {
			if(allBills.get(i).getIsPaid() == false) {
				totalAmt += allBills.get(i).getAmount();				
			}
		}
		return totalAmt;
	}
	
	
	public Double totalPaid() {
		List<Bill> allBills = billRepo.findAll();
		Double totalPaid = 0.0;
		for(int i=0; i<allBills.size(); i++) {
			if(allBills.get(i).getIsPaid() == true) {
				totalPaid += allBills.get(i).getAmount();				
			}
		}
		return totalPaid;
	}
	
	//FIND ALL
	public List<Bill> allBills(){
		return billRepo.findAll();
	}
	
	//FIND ONE
	public Bill findById(Long id) {
		Optional<Bill> optionalBill = billRepo.findById(id);
		if(optionalBill.isPresent()) {
			return optionalBill.get();
		}
		else {
			return null;
		}
	}
	
	//CREATE
	public Bill createBill(Bill bill) {
		return billRepo.save(bill);
	}
	
	//UPDATE
	public Bill updateBill(Bill bill) {
		return billRepo.save(bill);
	}
	
	//DELETE
	public void deleteBill(Long id) {
		billRepo.deleteById(id);
		return;
	}
}
