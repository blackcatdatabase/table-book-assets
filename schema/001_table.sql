-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00)
-- table: book_assets
CREATE TABLE IF NOT EXISTS book_assets (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  book_id BIGINT UNSIGNED NOT NULL,
  asset_type ENUM(''cover'',''pdf'',''epub'',''mobi'',''sample'',''extra'') NOT NULL,
  filename VARCHAR(255) NOT NULL,
  mime_type VARCHAR(100) NOT NULL,
  size_bytes BIGINT NOT NULL,
  storage_path TEXT NULL,
  content_hash VARCHAR(64) NULL,
  download_filename VARCHAR(255) NULL,
  is_encrypted BOOLEAN NOT NULL DEFAULT 0,
  encryption_algo VARCHAR(50) NULL,
  encryption_key_enc BLOB NULL,
  encryption_iv VARBINARY(32) NULL,
  encryption_tag VARBINARY(32) NULL,
  encryption_aad VARBINARY(255) NULL,
  encryption_meta JSON NULL,
  key_version VARCHAR(64) NULL,
  key_id BIGINT UNSIGNED NULL,
  created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  INDEX idx_book_assets_book (book_id),
  INDEX idx_book_assets_type (asset_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
