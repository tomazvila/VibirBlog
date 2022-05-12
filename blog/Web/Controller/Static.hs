module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome
import Web.View.Layout (myCustomLayout)

instance Controller StaticController where
    beforeAction = do
        mtranslation <- getSession "translation" :: IO (Maybe Bool)
        case mtranslation of
            Just True -> setLayout $ myCustomLayout True
            _         -> setLayout $ myCustomLayout False


    action WelcomeAction = do
        mtranslation <- getSession "translation" :: IO (Maybe Bool)
        case mtranslation of
            Just True -> render WelcomeView { wtranslation = True }
            _         -> render WelcomeView { wtranslation = False }
