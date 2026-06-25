# daily-commit-bot

A tiny project that pushes a few commits to this repo every day via a scheduled
[GitHub Actions](.github/workflows/daily-commit.yml) workflow. Each day it appends
timestamped lines to [`activity-log.md`](activity-log.md) and makes a random **6–10
commits**, so the contribution graph stays green without your machine being on.

## How it works

- `.github/workflows/daily-commit.yml` runs on two cron times (`17 6` and
  `17 13` UTC) and also supports manual runs from the **Actions** tab. GitHub
  often delays scheduled jobs by hours, so the second time is a safety net.
- A **per-day guard** checks whether today's batch already landed and exits early
  if so — so the two cron times (plus any manual runs) still produce only one
  batch of 6–10 commits per day, never double.
- It commits as `sarthakvs10@gmail.com`. Commits count toward your contribution
  graph because that email is tied to your GitHub account, the repo is public,
  and commits land on the default branch.
- `scripts/log-activity.sh` does the actual file change. You can run it locally too.

## Changing the schedule

Edit the `cron` line. Cron in Actions is **UTC**. Some examples:

| When (UTC)        | cron            |
| ----------------- | --------------- |
| Daily 06:17       | `17 6 * * *`    |
| Twice a day       | two `- "..."` lines under `schedule` |
| Weekdays only 09:00 | `0 9 * * 1-5` |

Scheduled runs can be delayed (or, rarely, skipped) when GitHub is busy — fine
for this use case. Because this workflow keeps committing, the repo never goes
60 days idle, so the schedule won't get auto-disabled.

## If green squares don't show up

1. Confirm `sarthakvs10@gmail.com` is listed (and verified) under
   **GitHub → Settings → Emails**.
2. Make sure commits are on the **default branch** (they are).
3. As a fallback, push using a Personal Access Token instead of the default
   `GITHUB_TOKEN`: add the PAT as a repo secret and `git remote set-url` to
   `https://x-access-token:${PAT}@github.com/<you>/daily-commit-bot.git`.

## Run it manually

```bash
gh workflow run "Daily commits"      # trigger the cloud workflow now
# or, locally:
scripts/log-activity.sh && git add -A && git commit -m "manual" && git push
```
