-- Create the database
CREATE DATABASE library_management_system;

-- Use the database
USE library_management_system;

-- Create the Authors table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Biography TEXT
);

-- Create the Publishers table
CREATE TABLE Publishers (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

-- Create the Books table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    PublicationDate DATE,
    AuthorID INT,
    PublisherID INT,
    Genre VARCHAR(50),
    Status ENUM('Available', 'Checked Out', 'Reserved') DEFAULT 'Available' NOT NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- Create the Members table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(200),
    MembershipDate DATE NOT NULL,
    Status ENUM('Active', 'Inactive', 'Suspended') DEFAULT 'Active' NOT NULL
);

-- Create the Loans table
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    Status ENUM('Pending', 'Returned', 'Overdue') DEFAULT 'Pending' NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Create the Reservations table
CREATE TABLE Reservations (
    ReservationID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    ReservationDate DATE NOT NULL,
    Status ENUM('Pending', 'Active', 'Cancelled', 'Completed') DEFAULT 'Pending' NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Create the Book_Keywords table (for many-to-many relationship between Books and Keywords)
CREATE TABLE Book_Keywords (
    BookID INT,
    Keyword VARCHAR(50),
    PRIMARY KEY (BookID, Keyword),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Create the Reviews table
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
