package com.lcomputerstudy.example.controller;

import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lcomputerstudy.example.config.JwtUtils;
import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.User;
import com.lcomputerstudy.example.domain.UserInfo;
import com.lcomputerstudy.example.request.JoinRequest;
import com.lcomputerstudy.example.request.LoginRequest;
import com.lcomputerstudy.example.request.PostRequest;
import com.lcomputerstudy.example.response.JwtResponse;
import com.lcomputerstudy.example.service.BoardService;
import com.lcomputerstudy.example.service.UserService;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/auth")
public class AuthController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	AuthenticationManager authenticationManager;
	
	@Autowired
	PasswordEncoder encoder;
	
	@Autowired
	JwtUtils jwtUtils;
	
	@Autowired
	UserService userService;
	
	@Autowired
	BoardService boardService;
	
	@PostMapping("/signin")
	public ResponseEntity<?> authenticateUser(@Validated @RequestBody LoginRequest loginRequest) {
		
		logger.info("test"+ loginRequest);
		
		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));
		
		SecurityContextHolder.getContext().setAuthentication(authentication);
		String jwt = jwtUtils.generateJwtToken(authentication);
		System.out.println(jwt);
		
		User user = (User) authentication.getPrincipal();
		logger.info("dddd"+ authentication.getPrincipal());
		List<String> roles= user.getAuthorities().stream()
				.map(item -> item.getAuthority())
				.collect(Collectors.toList());
		
		return ResponseEntity.ok(new JwtResponse(jwt,
												user.getUsername(),
												user.getName(),
												roles));
	}
	
	@PostMapping("/signup")
	public ResponseEntity<?> signupUser(@Validated @RequestBody JoinRequest joinRequest) {
		
		String encodedPassword = new BCryptPasswordEncoder().encode(joinRequest.getPassword());
		
		User user = new User();
		
		user.setUsername(joinRequest.getUsername());
		user.setName(joinRequest.getName());
		user.setPassword(encodedPassword);
		user.setPhone(joinRequest.getPhone());
		user.setAccountNonExpired(true);
		user.setEnabled(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		
		userService.createUser(user);
		
		userService.createAuthority(user);
		
		return new ResponseEntity<>("success", HttpStatus.OK);
		
	}
	
	@GetMapping("/unpackToken")
	public ResponseEntity<?> unpackToken(HttpServletRequest request) {
		String token = new String();
		token = request.getHeader("Authorization");
		
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		System.out.println("새로고침시 넘어온 토큰="+token);
		String username = jwtUtils.getUserEmailFromToken(token);
		UserInfo user = userService.readUser_refresh(username);
		
		return new ResponseEntity<>(user, HttpStatus.OK);
	}
	
	@PostMapping("/board")
	public ResponseEntity<?> writePost(HttpServletRequest request, @Validated @RequestBody PostRequest post ) {
		
		System.out.println("post="+post);
		String token = new String();
		token = request.getHeader("Authorization");
		
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		UserInfo user = userService.readUser_refresh(username);
		
		Board board = new Board();
		board.setTitle(post.getTitle());
		board.setContent(post.getContent());
		board.setWriter(user.getUsername());
		
		boardService.insertBoard(board);
		
		return new ResponseEntity<>("success", HttpStatus.OK);
		
	}
	
}


