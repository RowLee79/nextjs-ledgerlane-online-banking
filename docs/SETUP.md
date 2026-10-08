# LedgerLane — Online Banking Simulation

A Next.js and Cloudflare D1 banking sandbox with fictional customers, demo accounts, internal transfers, deposits, withdrawals, beneficiaries, transaction entries, account statements and CSV export. Values are Philippine pesos stored as integer centavos. **This is not a real bank. Never use real customer data or money.**

## Run locally

1. Install Node.js 22.13 or newer.
2. Extract this ZIP and enter the `ledgerlane-bank` folder.
3. Run `npm ci`, then `npm run dev`. Open the displayed local URL. If your hosting environment blocks its local network interfaces, run it on your own computer.
4. On Overview, choose **Load demo data** to create three fictional customers and four funded sample accounts.
5. Use **Transfers** to move simulated funds between demo accounts. Review the details before posting. Try a withdrawal that exceeds an account's balance; it will be rejected. Add a beneficiary and export a statement to CSV.

The D1 database binding is `DB` in `.openai/hosting.json`; the initial migration is `drizzle/0000_square_korath.sql`. Every movement uses one Cloudflare D1 `batch()` transaction: a conditional movement insert checks active accounts and available balance, then sequentially updates the balances and records debit and credit ledger entries. A unique reference derived from the client request ID makes a repeated request safe from double posting. The `accounts` table has a nonnegative balance check. If changing `db/schema.ts`, run `npm run db:generate` and apply new migrations. For independent deployment, configure a D1 binding and adapt the included Sites-specific build scripts.

## Validation

- `npx tsc --noEmit` type checks the app.
- `npm run build` builds the Workers-compatible app.
- The migration and transaction SQL were checked with an in-memory SQLite database for deposits, matching transfer ledger entries, exact balances and overdraft rejection. The private deployment succeeded with the migrated D1 tables.

## Security and production scope

This is an educational simulation with **no authentication or account ownership authorization**. Its management views and API expose all fictional demo data. Never expose it to untrusted users or use real credentials, personal data, balances or payment instructions. A real financial system needs secure identity and MFA, transaction authorization, customer isolation, durable signed audit trails, reconciliation, fraud controls, rate limiting, access controls, legal/regulatory review and independent security testing. It also needs an audited ledger architecture and banking or payment rail integrations. Deposits and withdrawals here change simulated balances only. The private preview is an owner-only demo.
