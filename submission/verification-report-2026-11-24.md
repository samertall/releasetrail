# ReleaseTrail — Gnome Tavern evidence and verification report
**Verification date:** 2026-11-24 (UTC+03)
**Network:** Onyx, chain ID `onyx-1`
**Overall:** On-chain package submission confirmed; **NOT YET LIVE**. Do not mark this project as a working testnet deployment or submit it as eligible until activated.

## Immutable evidence
- **Repository:** https://github.com/samertall/releasetrail
- **Expected package path:** `gno.land/r/g1z4kaltz0g3qj5ey8jefjwfkeqah428vv4syy85/releasetrail`
- **Submitting wallet:** `g1z4kaltz0g3qj5ey8jefjwfkeqah428vv4syy85`
- **AddPackage tx hash:** `5d3b2211a5f01d01ad25e31844708d79eb900a108365271bc85d0e30586dacc5`
- **Official tx receipt:** https://rpc.onyx.testnets.gno.land:443/tx?hash=0x5d3b2211a5f01d01ad25e31844708d79eb900a108365271bc85d0e30586dacc5
- **Receipt outcome:** height 1,351,554, `msg:0,success:true`; this only confirms package submission.
- **Gno native CI:** https://github.com/samertall/releasetrail/actions/runs/45174592161 (successful native lint/tests; no live-chain guarantees)

## Live chain check — 2026-11-24
- **RPC query** `vm/qpkgmeta_json` for the package returned `"status":"inert"`, `"pending":true`, and `"reason":"waiting for a package approver to enable it"`.
- **RPC query** `vm/qrender`: `vm.InvalidPkgPathError` / `package not found` (not callable yet).
- **RPC query** `vm/qfuncs`: `vm.InvalidPkgPathError` / `package not found` (not callable yet).
- **Public realm:** https://onyx.testnets.gno.land/r/g1z4kaltz0g3qj5ey8jefjwfkeqah428vv4syy85/releasetrail — returned 404.
- **Approval service:** https://gpas.onyx.testnets.gno.land/?path=gno.land/r/g1z4kaltz0g3qj5ey8jefjwfkeqah428vv4syy85/releasetrail — exact path lookup returned no public review row. Absence of a row is not proof of rejection; ask approver operators to inspect indexing/queue.

## Blockers
1. Onyx must enable package before realm calls and live demo.
2. Confirm on-chain `Publish`, `Review` from a distinct wallet, `Retract`, and read-only `Render`/detail query transactions. Record real hashes; do not invent them.
3. Record and provide a genuine video showing the functional testnet realm and its transaction(s). The existing `submission/demo-script.md` is only a storyboard.
4. Complete DoraHacks BUIDL entry with public source, live realm, video, and honest claims. Deadline **2026-12-18 01:00 UTC**. Submit exactly once.

## Next verification checklist
- [ ] Onyx `vm/qpkgmeta_json` returns enabled/active rather than `inert`
- [ ] Public realm page responds and displays the intended ReleaseTrail Markdown
- [ ] `vm/qfuncs` contains exported contract functions
- [ ] `Publish` testnet tx succeeded with a visible new record
- [ ] Independent `Review` testnet tx succeeded from another wallet
- [ ] `Retract` testnet tx succeeded while history persisted
- [ ] Working demo video link added and reviewed
- [ ] DoraHacks submission form completed and final entry URL verified

**Scope caution:** GitHub's native Gno test run proves unit tests, not deployment or activation. The successful AddPackage transaction is not proof of an enabled or callable realm.
