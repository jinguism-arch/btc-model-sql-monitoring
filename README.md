\# BTC Model – SQL Monitoring



SQL analysis of forward-validation predictions from a BTC 24-hour / 2% barrier

prediction model. This repo contains sample data only; the model itself is not

included.



\## Tables

\- predictions(timestamp, target, target\_name, feature\_set, probability, prediction\_source)

\- outcomes(timestamp, target\_name, realized\_target)



\## Queries (queries.sql)

1\. Accuracy by target and feature set (JOIN, GROUP BY, CASE)

2\. 7-day rolling accuracy (CTE + window function)

3\. Unmatched predictions / reconciliation (LEFT JOIN)

4\. Duplicate-key data-quality check (HAVING)

5\. Calibration buckets (predicted probability vs observed hit rate)

6\. Base-rate vs accuracy (naive baseline comparison)



\## How to run

pip install pandas

python load\_db.py

python run\_queries.py



Results are printed and saved as result\_\*.csv files.



\## Findings (sample of 250 matured predictions per target, \~10 days)

\- Accuracy: 74.4% downside, 79.2% upside.

\- Baseline check: always predicting "no event" scores 74.8% (downside) and

&#x20; 79.2% (upside), so accuracy alone shows no edge over the naive baseline.

\- Rolling 7-day accuracy is unstable (downside fell from \~92% to \~62% in a

&#x20; few days).

\- Calibration is uneven: predicted probabilities do not rise smoothly with

&#x20; observed event rates.

\- 48 recent predictions have no outcome yet (not matured); no duplicate keys.

\- Small sample: findings are descriptive, not conclusive.

