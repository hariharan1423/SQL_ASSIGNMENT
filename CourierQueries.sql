--switching into courierSystem database 
use CourierSystem;

--creating user table
create table [user] 
(userId int primary key,
Name VARCHAR(255),
Email VARCHAR(255) UNIQUE,
Password VARCHAR(255),
ContactNumber VARCHAR(20),
Address TEXT );



--creating courier table
create table Courier (
CourierID INT PRIMARY KEY,
SenderName VARCHAR(255),
SenderAddress TEXT,
ReceiverName VARCHAR(255),
ReceiverAddress TEXT,
Weight DECIMAL(5, 2),
Status VARCHAR(50),
TrackingNumber VARCHAR(20) UNIQUE,
DeliveryDate DATE
);

--creating courierServices table
create table CourierServices (
ServiceID INT PRIMARY KEY,
ServiceName VARCHAR(100),
Cost DECIMAL(8, 2)
);

--creating employee table 
CREATE TABLE EMPLOYEE 
(EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(255),
Email VARCHAR(255) UNIQUE,
ContactNumber VARCHAR(20),
Role VARCHAR(50),
Salary DECIMAL(10, 2));

--CREATING LOCATION TABLE
CREATE TABLE [LOCATION](
LocationID INT IDENTITY(1,1) PRIMARY KEY,
LocationName VARCHAR(100),
Address TEXT
); 

--CREATING PAYMENT TABLE 
CREATE TABLE PAYMENT(
PaymentID INT IDENTITY(1,1) PRIMARY KEY,
CourierID INT,
LocationId INT,
Amount DECIMAL(10, 2),
PaymentDate DATE,
FOREIGN KEY (CourierID) REFERENCES Courier(CourierID),
FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);


--Here, I'm altering the scheme because some questions need those columns for the required answer.
-------------------------------------------------------------------------
--adding userId as foreign key to payment table
alter table payment add userId int;

alter table payment add constraint FK_Payment
foreign key (userId) references [user](userId);


--adding  employee id foreign key to courier table
alter table courier add employeeId int;

alter table courier add constraint FK_Courier_Employee
foreign key (employeeId) references employee(employeeId);


--adding  USER id foreign key to courier table
alter table courier add userId int;

alter table courier add constraint FK_Courier_User
foreign key (userId) references [user](userId);

--adding  service id foreign key to courier table
alter table courier add serviceId int;

alter table courier add constraint FK_Courier_Service
foreign key (serviceId) references [CourierServices](serviceId);
--------------------------------------------------------------------------

--inserting values into user table

insert into [user] values(1, 'John Doe', 'john.doe@example.com', 'password123', '123-456-7890', '123 Main St, Cityville, ABC'),
(2, 'Jane Smith', 'jane.smith@example.com', 'abc123', '987-654-3210', '456 Oak St, Townsville, XYZ'),
(3, 'Michael Johnson', 'michael.j@example.com', 'pass123', '555-555-5555', '789 Elm St, Villageton, DEF'),
(4, 'Emily Davis', 'emily.davis@example.com', 'securepass', '111-222-3333', '321 Pine St, Hamletown, GHI'),
(5, 'Chris Wilson', 'chris.w@example.com', 'qwerty', '444-444-4444', '555 Cedar St, Boroughville, JKL');

--inserting values into courier table
INSERT INTO Courier (CourierID, SenderName, SenderAddress, ReceiverName, ReceiverAddress, [Weight], [Status], TrackingNumber, DeliveryDate,employeeId,userId,serviceId) 
VALUES
(1, 'John Doe', '123 Main St, Cityville, ABC', 'Jane Smith', '456 Elm St,Villa', 11, 'In transit', 'TRK123456789', '2024-04-28',2,2,3),
(2, 'Michael Johnson', '789 Elm St, Villageton, DEF', 'Bob White', '321 Maple St,TownsVille', 12, 'Delivered', 'TRK987654321', '2023-04-27',1,3,1),
(3, 'Emily Davis',  '321 Pine St, Hamletown, GHI', 'Michael Brown', '999 Cedar St,Cityville', 4, 'Pending', 'TRK567890100', NULL,2,4,2),
(4, 'Jane Smith', '789 Elm St, Villageton, DEF', 'Bob White', '321 Maple St,TownsVille', 3, 'Delivered', 'TRK987654331', '2024-04-11',3,1,4),
(5, 'Chris Wilson',  '321 Pine St, Hamletown, GHI', 'Michael Brown', '999 Cedar St,Cityville', 5, 'Not Delivered', 'TRK567890123', NULL,4,1,4);


--inserting values into employee table
insert into employee values('Christopher Davis', 'christopher.davis@example.com', '444-444-4444', 'IT Specialist', 40000.00),
('Sarah Wilson', 'sarah.wilson@example.com', '666-666-6666', 'Human Resources Coordinator', 38000.00),
('David Martinez', 'david.martinez@example.com', '777-777-7777', 'Operations Manager', 55000.00),
('Amanda Taylor', 'amanda.taylor@example.com', '888-888-8888', 'Marketing Coordinator', 36000.00),
('James Anderson', 'james.anderson@example.com', '999-999-9999', 'Warehouse Supervisor', 42000.00);
insert into employee values ('Davis', 'davis.ka@example.com', '444-444-4444', 'IT Specialist', 40000.00);
insert into employee values('Wilson', 'wilson.wil@gmail.com', '666-666-6666', 'Human Resources Coordinator', 38000.00);


--inserting values into courier services table 
insert into CourierServices values 
(1, 'Standard Shipping', 10.00),
(2, 'Express Shipping', 20.00),
(3, 'Overnight Shipping', 30.00),
(4, 'International Economy', 15.00),
(5, 'International Standard', 25.00);

--inserting values into location table
insert into location values 
('Main Office', '123 Main St, Cityville, ABC'),
('Branch A', '456 Oak St, Townsville, XYZ'),
('Branch B', '789 Elm St, Villageton, DEF'),
('Warehouse', '321 Pine St, Hamletown, GHI'),
('Distribution Center', '555 Cedar St, Boroughville, JKL');

--inserting values into payment table
insert into payment values
(1, 1, 5000.00, '2024-04-20', 2),
(2, 2, 3005.75, '2023-04-24', 3),
(3, 2, 7000.25, '2024-04-26', 1),
(4, 3, 450.50, '2024-04-01', 4),
(5, 5, 40.20, '2024-04-28', 5);


--task2 question

--1 List all customers: 
select * from [user];

--2 List all orders for a specific customers
select * from courier where SenderName = 'John Doe';

--3 list all couriers 
select * from courier;

--4 List all packages for a specific order:
select * from courier
where TrackingNumber = 'TRK123456789';

--5.List all deliveries for a specific courier;
select * from courier 
where Status = 'Delivered';

--6 List all undelivered packages
select * from Courier 
where Status = 'Not Delivered';

--7 List all packages that are scheduled for delivery today
select * from Courier 
where DeliveryDate = GETDATE();

--8 List all packages with a specific status:
select * from courier 
where status ='In Transit';

--9 Calculate the total number of packages for each courier.
select s.serviceId,s.serviceName,COUNT(c.courierId) as TotalCouriers 
from courier c 
join CourierServices s
on c.serviceId = s.ServiceID
group by s.ServiceID , s.ServiceName;


--.10 Find the average delivery time for each courier 
select c.courierID, AVG(DATEDIFF(DAY, P.PaymentDate, C.DeliveryDate)) AS AverageDelivery from Courier C
join Payment P on C.CourierID = P.CourierID
group by C.CourierID;

--11 List all packages with a specific weight range: 
select * from courier 
where weight between 10 and 20;

--12 Retrieve employees whose names contain 'John'
select * from [user] 
where [Name] like '%John%';

--13.Retrieve all courier records with payments greater than $50. 
select CourierID,Amount from payment 
WHERE amount >50;

--updating password
--update [user] set [Password] = '1233432' where [Name] = 'John Doe' and Email = 'john.doe@example.com';

--task 3 questions

--14. Find the total number of couriers handled by each employee.
select e.employeeId,count(courierId) as totalCouriers from courier c 
join employee e 
on c.employeeId=e.employeeId 
group by e.employeeId;

--15. Calculate the total revenue generated by each location
select locationName , sum(amount) as totalRevenue from payment p
join location l 
on p.LocationId=l.LocationID 
group by p.LocationId,LocationName;

--16. Find the total number of couriers delivered to each location. 
select l.LocationName, COUNT(c.CourierID) AS TotalCouriersDelivered from Location l
join payment p
on l.LocationID = p.LocationId
join Courier c on p.CourierID=c.CourierID
where c.Status = 'delivered'
group by l.LocationID,l.LocationName;

--17. Find the courier with the highest average delivery time: 
select top 1 c.courierID, AVG(DATEDIFF(DAY, P.PaymentDate, C.DeliveryDate)) AS AverageDelivery from Courier C
join Payment P on C.CourierID = P.CourierID
group by C.CourierID 
order by AverageDelivery desc;

--18. Find Locations with Total Payments Less Than a Certain Amount
select l.LocationID,l.LocationName, SUM(Amount) as TotalPayments from Payment p
join [LOCATION] l 
on l.LocationID=p.locationId
group by l.LocationID ,l.LocationName
having SUM(Amount) < 780;

--19. Calculate Total Payments per Location 
select l.LocationID,l.LocationName, SUM(Amount) as TotalPayments from Payment p
join [LOCATION] l 
on l.LocationID=p.locationId
group by l.LocationID ,l.LocationName
having SUM(Amount) < 780;

--20 Retrieve couriers who have received payments totaling more than $1000 in a specific location (LocationID = X):
select CourierID from Payment
where LocationID = 3
group by CourierID
having SUM(Amount) > 1000;

--21. Retrieve couriers who have received payments totaling more than $1000 after a certain date (PaymentDate > 'YYYY-MM-DD'):
select CourierID
from Payment
where PaymentDate > '2024-04-02'
group by CourierID
having SUM(Amount) > 1000;

--22. Retrieve locations where the total amount received is more than $5000 before a certain date (PaymentDate > 'YYYY-MM-DD') select LocationID
from Payment
where PaymentDate < '2024-04-02'
group by LocationID
having SUM(Amount) > 5000;

--TASK 4 

--23. Retrieve Payments with Courier Information 
select * from payment p 
join courier c 
on p.courierId = c.courierId;

--24. Retrieve Payments with Location Information 
select * from payment p 
join location l 
on p.LocationId = l.LocationID;

--25. Retrieve Payments with Courier and Location Information
select * from payment p 
join location l 
on p.locationId = l.locationId 
join courier c 
on p.CourierID = l.LocationID;

--26. List all payments with courier details
select * from payment p 
join Courier c 
on p.CourierID = c.CourierID;

--27. Total payments received for each courier 
select p.CourierID,sum(amount) as totalPaymets from payment p
join Courier c
on p.courierId = c.CourierID
group by p.CourierID;

--28. List payments made on a specific date 
select * from payment 
where PaymentDate = '2024-04-26';

--29. Get Courier Information for Each Payment 
select * from courier c 
right join payment p
on p.CourierID=c.CourierID

--30. Get Payment Details with Location 
select * from payment p
left join location l
on p.LocationId=l.LocationID;

--31. Calculating Total Payments for Each Courier
select p.courierId,sum(amount) as totalPayments from payment p
join courier c 
on p.CourierID = c.CourierID
group by p.CourierID;

--32. List Payments Within a Date Range 
select * from PAYMENT
where PaymentDate between '2021-02-12' and '2023-05-12';

--33. Retrieve a list of all users and their corresponding courier records, including cases where there are no matches on either side 
select * from [user] u 
full outer join courier c 
on u.userId = c.userId;

--34. Retrieve a list of all couriers and their corresponding services, including cases where there are no matches on either side (doutbt)
select * from Courier c
full outer join CourierServices s
on s.ServiceID = c.serviceId;

--35. Retrieve a list of all employees and their corresponding payments, including cases where there are no matches on either side  (doubt)
select e.EmployeeID, e.Name,PaymentID,p.Amount, p.PaymentDate
FROM Employee e
FULL OUTER JOIN courier c ON c.EmployeeID = e.EmployeeID
full outer join payment p  ON p.CourierID =c.CourierID;


--36. List all users and all courier services, showing all possible combinations.
select * from [user] u 
cross join courier c;

--37. List all employees and all locations, showing all possible combinations:
select * from employee 
cross join LOCATION;

--38. Retrieve a list of couriers and their corresponding sender information (if available)
select * from courier c
join [user] u 
on c.userId = u.userId;

--39.Retrieve a list of couriers and their corresponding receiver information (if available):
select * from Courier c
join [user] u 
on c.ReceiverName = u.[Name];

--40.Retrieve a list of couriers along with the courier service details (if available): (doubt)
select * from Courier c
join CourierServices s
on c.serviceId = s.serviceID;

--41. Retrieve a list of employees and the number of couriers assigned to each employee:
select e.[Name],c.courierId from employee e 
join Courier c
on e.EmployeeID = c.employeeId;

--42. Retrieve a list of locations and the total payment amount received at each location:
select l.LocationID,l.LocationName, SUM(Amount) as TotalPayments from Payment p
join [LOCATION] l 
on l.LocationID=p.locationId
group by l.LocationID ,l.LocationName;

--43. Retrieve all couriers sent by the same sender (based on SenderName).
select * from courier 
where SenderName = 'John Doe';

--44. List all employees who share the same role.
select * , ROW_NUMBER() over (partition by [role] order by [Name]) as [Role] from EMPLOYEE where role in (select role from employee group by role having count(role)>1);

--45. Retrieve all payments made for couriers sent from the same location.
select * , ROW_NUMBER() over (partition by [locationId] order by [amount]) as [LocationOrder] from payment
where courierid in (
    select c1.CourierID from Courier c1
    join Courier c2 
	on CAST(c1.SenderAddress AS VARCHAR(255)) = CAST(c2.SenderAddress AS VARCHAR(255))
    where c1.CourierID <> c2.CourierID
);

--46. Retrieve all couriers sent from the same location (based on SenderAddress). 
select * from courier
where courierid in (
    select C1.CourierID from Courier C1
    join Courier C2 
	on CAST(C1.SenderAddress AS VARCHAR(255)) = CAST(C2.SenderAddress AS VARCHAR(255))
    where C1.CourierID <> C2.CourierID
);

--47. List employees and the number of couriers they have delivered:
select * from employee e 
join courier c
on e.EmployeeID = c.employeeId
where [Status] = 'Delivered';

--48. Find couriers that were paid an amount greater than the cost of their respective courier services 
select c.*,amount,cost from Courier c
join CourierServices s 
on c.ServiceID = s.ServiceID
join Payment p 
on c.CourierID = p.CourierID
where p.Amount > s.Cost;

--49. Find couriers that have a weight greater than the average weight of all couriers
select * from courier where [weight] > (select avg(weight) from courier);

--50. Find the names of all employees who have a salary greater than the average salary:
select [Name] from employee where salary > (select Avg(Salary) from employee);

--51. Find the total cost of all courier services where the cost is less than the maximum cost 
select SUM(Cost) as TotalCost
from CourierServices s
where Cost < (select MAX(Cost) from CourierServices);

--52. Find all couriers that have been paid for 
select * from courier c
join payment p
on c.CourierID = p.CourierID;

--53. Find the locations where the maximum payment amount was made 
select top 1 LocationName,amount 
from [Location] l 
join PAYMENT p 
on p.LocationId = l.LocationID
order by Amount desc;

--54. Find all couriers whose weight is greater than the weight of all couriers sent by a specific sender
select max(weight) as MaxWeight from courier where SenderName = 'John Doe';
