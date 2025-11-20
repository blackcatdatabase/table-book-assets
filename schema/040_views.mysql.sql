-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  book_assets
-- Contract view for [book_assets]
-- Hides encryption_key_enc, encryption_iv, encryption_tag, encryption_aad.
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_book_assets AS
SELECT
  tenant_id,
  id,
  book_id,
  asset_type,
  filename,
  mime_type,
  size_bytes,
  storage_path,
  content_hash,
  download_filename,
  is_encrypted,
  encryption_algo,
  encryption_meta,
  key_version,
  key_id,
  created_at,
  encryption_key_enc,
  encryption_iv,
  encryption_tag,
  encryption_aad,
  CAST(LPAD(HEX(encryption_key_enc), 64, '0') AS CHAR(64)) AS encryption_key_enc_hex,
  CAST(LPAD(HEX(encryption_iv),      32, '0') AS CHAR(32)) AS encryption_iv_hex,
  CAST(LPAD(HEX(encryption_tag),     32, '0') AS CHAR(32)) AS encryption_tag_hex,
  CAST(LPAD(HEX(encryption_aad),     64, '0') AS CHAR(64)) AS encryption_aad_hex
FROM book_assets;

-- Auto-generated from schema-views-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  book_assets_encryption_coverage
-- Encryption coverage per asset_type
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_book_assets_encryption_coverage AS
SELECT
  asset_type,
  COUNT(*) AS total,
  SUM(CASE WHEN is_encrypted THEN 1 ELSE 0 END) AS encrypted,
  ROUND(100.0 * SUM(CASE WHEN is_encrypted THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS pct_encrypted
FROM book_assets
GROUP BY asset_type
ORDER BY asset_type;

