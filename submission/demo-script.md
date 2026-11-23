# ReleaseTrail — 90-second demo recording script

> This is a storyboard, not evidence of a recorded or working demo.

| Time | Visual | Voice-over |
| --- | --- | --- |
| 0:00–0:10 | Title: ReleaseTrail + live testnet URL | “Product releases are easy to announce but hard to independently verify. Meet ReleaseTrail.” |
| 0:10–0:22 | gnoweb homepage, actions, source code | “ReleaseTrail is a real stateful Gno realm. The registry and user interface are rendered directly from the blockchain.” |
| 0:22–0:40 | Wallet A calls `Publish`; show transaction success | “A publisher commits a product version, release notes and an HTTPS evidence URL. Their wallet identity and block height become part of the record.” |
| 0:40–0:55 | Release detail, repository evidence | “The record is public, searchable by release ID, and keeps external evidence attached.” |
| 0:55–1:10 | Wallet B calls `Review(id, "verify")` | “A separate wallet can verify or flag the release once. Its address and decision are preserved on-chain.” |
| 1:10–1:20 | Show self-review rejection + Retract status | “Self-review is blocked, and retracting a claim never deletes the audit history.” |
| 1:20–1:30 | Show public GitHub repo and tests | “No backend, no account database — just an open, auditable on-chain record. Built with Gno.” |

Before recording, verify the actual testnet deployment and transactions. Show transaction hashes or explorer page on screen when possible. Do not include false or simulated on-chain action in the final contest demo.
