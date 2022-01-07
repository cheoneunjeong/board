package com.lcomputerstudy.example.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class JwtUtils {
	
	private static final String jwtSecret = "lcomputerstudy";
	
	private static final int jwtExpirationMs= 864000;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public String generateJwtToken(Authentication authentication) {
		
	}
}