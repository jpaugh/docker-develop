#!/bin/bash -e

PACKAGES=/var/cache/apt/archives
HASH_PREFIX=MD5Sum:

exec 3<"$1"

echo "Prefetching $(wc -l "$1") packages"

while read -r -u 3 uri name size hash trailing; do
    # Verify parse
    [ -n "$trailing" ] && {
        # Too many spaces in input
        echo >&2 -n "Skipping unparsable line: "
        echo >&2 "$uri $name $size $hash $trailing"
        continue
    }
    # Remove quotes
    uri=${uri#\'}
    uri=${uri%\'}

    echo
    echo "Package: $name"
    echo "Size: $size"
    echo "Hash: $hash"
    echo "URI: $uri"

    # Download
    curl -o "/tmp/$name" "$uri"

    # Check hash
    md5sum "/tmp/$name" | cut -d\  -f1 > /tmp/hash
    [ "$hash" != "$HASH_PREFIX$(</tmp/hash)" ] && {
        echo >&2 "Skipping package $name: bad checksum"
        rm "/tmp/$name" || true
        continue
    }

    # Cache
    mv "/tmp/$name" "$PACKAGES/$name"
done
