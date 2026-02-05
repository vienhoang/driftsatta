-- =============================================================
-- Databasinitiering
-- =============================================================

-- Skapa tabellen "items"
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lägg in exempeldata
INSERT INTO items (name, description) VALUES
    ('Laptop', 'High-performance laptop for development work'),
    ('Monitor', '27-inch 4K display with USB-C connectivity'),
    ('Keyboard', 'Mechanical keyboard with RGB backlighting'),
    ('Mouse', 'Wireless ergonomic mouse with precision tracking'),
    ('Headphones', 'Noise-cancelling headphones for focused work');

-- =============================================================
-- Skapa applikationsanvändare med begränsade rättigheter
-- =============================================================
-- Principen om minsta privilegium: Ge endast de rättigheter som krävs
-- Baserat på typiska API-operationer (CRUD utan DELETE):
-- - SELECT: Läsa/lista items
-- - INSERT: Skapa nya items
-- - UPDATE: Uppdatera befintliga items
-- (DELETE utelämnas om applikationen inte ska kunna radera data)

CREATE USER IF NOT EXISTS 'app_user'@'%' IDENTIFIED BY 'cHX@6osY2OpV7p';

-- Ge endast nödvändiga rättigheter på appdb-databasen
GRANT SELECT, INSERT, UPDATE ON appdb.* TO 'app_user'@'%';

-- Om applikationen även behöver DELETE-funktionalitet, lägg till:
-- GRANT DELETE ON appdb.* TO 'app_user'@'%';

FLUSH PRIVILEGES;