package com.sara.proj.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sara.proj.models.Category;
import com.sara.proj.repositories.CategoryRepo;

@Service
public class CategoryService {
	
	@Autowired
	private final CategoryRepo catRepo;
	
	//CONSTRUCTOR
	public CategoryService(CategoryRepo catRepo) {
		this.catRepo = catRepo;
	}
	
	//METHODS
	//FIND ALL
	public List<Category> allCategories(){
		return catRepo.findAll();
	}
	
	//FIND ONE
	public Category findOneById(Long id) {
		Optional<Category> optionalCat = catRepo.findById(id);
		if(optionalCat.isPresent()) {
			return optionalCat.get();
		}
		else {
			return null;
		}
	}
	
	//CREATE
	public Category createCat(Category cat) {
		return catRepo.save(cat);
	}
	
	//UPDATE
	public Category updateCat(Category cat) {
		return catRepo.save(cat);
	}
	
	//DELETE
	public void deleteCat(Long id) {
		catRepo.deleteById(id);
		return;
	}
}
