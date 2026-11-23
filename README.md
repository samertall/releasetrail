# ReleaseTrail

**Ship with evidence. Verify with your wallet.**

ReleaseTrail is an open-source, on-chain product release and independent-attestation registry built for [Gno.land](https://gno.land/). It lets builders publish immutable release milestones, link evidence (repository, deployed demo, changelog, accessibility report), and collect transparent wallet-signed **verify** or **flag** reviews. Project owners can retract a claim, but cannot erase history or reviews.

> **Gnome Tavern 2026 status (2026-11-23):** ReleaseTrail's `MsgAddPackage` was accepted on Onyx (`onyx-1`) at block **1,351,554**, but the package is currently **inert and awaiting approval**. The realm is **not live or callable yet**. Do **not** present it as a working deployment until the package is enabled, its public page loads, and feature transactions succeed.

## Why it exists

Software releases, accessibility fixes, and security claims are commonly buried in changing release notes and screenshots. ReleaseTrail makes the **who, what, evidence, and independent review history** publicly inspectable. The registry is a provenance tool, not an audit certification authority.

## Core features

- **Immutable release claims:** `Publish(project, version, summary, evidenceURL)` records block height, author address and an HTTPS evidence URL.
- **Signed caller checks:** write entry points derive authenticated caller identity using `cur.Previous().Address()` in the runtime-provided realm context. The former `cur.IsCurrent()` check was removed for compatibility with the supported runtime.
- **Independent reviews:** `Review(releaseID, outcome)` accepts `verify` or `flag` from a different wallet, once per wallet per release.
- **Auditable reviewers:** reviewer address, decision, and block height are persisted and shown publicly in the detail view.
- **Non-destructive retraction:** `Retract(releaseID)` is restricted to the original author; it preserves the release and past reviews.
- **Fully on-chain interface:** `Render(path)` exposes the overview and each release detail via gnoweb. No hosted server or proprietary API required.
- **Input hardening:** strictly bounded ASCII inputs and validated HTTPS evidence links reduce Markdown/HTML injection and storage-abuse risk.
- **Read-only integrations:** `Count()` and `Detail(releaseID)` are public realm functions.

## Architecture

```text
Publisher / calling realm          Independent reviewer / calling realm
        |                                     |
        | Publish(project, ...)               | Review(id, verify|flag)
        v                                     v
       +----------------------------------------+
       | Gno.land ReleaseTrail realm            |
       | - releases[]: immutable data            |
       | - reviewRecords[]: signed review ledger |
       | - reviewers{}: uniqueness guard        |
       | - retraction flag per claim             |
       +----------------------------------------+
                          |
                          | Render(path) [read-only]
                          v
                    gnoweb public UI
          home index + /:releaseID detail pages
```

## Project structure

- `realm/gnomod.toml` – package path and Gno language version
- `realm/releasetrail.gno` – real, stateful Gno realm
- `realm/releasetrail_test.gno` – validation, rendering and publish/retract tests
- `scripts/deploy-onyx.sh` – interactive `gnokey` deploy helper (never contains a key)
- `submission/dorahacks.md` – short description, suggested demo, exact completion checklist
- `submission/demo-script.md` – recording storyboard and repeatable transaction sequence

## Run and test locally

1. Install [Gno CLI and gnokey](https://docs.gno.land/builders/install/), and [gnodev](https://docs.gno.land/resources/gnodev/).
2. From `realm/`, run:

```bash
gno fmt ./...
gno lint ./...
gno test ./...
gnodev .
```

3. Open `http://localhost:8888`, select ReleaseTrail and use the `Actions` tab.
4. Publish a release using wallet A, then review it using wallet B. A self-review must be rejected. Verify the public detail page reflects each signed action.

**Test status:** Native Gno lint, tests, and deployment-helper syntax checks passed on GitHub Actions with the Gno v1.8.0 toolchain. [See successful run](https://github.com/samertall/releasetrail/actions/runs/45174592161). This is source-level validation, not proof of the realm functioning on-chain.

## Deploy to the Onyx testnet

Onyx is Gno.land's active testnet as of **2026-11-23**, using chain ID `onyx-1` and RPC `https://rpc.latest.testnets.gno.land:443`. The testnet may change; always verify the [network documentation](https://docs.gno.land/resources/gnoland-networks/).

1. Set up a new **testnet-only** wallet in `gnokey` or in [Adena](https://adena.app/). **Do not share its mnemonic or private key with anyone.**
2. [Use the faucet](https://faucet.gno.land/) to fund your testnet address.
3. From this repository's root, for `gnokey`, run:

```bash
chmod +x scripts/deploy-onyx.sh
./scripts/deploy-onyx.sh YOUR_TESTNET_G1_ADDRESS YOUR_GNOKEY_KEY_NAME
```

The script copies the Gno realm to a temporary directory, rewrites the module path to your own address namespace, and uses `gnokey` to sign and submit an `addpkg` transaction. Review the network, fees and address before signing. It **does not** read or store credentials. Or use [Gno Playground](https://play.gno.land/) with the [Adena wallet](https://adena.app/) and deploy the same realm via the browser.

**Submitted package path (currently inert):**

`gno.land/r/g1z4kaltz0g3qj5ey8jefjwfkeqah428vv4syy85/releasetrail`

**Confirmed add-package transaction:**

`5d3b2211a5f01d01ad25e31844708d79eb900a108365271bc85d0e30586dacc5`

[Onyx transaction receipt](https://rpc.onyx.testnets.gno.land:443/tx?hash=0x5d3b2211a5f01d01ad25e31844708d79eb900a108365271bc85d0e30586dacc5) — `msg:0,success:true`, block 1,351,554.

**Package activation status:** [Check current Onyx package metadata](https://rpc.onyx.testnets.gno.land:443/abci_query?path=%22vm%2Fqpkgmeta_json%22&data=0x676e6f2e6c616e642f722f67317a346b616c747a306733716a356579386a65666a77666b6571616834323876763473797938352f72656c65617365747261696c). On 2026-11-23, status was `inert` with reason `waiting for a package approver to enable it`; the realm's live web page still returned 404.

**Target page after enablement:**

`https://onyx.testnets.gno.land/r/g1z4kaltz0g3qj5ey8jefjwfkeqah428vv4syy85/releasetrail`

To inspect a release, append `:<RELEASE_ID>` to the realm URL. Use gnoweb's **Actions** tab for write methods.

**After deployment:** Wait for activation, call `Publish` with a real demo URL, then call `Review` from another wallet, record the transaction hashes and take screenshots. The project must be LIVE before DoraHacks submission.

## Recommended demo workflow

1. Open the live testnet realm. Show empty registry and `Source` tab.
2. Wallet A → `Publish("ReleaseTrail", "v1.0.0", "Initial product milestone with public evidence", "https://github.com/... ")`. Replace the placeholder with a real HTTPS repository URL with no spaces.
3. Inspect the record with `:1` and the published address and block height.
4. Wallet B → `Review(1, "verify")` and observe the signed review in `:1`.
5. Wallet A → `Review(1, "verify")` should fail (author cannot self-verify).
6. Wallet A → `Retract(1)` and confirm the original record and reviews remain visible.
7. Show the public code repository and explain provenance vs. proof.

## Security model and limitations

- **Attestation is not certification.** Anyone can claim they verified a release, and one person may control many wallets. The contract only prevents repeat reviews by the **same address** and self-review by the publisher address.
- **Evidence is external.** The realm records an HTTPS URL, not a cryptographic hash of the external document. Linked pages can change or disappear. For stronger provenance, use an immutable content-addressed evidence link and independently validate its content.
- **No private data.** Everything published on chain is public and effectively permanent.
- **Storage limits.** This prototype caps releases at 1,000 and reviews at 4,000; it prioritizes bounded on-chain resources over indefinite scalability.
- **No governance guarantee.** Retraction does not invalidate historical review records. Independent flags remain visible and do not constitute adjudication.
- **ASCII-only text in v1.** To prevent Markdown injection, project/summary inputs currently accept a restricted ASCII character set; internationalization is a roadmap item.

## Prize-retention roadmap (if selected)

- Month 1: testnet field feedback; public dataset export; improved evidence integrity (sha256/CID).
- Months 2–3: mainnet migration, automatic release links and contributor dashboard; onboarding 50 **organic unique wallets**.
- Months 4–6: reusable package / API integrations, verifier reputation, community-supported moderation; target 100 genuine unique wallets and one integration importing the registry.

These are proposed milestones, not completed outcomes.

## Public repository

https://github.com/samertall/releasetrail

## Hackathon requirements

- [x] Public GitHub repository with THIS source (https://github.com/samertall/releasetrail)
- [x] Native `gno lint` and `gno test` passing in CI (and shell syntax check)
- [x] Onyx add-package transaction included and executed successfully (package `inert`)
- [ ] Package approved/enabled and live realm accessible on Onyx testnet
- [ ] Publish, independent Review and Retract transactions confirmed
- [ ] Demo video with the chain interaction and live URLs
- [ ] DoraHacks BUIDL submitted once, with links and honest technical details

## License

MIT. See [LICENSE](LICENSE). Independent community project; not affiliated with Gno.land.
