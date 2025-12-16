-- Auto-generated from core\joins-postgres.yaml (map@sha1:29CF395A3A4C8964482083733F8E613ABFBEF5CC)
-- engine: postgres
-- view:   book_assets_encryption_coverage

-- Encryption coverage per asset_type
CREATE OR REPLACE VIEW vw_book_assets_encryption_coverage AS
SELECT
  asset_type,
  COUNT(*)                                         AS total,
  COUNT(*) FILTER (WHERE is_encrypted)             AS encrypted,
  ROUND(100.0 * COUNT(*) FILTER (WHERE is_encrypted) / GREATEST(COUNT(*),1), 2) AS pct_encrypted
FROM book_assets
GROUP BY asset_type;
