-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 27, 2020 at 10:24 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mazebank`
--

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `account_no` bigint(10) NOT NULL,
  `branch_id` int(10) NOT NULL,
  `balance` bigint(10) NOT NULL,
  `type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`account_no`, `branch_id`, `balance`, `type`) VALUES
(2020100001, 1, 3000, 'Savings'),
(2020100002, 4, 1000, 'Savings'),
(2020100003, 2, 500, 'savings'),
(2020100004, 3, 0, 'savings');

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `bank_id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `website` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`bank_id`, `name`, `website`, `type`, `address`) VALUES
(1, 'MazeBank', 'www.mazebank.com', 'Private', 'Maharashtra, India');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(10) NOT NULL,
  `bank_id` int(10) NOT NULL,
  `name` varchar(20) NOT NULL,
  `address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `bank_id`, `name`, `address`) VALUES
(1, 1, 'Thane', 'Thane, Maharashtra'),
(2, 1, 'Bhiwandi', 'Bhiwandi, Maharashtra'),
(3, 1, 'Nerul', 'Nerul, Maharashtra'),
(4, 1, 'Taloja', 'Taloja, Maharashtra');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `tr_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `account_no` bigint(10) NOT NULL,
  `type` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `transfer_acc_no` bigint(10) DEFAULT NULL,
  `amount` bigint(10) NOT NULL,
  `current_balance` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`tr_id`, `user_id`, `account_no`, `type`, `created_at`, `transfer_acc_no`, `amount`, `current_balance`) VALUES
(2, 1, 2020100001, 'Deposit', '2020-09-21 10:49:22', NULL, 500, 500),
(3, 1, 2020100001, 'Deposit', '2020-09-25 19:08:37', NULL, 500, 1000),
(4, 1, 2020100001, 'Deposit', '2020-09-25 19:13:01', NULL, 1000, 2000),
(5, 1, 2020100001, 'Deposit', '2020-09-25 19:24:14', NULL, 500, 2500),
(6, 1, 2020100001, 'Deposit', '2020-09-25 19:26:36', NULL, 1000, 3500),
(8, 1, 2020100001, 'Withdraw', '2020-09-27 18:46:12', NULL, 500, 3000),
(9, 1, 2020100001, 'Withdraw', '2020-09-27 18:52:59', NULL, 1000, 2000),
(10, 2, 2020100002, 'Deposit', '2020-09-27 18:56:07', NULL, 1000, 1000),
(11, 3, 2020100003, 'Deposit', '2020-09-27 19:14:13', NULL, 500, 500),
(12, 1, 2020100001, 'Withdraw', '2020-09-27 19:14:14', NULL, 500, 1500),
(13, 1, 2020100001, 'Deposit', '2020-09-27 20:18:52', NULL, 1500, 3000);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(10) NOT NULL,
  `account_no` bigint(10) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` bigint(10) NOT NULL,
  `address` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `pan` varchar(10) NOT NULL,
  `pin` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `account_no`, `first_name`, `last_name`, `email`, `phone`, `address`, `dob`, `pan`, `pin`) VALUES
(1, 2020100001, 'Omkar', 'Babrekar', 'babrekaromkar@gmail.com', 9930923562, 'Thane, Maharashtra', '2020-09-21', 'ASDFG3562O', 3562),
(2, 2020100002, 'Aman', 'Kazi', 'amankazi1319@gmail.com', 8208800633, 'Taloja, Maharashtra', '2020-09-16', 'ZXCVB0633A', 1319),
(3, 2020100003, 'Adeeba', 'Ansari', 'adeeba.anj@gmail.com', 9930923562, 'Bhiwandi, Maharashtra', '2000-03-16', 'ZXCVB4813A', 4813),
(4, 2020100004, 'Ibrahim', 'Sarguroh', 'ibbu@gmail.com', 9876543210, 'Nerul, Maharashtra', '2020-09-08', 'QWERT1234I', 1234);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`account_no`),
  ADD KEY `branch_id` (`branch_id`);

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`bank_id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`),
  ADD KEY `bank_id` (`bank_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`tr_id`),
  ADD KEY `account_no` (`account_no`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `account_no` (`account_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `account_no` bigint(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2020100005;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `tr_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`);

--
-- Constraints for table `branch`
--
ALTER TABLE `branch`
  ADD CONSTRAINT `branch_ibfk_1` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`bank_id`);

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`account_no`) REFERENCES `account` (`account_no`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`account_no`) REFERENCES `account` (`account_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
