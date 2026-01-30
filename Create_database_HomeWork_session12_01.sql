create database Homework_session12_01;
-- Tạo bảng
create table customers(
	customer_id serial primary key,
	name varchar(50),
	email varchar(50)
);
create table customer_log(
	log_id serial primary key,
	customer_name varchar(50),
	action_time timestamp
);
-- Tạo function cho trigger tg_insert_customers
create or replace function f_insert_customers()
returns trigger as $$
begin
	if tg_op = 'INSERT' then
		insert into customer_log(customer_name, action_time) values
		(new.name, current_timestamp);
		return new;
	end if;
end;
$$ language plpgsql;
-- Tạo TRIGGER để tự động ghi log khi INSERT vào customers
create or replace trigger tg_insert_customers
after insert on customers
for each row
execute function f_insert_customers();
-- insert data
INSERT into customers(name, email) values
('Nguyen Duc Hong Quan', 'quan41144@gmail.com'),
('Nguyen Khanh Van', 'kvanxing@gmail.com');
-- Kiểm tra lại
select * from customer_log;