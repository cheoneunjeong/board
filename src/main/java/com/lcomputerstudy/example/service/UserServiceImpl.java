package com.lcomputerstudy.example.service;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.lcomputerstudy.example.domain.User;
import com.lcomputerstudy.example.mapper.UserMapper;

public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper usermapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		
		User user = usermapper.readUser(username);
		user.setAuthorities(getAuthorities(username));
		return user;
	}

	@Override
	public User readUser(String username) {
		// TODO Auto-generated method stub
		return usermapper.readUser(username);
	}

	@Override
	public void createUser(User user) {
		// TODO Auto-generated method stub
		usermapper.createUser(user);
	}

	@Override
	public Collection<GrantedAuthority> getAuthorities(String username) {
		// TODO Auto-generated method stub
		List<GrantedAuthority> authorities = usermapper.readAuthorities(username);
		return null;
	}

	@Override
	public void createAuthority(User user) {
		// TODO Auto-generated method stub
		usermapper.createAuthority(user);
	}

}
