-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  book_assets
CREATE INDEX idx_book_assets_book ON book_assets (book_id);

CREATE INDEX idx_book_assets_type ON book_assets (asset_type);
