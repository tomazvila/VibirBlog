module Web.Controller.Translator where

import Web.Controller.Prelude
import Web.ClientSession

instance Controller TranslatorController where
    -- action TranslatorsAction = do
    --     translator <- query @Translator |> fetch
    --     render IndexView { .. }

    action SetTranslationCookieAction { translatorId } = do
        case translatorId of
            "True"  -> setSession "translation" True
            "False" -> setSession "translation" False
            _       -> setSession "translation" False
        putStrLn "wee"
        renderPlain "foo"
        
    -- action ShowTranslatorAction { translatorId } = do
    --     translator <- fetch translatorId
    --     render ShowView { .. }

    -- action DeleteTranslatorAction { translatorId } = do
    --     translator <- fetch translatorId
    --     deleteRecord translator
    --     setSuccessMessage "Translator deleted"
    --     redirectTo TranslatorsAction

buildTranslator translator = translator
    |> fill @'[]
