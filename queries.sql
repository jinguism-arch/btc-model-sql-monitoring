-- name: accuracy_by_target_featureset
SELECT p.target_name, p.feature_set, COUNT(*) AS n,
       AVG(CASE WHEN (p.probability >= 0.5) = o.realized_target THEN 1.0 ELSE 0 END) AS accuracy
FROM predictions p JOIN outcomes o
  ON p.timestamp = o.timestamp AND p.target_name = o.target_name
GROUP BY p.target_name, p.feature_set;

-- name: rolling_7d_accuracy
WITH daily AS (
  SELECT substr(p.timestamp, 1, 10) AS day, p.target_name,
         AVG(CASE WHEN (p.probability >= 0.5) = o.realized_target THEN 1.0 ELSE 0 END) AS acc
  FROM predictions p JOIN outcomes o
    ON p.timestamp = o.timestamp AND p.target_name = o.target_name
  GROUP BY day, p.target_name)
SELECT day, target_name, acc,
       AVG(acc) OVER (PARTITION BY target_name ORDER BY day
                      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS acc_7d
FROM daily ORDER BY target_name, day;

-- name: unmatched_predictions
SELECT p.timestamp, p.target_name, p.feature_set, p.probability
FROM predictions p LEFT JOIN outcomes o
  ON p.timestamp = o.timestamp AND p.target_name = o.target_name
WHERE o.timestamp IS NULL LIMIT 20;

-- name: duplicate_keys
SELECT timestamp, target_name, feature_set, COUNT(*) AS c
FROM predictions GROUP BY timestamp, target_name, feature_set HAVING c > 1;

-- name: calibration_buckets
SELECT p.target_name, ROUND(p.probability, 1) AS bucket, COUNT(*) AS n,
       AVG(o.realized_target) AS hit_rate
FROM predictions p JOIN outcomes o
  ON p.timestamp = o.timestamp AND p.target_name = o.target_name
GROUP BY p.target_name, bucket ORDER BY p.target_name, bucket;
-- name: base_rate_vs_accuracy
SELECT target_name, COUNT(*) AS n, AVG(realized_target) AS event_rate,
       1 - AVG(realized_target) AS always_predict_no_accuracy
FROM outcomes GROUP BY target_name;