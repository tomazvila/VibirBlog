module Web.View.Posts.Show where
import Web.View.Prelude
import qualified Text.MMark as MMark

data ShowView = ShowView { post :: Post, translation :: Bool }

instance View ShowView where
    html ShowView { .. } = [hsx|
       <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={PostsAction}>Posts</a></li>
                <li class="breadcrumb-item active">Show Post</li>
            </ol>
        </nav>
        <div>{markdownPost}</div>
    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Posts" PostsAction
                            , breadcrumbText "Show Post"
                            ]
            markdownPost :: Html
            markdownPost = case translation of
                True  -> [hsx|<p><h1>{get #originaltitle post} - title of post</h1>
                              <div>{get #originalbody post |> renderMarkdown}</div></p>
                              <p>Normal body</p>|]
                False -> [hsx|<h1>{get #translatedtitle post} - title of post</h1>
                              <div>{get #translatedbody post |> renderMarkdown}</div>
                              <p>TBODY</p>|]

renderMarkdown text =  -- text |> MMark.parse "" -- empty string is the name of a markdown file in this case it doesn't exist so we pass empty string
  case text |> MMark.parse "" of
        Left error -> "Something went wrong"
        Right markdown -> MMark.render markdown |> tshow |> preEscapedToHtml
