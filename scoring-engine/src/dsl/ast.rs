// AST node definitions.

// core AST types
pub struct Rule{
    pub condition: Condition,
    pub action: Action,
}

pub struct Condition{
    pub expression: Expression,
    pub rest: Vec<(LogicalOp, Expression)>,
}

pub enum LogicalOp{
    And,
    Or
}

pub struct Expression{
    pub field: String,
    pub operation: ComparisonOp,
    pub value: Value,
}

pub enum ComparisonOp{
    GreaterThan,
    LessThan,
    Equal,
    NotEqual,
    In,
}

pub enum Value {
    Number(f64),
    String(String),
    List(Vec<Value>),
}

enum Action{
    AddScore(i32),
    Flag(String),
}