package com.sara.proj.services;

import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sara.proj.models.Bill;
import com.sara.proj.models.Category;
import com.sara.proj.models.Income;
import com.sara.proj.repositories.AccountRepo;
import com.sara.proj.repositories.BillRepo;
import com.sara.proj.repositories.UserRepo;

@Service
public class BillService {
	
	@Autowired
	private BillRepo billRepo;
	
	@Autowired
	private AccountRepo acctRepo;
	
	@Autowired
	private UserRepo userRepo;
	
	
	//METHODS
	public HashMap<String, Double> moneySpent(Long acct_id, Long user_id){
		HashMap<String, Double> map = new HashMap<String, Double>();
		List<Category> allCats = userRepo.findById(user_id).get().getCategories();
		List<Income> allIncome = acctRepo.findById(acct_id).get().getIncomes();
		Double totalAmt = 0.0;
		for(int i=0; i<allIncome.size(); i++) {
			totalAmt += allIncome.get(i).getAmount();				
		}
		for(int x=0; x<allCats.size(); x++) {
			Double catSum = 0.0;
			String catName = allCats.get(x).getName();
			List<Bill> allCatBills = allCats.get(x).getBills();
			for(int j=0; j<allCatBills.size(); j++) {
				if(allCatBills.get(j).getAccount() == acctRepo.findById(acct_id).get()) {
					catSum += allCatBills.get(j).getAmount();					
				}
			}
			catSum = (catSum/totalAmt) *100;
			catSum = round(catSum, 2);
			map.put(catName, catSum);
		}
        List<Map.Entry<String, Double> > list = new LinkedList<Map.Entry<String, Double> >(
                map.entrySet());
        Collections.sort(
            list,
            (i1,
             i2) -> i1.getValue().compareTo(i2.getValue()));
        Collections.reverse(list);
        HashMap<String, Double> temp = new LinkedHashMap<String, Double>();
        for (Map.Entry<String, Double> aa : list) {
            temp.put(aa.getKey(), aa.getValue());
        }
        return temp;
	}
	
	public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();

	    long factor = (long) Math.pow(10, places);
	    value = value * factor;
	    long tmp = Math.round(value);
	    return (double) tmp / factor;
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
