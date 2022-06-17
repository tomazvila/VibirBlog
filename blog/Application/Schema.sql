-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    originaltitle TEXT NOT NULL,
    translatedtitle TEXT NOT NULL,
    originalbody TEXT NOT NULL,
    translatedbody TEXT NOT NULL
);
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    fullname TEXT NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT null,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    confirmed BOOLEAN DEFAULT false NOT NULL,
    fk_user_role UUID NOT NULL
);
CREATE TABLE user_roles (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    user_role TEXT NOT NULL
);