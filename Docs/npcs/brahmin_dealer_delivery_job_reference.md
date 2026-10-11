# Brahmin Dealer and Delivery Job — Reference Notes

## Purpose

This document records the current implementation and observed behaviour of the Brahmin dealer dialogue in FOnline Revival, for future maintenance and debugging.

## Relevant files

- `brahmin_dealer.fodlg` — dealer dialogue and branching.
- `brahmin_trader.fos` — Brahmin detection and sale logic.
- `FOQUEST.MSG` — player-facing quest title, description, and status messages.
- `_vars.fos` — quest variable declaration.

## Quest variable

The job uses the following variable entry in `_vars.fos`:

```text
$    10425    1    q_brahmin_delivery    0    0    99    1
```

The corresponding quest variable name is `q_brahmin_delivery`.

### Observed state meanings

| Value | Meaning |
|---:|---|
| `0` | Job not started / available to accept. |
| `1` | Job in progress; the player has accepted the delivery job. |
| `99` | Job completed; the cooldown flow applies. |

These meanings describe the current dialogue flow. Check the module and shared timeout implementation before changing them.

## Job flow

1. When the player first interacts with the dealer, the dialogue checks the player's quest state and whether a Brahmin is available.
2. If the job is available, the dealer can offer a Brahmin delivery job.
3. The player accepts the job, setting `q_brahmin_delivery` to `1`.
4. While the job is in progress, the dialogue checks whether the player has a Brahmin.
5. If the player does not have a suitable Brahmin, the dealer asks the player to return with one.
6. If the player has a suitable Brahmin, the sale/completion path calls `brahmin_trader@r_SellBrahminToDealer`.
7. The dialogue sets `q_brahmin_delivery` to `99` and invokes the shared timeout function.
8. During the cooldown, the dealer tells the player that he does not need more Brahmin yet.
9. When the timeout is ready, the dialogue resets `q_brahmin_delivery` to `0`, making the job available again.

## One-hour cooldown

The dealer already uses the shared dialogue timeout mechanism. According to the current project implementation/observed behaviour, the player must wait one hour before repeating the action.

The dialogue references these shared functions:

- `dialog@r_QuestTimeout` — starts or sets the timeout.
- `dialog@d_QuestTimeoutReady` — checks whether the timeout has expired.
- `dialog@d_QuestTimeoutNotReady` — checks whether the timeout is still active.

The dialogue file shows calls to these functions, but the timeout duration itself is defined by the shared implementation, not by the dialogue lines alone. If the cooldown duration needs to be changed, inspect the implementation of `dialog@r_QuestTimeout` rather than adding a second cooldown system.

## Relevant dialogue logic

The following snippets were identified in the dealer dialogue.

### Check for an active job and Brahmin

```text
12 1020 D _var p q_brahmin_delivery = 1 D _script brahmin_trader@d_PlayerHasBrahmin 0
6 1030 D _var p q_brahmin_delivery = 1 D _script brahmin_trader@d_NotPlayerHasBrahmin 0
```

These branches distinguish whether the player has a Brahmin while the job is in progress.

### Completed-job cooldown branches

```text
15 1050 D _var p q_brahmin_delivery = 99 D _script dialog@d_QuestTimeoutNotReady 0
13 1060 D _var p q_brahmin_delivery = 99 D _script dialog@d_QuestTimeoutReady 0
```

These branches check whether the cooldown is still active or has expired.

### Sale and completion calls

The dialogue contains transaction paths with calls equivalent to:

```text
R _script brahmin_trader@r_SellBrahminToDealer 1 100
R _var p q_brahmin_delivery = 99
R _script dialog@r_QuestTimeout 1 1
```

The exact order and branch context should be checked in `brahmin_dealer.fodlg` before editing. The dialogue includes more than one sale path, so verify whether a path is a job completion or a regular Brahmin sale before changing it.

### Reset after cooldown

```text
0 1060 D _var p q_brahmin_delivery = 99 D _script dialog@d_QuestTimeoutReady 0 R _var p q_brahmin_delivery = 0
```

When the timeout-ready branch is taken, the quest variable is reset to `0`, allowing the player to start the job again.

## Player-facing quest messages

The job's quest messages use the same numbering convention as the existing caravan job, with `10425` as the base ID:

```text
#=======================================
# 10425 / q_brahmin_delivery
# Brahmin Dealer: Brahmin Delivery Job (repeatable)
#=======================================
{10425001}{}{I heard a Brahmin dealer is looking to buy livestock. I should talk to him if I'm interested in making some caps.

:: New Job Available ::}
{10425011}{}{The Brahmin dealer offered to pay me for bringing him a Brahmin. I should return with one to collect my reward.}
{10425012}{}{HIDDEN:Brahmin delivered.}
{10425013}{}{NO_POPUP:Brahmin delivered.}
{10425014}{}{DONE:That's all. I should talk to the Brahmin dealer to collect my reward!}
{10425097}{}{SOFT_FAILED:I couldn't complete the Brahmin delivery job. Maybe I can try again later.

:: Job Failed ::}
{10425099}{}{SOFT_COMPLETED:I delivered a Brahmin to the dealer and collected my reward. I could return for more work a bit later.

:: Job Completed ::}
{10425101}{}{Brahmin Dealer: Brahmin Delivery Job (repeatable)}
{10425102}{}{JOB:Deliver a Brahmin to the dealer for caps}
```

Only retain message entries that are actually referenced by the quest/dialogue implementation. The `SOFT_FAILED` entry may be unnecessary if the job has no failure condition.

## Important implementation notes

- The dealer has a normal Brahmin-selling interaction as well as the delivery-job flow. Do not assume every call to `r_SellBrahminToDealer` is necessarily a quest completion.
- The sale function is responsible for the actual Brahmin transaction and payment. The dialogue's quest-state and timeout calls manage job progression and repeat availability.
- Verify that the Brahmin validation succeeds before the sale function is called.
- Check that the sale function removes the correct Brahmin and pays only once.
- The screenshot test showed the job-completed popup and completion text. That confirms the completion UI is displayed, but by itself does not prove that payment, Brahmin transfer, and repeat availability all work correctly.
- Avoid creating a second cooldown variable or separate cooldown mechanism unless there is a specific reason to replace the existing shared timeout logic.
- Before editing the dialogue, inspect the full branch context. Dialogue line numbers and jump targets matter; snippets alone are not enough to safely restructure the flow.

## Suggested regression test

1. Start the job with `q_brahmin_delivery = 0`.
2. Accept the job and confirm the variable becomes `1`.
3. Talk to the dealer without a suitable Brahmin; confirm the job remains active.
4. Return with a suitable player-owned Brahmin and complete the transaction.
5. Confirm the Brahmin is transferred/removed as intended.
6. Confirm the reward is paid exactly once.
7. Confirm the variable becomes `99`.
8. Immediately talk to the dealer again; confirm the cooldown prevents another sale/job completion.
9. Wait for the one-hour timeout to expire.
10. Talk to the dealer again; confirm the variable can reset to `0` and the job can be repeated.
11. Test the dealer's ordinary sale path separately to ensure it does not accidentally bypass or corrupt the job cooldown.

## Source of truth

These notes summarize the dialogue snippets and behaviour discussed during development. For exact current conditions, parameters, and branch order, consult the live files `brahmin_dealer.fodlg`, `brahmin_trader.fos`, the shared `dialog` module, `FOQUEST.MSG`, and `_vars.fos`.
