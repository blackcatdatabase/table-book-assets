<?php
declare(strict_types=1);

namespace BlackCat\Database\Packages\BookAssets\Dto;

/**
 * Simple immutable DTO with public readonly properties.
 * - No logic; just a data carrier.
 * - Strong types enforce the contract across layers.
 */
final class BookAssetDto implements \JsonSerializable {
    public function __construct(
        public readonly int $id,
        public readonly int $tenantId,
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

    /** Suitable for serialization/logging (without large blobs). */
    public function toArray(): array {
        return get_object_vars($this);
    }

    /** toArray() without null values - for clean logging/diffs. */
    public function toArrayNonNull(): array {
        return array_filter(get_object_vars($this), static fn($v) => $v !== null);
    }

    public function jsonSerialize(): array {
       $a = $this->toArray();
       foreach ($a as $k => $v) {
           if ($v instanceof \DateTimeInterface) {
               // ISO-8601 with a timezone; switch to 'Y-m-d H:i:s.u' if needed
               $a[$k] = $v->format(\DateTimeInterface::ATOM);
           }
       }
       return $a;
   }
}
