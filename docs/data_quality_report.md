# Data Quality Report

I checked the Olist data in PostgreSQL before any analysis.
No raw data was changed. Problems are handled in the analysis queries.

| # | Check | Result | How I handle it |
|---|---|---|---|
| 1 | Row counts | All 9 tables match the source files | None needed |
| 2 | Duplicate keys | No duplicate order_id, customer_id or product_id | None needed |
| 3 | Orders with multiple reviews | 547 orders | Aggregate reviews per order before joining |
| 4 | Order status | 96,478 delivered; 625 canceled; 609 unavailable; others in progress | Revenue counts delivered orders only |
| 5 | Missing dates | 160 no approval, 1,783 no carrier, 2,965 no delivery date | Expected for undelivered orders |
| 6 | Delivered with no delivery date | 8 orders | Exclude from delivery-time analysis |
| 7 | Delivered before purchase | 0 orders | None needed |
| 8 | Products with no category | 610 | Label as "unknown" |
| 9 | Categories without English name | 2 (pc_gamer, portateis_cozinha_e_preparadores_de_alimentos) | Fall back to the Portuguese name |
