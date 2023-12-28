-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2023 at 09:46 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expense_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `add_category`
--

CREATE TABLE `add_category` (
  `id` int(255) NOT NULL,
  `category` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `add_category`
--

INSERT INTO `add_category` (`id`, `category`) VALUES
(1, 'salary'),
(2, 'shopping'),
(3, 'food'),
(4, 'transportation'),
(6, 'entertainment'),
(9, 'coffee');

-- --------------------------------------------------------

--
-- Table structure for table `budget_limit`
--

CREATE TABLE `budget_limit` (
  `id` int(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `budget_limit` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `budget_limit`
--

INSERT INTO `budget_limit` (`id`, `category`, `budget_limit`) VALUES
(1, 'food', '1000'),
(2, 'purchase', '1000');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` int(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `note` varchar(255) NOT NULL,
  `date` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `budget_limit_value_send` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `amount`, `type`, `note`, `date`, `category`, `budget_limit_value_send`) VALUES
(1, '50000', 'Income', 'got', '2023-11-30 14:02:38.002618', 'salary', '100000'),
(2, '600', 'Expense', 'Expense', '2023-11-30 14:03:02.511624', 'shopping', '1000'),
(3, '400', 'Expense', 'Expense', '2023-11-30 14:03:35.086220', 'shopping', '1000'),
(4, '500', 'Expense', 'Expense', '2023-11-09 00:00:00.000', 'transportation', '1000'),
(5, '500', 'Expense', 'Expense', '2023-11-09 00:00:00.000', 'transportation', '1000'),
(6, '500', 'Expense', 'Expense', '2023-11-09 00:00:00.000', 'transportation', '1000'),
(7, '500', 'Expense', 'Expense', '2023-11-09 00:00:00.000', 'transportation', '1000'),
(8, '500', 'Expense', 'Expense', '2023-11-09 00:00:00.000', 'transportation', '1000');

-- --------------------------------------------------------

--
-- Table structure for table `user_registraion`
--

CREATE TABLE `user_registraion` (
  `id` int(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_registraion`
--

INSERT INTO `user_registraion` (`id`, `username`, `email`, `phone`, `password`) VALUES
(4, 'pp', 'pp', 'pp', 'pp'),
(5, 'hh', 'hh@gmail.com', '69', 'hh'),
(6, 'jibin', 'jib@gmail.com', '9764351249', 'jibin123'),
(7, 'malu', 'malu123@gmail.com', '7645312599', 'malu123456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_category`
--
ALTER TABLE `add_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `budget_limit`
--
ALTER TABLE `budget_limit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_registraion`
--
ALTER TABLE `user_registraion`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_category`
--
ALTER TABLE `add_category`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `budget_limit`
--
ALTER TABLE `budget_limit`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_registraion`
--
ALTER TABLE `user_registraion`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
