# Frozen Document and Signature Binding Contract

## Required state transition

```text
canonical document
  -> SHA-256
  -> frozen version
  -> signature binding
  -> immutable signed snapshot
```

A signature is not bound merely to a case ID or the latest mutable text. It is bound to a specific frozen document version and its SHA-256 digest.

## Canonicalization

Before hashing, the backend must produce a deterministic representation of all fields that are legally/operationally part of the signed interrogation document. The canonicalization version itself must be stored with the frozen record so future code can reproduce the hash.

At minimum the frozen record stores:

- case ID;
- document version/revision;
- canonicalization version;
- canonical document or immutable reference to it;
- SHA-256 digest;
- freeze timestamp;
- relevant operator/signer references.

## Freeze invariant

After a document version is frozen:

- its canonical content cannot be silently changed;
- its SHA-256 cannot be replaced in place;
- a signature record cannot be rebound to another digest;
- generated reports must identify the same frozen version/hash.

## Post-freeze edits

Any edit after freeze requires:

```text
new document revision
  -> new canonical representation
  -> new SHA-256
  -> new frozen version
  -> new signature(s)
```

The old frozen/signed snapshot remains immutable and auditable.

## Release-side verification

`scripts/mock_e2e.py` exercises the invariant without physical signature hardware or model weights: it canonicalizes a mock case, computes SHA-256, stores the frozen digest, binds a mock signature to that digest, restarts the database connection, creates/restores a backup, and verifies the digest/signature still match.

The real backend must implement the same invariant in its business persistence layer; this release branch deliberately avoids taking ownership of that core module.
