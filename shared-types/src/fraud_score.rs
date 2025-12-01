use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct FraudScore{
    pub transaction_id: String,
    pub score: u32,
    pub reasons: Vec<String>,
    pub timestamp: DateTime<Utc>,
}