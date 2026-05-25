DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS studios;

CREATE TABLE studios (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(50) NOT NULL
);

CREATE TABLE games (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  genre VARCHAR(50) NOT NULL,
  platform VARCHAR(50) NOT NULL,
  release_year INTEGER NOT NULL,
  description TEXT NOT NULL,
  image_url TEXT NOT NULL,
  studio_id INTEGER REFERENCES studios(id) ON DELETE SET NULL
);

INSERT INTO studios (name, country) VALUES
('EA Sports','EUA'),
('Riot Games','EUA'),
('Epic Games','EUA'),
('CD Projekt Red','Polônia');

INSERT INTO games (
  name,
  genre,
  platform,
  release_year,
  description,
  image_url,
  studio_id
) VALUES (
  'Cyberpunk 2077',
  'RPG',
  'PC',
  2020,
  'Entre na Night City...',
  'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=1920&h=1080&fit=crop',
  4
);

-- RLS
ALTER TABLE games ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read games"
ON games
FOR SELECT
USING (true);

CREATE POLICY "Allow public insert games"
ON games
FOR INSERT
WITH CHECK (true);

CREATE POLICY "Allow public update games"
ON games
FOR UPDATE
USING (true);

CREATE POLICY "Allow public delete games"
ON games
FOR DELETE
USING (true);

-- PERMISSÕES
GRANT USAGE ON SCHEMA public TO anon;

GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE games
TO anon;

GRANT SELECT
ON TABLE studios
TO anon;

GRANT USAGE, SELECT
ON SEQUENCE games_id_seq
TO anon;

GRANT USAGE, SELECT
ON SEQUENCE studios_id_seq
TO anon;