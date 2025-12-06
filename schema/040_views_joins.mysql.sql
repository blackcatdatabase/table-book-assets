-- Auto-generated from joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   book_assets_encryption_coverage

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_book_assets_encryption_coverage AS
SELECT
  asset_type,
  COUNT(*) AS total,
  SUM(CASE WHEN is_encrypted THEN 1 ELSE 0 END) AS encrypted,
  ROUND(100.0 * SUM(CASE WHEN is_encrypted THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS pct_encrypted
FROM book_assets
GROUP BY asset_type;
