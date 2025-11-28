-- Auto-generated from joins-mysql.psd1 (map@mtime:2025-11-27T17:49:37Z)
-- engine: mysql
-- view:   book_assets_encryption_coverage
-- Encryption coverage per asset_type
CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_book_assets_encryption_coverage AS
SELECT
  asset_type,
  COUNT(*) AS total,
  SUM(CASE WHEN is_encrypted THEN 1 ELSE 0 END) AS encrypted,
  ROUND(100.0 * SUM(CASE WHEN is_encrypted THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS pct_encrypted
FROM book_assets
GROUP BY asset_type;
