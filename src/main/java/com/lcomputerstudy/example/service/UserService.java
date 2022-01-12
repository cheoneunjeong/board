package com.lcomputerstudy.example.service;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.lcomputerstudy.example.domain.User;
import com.lcomputerstudy.example.domain.UserInfo;

public interface UserService extends UserDetailsService {

	public User readUser(String username);
	
	public void createUser(User user);
	
	Collection<GrantedAuthority> getAuthorities(String username);
	
	public void createAuthority(User user);

	public UserInfo readUser_refresh(String username);

	public List<UserInfo> read_user_list();

	public void deleteAuth(String username);
	
}
