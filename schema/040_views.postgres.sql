-- Auto-generated from schema-views-postgres.psd1 (map@c5e4097)
-- engine: postgres
-- table:  book_assets
-- Contract view for [book_assets]
-- Hides encryption_key_enc, encryption_iv, encryption_tag, encryption_aad.
CREATE OR REPLACE VIEW vw_book_assets AS
SELECT
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
  encode(encryption_key_enc, 'hex') AS encryption_key_enc_hex,
  encode(encryption_iv,  'hex')     AS encryption_iv_hex,
  encode(encryption_tag, 'hex')     AS encryption_tag_hex,
  encode(encryption_aad, 'hex')     AS encryption_aad_hex
FROM book_assets;
