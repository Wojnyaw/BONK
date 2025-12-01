use chrono::{DateTime, Utc};
use serde::{ Serialize, Deserialize };
use std::net::IpAddr;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Transaction {
    pub id: String,
    pub amount: f64,
    pub currency: String,
    pub user_id: String,
    pub email: String,
    pub ip_address: IpAddr,
    pub timestamp: DateTime<Utc>,
    pub geolocation: (f64, f64), // latitude, longitude)
}