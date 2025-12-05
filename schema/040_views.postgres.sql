-- Auto-generated from schema-views-postgres.yaml (map@sha1:EDC13878AE5F346E7EAD2CF0A484FEB7E68F6CDD)
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
  UPPER(encode(encryption_key_enc,'hex'))   AS encryption_key_enc_hex,
  UPPER(encode(encryption_iv,'hex'))        AS encryption_iv_hex,
  UPPER(encode(encryption_tag,'hex'))       AS encryption_tag_hex,
  UPPER(encode(encryption_aad,'hex'))       AS encryption_aad_hex
FROM book_assets;
