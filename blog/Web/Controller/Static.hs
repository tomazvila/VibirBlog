module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome

instance Controller StaticController where
    action WelcomeAction = do
        mtranslation <- getSession "translation" :: IO (Maybe Bool)
        case mtranslation of
            Just True -> render WelcomeView { wtranslation = True }
            _         -> render WelcomeView { wtranslation = False }
