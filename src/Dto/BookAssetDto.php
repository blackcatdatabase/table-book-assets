<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\BookAssets\Dto;

/**
 * Jednoduché, neměnné DTO s veřejnými readonly vlastnostmi.
 * - Žádná logika; pouze nosič dat.
 * - Silné typy drží kontrakt napříč vrstvami.
 */
final class BookAssetDto {
    public function __construct(
        public readonly ?int $id,
        public readonly int $bookId,
        public readonly string $assetType,
        public readonly string $filename,
        public readonly string $mimeType,
        public readonly int $sizeBytes,
        public readonly ?string $storagePath,
        public readonly ?string $contentHash,
        public readonly ?string $downloadFilename,
        public readonly bool $isEncrypted,
        public readonly ?string $encryptionAlgo,
        public readonly ?string $encryptionKeyEnc,
        public readonly ?string $encryptionIv,
        public readonly ?string $encryptionTag,
        public readonly ?string $encryptionAad,
        public readonly array|null $encryptionMeta,
        public readonly ?string $keyVersion,
        public readonly ?int $keyId,
        public readonly \DateTimeImmutable $createdAt
    ) {}

    /** Vhodné pro serializaci/logování (bez binárních/velkých blobů). */
    public function toArray(): array {
        // get_object_vars funguje dobře s public readonly vlastnostmi
        return get_object_vars($this);
    }
}
