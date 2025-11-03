-- Auto-generated from schema-map-postgres.psd1 (map@9d3471b)
-- engine: postgres
-- table:  book_assets
CREATE INDEX IF NOT EXISTS idx_book_assets_book ON book_assets (book_id);

CREATE INDEX IF NOT EXISTS idx_book_assets_type ON book_assets (asset_type);

CREATE UNIQUE INDEX IF NOT EXISTS ux_book_assets_unique ON book_assets (book_id, asset_type);
