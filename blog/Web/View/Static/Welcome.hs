module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView { wtranslation :: Bool }

instance View WelcomeView where
    html WelcomeView { .. } = [hsx|
        <h1>Labas {get #email currentUser}</h1>
|]