# CreditCard_FraudDetection
Pulling transactional data from SQL databases and exporting it to create a visualization of fraudulent transactions


# REPORT TO THE CFO 

- PART 1

1. Evidence suggesting that credit card has been hacked 

 - Outlier transactions amounts after a consistent range of transactions 
 ex. (10.98 , 19.00 , 5.99, 15.87 , 20.00 , 1978 , 19.00) 
 the 6th transaction in the above example would be considered an outlier
 
 - Unusual transaction amounts at merchants whos assumed prices are not that high like pubs and food trucks , coffee shops 
 
 ex. ( Robert Johnson paid 1691 at Osborne - Page Coffee shop on 2018-01-24 13:17:19 ) that is highly unusual 
 Some accounts may be corporate accounts and may be treating clients or employees as part of their operations however it still calls for further investigation 
 
 
 - Unusual transactions at unusual times of the day and at unusual amounts as well
 
 ex. ( Robert Johnson paid 0.79 cents at Riggs Adams Resturant at 2018-03-10 23:00:35 ) 
 
 That is very late to be at a resturant and it is correct to assume that no menu item in a resuturant would be priced that low
 
 - Transaction amounts that are highly suspicious such as (1789.9999999999999998) 
 a transaction that percisce is not regular anywhere and calls for further investigation 
 
 
 - Transactions to food service shops that occur on the same day or  multiple days in a row. If the client has not made the bank aware that he is abroad or out of town then this would be considered suspicious 
 ex. Robert Johnson between 2018-12-30 to 2018-12-30
 
 2018-12-30 19:28:21   $11.26  Carter-Blackwell   Pub
 2018-12-30 23:23:09   $1033   Thornton-Williams  Pub 
 
 2. Fraudulent Transactions by Time 
 
 - Between 7:00AM - 9:00AM
 
 it is very unusual to have bars open between those times so any transactions of any amounts occuring at bars at the time are considered suspicious 
 ex.  transaction_id (3163) at 2018-12-07 07:22:03 $1894 - Curry,Scott and Richardson - Bar
 
 It is also untypical for resturants or food trucks to be open for service before 9:00 AM so any transactions at that time would be considered suspicious 
 ex. transaction_id (3305) at 2018-10-07 07:08:08 $18.53 - Fowler and Sons - Food Truck 
 
 - Is there a higher amount of fraudulent transactions beyond the 7:00 AM -9:00 AM timeframe ? 
 
 Yes , first the amount of highly suspicious 2.00 or less transactions occurs much more beyond that time frame 
 
 Yes , the amount of repeated transactions at food service shops on the same day or multiple days in a row by the same customer increases 
 
 Yes , the amount of highly large transaction amounts beyond $500 is much more. Ofcourse in this matter a fraudelent trasnaction depends on if the customer is a corporate client or not 
 
 
 3. What are the top 5 merchants prone to being hacked using small transactions?
 
 Merchant_id        Merchant_Name      # of small tranasctions
      2               Riggs -Adams             37 
      70               White-Hall              36 
      35               Javis -Turner            36 
      150              Johnson and Sons         34 
      78                Ruiz - Anderson          34 
      
 - PART 2 
 
 
 1. Next, to better compare their patterns, create a single line plot that contains both card holders' trend data.  What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? Explain your rationale.
 
 - Cusomer_id 2 has no outliers in his transactions and fall in a more consistent range 
 
 - Customer_id 18 has much more outliers , 6 to be exact however looking at the transactional data , it seems like most of the transactions are in large amounts which could imply that this is a corporate client unlike customer_id 2 which could be a regualar consumer 
 
 
 2. The CEO of the biggest customer of the firm suspects that someone has used her corporate credit card without authorization in the first quarter of 2018 to pay quite expensive restaurant bills. Again, for privacy reasons, you know only that the cardholder ID in question is 25.

 
 - Atleast once a month there is a outlier transaction from the beg to end of the year. A total of 12 anamolus transactions
 
 - It seems like someone within the company is treating themselves or other co-workers to large amounts of food once a month. It is done once a month to avoid being suspicious or getting caught. 
  
 
 
 
 
 
