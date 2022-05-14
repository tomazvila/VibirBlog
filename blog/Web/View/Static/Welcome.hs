module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView { wtranslation :: Bool }

instance View WelcomeView where
    html WelcomeView { .. } = [hsx|
        <h1>Labas {greeting}</h1>
    |]
        where
            greeting = case currentUserOrNothing of
                Just currentUser -> [hsx|{get #email currentUser}|]
                Nothing          -> [hsx||]