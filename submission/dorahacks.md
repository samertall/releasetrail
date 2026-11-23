# DoraHacks submission — ReleaseTrail

> Draft only. **Never claim deployed, tested or submitted until the actual links and transaction receipts are verified.**

## Project name
ReleaseTrail

## Short description
ReleaseTrail is a Gno.land-native product release registry that records authenticated caller-authored milestones, external evidence links, independent verification or flag decisions, and non-destructive retractions. Anyone can inspect the public review trail directly on-chain using gnoweb; no backend or account system is required.

## Detailed description
Release notes are often editable, fragmented, and difficult to verify. ReleaseTrail turns each milestone into a public on-chain claim, with the authenticated calling address, block height, version, summary and evidence link recorded immutably. Other wallets can verify or flag a milestone, while the original publisher may retract it without erasing historical provenance. A native `Render(path)` function provides a browsable Gno.land interface, including signed reviewer addresses and block heights.

The project's strength is deliberate simplicity and transparency: the registry only establishes provenance and wallet-signed opinions, not the accuracy of linked claims or the identity of reviewers. Gno's native realm architecture keeps the logic, state and public UI on the same chain.

## Category
Realm / decentralized application

## Technology
Gno, Gno.land realm, gnoweb Markdown renderer, `chain/runtime` and `strconv`/`strings`; shell deployment helper; optional Adena wallet and gnokey.

## GitHub repository
https://github.com/samertall/releasetrail

## Live testnet URL
[ADD VERIFIED REALM URL AFTER DEPLOYMENT]

## On-chain contract path
`gno.land/r/[G1_ADDRESS]/releasetrail` — address not yet assigned

## Transaction proof
- Add package: [ACTUAL_TX_HASH]
- Publish release: [ACTUAL_TX_HASH]
- Review by separate wallet: [ACTUAL_TX_HASH]
- Retract a demo release (optional): [ACTUAL_TX_HASH]

## Demo video
[ADD VIDEO URL AFTER RECORDING]

## Builder
Samer Tallauze — Product Design & Engineering; Amman, Jordan. [https://samertall.com](https://samertall.com)

## Main innovation
An auditable, non-destructive software-delivery record with independent wallet signatures, accessible directly through a stateful Gno realm's built-in public UI. Unlike a static changelog, its review trail cannot be silently rewritten by the release publisher.

## What to show judges
Show actual Publish, an independent Review, a failed self-review, release detail with signed review, a Retract, and source/test files. Demonstrate everything on the same public testnet realm with a working link.

## Important rule checks
- Do not name the project with the banned `Gno` prefix.
- Do not submit code-only or concept-only work.
- Do not invent deployment addresses, outcomes, demo links, or hashes.
- Submit only once for this distinct project.
- Deadline: **December 18, 2026 at 01:00 UTC** (Jordan time 04:00).
