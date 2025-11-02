-- Auto-generated from schema-map-postgres.psd1 (map@db2f8b8)
-- engine: postgres
-- table:  book_assets
ALTER TABLE book_assets ADD CONSTRAINT fk_book_assets_key FOREIGN KEY (key_id) REFERENCES crypto_keys(id) ON DELETE SET NULL;

ALTER TABLE book_assets ADD CONSTRAINT fk_book_assets_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE;
