use serde::{Deserialize, Serialize};
use chrono::{DateTime, Utc};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Alert {
    pub id: String,     // or uuid::Uuid
    pub fraud_score: FraudScore,
    pub threshold: u8,  // 0-100 score threshold
    pub triggered_at: DateTime<Utc>,
    pub webhook_url: String,
}