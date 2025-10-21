-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00)
-- table: book_assets
ALTER TABLE book_assets ADD CONSTRAINT fk_book_assets_key FOREIGN KEY (key_id) REFERENCES crypto_keys(id) ON DELETE SET NULL;

ALTER TABLE book_assets ADD CONSTRAINT fk_book_assets_book FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE;
