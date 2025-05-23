# -*- coding: utf-8 -*-

# -- Project --

# # Final Project - Analyzing Sales Data
# 
# **Date**: 3 December 2024
# 
# **Author**: Abdulhakim Sani (Kim)
# 
# **Course**: `Pandas Foundation`


# import data
import pandas as pd
df = pd.read_csv("sample-store.csv")

# preview top 5 rows
df.head()

# shape of dataframe
df.shape

# see data frame information using .info()
df.info()

# We can use `pd.to_datetime()` function to convert columns 'Order Date' and 'Ship Date' to datetime.


# example of pd.to_datetime() function
pd.to_datetime(df['Order Date'].head(), format='%m/%d/%Y')

df.columns

# TODO - convert order date and ship date to datetime in the original dataframe
df[['Order Date', 'Ship Date']] = df[['Order Date', 'Ship Date']].apply(pd.to_datetime, format='%m/%d/%Y')

# TODO - count nan in postal code column
df['Postal Code'].isna().sum()

# TODO - filter rows with missing values
df = df.dropna()
df.isna().sum()

# TODO - Explore this dataset on your owns, ask your own questions

# ## Data Analysis Part
# 
# Answer 10 below questions to get credit from this course. Write `pandas` code to find answers.


# TODO 01 - how many columns, rows in this dataset
df.shape

# TODO 02 - is there any missing values?, if there is, which colunm? how many nan values?
df.isna().sum()

#There are 11 missing values in Postal Code column

# TODO 03 - your friend ask for `California` data, filter it and export csv for him
California_df = df[df['State'] == 'California']
California_df.head()
California_df.to_csv('California.csv', index=False)

# TODO 04 - your friend ask for all order data in `California` and `Texas` in 2017 (look at Order Date), send him csv file
CalTex2017 = df[ (df['State'].isin(['California', 'Texas']))  & (df['Order Date'].dt.year == 2017)]
CalTex2017.to_csv('CalTex2017.csv', index=False)


# TODO 05 - how much total sales, average sales, and standard deviation of sales your company make in 2017
df[df['Order Date'].dt.year == 2017]['Sales'].agg(['sum', 'mean', 'std']).round()

#Sales in 2017:
#total sales is 484247.0
#average sales is 243.0
#standard deviation is 754.0

# TODO 06 - which Segment has the highest profit in 2018
df[df['Order Date'].dt.year == 2018].groupby('Segment')['Profit'].sum().sort_values(ascending=False).round()

#The consumer segment had the highest profit in 2018

# TODO 07 - which top 5 States have the least total sales between 15 April 2019 - 31 December 2019
df[df['Order Date'].between('2019-04-15', '2019-12-31')]\
    .groupby('State')['Sales'].sum().round(2).sort_values(ascending=True)

#The top 5 states that had the least total sales between 15 April 2019 - 31 December 2019 were 
#New Hampshire (49.05), New Mexico(64.08), District of Columbi(117.07), Louisiana (249.8) and South Carolina(502.48)

# TODO 08 - what is the proportion of total sales (%) in West + Central in 2019 e.g. 25% 
ttl_sales_2019 = df[df['Order Date'].dt.year == 2019]['Sales'].sum()
wc_ttl_sales_2019 = df[(df['Region'].isin(['West', 'Central'])) & (df['Order Date'].dt.year == 2019)]['Sales'].sum()
wc_propo_2019 = (wc_ttl_sales_2019/ttl_sales_2019)*100
wc_propo_2019 = wc_propo_2019.round(2)
result = f"Proportion of total sales (%) in West and Central in 2019 is {wc_propo_2019}%"
print(result)

#The proportion of total sales (%) in the West and Central regions in 2019 was 54.97%

# TODO 09 - find top 10 popular products in terms of number of orders vs. total sales during 2019-2020
df_dur = df[df['Order Date'].dt.year.between(2019, 2020)]
ten_pop_q = df_dur.groupby('Product Name')['Quantity'].sum().sort_values(ascending=False).head(10).reset_index()
ten_pop_s = df_dur.groupby('Product Name')['Sales'].sum().sort_values(ascending=False).round(2).head(10).reset_index()
ten_pop_q

#f string
#"Top 10 popular products in terms of number of orders were:"
 
#for P in ten_pop_q
    #print(f"{P['Product Name']} {P['Quantity']}")
print("\033[1mThe top 10 popular products in terms of number of orders were:\033[0m")
for index, row in ten_pop_q.iterrows():
    print(f"({row['Quantity']}) {row['Product Name']}")

print(" ")

print("\033[1mThe top 10 popular products in terms of total sales were:\033[0m")
for index, row in ten_pop_s.iterrows():
    print(f"({row['Sales']}) {row['Product Name']} ")






# TODO 10 - plot at least 2 plots, any plot you think interesting :)

#Sales trend Quarterly in 2020
df['Quarter'] = df['Order Date'].dt.to_period('Q') #Create 'Quarter' column
df_Q = df[df['Order Date'].dt.year == 2020].groupby('Quarter')['Sales'].sum().round(2).reset_index()

df_Q.plot(x='Quarter', y='Sales');

#The quantities of each category sold in 2020
ttl_quan = df.groupby('Category')['Quantity'].sum().sort_values(ascending=True)
ttl_quan.plot.barh();

#Proportion of the quantities sold in each category in 2020
df['Year'] = df['Order Date'].dt.year
stack_df = df[df['Order Date'].dt.year == 2020].groupby(['Year', 'Category'])['Quantity'].sum().sort_values(ascending=False).unstack(fill_value=0)
stack_df

#Convert stack_df to proprtional
proportional_df = stack_df.div(stack_df.sum(axis=1), axis=0)
proportional_df.plot.bar(stacked=True);




#The quantities of each product sold in the office supply categegory in 2020
sub_off = df[df['Category']=='Office Supplies'].groupby('Sub-Category')['Quantity'].sum().sort_values(ascending=True)
sub_off.plot.barh();

#The proportional sales in each product sold in 2020
profit_off = df[df['Category']=='Office Supplies'].groupby('Sub-Category')['Sales'].sum().sort_values(ascending=True)
pct_profit_off = profit_off/sum(profit_off)*100
pct_profit_off.plot.pie(autopct='%1.1f%%');

# TODO Bonus - use np.where() to create new column in dataframe to help you answer your own questions
# How many customers who were high, medium, and low spenders?
##Segment customer by spending (percentile based threshold)

import numpy as np

summary = df['Sales'].describe().round(2)
q1 = summary['25%']
q2 = summary['50%']
q3 = summary['75%']

df['Spending Class'] = np.where(df['Sales'] <= q1, 'Low Spender',
                                 np.where(df['Sales'] <= q3, 'Medium Spender', 'High Spender'))

segment_spend = df.groupby('Spending Class')['Customer ID'].count()
segment_spend.plot.pie(autopct='%1.1F%%')


