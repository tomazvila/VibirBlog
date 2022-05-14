-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    originaltitle TEXT NOT NULL,
    translatedtitle TEXT NOT NULL,
    originalbody TEXT NOT NULL,
    translatedbody TEXT NOT NULL
);
