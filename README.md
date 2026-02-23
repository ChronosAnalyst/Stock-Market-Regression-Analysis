# Automotive Giants Stock Correlation Analysis 🏎️⚡

## Project Overview
This project performs a comparative analysis and **Linear Regression** between the stock prices of **Tesla (TSLA)** and **Ferrari (RACE)**. The goal is to investigate how much of Tesla's price movement can be explained by Ferrari's market performance using data from 2015 to 2024.

## Tech Stack
* **Language:** R
* **Libraries:** `tidyverse`, `ggplot2`
* **Model:** Simple Linear Regression (OLS)

## Key Findings
* **Correlation:** ~0.74 (Strong positive relationship)
* **R-squared:** 0.554 (The model explains 55.4% of the variance)
* **P-value:** < 2.2e-16 (Statistically highly significant)

## Visualizations
![Regression Analysis](./Final_Regression_Analysis.png)

## How to Run
1. Clone this repository.
2. Open the `Analysis_Script.R` in RStudio.
3. Set your working directory and run the script to reproduce the results.

## Statistical Interpretation
The analysis revealed a **Correlation Coefficient (r) of 0.74**, indicating a **strong positive relationship** between Tesla and Ferrari stock prices. 

### What does this mean?
* **Market Sentiment:** Even though these companies have different production models, they both belong to the high-end luxury and innovation sector. A correlation of 0.74 suggests they are influenced by similar macroeconomic factors, such as global luxury consumer demand and interest rate shifts.
* **Predictive Power (R-squared):** The R-squared value of **0.554** means that approximately **55.4%** of Tesla's price variance can be explained by Ferrari's price movements. While the relationship is statistically significant (p-value < 0.01), the remaining 44.6% is likely driven by factors unique to Tesla, such as its energy sector ventures and company-specific news.
