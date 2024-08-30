<b>About</b><br>
This project aims to explore the Walmart Sales data to understand top performing branches and products,sales trend of different products,customer behaviour.The aims is to study how sales strategies can be improved and optimized.<br>
<br>
"In this recruiting competition,job-seekers are provided with historical sales data for 45 wallmart stores located in different regions.Each store contains many departments, and participants must project the sales for each department in each store.To add to the challenge,selected holiday markdown events are included in the dataset.These markdowns are known to affect sales,but it is challenging to predict which departments are affected and the extent of the impact."<br><br>
<b>Purpose of The Project</b><br><br>
The major aim of this project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.<br><br>
<b>Analysis List</b><br>
1.Product Analysis<br>
Conduct analysis on the data to understand the different product lines,the products lines performing best and the product lines that need to be improved<br><br>
2.Sales Analysis<br>
This analysis aims to answer the question of the sales trends of product.The result of this can help use measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.<br><br>
3.Customer Analysis<br>
This analysis aims to uncover the different customer segments,purchase trends and the profitability of each customer segment.<br><br>
<b>Approach Used</b><br>
1.Data Wrangling:This  is the first step where inspection of data is done to make sure NULL values and missing valuse are detected and data replacement methods are used to replace,missing or NULL values.<br>
  * Build a database.<br>
  * Create table and insert the data.<br>
  * Select columns with null values in them.There are no null values in our database as in creating the tables,we set NOT NULL, for each field,hence null value are filtered out.<br> </b>                    
2.Featuring Engineering:This will help use generate some new columns from existing ones.<br>

  * Add a new column named time_of_day to give insight of sales in the morning,Afternoon and Evening.This will help answer the question on which part of the day most sales are made.<br>
  * Add a new column named day_name that contains the extracted days of the week on which the given transaction took place(Mon,Tue,Wed,Thur,Fri).This will help answer the question on which week of the day each 
    branch is busiest.<br><br>
  * Add new column named month_name that contains the extracted months of the year on which the given transaction took place(Jan,Feb,Mar).Help determine which month of the year has the most sales and profit.
