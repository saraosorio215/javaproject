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
import com.sara.proj.repositories.BillRepo;
import com.sara.proj.repositories.CategoryRepo;

@Service
public class BillService {
	
	@Autowired
	private final BillRepo billRepo;
	
	@Autowired
	private final CategoryRepo catRepo;
	
	//CONSTRUCTOR
	public BillService(BillRepo billRepo, CategoryRepo catRepo) {
		this.billRepo = billRepo;
		this.catRepo = catRepo;
	}
	
	//METHODS
	public HashMap<String, Double> moneySpent(){
		HashMap<String, Double> map = new HashMap<String, Double>();
		List<Category> allCats = catRepo.findAll();
		List<Bill> allBills = billRepo.findAll();
		Double totalAmt = 0.0;
		for(int i=0; i<allBills.size(); i++) {
			totalAmt += allBills.get(i).getAmount();				
		}
		for(int i=0; i<allCats.size(); i++) {
			Double catSum = 0.0;
			String catName = allCats.get(i).getName();
			List<Bill> allCatBills = allCats.get(i).getBills();
			for(int j=0; j<allCatBills.size(); j++) {
				catSum += allCatBills.get(j).getAmount();
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
