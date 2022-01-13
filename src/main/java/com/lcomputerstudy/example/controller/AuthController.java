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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	
	
	@PostMapping("/addRole")
	public ResponseEntity<?> addRoleAdmin(@Validated @RequestBody UserInfo user_) {

		User u = userService.readUser(user_.getUsername());
		
		u.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER", "ROLE_ADMIN"));
		userService.createAuthority(u);
		
		List<String> roles= userService.getAuthorities(u.getUsername()).stream()
				.map(item -> item.getAuthority())
				.collect(Collectors.toList());
		
		UserInfo user = new UserInfo();
		user.setUsername(u.getUsername());
		user.setName(u.getName());
		user.setRoles(roles);
		
		return new ResponseEntity<>(user, HttpStatus.OK);
	}
	
	@DeleteMapping("/role-admin")
	public ResponseEntity<?> deleteRoleAdmin(@Validated UserInfo user_) {

		User u = userService.readUser(user_.getUsername());
		
		u.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		userService.deleteAuth(u.getUsername());
		
		List<String> roles= userService.getAuthorities(u.getUsername()).stream()
				.map(item -> item.getAuthority())
				.collect(Collectors.toList());
		
		UserInfo user = new UserInfo();
		user.setUsername(u.getUsername());
		user.setName(u.getName());
		user.setRoles(roles);
		
		return new ResponseEntity<>(user, HttpStatus.OK);
	}
	
	@PostMapping("/board")
	public ResponseEntity<?> writePost(HttpServletRequest request, @Validated @RequestBody PostRequest post ) {
		
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
	
	@DeleteMapping("/board")
	public ResponseEntity<?> deleteBoardView(HttpServletRequest request, @Validated PostRequest post) {
		
		String token= request.getHeader("Authorization");
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		UserInfo user = userService.readUser_refresh(username);
		
		Board board = boardService.getBoardDetail(post.getB_id());


		if(board.getWriter().equals(user.getUsername()) || request.isUserInRole("ROLE_ADMIN") ) {
			
			boardService.deletePost(post.getB_id());
			
			return new ResponseEntity<>("success", HttpStatus.OK);
			
		}else 
			return new ResponseEntity<>("fail", HttpStatus.FORBIDDEN);
		
	}
	
	@PutMapping("/board")
	public ResponseEntity<?> editPost(HttpServletRequest request, @Validated @RequestBody PostRequest post) {
		
		String token= request.getHeader("Authorization");
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		Board board = boardService.getBoardDetail(post.getB_id());
		
		if(board.getWriter().equals(username)) {
		
			Board setBoard = new Board();
			setBoard.setTitle(post.getTitle());
			setBoard.setContent(post.getContent());
			setBoard.setB_id(post.getB_id());
			
			
			boardService.editPost(setBoard);
			
			return new ResponseEntity<>("success", HttpStatus.OK);
		
		} else
		
			return new ResponseEntity<>("fail", HttpStatus.FORBIDDEN);
		
	}
	
	@PostMapping("/reply")
	public ResponseEntity<?> writeReplyPost(HttpServletRequest request, @Validated @RequestBody PostRequest post ) {
		
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
		board.setGroups(post.getGroups());
		board.setOrders(post.getOrders());
		board.setDepth(post.getDepth());
		
		boardService.insertReply(board);
		
		return new ResponseEntity<>("success", HttpStatus.OK);
		
	}
	
}


