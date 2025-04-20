# System Requirements Specification

- For 'AirTassili'
- Version 1.0.0
- Organization of Web Development and Innovation
- Date Created: 2025-02-26

---
Refer
# Table of Contents

1. [Introduction](#introduction)
   - [Purpose](#purpose)
   - [Scope](#scope)
   - [Definitions, Acronyms, and Abbreviations](#definitions-acronyms-and-abbreviations)
   - [References](#references)
   - [Overview](#overview)

2. [Overall Description](#overall-description)
   - [Product Perspective](#product-perspective)
   - [Product Functions](#product-functions)
   - [User Classes and Characteristics](#user-classes-and-characteristics)
   - [Operating Environment](#operating-environment)
   - [Design and Implementation Constraints](#design-and-implementation-constraints)
   - [User Documentation](#user-documentation)
   - [Assumptions and Dependencies](#assumptions-and-dependencies)

3. [Specific Requirements](#specific-requirements)
   - [External Interface Requirements](#external-interface-requirements)
   - [Functional Requirements](#functional-requirements)
   - [Performance Requirements](#performance-requirements)
   - [Logical Database Requirements](#logical-database-requirements)
   - [Design Constraints](#design-constraints)
   - [Software System Attributes](#software-system-attributes)

---

## 1. Introduction

##### 1.1 Purpose

The purpose of this document is to define a SRS for 'LIBSYS', a library management
system online which handles book tracking, lending operations and member management.

This document is intended for developers, project managers and stakeholders.

##### 1.2 Scope

LIBSYS will provide a centralized system for managing books and members. It will be
responsible for tracking, assigning and moving books to and from members. It wil not
include advanced analytics and data analysis capabilites.

###### 1.3 Definitions, Acronyms, and Abbreviations


-SRS : software Requirements Specifications
- ISBN: International Standard Book Number.
- API: Application Programming Interface.
- UI: User Interface.

##### 1.4 References

[IEEE 830-1998: IEEE Recommended Practice for Software Requirements Specifications.](https://press.rebus.community/requirementsengineering/back-matter/appendix-c-ieee-830-template/)

##### 1.5 Overview

This document is divided into three major sections. The 1st sections describes the
workings of this document and tells an introduction about the project and its scope.
The 2nd section gives and overall description regarding dependencies of the system,
contraints the system must adhere to and brief documentation about User classes and characteristics
The 3rd and final major section goes into details about functional and non-functional
requirements.Refer

## 2. Overall Description

##### 2.1 Product Perspective

'LIBSYS' is a standalone system that will integrate with university management system.
Users of the system will have the capacity to import and export their data to and from
the system into their respective department software.

It will also interface will a book barcode to ensure fast and easy creation of books in the system.

##### 2.2 Product Functions

"LIBSYS will support the following functions:

1. Member registration and management.
2. Book lending and return.
3. Inventory management and tracking."`

##### 2.3 User Classes and Characteristics

The primary users of 'LIBSYS' are:

1. Librarians (less than admins, but manage system with restricted privileges)
2. Members (one who borrow books)
3. Admins

##### 2.4 Operating Environment

'LIBSYS' will run in a web-based platform, compatible with modern browsers (Chrome, Brave, firefox, Edge). The backend will run on a linux server with MySQL as the database.

##### 2.5 Design and Implementation Constraints

'LIBSYS' must comply with DGPR (General Data Protection Regulation) for data privacy. The system must also support multi-language functionality for international users.

##### 2.6 User Documentation

User documentation will include a user manual and online help guides.

##### 2.7 Assumptions and Dependencies


It is assumed that the university's student management system will provide member data.
LIBSYS depends on the availability of this system for member authentication.

## 3. Specific Requirements

##### 3.1 External Interface Requirements

'LIBSYS' will provide a web-based user interface accessible via browsers. It will also integrate with a barcode scanner for book tracking.

##### 3.2 Functional Requirements

- FR-1: The system shall allow librarians to add, update, and delete book records.
- FR-2: The system shall allow members to search for books by title, author, or ISBN.

##### 3.3 Performance Requirements

The system shall support up to 500 concurrent users with a response time of less than 2 seconds for search queries.

##### 3.4 Logical Database Requirements

The database shall include tables for books, members, and transactions. Each book record shall include fields for title, author, ISBN, and availability status.

##### 3.5 Design Constraints

The system must use open-source technologies to minimize licensing costs.

##### 3.6 Software System Attributes

The system shall have 99.9% uptime and shall encrypt all sensitive data in transit and at rest

##### 3.7 Functional Requirements (Detailed)

- FR-10: The system shall send automated reminders to members for overdue books.
- *...other requirements*

