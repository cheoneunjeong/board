-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.4-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- jung 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `jung` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `jung`;

-- 테이블 jung.answer 구조 내보내기
CREATE TABLE IF NOT EXISTS `answer` (
  `a` varchar(50) NOT NULL,
  `q_num` int(11) NOT NULL,
  `a_num` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`a_num`),
  KEY `q_num` (`q_num`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`q_num`) REFERENCES `question` (`q_num`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.answer:~27 rows (대략적) 내보내기
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` (`a`, `q_num`, `a_num`) VALUES
	('객1', 61, 67),
	('ㄱ2', 61, 68),
	('ㄱ3', 61, 69),
	('ㄱ4', 61, 70),
	('ㅊ1', 62, 71),
	('ㅊ2', 62, 72),
	('ㅊ3', 62, 73),
	('ㅊ4', 62, 74),
	('ㅊ5', 62, 75),
	('ㄷ1', 63, 76),
	('ㄷ2', 63, 77),
	('ㄷ3', 63, 78),
	('ㄷ4', 63, 79),
	('ㄷ5', 63, 80),
	('gg', 65, 81),
	('ffffff', 67, 82),
	('sssss', 67, 83),
	('cccc', 67, 84),
	('d', 68, 85),
	('s', 68, 86),
	('x', 68, 87),
	('aw', 68, 88),
	('qweqwe', 69, 89),
	('sdfdsf', 69, 90),
	('xvxv', 69, 91),
	('xzx', 69, 92),
	('xccc', 69, 93);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;

-- 테이블 jung.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `b_idx` int(10) NOT NULL AUTO_INCREMENT,
  `b_title` varchar(255) NOT NULL,
  `b_content` varchar(255) NOT NULL,
  `b_date` varchar(255) NOT NULL,
  `b_writer` varchar(255) NOT NULL,
  `u_idx` int(10) DEFAULT NULL,
  PRIMARY KEY (`b_idx`),
  KEY `u_idx` (`u_idx`),
  CONSTRAINT `board_ibfk_1` FOREIGN KEY (`u_idx`) REFERENCES `user` (`u_idx`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.board:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` (`b_idx`, `b_title`, `b_content`, `b_date`, `b_writer`, `u_idx`) VALUES
	(1, '제목', '내용입니다.', '2021-11-09', '작성자', 1);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;

-- 테이블 jung.boardlist 구조 내보내기
CREATE TABLE IF NOT EXISTS `boardlist` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_title` varchar(255) DEFAULT NULL,
  `b_content` varchar(255) DEFAULT NULL,
  `b_writer` varchar(50) NOT NULL,
  `b_datetime` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `b_hit` int(11) NOT NULL DEFAULT 0,
  `groups` int(11) DEFAULT NULL,
  `orders` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL DEFAULT 0,
  `fileName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`b_id`) USING BTREE,
  KEY `b_writer` (`b_writer`) USING BTREE,
  CONSTRAINT `boardlist_ibfk_1` FOREIGN KEY (`b_writer`) REFERENCES `lc_user1` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 jung.boardlist:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `boardlist` DISABLE KEYS */;
INSERT INTO `boardlist` (`b_id`, `b_title`, `b_content`, `b_writer`, `b_datetime`, `b_hit`, `groups`, `orders`, `depth`, `fileName`) VALUES
	(66, 'y', 'tu', 'c', '2021-12-14 09:54:37', 1, 66, 1, 0, NULL),
	(67, 'ghgfj', 'yfju', 'c', '2021-12-14 12:05:11', 2, 67, 1, 0, NULL),
	(68, 'pl', 'p', 'c', '2021-12-14 11:38:54', 2, 68, 1, 0, NULL),
	(69, 'xx', 'i9o-', 'c', '2021-12-17 09:26:18', 7, 69, 1, 0, NULL),
	(97, 'test', 'test', 'c', '2021-12-15 11:21:55', 8, 97, 1, 0, NULL),
	(98, '안녕', 'ㄹㄹㄹ', 'c', '2021-12-16 09:12:09', 18, 98, 1, 0, NULL),
	(102, 'ㅇㅇㅇ', 'ㅇㅇㅇ', 'c', '2021-12-27 11:23:39', 7, 102, 1, 0, 'tte.txt'),
	(103, 'ddd', 'ddd', 'zaza', '2021-12-27 11:23:29', 3, 103, 1, 0, NULL),
	(104, 'aa', 'aa', 'zaza', '2021-12-17 09:28:14', 1, 104, 1, 0, NULL);
/*!40000 ALTER TABLE `boardlist` ENABLE KEYS */;

-- 테이블 jung.lc_auth 구조 내보내기
CREATE TABLE IF NOT EXISTS `lc_auth` (
  `u_id` varchar(50) NOT NULL,
  `u_auth` varchar(50) NOT NULL,
  PRIMARY KEY (`u_id`,`u_auth`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.lc_auth:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `lc_auth` DISABLE KEYS */;
INSERT INTO `lc_auth` (`u_id`, `u_auth`) VALUES
	('abc', 'ROLE_USER'),
	('c', 'ROLE_ADMIN'),
	('c', 'ROLE_USER'),
	('test', 'ROLE_USER'),
	('tt', 'ROLE_USER'),
	('zaza', 'ROLE_ADMIN'),
	('zaza', 'ROLE_USER');
/*!40000 ALTER TABLE `lc_auth` ENABLE KEYS */;

-- 테이블 jung.lc_board 구조 내보내기
CREATE TABLE IF NOT EXISTS `lc_board` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_title` varchar(255) DEFAULT NULL,
  `b_content` varchar(255) DEFAULT NULL,
  `b_writer` varchar(50) NOT NULL,
  `b_datetime` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `b_hit` int(11) NOT NULL DEFAULT 0,
  `groups` int(11) DEFAULT NULL,
  `orders` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL DEFAULT 0,
  `fileName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`b_id`),
  KEY `b_writer` (`b_writer`),
  CONSTRAINT `lc_board_ibfk_1` FOREIGN KEY (`b_writer`) REFERENCES `lc_user1` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.lc_board:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `lc_board` DISABLE KEYS */;
INSERT INTO `lc_board` (`b_id`, `b_title`, `b_content`, `b_writer`, `b_datetime`, `b_hit`, `groups`, `orders`, `depth`, `fileName`) VALUES
	(66, 'y', 'tu', 'c', '2021-12-14 09:54:37', 1, 66, 1, 0, NULL),
	(67, 'ghgfj', 'yfju', 'c', '2021-12-14 12:05:11', 2, 67, 1, 0, NULL),
	(68, 'pl', 'p', 'c', '2021-12-14 11:38:54', 2, 68, 1, 0, NULL),
	(69, 'xx', 'i9o-', 'c', '2021-12-17 09:26:18', 7, 69, 1, 0, NULL),
	(97, 'test', 'test', 'c', '2021-12-15 11:21:55', 8, 97, 1, 0, NULL),
	(98, '안녕', 'ㄹㄹㄹ', 'c', '2021-12-16 09:12:09', 18, 98, 1, 0, NULL),
	(102, 'ㅇㅇㅇ', 'ㅇㅇㅇ', 'c', '2021-12-27 11:23:39', 7, 102, 1, 0, 'tte.txt'),
	(103, 'ddd', 'ddd', 'zaza', '2021-12-27 11:23:29', 3, 103, 1, 0, NULL),
	(104, 'aa', 'aa', 'zaza', '2021-12-17 09:28:14', 1, 104, 1, 0, NULL);
/*!40000 ALTER TABLE `lc_board` ENABLE KEYS */;

-- 테이블 jung.lc_reply 구조 내보내기
CREATE TABLE IF NOT EXISTS `lc_reply` (
  `bId` int(11) NOT NULL,
  `content` varchar(200) DEFAULT NULL,
  `writer` varchar(50) DEFAULT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `groups` int(11) NOT NULL DEFAULT 0,
  `orders` int(11) NOT NULL DEFAULT 0,
  `depth` int(11) NOT NULL DEFAULT 0,
  `r_num` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`r_num`),
  KEY `writer` (`writer`),
  KEY `bId` (`bId`),
  CONSTRAINT `lc_reply_ibfk_1` FOREIGN KEY (`bId`) REFERENCES `lc_board` (`b_id`),
  CONSTRAINT `lc_reply_ibfk_2` FOREIGN KEY (`writer`) REFERENCES `lc_user1` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.lc_reply:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `lc_reply` DISABLE KEYS */;
INSERT INTO `lc_reply` (`bId`, `content`, `writer`, `datetime`, `groups`, `orders`, `depth`, `r_num`) VALUES
	(97, '1', 'c', '2021-12-14 22:53:06', 1, 1, 0, 1),
	(97, '1', 'c', '2021-12-14 23:08:18', 2, 1, 0, 2),
	(97, '1', 'c', '2021-12-14 23:08:43', 3, 1, 0, 3),
	(98, 'ㅁㄴㄷㄱㄹ', 'c', '2021-12-15 10:27:37', 4, 1, 0, 4),
	(98, 'ㄴㄷㅇㄹ', 'c', '2021-12-15 10:33:24', 5, 1, 0, 5),
	(98, 'rr', 'c', '2021-12-15 12:07:10', 7, 1, 0, 7);
/*!40000 ALTER TABLE `lc_reply` ENABLE KEYS */;

-- 테이블 jung.lc_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `lc_user` (
  `u_id` varchar(50) DEFAULT NULL,
  `u_password` varchar(50) DEFAULT NULL,
  `u_name` varchar(50) DEFAULT NULL,
  `u_age` int(11) DEFAULT NULL,
  `u_datetime` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.lc_user:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `lc_user` DISABLE KEYS */;
INSERT INTO `lc_user` (`u_id`, `u_password`, `u_name`, `u_age`, `u_datetime`) VALUES
	('aaa', 'aaa', 'aa', 10, '2021-12-01 00:00:00'),
	('test1', '1234', 'kim', 20, '2021-12-02 09:55:56'),
	('test1', '1234', 'kim', 20, '2021-12-03 16:36:58');
/*!40000 ALTER TABLE `lc_user` ENABLE KEYS */;

-- 테이블 jung.lc_user1 구조 내보내기
CREATE TABLE IF NOT EXISTS `lc_user1` (
  `u_id` varchar(50) NOT NULL,
  `u_password` varchar(200) DEFAULT NULL,
  `u_name` varchar(200) DEFAULT NULL,
  `u_datetime` datetime DEFAULT current_timestamp(),
  `u_isAccountNonExpired` tinyint(10) DEFAULT NULL,
  `u_isAccountNonLocked` tinyint(10) DEFAULT NULL,
  `u_isCredentialNonExpired` tinyint(10) DEFAULT NULL,
  `u_isEnabled` tinyint(10) DEFAULT NULL,
  `u_auth` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.lc_user1:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `lc_user1` DISABLE KEYS */;
INSERT INTO `lc_user1` (`u_id`, `u_password`, `u_name`, `u_datetime`, `u_isAccountNonExpired`, `u_isAccountNonLocked`, `u_isCredentialNonExpired`, `u_isEnabled`, `u_auth`) VALUES
	('abc', '$2a$10$08XR0uPaiUX.YWh9pxGu8.suYdnnp/m2XsxPj0dxi7mbCRi8ej1Vq', 'abc', '2021-12-06 09:28:58', 1, 1, 1, 1, 0),
	('c', '$2a$10$OHE7XzHKtO25Vo5Hk4QTKOEW1ecLCrisEwdlh7HNIgUfxcu5fxNiK', 'c', '2021-12-06 09:32:58', 1, 1, 1, 1, 1),
	('qqq', '$2a$10$m84mPoZUFe0TNsuMs76Zh.qsYVRgwggh5FxyHS6xv6NKIcCH.G1Jy', 'qqq', '2021-12-10 11:29:09', 1, 1, 1, 1, 0),
	('test', '$2a$10$hUKBj0KXyq.LedcVeqv4YONVdE2yzwF7Uk.G2rYmcCsNBOQe3RXoG', 'test', '2021-12-04 14:25:02', 1, 1, 1, 1, 0),
	('tt', '$2a$10$QLbzS8zTg1.2WJ2LSdrMLOoU6FRzDXJGj8TyBoePrVK/3//ZTEswe', 'tt', '2021-12-04 14:25:23', 1, 1, 1, 1, 0),
	('zaza', '$2a$10$aKo6SCUkDM8OFvkAfB2dKegmqPgIE329b.FihTSsrmA5SLUbvVHwK', 'zaza', '2021-12-10 11:32:44', 1, 1, 1, 1, 0);
/*!40000 ALTER TABLE `lc_user1` ENABLE KEYS */;

-- 테이블 jung.question 구조 내보내기
CREATE TABLE IF NOT EXISTS `question` (
  `s_num` int(11) DEFAULT NULL,
  `q_num` int(11) NOT NULL AUTO_INCREMENT,
  `t` varchar(50) DEFAULT NULL,
  `q` varchar(50) DEFAULT NULL,
  `filename` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`q_num`) USING BTREE,
  KEY `s_num` (`s_num`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`s_num`) REFERENCES `survey` (`s_num`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.question:~11 rows (대략적) 내보내기
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` (`s_num`, `q_num`, `t`, `q`, `filename`) VALUES
	(57, 59, '1', '단답질문', NULL),
	(57, 60, '2', '장문', NULL),
	(57, 61, '3', '객관', NULL),
	(57, 62, '4', '체크', NULL),
	(57, 63, '5', '드롭', NULL),
	(58, 64, '1', 'ss', NULL),
	(58, 65, '3', 'gg', NULL),
	(59, 66, '1', 'question1', NULL),
	(59, 67, '3', 'questiuuon2', NULL),
	(59, 68, '5', 'ggggggg?', NULL),
	(59, 69, '4', 'question4', NULL);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;

-- 테이블 jung.sanswer 구조 내보내기
CREATE TABLE IF NOT EXISTS `sanswer` (
  `ans_num` int(11) NOT NULL AUTO_INCREMENT,
  `sub_num` int(11) DEFAULT NULL,
  `q_num` int(11) DEFAULT NULL,
  `a` varchar(50) DEFAULT NULL,
  `t` varchar(50) DEFAULT NULL,
  `s_num` int(11) NOT NULL,
  PRIMARY KEY (`ans_num`),
  KEY `sub_num` (`sub_num`),
  KEY `q_num` (`q_num`),
  KEY `s_num` (`s_num`),
  CONSTRAINT `sanswer_ibfk_1` FOREIGN KEY (`sub_num`) REFERENCES `submission` (`sub_num`),
  CONSTRAINT `sanswer_ibfk_2` FOREIGN KEY (`q_num`) REFERENCES `question` (`q_num`),
  CONSTRAINT `sanswer_ibfk_3` FOREIGN KEY (`s_num`) REFERENCES `survey` (`s_num`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.sanswer:~39 rows (대략적) 내보내기
/*!40000 ALTER TABLE `sanswer` DISABLE KEYS */;
INSERT INTO `sanswer` (`ans_num`, `sub_num`, `q_num`, `a`, `t`, `s_num`) VALUES
	(100, 33, 59, '11', '1', 57),
	(101, 33, 60, '22', '2', 57),
	(102, 33, 61, 'ㄱ3', '3', 57),
	(103, 33, 62, 'ㅊ1', '4', 57),
	(104, 33, 62, 'ㅊ2', '4', 57),
	(105, 33, 62, 'ㅊ3', '4', 57),
	(106, 33, 63, 'ㄷ5', '5', 57),
	(107, 34, 59, 'ㅁㄴ', '1', 57),
	(108, 34, 60, 'ㅂㅈㄷ', '2', 57),
	(109, 34, 61, 'ㄱ4', '3', 57),
	(110, 34, 62, 'ㅊ1', '4', 57),
	(111, 34, 62, 'ㅊ2', '4', 57),
	(112, 34, 62, 'ㅊ5', '4', 57),
	(113, 34, 63, 'ㄷ2', '5', 57),
	(114, 35, 64, 'ㅋㅋㅋㅋㅋㅋㅋ', '1', 58),
	(115, 35, 65, 'gg', '3', 58),
	(116, 36, 66, 'gggg', '1', 59),
	(117, 36, 67, 'sssss', '3', 59),
	(118, 36, 68, 'x', '5', 59),
	(119, 36, 69, 'sdfdsf', '4', 59),
	(120, 36, 69, 'xvxv', '4', 59),
	(121, 36, 69, 'xzx', '4', 59),
	(122, 37, 66, 'zzzz', '1', 59),
	(123, 37, 67, 'ffffff', '3', 59),
	(124, 37, 68, 'd', '5', 59),
	(125, 37, 69, 'qweqwe', '4', 59),
	(126, 37, 69, 'sdfdsf', '4', 59),
	(127, 37, 69, 'xvxv', '4', 59),
	(128, 38, 66, ',,,', '1', 59),
	(129, 38, 67, 'sssss', '3', 59),
	(130, 38, 68, 'aw', '5', 59),
	(131, 38, 69, 'xvxv', '4', 59),
	(132, 38, 69, 'xccc', '4', 59),
	(133, 39, 66, 'bbbb', '1', 59),
	(134, 39, 67, 'cccc', '3', 59),
	(135, 39, 68, 'x', '5', 59),
	(136, 39, 69, 'qweqwe', '4', 59),
	(137, 39, 69, 'sdfdsf', '4', 59),
	(138, 39, 69, 'xccc', '4', 59);
/*!40000 ALTER TABLE `sanswer` ENABLE KEYS */;

-- 테이블 jung.spring_session 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.spring_session:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;

-- 테이블 jung.spring_session_attributes 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.spring_session_attributes:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;

-- 테이블 jung.submission 구조 내보내기
CREATE TABLE IF NOT EXISTS `submission` (
  `s_num` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `disc` varchar(50) NOT NULL,
  `writer` varchar(50) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `sub_num` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sub_num`),
  KEY `s_num` (`s_num`),
  CONSTRAINT `submission_ibfk_1` FOREIGN KEY (`s_num`) REFERENCES `survey` (`s_num`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.submission:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `submission` DISABLE KEYS */;
INSERT INTO `submission` (`s_num`, `title`, `disc`, `writer`, `datetime`, `sub_num`) VALUES
	(57, '제목', '설명', 'c', '2021-12-29 02:07:22', 33),
	(57, '제목', '설명', 'c', '2021-12-29 02:07:35', 34),
	(58, 'dd', 'ff', 'c', '2021-12-29 02:07:58', 35),
	(59, 'test', 'disc', 'c', '2021-12-29 09:29:13', 36),
	(59, 'test', 'disc', 'c', '2021-12-29 09:29:28', 37),
	(59, 'test', 'disc', 'c', '2021-12-29 09:29:44', 38),
	(59, 'test', 'disc', 'c', '2021-12-29 09:29:54', 39);
/*!40000 ALTER TABLE `submission` ENABLE KEYS */;

-- 테이블 jung.survey 구조 내보내기
CREATE TABLE IF NOT EXISTS `survey` (
  `s_num` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `disc` varchar(200) DEFAULT NULL,
  `writer` varchar(50) NOT NULL,
  `datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `hit` int(100) NOT NULL DEFAULT 0,
  PRIMARY KEY (`s_num`),
  KEY `writer` (`writer`),
  CONSTRAINT `survey_ibfk_1` FOREIGN KEY (`writer`) REFERENCES `lc_user1` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.survey:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `survey` DISABLE KEYS */;
INSERT INTO `survey` (`s_num`, `title`, `disc`, `writer`, `datetime`, `hit`) VALUES
	(57, '제목', '설명', 'c', '2021-12-28 17:55:08', 0),
	(58, 'dd', 'ff', 'c', '2021-12-28 22:45:37', 0),
	(59, 'test', 'disc', 'c', '2021-12-29 09:29:00', 0);
/*!40000 ALTER TABLE `survey` ENABLE KEYS */;

-- 테이블 jung.test 구조 내보내기
CREATE TABLE IF NOT EXISTS `test` (
  `b_idx` int(10) NOT NULL AUTO_INCREMENT,
  `b_title` varchar(255) NOT NULL,
  `b_content` varchar(255) NOT NULL,
  `b_date` datetime NOT NULL,
  `u_idx` int(10) NOT NULL,
  `b_hit` int(10) NOT NULL DEFAULT 0,
  `groups` int(11) DEFAULT NULL,
  `orders` int(11) DEFAULT NULL,
  `depth` int(11) NOT NULL DEFAULT 0,
  `b_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`b_idx`),
  KEY `u_idx` (`u_idx`),
  CONSTRAINT `test_ibfk_1` FOREIGN KEY (`u_idx`) REFERENCES `user` (`u_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.test:~26 rows (대략적) 내보내기
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` (`b_idx`, `b_title`, `b_content`, `b_date`, `u_idx`, `b_hit`, `groups`, `orders`, `depth`, `b_file`) VALUES
	(99, '1', 'l', '2021-11-19 09:59:04', 11, 3, 99, 1, 0, NULL),
	(100, '3', 'ㅇㅇㅇ', '2021-11-19 05:22:50', 11, 44, 100, 1, 0, NULL),
	(101, '1-1', ';', '2021-11-19 09:59:15', 11, 3, 99, 5, 1, NULL),
	(102, '1-2', 'p0', '2021-11-19 09:59:22', 11, 2, 99, 3, 1, NULL),
	(103, '1-1 /1', 'jnj', '2021-11-19 10:06:22', 11, 0, 99, 9, 2, NULL),
	(104, '1-1 / 2', '[[', '2021-11-19 10:06:32', 11, 3, 99, 6, 2, NULL),
	(105, '112 -1', '[[', '2021-11-19 10:06:55', 11, 0, 99, 8, 3, NULL),
	(106, '112 -2', '[[', '2021-11-19 10:07:09', 11, 0, 99, 7, 3, NULL),
	(107, '2-1', '[', '2021-11-19 10:07:23', 11, 1, 100, 2, 1, NULL),
	(108, '1-3', '[[', '2021-11-19 10:07:34', 11, 2, 99, 2, 1, NULL),
	(109, '1-2 /1', '[[', '2021-11-19 10:07:57', 11, 0, 99, 4, 2, NULL),
	(113, '글', 'ㄹㄹㄹ', '2021-11-19 05:21:23', 11, 1, 113, 1, 0, NULL),
	(114, '글2', 'ㅇㅇㅇ', '2021-11-19 05:21:32', 11, 23, 114, 1, 0, NULL),
	(115, '답글', 'ㄴㄴㄴ', '2021-11-19 05:21:44', 11, 1, 113, 2, 1, NULL),
	(116, '수정', 'ㅇㅇ', '2021-11-19 05:22:16', 11, 3, 113, 3, 2, NULL),
	(117, 'tt', 'tt', '2021-11-19 07:45:40', 11, 3, 117, 1, 0, NULL),
	(121, 'zz', 'zz', '2021-11-25 04:16:13', 11, 0, 121, 1, 0, NULL),
	(122, 'zz', 'zz', '2021-11-25 04:58:11', 11, 4, 122, 1, 0, NULL),
	(123, 'f', 'f', '2021-11-25 04:59:30', 11, 7, 123, 1, 0, NULL),
	(135, 'TRYH', 'EY', '2021-11-26 10:07:19', 11, 1, 135, 1, 0, '추상.txt'),
	(136, 'ZZZ', 'ZZZZ', '2021-11-26 10:07:48', 11, 8, 136, 1, 0, '추상.txt,인터.txt'),
	(156, 'ㅇㄴㅇ', '9946A4505F5817A60D.png', '2021-11-26 11:22:13', 11, 4, 156, 1, 0, '9946A4505F5817A60D.png'),
	(157, 'ad', 'asd', '2021-12-13 10:42:37', 11, 0, 157, 1, 0, 'web - 복사본.xml'),
	(158, 'g', 'g', '2021-12-14 10:23:42', 11, 0, 158, 1, 0, 'ssawe.jpg'),
	(159, 'r', 'r', '2021-12-14 10:24:57', 11, 0, 159, 1, 0, 'ssawe.jpg'),
	(160, 'r', 'e', '2021-12-14 10:26:24', 11, 0, 160, 1, 0, 'ssawe.jpg');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;

-- 테이블 jung.test_reply 구조 내보내기
CREATE TABLE IF NOT EXISTS `test_reply` (
  `c_num` int(10) NOT NULL AUTO_INCREMENT,
  `b_idx` int(11) NOT NULL DEFAULT 0,
  `u_idx` int(11) NOT NULL DEFAULT 0,
  `c_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `c_content` varchar(255) NOT NULL,
  `groups` int(11) NOT NULL DEFAULT 0,
  `orders` int(11) NOT NULL DEFAULT 0,
  `depth` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`c_num`),
  KEY `u_idx` (`u_idx`),
  KEY `b_idx` (`b_idx`),
  CONSTRAINT `test_reply_ibfk_1` FOREIGN KEY (`u_idx`) REFERENCES `user` (`u_idx`),
  CONSTRAINT `test_reply_ibfk_2` FOREIGN KEY (`b_idx`) REFERENCES `test` (`b_idx`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.test_reply:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `test_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_reply` ENABLE KEYS */;

-- 테이블 jung.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `u_idx` int(10) NOT NULL AUTO_INCREMENT,
  `u_id` varchar(255) NOT NULL,
  `u_pw` varchar(255) NOT NULL,
  `u_name` varchar(255) NOT NULL,
  `u_tel` varchar(255) NOT NULL,
  `u_age` varchar(255) NOT NULL,
  `manager` int(11) NOT NULL DEFAULT 0,
  `u_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`u_idx`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.user:~19 rows (대략적) 내보내기
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`u_idx`, `u_id`, `u_pw`, `u_name`, `u_tel`, `u_age`, `manager`, `u_datetime`) VALUES
	(1, 'abc', '1234', 'NAME1', '010-0000-0000', '50', 1, '0000-00-00 00:00:00'),
	(3, 'rlaEodEOd', '111', '김땡땡', '010-1111-1111', '20', 0, '0000-00-00 00:00:00'),
	(4, 'b', '222', '이모씨', '010-2222-2222', '37', 0, '0000-00-00 00:00:00'),
	(5, 'ccc', '34343', '강하다', '010-2121-3232', '58', 0, '0000-00-00 00:00:00'),
	(6, 'dfdf', '545', '홍길동', '010-2898-4767', '44', 0, '0000-00-00 00:00:00'),
	(7, 'zyzy', '252d', '대한민국', '010-4747-3634', '88', 0, '0000-00-00 00:00:00'),
	(8, 'a1234', 'bbbb', '만세', '010-8487-7978', '69', 0, '0000-00-00 00:00:00'),
	(9, 'baba', 'cfdfd', '바비', '010-8787-1111', '56', 0, '0000-00-00 00:00:00'),
	(10, 'wew', 'qqqq', '박찬호', '010-7777-3232', '50', 0, '0000-00-00 00:00:00'),
	(11, 'a1', '5555', '강호동', '090-4343-4444', '32', 1, '0000-00-00 00:00:00'),
	(12, 'b1', '1111', '박길동', '090-3333-7777', '49', 0, '0000-00-00 00:00:00'),
	(13, 'bb1', '2222', '고길돌', '090-4444-6666', '61', 0, '0000-00-00 00:00:00'),
	(16, 'gbhuj', '1234', 'ok', '1-1-1', '11', 0, '0000-00-00 00:00:00'),
	(18, 'abcd', 'efg', 'abcd', '010-1234-1234', '30', 0, '0000-00-00 00:00:00'),
	(20, 'ttt', 'zxczxc', 'ttt', '010-7894-1412', '30', 0, '0000-00-00 00:00:00'),
	(21, 'zzxx', 'zzxx', 'zzxx', '010-1111-2222', '11', 0, '0000-00-00 00:00:00'),
	(22, 'gg', 'aa', 'aa', 'a-a-a', 'aa', 0, '0000-00-00 00:00:00'),
	(23, 'zxc', 'zxc', 'zxc', 'zxc-zxc-zxc', 'zxc', 0, '0000-00-00 00:00:00'),
	(24, 'ㅇㅇㅇ', '123123', 'ddd', '1231-1231-1231', '12', 0, '0000-00-00 00:00:00');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- 테이블 jung.userauth 구조 내보내기
CREATE TABLE IF NOT EXISTS `userauth` (
  `u_id` varchar(50) NOT NULL,
  `u_auth` varchar(50) NOT NULL,
  PRIMARY KEY (`u_id`,`u_auth`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 jung.userauth:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `userauth` DISABLE KEYS */;
INSERT INTO `userauth` (`u_id`, `u_auth`) VALUES
	('aa', 'ROLE_ADMIN'),
	('aa', 'ROLE_USER'),
	('asd', 'ROLE_USER'),
	('dd', 'ROLE_USER'),
	('zz', 'ROLE_USER');
/*!40000 ALTER TABLE `userauth` ENABLE KEYS */;

-- 테이블 jung.userlist 구조 내보내기
CREATE TABLE IF NOT EXISTS `userlist` (
  `u_id` varchar(50) NOT NULL,
  `u_password` varchar(200) DEFAULT NULL,
  `u_name` varchar(200) DEFAULT NULL,
  `u_phone` int(50) DEFAULT NULL,
  `u_datetime` datetime DEFAULT current_timestamp(),
  `u_isAccountNonExpired` tinyint(10) DEFAULT NULL,
  `u_isAccountNonLocked` tinyint(10) DEFAULT NULL,
  `u_isCredentialNonExpired` tinyint(10) DEFAULT NULL,
  `u_isEnabled` tinyint(10) DEFAULT NULL,
  `u_auth` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`u_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 jung.userlist:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `userlist` DISABLE KEYS */;
INSERT INTO `userlist` (`u_id`, `u_password`, `u_name`, `u_phone`, `u_datetime`, `u_isAccountNonExpired`, `u_isAccountNonLocked`, `u_isCredentialNonExpired`, `u_isEnabled`, `u_auth`) VALUES
	('aa', '$2a$10$EDtcH3Ptp1BqdPxSU5TKpe7W3v/rf9NieuJtWr6g.MnCk3nrSLr.G', 'aa', 123123, '2022-01-10 18:23:31', 1, 1, 1, 1, 0),
	('asd', '$2a$10$WegzPvLl9oC2infDhUVwSuVcYFvwNoi3kHQXQ4AXJgQZKhg8l33XS', 'asd', 666666, '2022-01-11 00:35:46', 1, 1, 1, 1, 0),
	('dd', '$2a$10$RK2KuyFh.117wW4dxpRTd.mbgyO8E.7oej8WzHsWNW4XJsDrwBJEq', 'dd', 44333222, '2022-01-11 00:35:34', 1, 1, 1, 1, 0),
	('zz', '$2a$10$53ziV3dMpSjlXdVjtYKA..8z/MVTaQVAsyT95xfNFYVz1v8XxKvpO', 'zz', 222333, '2022-01-11 00:35:26', 1, 1, 1, 1, 0);
/*!40000 ALTER TABLE `userlist` ENABLE KEYS */;

-- 테이블 jung.vue_board 구조 내보내기
CREATE TABLE IF NOT EXISTS `vue_board` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(300) DEFAULT NULL,
  `writer` varchar(50) DEFAULT NULL,
  `datetime` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hit` int(11) DEFAULT 0,
  `groups` int(11) DEFAULT 0,
  `orders` int(11) DEFAULT 0,
  `depth` int(11) DEFAULT 0,
  PRIMARY KEY (`b_id`),
  KEY `writer` (`writer`),
  CONSTRAINT `vue_board_ibfk_1` FOREIGN KEY (`writer`) REFERENCES `userlist` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.vue_board:~11 rows (대략적) 내보내기
/*!40000 ALTER TABLE `vue_board` DISABLE KEYS */;
INSERT INTO `vue_board` (`b_id`, `title`, `content`, `writer`, `datetime`, `hit`, `groups`, `orders`, `depth`) VALUES
	(15, '1', 'sdesd', 'zz', '2022-01-13 20:16:02', 2, 15, 1, 0),
	(16, '2', 'wetfg', 'zz', '2022-01-13 22:36:05', 8, 16, 1, 0),
	(17, '3', 'ewsrf', 'zz', '2022-01-13 22:12:56', 4, 17, 1, 0),
	(18, '2-1', 'rseyghers', 'zz', '2022-01-13 20:15:55', 1, 16, 7, 1),
	(19, '2-2', 'sertg', 'zz', '2022-01-13 22:32:07', 3, 16, 4, 1),
	(20, '2-3', 'srfhrsrf', 'zz', '2022-01-14 00:53:02', 4, 16, 2, 1),
	(21, '2-2/1', 'sdfgh', 'zz', '2022-01-13 10:38:48', 1, 16, 6, 2),
	(22, '2-2/2', 'shyhjsj', 'zz', '2022-01-13 20:12:24', 1, 16, 5, 2),
	(23, '2-3/1', 'sdeg', 'zz', '2022-01-13 22:20:32', 1, 16, 3, 2);
/*!40000 ALTER TABLE `vue_board` ENABLE KEYS */;

-- 테이블 jung.vue_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `vue_comment` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `bid` int(11) DEFAULT NULL,
  `content` varchar(50) DEFAULT NULL,
  `writer` varchar(50) DEFAULT NULL,
  `datetime` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `groups` int(11) DEFAULT 0,
  `orders` int(11) DEFAULT 0,
  `depth` int(11) DEFAULT 0,
  PRIMARY KEY (`c_id`),
  KEY `bid` (`bid`),
  KEY `writer` (`writer`),
  CONSTRAINT `vue_comment_ibfk_1` FOREIGN KEY (`bid`) REFERENCES `vue_board` (`b_id`),
  CONSTRAINT `vue_comment_ibfk_2` FOREIGN KEY (`writer`) REFERENCES `userlist` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 jung.vue_comment:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `vue_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `vue_comment` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
