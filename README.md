# Hotel Booking Business Analysis
### Customer Segmentation, VIP Analytics & Growth Strategy

![Python](https://img.shields.io/badge/Python-Data%20Analytics-blue)
![SQL](https://img.shields.io/badge/SQL-Business%20Analytics-green)
![Domain](https://img.shields.io/badge/Domain-Hotel%20Booking-orange)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/om-mishra-a62991289)
[![GitHub](https://img.shields.io/badge/GitHub-ommishra03-black?logo=github)](https://github.com/ommishra03)

---

## The Core Business Question

> How should a hotel booking platform allocate a ₹50 lakh budget between customer acquisition and customer retention?

This project answers that question using 12,000 booking transactions — combining customer segmentation, VIP analytics, LTV modeling, and acquisition/retention economics to produce a defensible budget recommendation.

---

## What This Project Covers

- Data Quality Assessment
- Customer Segmentation
- VIP Definition & Analytics
- Revenue Analysis
- Acquisition Economics
- Retention Economics
- SQL-Based Business Reporting
- Executive-Level Recommendations

---

## Project Structure

```
hotel-booking-business-analysis/
│
├── dataset/
│   └── hotel_bookings.csv
│
├── notebook/
│   └── analysis.ipynb
│
├── sql_query/
│   └── SQLQuery1.sql
│
├── reports/
│   ├── business_analysis_report.pdf
│   └── Problem Statement.pdf
│
├── visualizations/
│   ├── Acquisition Economics.png
│   ├── Break-Even vs Actual LTV (C4).png
│   ├── Customer Reach per ₹50L (C3,C4).png
│   ├── VIP Cohort Sizes (C1).png
│   ├── VIP Definition Overlap (C1).png
│   ├── VIP vs Non-VIP Behaviour (C2).png
│   ├── VIP vs Non-VIP Cancellation Rate (C2).png
│   └── VIP vs Non-VIP Discount Intensity (C2).png
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

## Dataset

**Source:** Hotel Booking Platform Dataset  
**Records:** 12,000 booking transactions

Key fields include Customer ID, Property ID, Booking & Check-in/Check-out Dates, Total Amount, Discount Amount, Booking Status, Review Rating, and Customer Segment.

---

## Data Quality Assessment

Three issues were identified before any analysis:

| Issue | Count |
|---|---|
| Bookings with `num_rooms = 0` | 60 |
| Booking date earlier than signup date | 163 |
| Missing reviews (overall) | 57.12% |

Review gaps broke down by booking status:

| Booking Status | Missing Reviews |
|---|---|
| Completed | 45.40% |
| Cancelled | 97.83% |
| No-Show | 100.00% |

These point to upstream validation gaps and a clear review collection opportunity for completed bookings.

---

## VIP Customer Strategy

### Three Independent VIP Definitions

1. Top 10% by Total Spend
2. Top 10% by Booking Count
3. Top 10% by Lifetime Value Rate

Each definition identified **80 customers**.

![VIP Cohorts](visualizations/VIP%20Cohort%20Sizes%20(C1).png)

### Definition Overlap

![VIP Overlap](visualizations/VIP%20Definition%20Overlap%20(C1).png)

| Overlap Category | Customers |
|---|---|
| Exactly one definition | 102 |
| Exactly two definitions | 57 |
| All three definitions | 8 |

**Key insight:** VIP status is highly sensitive to the chosen definition. High spenders are not always frequent bookers, and frequent bookers are not always the highest-value customers relative to tenure. The selection of VIP criteria is a strategic decision, not a technical one.

---

## VIP Risk Profile

The **spend-based VIP definition** was selected for its direct alignment with revenue contribution.

### Revenue Contribution

VIP customers generated **26.84%** of realized platform revenue.

### Cancellation Rate

| Group | Cancellation Rate |
|---|---|
| VIP | 17.06% |
| Non-VIP | 19.45% |

![Cancellation Rate](visualizations/VIP%20vs%20Non-VIP%20Cancellation%20Rate%20(C2).png)

### Discount Intensity

| Group | Average Discount |
|---|---|
| VIP | ₹3,967 |
| Non-VIP | ₹1,440 |

![Discount Intensity](visualizations/VIP%20vs%20Non-VIP%20Discount%20Intensity%20(C2).png)

VIP customers cancel less but receive nearly 3× the discount. This raises a question worth testing: is the discount driving retention, or are VIPs already loyal regardless?

---

## Acquisition Economics

**Assumptions:** Budget = ₹50,00,000 | CAC = ₹3,000

| Metric | Value |
|---|---|
| Customers Acquired | 1,667 |
| Avg Customer Lifetime Spend | ₹3,68,575 |
| Gross Lifetime Revenue | ₹61.43 Crore |
| Year-1 Revenue | ₹12.29 Crore |

![Acquisition Economics](visualizations/Acquisition%20Economics.png)

---

## Retention Economics

**Assumptions:** Retention cost = ₹500 per customer

| Metric | Value |
|---|---|
| Customers Retained | 10,000 |
| Break-Even LTV | ₹2,500 |
| Actual Avg LTV | ₹3,68,575 |

![Customer Reach](visualizations/Customer%20Reach%20per%20₹50L%20(C3,C4).png)

![LTV Comparison](visualizations/Break-Even%20vs%20Actual%20LTV%20(C4).png)

Actual LTV is **147× the break-even threshold**. The economics of retention are overwhelmingly favorable.

---

## Recommendation

### Budget Allocation: 60% Retention / 40% Acquisition

| Allocation | Budget |
|---|---|
| Retention (60%) | ₹30,00,000 |
| Acquisition (40%) | ₹20,00,000 |

**Why this split?**

- VIP customers drive a disproportionate share of revenue and cancel less
- Retention break-even is trivially low vs. actual LTV
- Acquisition still generates strong projected lifetime revenue at ₹3,68,575 per customer
- A pure-retention strategy risks stagnating the customer base; a pure-acquisition strategy leaves existing high-value customers unprotected

---

## SQL Analysis

The project includes normalized schema design, customer booking sequence analysis, property rating normalization, and analytical reporting.

```
sql_query/SQLQuery1.sql
```

---

## Tech Stack

- Python (Pandas, NumPy, Matplotlib)
- SQL
- Jupyter Notebook
- Git & GitHub

---

## Skills Demonstrated

Business Analysis · Customer Segmentation · Revenue Analytics · LTV Modeling · Acquisition vs. Retention Strategy · Data Quality Assessment · SQL · Data Visualization · Executive Reporting

---

## Author

**Om Mishra** — Business Analytics | Data Analytics | AI & ML

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/om-mishra-a62991289)
[![GitHub](https://img.shields.io/badge/GitHub-ommishra03-black?logo=github)](https://github.com/ommishra03)
