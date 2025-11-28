-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-11-21T00:25:46Z)
-- engine: postgres
-- table:  book_assets

CREATE INDEX IF NOT EXISTS idx_book_assets_book ON book_assets (book_id);

CREATE INDEX IF NOT EXISTS idx_book_assets_type ON book_assets (asset_type);

CREATE INDEX IF NOT EXISTS gin_book_assets_enc_meta ON book_assets USING GIN (encryption_meta jsonb_path_ops);

CREATE INDEX IF NOT EXISTS idx_book_assets_tenant ON book_assets (tenant_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_book_assets_tenant_unique ON book_assets (tenant_id, book_id, asset_type);

CREATE UNIQUE INDEX IF NOT EXISTS ux_book_assets_tenant_id ON book_assets (tenant_id, id);
