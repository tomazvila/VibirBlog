

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.posts DISABLE TRIGGER ALL;



ALTER TABLE public.posts ENABLE TRIGGER ALL;


ALTER TABLE public.schema_migrations DISABLE TRIGGER ALL;



ALTER TABLE public.schema_migrations ENABLE TRIGGER ALL;


ALTER TABLE public.user_roles DISABLE TRIGGER ALL;

INSERT INTO public.user_roles (id, user_role) VALUES ('c6cbaf95-0f55-4af7-839c-d81bc1bbd305', 'admin');
INSERT INTO public.user_roles (id, user_role) VALUES ('0ebb72bb-7898-43df-8391-9e98651c537e', 'user');


ALTER TABLE public.user_roles ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, fullname, email, password_hash, locked_at, failed_login_attempts, confirmed, fk_user_role) VALUES ('8a208fa4-e588-4d56-851e-8eb276c591dd', 'admin', 'admin@email.com', 'sha256|17|2pnD+1n+WOgsSRz4LYOUyQ==|Y75QMamGllhsuGfA1HxcL6Wy20lz7bhr0+KepFJbiqw=', NULL, 0, true, 'c6cbaf95-0f55-4af7-839c-d81bc1bbd305');


ALTER TABLE public.users ENABLE TRIGGER ALL;


