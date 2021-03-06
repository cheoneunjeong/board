package com.lcomputerstudy.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.swing.filechooser.FileNameExtensionFilter;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Select;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.lcomputerstudy.example.config.JwtUtils;
import com.lcomputerstudy.example.domain.Board;
import com.lcomputerstudy.example.domain.Comment;
import com.lcomputerstudy.example.domain.User;
import com.lcomputerstudy.example.domain.UserInfo;
import com.lcomputerstudy.example.request.JoinRequest;
import com.lcomputerstudy.example.request.LoginRequest;
import com.lcomputerstudy.example.request.PostRequest;
import com.lcomputerstudy.example.request.SelectedB_id;
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
	
	@Autowired
	ServletContext context;
	
	
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

	@RequestMapping(value="/file", method=RequestMethod.POST)
	public ResponseEntity<?> fileupload(HttpServletRequest request,
										@RequestParam("file") List<MultipartFile> multipartFiles,
										@RequestParam("title") String title,
										@RequestParam("content") String content) {
		
		String token = new String();
		token = request.getHeader("Authorization");
		
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		
		//String path = "/Users/jeong/eclipse-workspace/board/src/main/resources/static/images/";
		String path = System.getProperty("user.home")+"/boardVue/src/assets/";
		
		StringBuilder builder = new StringBuilder();
		
		for(MultipartFile file : multipartFiles) {
			if(!file.isEmpty()) {
				String filename = file.getOriginalFilename();
				builder.append(filename);
				builder.append(",");
				
				File f = new File(path+filename);
				
				try {
					InputStream input = file.getInputStream();
					FileUtils.copyInputStreamToFile(input, f);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		if (builder.toString().contains(",")) {
			int p = builder.toString().lastIndexOf(",");
			builder.deleteCharAt(p);
			
			Board board = new Board();
			board.setTitle(title);
			board.setContent(content);
			board.setWriter(username);
			board.setFilename(builder.toString());
			
			boardService.insertBoard(board);
			
		}
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
			
			boardService.deleteBoardComments(post.getB_id());
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
	
	@PostMapping("/comment")
	public ResponseEntity<?> writeComment(HttpServletRequest request, @Validated @RequestBody Comment comment_ ) {
		
		String token = new String();
		token = request.getHeader("Authorization");
		
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		UserInfo user = userService.readUser_refresh(username);
		
		Comment comment = new Comment();
		comment.setBid(comment_.getBid());
		comment.setContent(comment_.getContent());
		comment.setWriter(user.getUsername());
		
		
		boardService.createComment(comment);
		List<Comment> list = boardService.getCommentList(comment_.getBid());
		
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}
	
	@DeleteMapping("/comment")
	public ResponseEntity<?> deleteComment(HttpServletRequest request,@Validated Comment c_id ) {
		
		Comment c = boardService.getCommentDetail(c_id);
		
		String token= request.getHeader("Authorization");
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		
		if(c.getWriter().equals(username) || request.isUserInRole("ROLE_ADMIN")) {
			
			boardService.deleteComment(c_id.getC_id());
			List<Comment> list = boardService.getCommentList(c.getBid());
			
			return new ResponseEntity<>(list, HttpStatus.OK);
		} else 
			return new ResponseEntity<>("fail", HttpStatus.FORBIDDEN);
	}
	
	@PostMapping("/reply-comment")
	public ResponseEntity<?> addReComment(HttpServletRequest request, @Validated @RequestBody Comment comment) {
		
		String token = new String();
		token = request.getHeader("Authorization");
		
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		
		Comment reComment = new Comment();
		reComment.setBid(comment.getBid());
		reComment.setContent(comment.getContent());
		reComment.setWriter(username);
		reComment.setGroups(comment.getGroups());
		reComment.setOrders(comment.getOrders());
		reComment.setDepth(comment.getDepth());
		
		boardService.insertReplyComment(reComment);
		List<Comment> list = boardService.getCommentList(comment.getBid());
		
		return new ResponseEntity<>(list, HttpStatus.OK);
		
	}
	
	@PutMapping("/selected-post")
	public ResponseEntity<?> DeleteSelectedPost(HttpServletRequest request, @Validated @RequestBody SelectedB_id id) {
		
		if(request.isUserInRole("ROLE_ADMIN") ) {
			
			for(int p: id.getB_id()) {
				boardService.deleteBoardComments(p);
				boardService.deletePost(p);
			}
			List<Board> list = boardService.getBoardList();
			
			return new ResponseEntity<>(list, HttpStatus.OK);
		
		} else

			return new ResponseEntity<>("fail", HttpStatus.FORBIDDEN);
	}
	
	@RequestMapping(value="/file", method=RequestMethod.PUT)
	public ResponseEntity<?> editFilePost(HttpServletRequest request,
										@RequestParam("file") List<MultipartFile> multipartFiles,
										@RequestParam("title") String title,
										@RequestParam("content") String content,
										@RequestParam("b_id") int b_id) {
		
		String token= request.getHeader("Authorization");
		if(StringUtils.hasText(token) && token.startsWith("Bearer ")) {
			token = token.substring(7, token.length());
		}
		String username = jwtUtils.getUserEmailFromToken(token);
		Board board = boardService.getBoardDetail(b_id);
		
		if(board.getWriter().equals(username)) {
			
				
			String path = System.getProperty("user.home")+"/boardVue/src/assets/";
				
				StringBuilder builder = new StringBuilder();
				
				for(MultipartFile file : multipartFiles) {
					if(!file.isEmpty()) {
						String filename = file.getOriginalFilename();
						builder.append(filename);
						builder.append(",");
						
						File f = new File(path+filename);
						
						try {
							InputStream input = file.getInputStream();
							FileUtils.copyInputStreamToFile(input, f);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
				if (builder.toString().contains(",")) {
					int p = builder.toString().lastIndexOf(",");
					builder.deleteCharAt(p);
				}
					
					Board setBoard = new Board();
					setBoard.setTitle(title);
					setBoard.setContent(content);
					setBoard.setB_id(b_id);
					setBoard.setFilename(builder.toString());
				
				
				boardService.editPost(setBoard);
				
				return new ResponseEntity<>("success", HttpStatus.OK);
			
			} else
			
				return new ResponseEntity<>("fail", HttpStatus.FORBIDDEN);
	
	}
	
}


