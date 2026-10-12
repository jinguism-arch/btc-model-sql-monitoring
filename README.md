\# BTC Model – SQL Monitoring



SQL analysis of forward-validation predictions from a BTC 24h / 2% barrier

prediction model (sample data only; the model itself is not included).



\## Tables

\- predictions(timestamp, target\_name, feature\_set, probability, ...)

\- outcomes(timestamp, target\_name, realized\_target)



\## Queries (queries.sql)

1\. Accuracy by target and feature set (JOIN, GROUP BY, CASE)

2\. 7-day rolling accuracy (CTE + window function)

3\. Unmatched predictions / reconciliation (LEFT JOIN)

4\. Duplicate-key data-quality check (HAVING)

5\. Calibration buckets (probability vs observed hit rate)



\## How to run

pip install pandas

python load\_db.py

python run\_queries.py



\## Findings (sample of 250 matured predictions per target)

\- Accuracy: 74.4% downside, 79.2% upside, but it varies a lot day to day.

\- Calibration is uneven: predicted probabilities do not rise smoothly with

&#x20; observed event rates, so accuracy alone overstates predictive quality.

\- 48 recent predictions have no outcome yet (not matured); no duplicate keys.

