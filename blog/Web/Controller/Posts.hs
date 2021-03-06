module Web.Controller.Posts where

import Web.Controller.Prelude
import Web.View.Posts.Index
import Web.View.Posts.New
import Web.View.Posts.Edit
import Web.View.Posts.Show
import Web.View.Layout (myCustomLayout)

instance Controller PostsController where
    beforeAction = do
        mtranslation <- getSession "translation" :: IO (Maybe Bool)
        case mtranslation of
            Just True -> setLayout $ myCustomLayout True
            _         -> setLayout $ myCustomLayout False

    action PostsAction = do
        (postsQ, pagination) <- query @Post |> paginate
        posts <- postsQ |> fetch
        render IndexView { .. }

    action NewPostAction = do
        let post = newRecord
        render NewView { .. }

    action ShowPostAction { postId } = do
        mtranslation <- getSession "translation" :: IO (Maybe Bool)
        post <- fetch postId
        case mtranslation of
            Just True -> render ShowView { post = post, translation = True }
            _         -> render ShowView { post = post, translation = False }

    action EditPostAction { postId } = do
        post <- fetch postId
        render EditView { .. }

    action UpdatePostAction { postId } = do
        post <- fetch postId
        post
            |> buildPost
            |> ifValid \case
                Left post -> render EditView { .. }
                Right post -> do
                    post <- post |> updateRecord
                    setSuccessMessage "Post updated"
                    redirectTo EditPostAction { .. }

    action CreatePostAction = do
        let post = newRecord @Post
        post
            |> buildPost
            |> ifValid \case
                Left post -> render NewView { .. } 
                Right post -> do
                    post <- post |> createRecord
                    setSuccessMessage "Post created"
                    redirectTo PostsAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        setSuccessMessage "Post deleted"
        redirectTo PostsAction

buildPost post = post
    |> fill @["title","body"]
