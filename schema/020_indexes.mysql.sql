-- Auto-generated from schema-map-mysql.psd1 (map@db2f8b8)
-- engine: mysql
-- table:  book_assets
CREATE UNIQUE INDEX ux_book_assets_unique ON book_assets (book_id, asset_type);
