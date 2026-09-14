CREATE TABLE users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    email       TEXT NOT NULL UNIQUE,
    created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE categories (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id         INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    parent_id       INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    name            TEXT NOT NULL,
    is_builtin      INTEGER NOT NULL DEFAULT 0,
    UNIQUE(user_id, parent_id, name)
);

CREATE TABLE transactions (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id                 INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    amount_minor            INTEGER NOT NULL, -- integer amount in minor currency units (e.g., cents)
    currency                TEXT NOT NULL, -- ISO 4217 currency code (e.g., USD, EUR)
    spent_at                TEXT NOT NULL DEFAULT (datetime('now')),
    merchant_id             INTEGER REFERENCES merchants(id) ON DELETE SET NULL,
    payment_method_id       INTEGER REFERENCES payment_methods(id) ON DELETE SET NULL,
    notes                   TEXT,
    created_at              TEXT NOT NULL DEFAULT (datetime('now')),
    modified_at             TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE transaction_items (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_id          INTEGER NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    description             TEXT NOT NULL,
    amount_minor            INTEGER NOT NULL, -- integer amount in minor currency units (e.g., cents)
    currency                TEXT NOT NULL, -- ISO 4217 currency code (e.g., USD, EUR)
    created_at              TEXT NOT NULL DEFAULT (datetime('now')),
    modified_at             TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE transaction_categories (
    transaction_id          INTEGER NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    category_id             INTEGER NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    PRIMARY KEY (transaction_id, category_id)
);

CREATE TABLE merchants (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name        TEXT NOT NULL,
    UNIQUE(user_id, name)
);

CREATE TABLE payment_methods (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name        TEXT NOT NULL,
    UNIQUE(user_id, name)
);

CREATE TABLE budgets (
    id                      INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id                 INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    category_id             INTEGER REFERENCES categories(id) ON DELETE CASCADE, -- NULL = overall
    amount_minor            INTEGER NOT NULL, -- integer amount in minor currency units (e.g., cents)
    currency                TEXT NOT NULL, -- ISO 4217 currency code (e.g., USD, EUR)
    start_date              TEXT NOT NULL, -- YYYY-MM-DD
    end_date                TEXT NOT NULL, -- YYYY-MM-DD
    repeatable              INTEGER NOT NULL DEFAULT 0, -- 0 = no, 1 = yes
    original_budget_id      INTEGER REFERENCES budgets(id) ON DELETE SET NULL, -- for repeatable budgets
    created_at              TEXT NOT NULL DEFAULT (datetime('now')),
    modified_at             TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE(user_id, category_id, start_date, end_date)
);


-- INDEXES
CREATE INDEX idx_transactions_user_date     ON transactions(user_id, spent_at);
CREATE INDEX idx_transactions_user_category ON transactions(user_id, category_id);
CREATE INDEX idx_transactions_user_merchant ON transactions(user_id, merchant_id);
CREATE INDEX idx_categories_user_parent ON categories(user_id, parent_id);
CREATE INDEX idx_transaction_items_transaction ON transaction_items(transaction_id);


/*
CREATE TABLE tags (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name        TEXT NOT NULL,
    UNIQUE(user_id, name)
);

CREATE TABLE transaction_tags (
    transaction_id          INTEGER NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    tag_id                  INTEGER NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (transaction_id, tag_id)
);
*/
