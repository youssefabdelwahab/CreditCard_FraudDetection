 select a.* , b.credit_card_num , c.transaction_id , c.amount 
 from cardholder as a 
 left join credit_card as b on (a.customer_id = b.customer_id)
 left join transactions as c on (b.credit_card_num = c.card)
 group by a.customer_id , b.credit_card_num , c.transaction_id , c.amount 


select a.customer_id, a.customer_name , b.credit_card_num , count(case c.amount<=2.00  when true then 1 else 0 end) as two_dollar_trans
from cardholder as a  
left join credit_card as b on (a.customer_id = b.customer_id) 
left join transactions as c on (b.credit_card_num = c.card)
group by a.customer_id , a.customer_name , b.credit_card_num 

select transaction_id , date, amount , card 
from transactions 
where cast(date as time) >= '07:00:00' and cast(date as time) <= '09:00:00'
order by amount desc 
limit 100 


select transaction_id , date, amount , card 
from transactions 
where cast(date as time) >= '07:00:00' and cast(date as time) <= '09:00:00'
order by amount desc 


select transaction_id , date, amount , card 
from transactions 
where cast(date as time) not  between '07:00:00' and '09:00:00' 
order by amount desc 


select a.merchant_id , a.merchant_name, count(case b.amount<=2.00  when true then 1 else 0 end) as two_dollar_trans
from merchant as a 
left join merchant_category as c on (a.merchant_cat = c.merchant_cat_id)
left join transactions as b on (a.merchant_id = b.merchant_id)
group by a.merchant_id , a.merchant_name
order by two_dollar_trans desc
limit 5


select a.*  , b.credit_card_num , c.transaction_id , c.date , c.amount , d.merchant_name
from cardholder as a 
left join credit_card as b on (a.customer_id = b.customer_id)
left join transactions as c on (b.credit_card_num = c.card)
left join merchant as d on (c.merchant_id = d.merchant_id)
where a.customer_id = 2 or a.customer_id = 18 
group by a.customer_id , b.credit_card_num , c.transaction_id , d.merchant_name
order by a.customer_id asc



select a.customer_name , b.credit_card_num , c.transaction_id , c.date , c.amount , d.merchant_name , d.merchant_cat
from cardholder as a 
left join credit_card as b on(a.customer_id = b.customer_id)
left join transactions as c on (b.credit_card_num  = c.card)
left join merchant as d on (c.merchant_id = d.merchant_id)
where a.customer_id = 25 
group by a.customer_name , b.credit_card_num , c.transaction_id , c.date , c.amount , d.merchant_name , d.merchant_cat
having d.merchant_cat = 1
order by date asc 
limit 13

select a.customer_id , a.customer_name , b.credit_card_num , c.transaction_id , c.amount
from cardholder as a 
left join credit_card as b on (a.customer_id = b.customer_id) 
left join transactions as c on (b.credit_card_num = c.card)
where a.customer_id = 1 
order by c.amount desc 

create view transactions_grouped_by_id as 
select a.* , b.credit_card_num , c.transaction_id , c.amount 
from cardholder as a 
left join credit_card as b on (a.customer_id = b.customer_id)
left join transactions as c on (b.credit_card_num = c.card)
group by a.customer_id , b.credit_card_num , c.transaction_id , c.amount 

select * from transactions_grouped_by_id

create view two_dollar_trans_per_cardholder as 
select a.customer_id, a.customer_name , b.credit_card_num , count(case c.amount<=2.00  when true then 1 else 0 end) as two_dollar_trans
from cardholder as a  
left join credit_card as b on (a.customer_id = b.customer_id) 
left join transactions as c on (b.credit_card_num = c.card)
group by a.customer_id , a.customer_name , b.credit_card_num 

create view top_100_trans_7_9 as 
select transaction_id , date, amount , card 
from transactions 
where cast(date as time) >= '07:00:00' and cast(date as time) <= '09:00:00'
order by amount desc 
limit 100 


create view top_5_merchants_hacked as 
select a.merchant_id , a.merchant_name, count(case b.amount<=2.00  when true then 1 else 0 end) as two_dollar_trans
from merchant as a 
left join merchant_category as c on (a.merchant_cat = c.merchant_cat_id)
left join transactions as b on (a.merchant_id = b.merchant_id)
group by a.merchant_id , a.merchant_name
order by two_dollar_trans desc
limit 5









