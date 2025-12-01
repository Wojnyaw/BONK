-- enable extensions
CREATE EXTENSION IF NOT EXISTS timescaledb;
CREATE EXTENSION IF NOT EXISTS uuid-ossp;
CREATE EXTENSION IF NOT EXISTS postgis;

-- transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    amount NUMERIC(12, 2) NOT NULL,
    currency TEXT NOT NULL
    user_id UUID NOT NULL,
    email TEXT NOT NULL,
    ip_address TEXT NOT NULL,
    timestamp TIMESTAMPZ NOT NULL
    geolocation GEOGRAPHY(Point, 4326) NOT NULL
)

-- convert to hypertable (partitioning on timestamp)
SELECT create_hypertable('transactions', 'timestamp', if_not_exists => TRUE);

-- fraud_scores table
CREATE TABLE IF NOT EXISTS fraud_scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    transaction_id UUID NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    score INTEGER NOT NULL CHECK (score >= 0 AND score <= 100),
    reasons TEXT NOT NULL,
    timestamp TIMESTAMPZ NOT NULL,
)

SELECT create_hypertable('fraud_scores', 'timestamp', if_not_exists => TRUE);

-- rules table
CREATE TABLE IF NOT EXISTS rules (
-- TODO rules table.
)

-- alerts table
CREATE TABLE IF NOT EXISTS alerts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    transaction_id UUID NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    fraud_score INTEGER NOT NULL REFERENCES fraud_score(score) ON DELETE CASCADE,
    threshold INTEGER NOT NULL CHECK (threshold >= 0 AND threshold <= 100),
    triggered_at TIMESTAMPZ NOT NULL DEFAULT NOW(),
    webhook_url TEXT NOT NULL,
    webhook_delivered BOOLEAN DEFAULT FALSE,
    webhook_attempt INTEGER DEFAULT 0,
    created_at TIMESTAMPZ NOT NULL DEFAULT NOW(),
)

-- index for querying recent alerts
CREATE INDEX idx_alerts_triggered_at ON alerts(triggered_at DESC);

-- index for finding alerts by transaction
CREATE INDEX idx_alerts_transaction_id ON alerts(transaction_id);