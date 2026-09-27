CREATE TABLE IF NOT EXISTS cheat_menu (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    cheat_name VARCHAR(255) NOT NULL,
    cheat_value VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES users(identifier)
);

INSERT INTO cheat_menu (player_id, cheat_name, cheat_value) VALUES
(1, 'godmode', 'false'),
(1, 'infiniteammo', 'false'),
(1, 'superjump', 'false'),
(1, 'superrun', 'false'),
(1, 'superswim', 'false'),
(1, 'supersprint', 'false'),
(1, 'superstrength', 'false'),
(1, 'supervision', 'false'),
(1, 'superhearing', 'false'),
(1, 'superspeed', 'false');