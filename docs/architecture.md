# Architecture Notes

This demo uses a simple CDC pattern for BI and reporting workloads.

## Flow

1. The source PostgreSQL database is configured with `wal_level=logical`.
2. Debezium reads changes from the PostgreSQL write-ahead log.
3. Change events are written to Kafka topic `bi_demo.public.users`.
4. Kafka Connect JDBC sink unwraps the Debezium envelope and writes the latest row state to `users_copy` in the target PostgreSQL database.

## Why this pattern is useful

- Reduces batch/reporting latency
- Decouples operational systems from reporting consumers
- Supports self-service analytics and downstream BI use cases
- Provides a reproducible local setup to test CDC behavior and schema evolution
