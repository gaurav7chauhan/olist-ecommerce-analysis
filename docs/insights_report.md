# Insights Report

I analyzed about 100,000 Olist orders (2016-2018) in PostgreSQL.
Revenue means item price on delivered orders only, with shipping excluded.

## Sales
- Revenue peaked in November 2017 at [987765.37], most likely because of
  Black Friday. It looks like a one-time spike, not steady growth.
- health_beauty earns the most revenue at [1233131.72].
- The top 10 sellers bring in [11.5%] of revenue, so the business leans
  on a small group of sellers.
- Credit card is the most common payment method.

## Customers
- State [SP] has the most customers, with [15.59%] of the total.
- Only [0%] of customers ever bought a second time.

## What I'd suggest
- Prepare stock and delivery capacity before every November.
- Keep the top sellers happy and recruit more good ones.
- Offer a follow-up deal after the first purchase to bring customers back.

## Limits of the data
- 2016 and late 2018 are incomplete, so I left them out of trend claims.
- 610 products have no category and are grouped as "unknown".
