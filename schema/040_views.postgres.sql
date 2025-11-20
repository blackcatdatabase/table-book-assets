-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  book_assets
-- Contract view for [book_assets]
-- Hides encryption_key_enc, encryption_iv, encryption_tag, encryption_aad.
CREATE OR REPLACE VIEW vw_book_assets AS
SELECT
  id,
  tenant_id,
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
  UPPER(encode(encryption_key_enc,'hex'))   AS encryption_key_enc_hex,
  UPPER(encode(encryption_iv,'hex'))        AS encryption_iv_hex,
  UPPER(encode(encryption_tag,'hex'))       AS encryption_tag_hex,
  UPPER(encode(encryption_aad,'hex'))       AS encryption_aad_hex
FROM book_assets;

-- Auto-generated from schema-views-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  book_assets_encryption_coverage
-- Encryption coverage per asset_type
CREATE OR REPLACE VIEW vw_book_assets_encryption_coverage AS
SELECT
  asset_type,
  COUNT(*)                                         AS total,
  COUNT(*) FILTER (WHERE is_encrypted)             AS encrypted,
  ROUND(100.0 * COUNT(*) FILTER (WHERE is_encrypted) / GREATEST(COUNT(*),1), 2) AS pct_encrypted
FROM book_assets
GROUP BY asset_type
ORDER BY asset_type;

