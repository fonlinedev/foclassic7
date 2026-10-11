# FONLINE Revival — Quest and Brahmin Testing Cheat Sheet

A quick reference for preparing a test session, spawning test NPCs, and changing quest states.

> **Security:** Use your own development/test server. Do not put real account passwords in this document or commit them to source control.

## 1. Get administrator access

In the server/game console, use:

```text
~getaccess <user> <pass>
```

Replace `<user>` and `<pass>` with the test account credentials.

## 2. Useful commands

Commands use the backtick prefix (`) in-game.

| Command | Purpose |
|---|---|
| `` `addfollower 10 `` | Adds a Brahmin follower. |
| `` `addfollower 68 `` | Adds Tandi as a follower. |

### Examples

Add a Brahmin for delivery-job testing:

```text
`addfollower 10
```

Add Tandi for quest testing:

```text
`addfollower 68
```

## 3. Tandi quest

Tandi's quest variable ID is `7328`.

Set the variable with:

```text
`setvar 7328 <VALUE>
```

Replace `<VALUE>` with the state you want to test.

### Quest state table

| Value | State / meaning |
|---:|---|
| `0` | Inactive |
| `1` | Active |
| `2` | Seth — raiders camp |
| `3` | Found |
| `4` | Escape |
| `5` | Duel |
| `6` | Quest done |
| `7` | Quest failed |

### Examples

Set Tandi's quest to inactive:

```text
`setvar 7328 0
```

Set Tandi's quest to active:

```text
`setvar 7328 1
```

Set Tandi's quest to the duel stage:

```text
`setvar 7328 5
```

Mark Tandi's quest as completed:

```text
`setvar 7328 6
```

Mark Tandi's quest as failed:

```text
`setvar 7328 7
```

## 4. Brahmin delivery job — quick test

Use this checklist when testing the Brahmin dealer's repeatable delivery job.

- [ ] Get administrator access.
- [ ] Spawn a Brahmin near the dealer with `addfollower 10`.
- [ ] Talk to the dealer and accept the delivery job.
- [ ] Confirm the job enters its active state.
- [ ] Test the dialogue without a Brahmin available, if needed.
- [ ] Return with a valid Brahmin and complete the delivery.
- [ ] Confirm the Brahmin is removed/transferred as intended.
- [ ] Confirm the reward is paid once.
- [ ] Confirm the completion message appears.
- [ ] Talk to the dealer again immediately and confirm the cooldown blocks another transaction.
- [ ] After the one-hour cooldown, confirm the job can be repeated.

## 5. Tandi quest — quick test

- [ ] Get administrator access.
- [ ] Add Tandi with `addfollower 68` if needed for the test.
- [ ] Set the quest variable with `setvar 7328 <VALUE>`.
- [ ] Use the state table above to choose the stage to test.
- [ ] Talk to the relevant NPC and verify the dialogue and quest progression.

## Notes

- The command IDs and quest-state meanings in this document are based on the project notes supplied for this testing workflow.
- `addfollower 10` is recorded here as the Brahmin-spawn command.
- `addfollower 68` is recorded here as the Tandi-spawn command.
- This document does not define the Brahmin delivery quest variable's state values; refer to the separate Brahmin Dealer & Delivery Job reference document for those details.
