# Retail Sales Performance Dashboard

## Executive Summary
Revenue grew **+2.35% MoM**, but profitability declined with **Profit ↓0.58%** and **Margin ↓1.76 pts**.  
The main driver was a **+54.43% increase in discount spending**, which boosted volume but reduced efficiency.  
Analysis showed that not all discount tiers perform equally; some drive high AOV but weaken margins.  
The key opportunity is optimizing discount strategy to balance growth and profitability.

---

## Business Problem
Evaluate current retail performance and determine whether growth is sustainable and profitable.  
Identify key drivers (volume, pricing, discounting) and pinpoint where performance issues are occurring across regions, channels, and products.

---

## Approach
- Cleaned and transformed data using **SQL (CTEs, joins, validation checks)**  
- Designed KPIs: Revenue, Net Sales, Profit, Margin, AOV, Orders  
- Implemented **time intelligence (MoM, MTD, QTD, YTD)** in Power BI  
- Developed a **2-page dashboard**:
  - Page 1: Performance & trends  
  - Page 2: Driver and segmentation analysis  

---

## Key Insights

- **Revenue ↑2.35%**, **Net Sales ↑1.2%**, **AOV ↑1.78%**
  - Growth driven primarily by **higher order volume**
  - Indicates positive demand trend

- **Discount Spending ↑54.43%**
  - Aggressive discounting used to drive sales
  - Key contributor to revenue growth

- **Profit ↓0.58% | Margin ↓1.76 pts**
  - Profitability declined despite revenue growth
  - Indicates **margin compression**

- Discount performance varies by tier:
  - **11% discount tier** → High AOV but lower efficiency (**37.63% margin**)
  - **15% discount tier** → Highest margin (**49.10%**)
  - <img width="335" height="336" alt="image" src="https://github.com/user-attachments/assets/a6b0a1e7-f49c-49f2-96c0-7f845af72c84" />

  - Shows **not all discounts drive profitable growth**

- Basket behavior:
  - **404 / 1,084 orders (4+ items)** generated highest AOV (**$1,456.87**)
  - Larger baskets contribute significantly to revenue

---

## Recommendations

- **Optimize discount strategy by tier**
  - Focus on high-performing tiers (e.g., 15%)
  - Expected: Improve margin while maintaining revenue

- **Reduce broad discounting in low-growth segments**
  - Target discounts where demand is proven
  - Expected: Lower unnecessary margin loss

- **Incentivize larger basket sizes**
  - Promote bundles or multi-item offers
  - Expected: Increase AOV and revenue efficiency

- **Monitor profitability alongside revenue**
  - Track margin by region, category, and discount tier
  - Risk: Continued focus on revenue alone may erode profit

---

## Dashboard / Output
<img width="1252" height="894" alt="image" src="https://github.com/user-attachments/assets/18610b7c-d2ca-48b4-8c21-92b5097089d2" />


---

## Skills Demonstrated

- **SQL**: CTEs, joins, data cleaning, validation, aggregations  
- **Data Modeling**: Star schema design (fact + dimensions)  
- **Power BI**: KPI design, time intelligence, dynamic field parameters  
- **Data Analysis**: Trend analysis, driver identification, segmentation  
- **Business Thinking**: Insight → Impact → Action framework  
- **Tools**: Python (data generation), SQL Server, Power BI, Excel  
