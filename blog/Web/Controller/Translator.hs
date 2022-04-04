module Web.Controller.Translator where

import Web.Controller.Prelude
import Web.ClientSession
import Web.Controller.Static
import Web.View.Static.Welcome
import Web.View.Posts.Index

instance Controller TranslatorController where
    -- action TranslatorsAction = do
    --     translator <- query @Translator |> fetch
    --     render IndexView { .. }

    action SetTranslationCookieAction { translatorid } = do
        case translatorid of
            "true"  -> setTrue
            _       -> setFalse
        where
            setTrue :: IO ()
            setTrue = do
                putStrLn "Set session to true"
                setSession "translation" True
                render WelcomeView { wtranslation = True }
            setFalse :: IO ()
            setFalse = do
                putStrLn "Set session to false"
                setSession "translation" False
                render WelcomeView { wtranslation = False }

buildTranslator translator = translator
    |> fill @'[]
