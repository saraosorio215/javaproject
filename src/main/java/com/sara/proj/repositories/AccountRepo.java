package com.sara.proj.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.sara.proj.models.Account;

@Repository
public interface AccountRepo extends CrudRepository<Account, Long> {
	List<Account> findAll();
}
