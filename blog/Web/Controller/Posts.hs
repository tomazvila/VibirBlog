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
        case currentUserOrNothing of
            Just currentUser -> case get #fullname currentUser of
                                    "admin" -> render NewView { .. }
                                    _       ->  action PostsAction
            Nothing          ->  action PostsAction

    action ShowPostAction { postId } = do
        mtranslation <- getSession "translation" :: IO (Maybe Bool)
        post <- fetch postId
        case mtranslation of
            Just True -> render ShowView { post = post, translation = True }
            _         -> render ShowView { post = post, translation = False }

    action EditPostAction { postId } = do
        post <- fetch postId
        case currentUserOrNothing of
            Just currentUser -> case get #fullname currentUser of
                                    "admin" -> render EditView { .. }
                                    _       -> action PostsAction
            Nothing          -> action PostsAction

    action UpdatePostAction { postId } = do
        post <- fetch postId
        case currentUserOrNothing of
            Just currentUser -> case get #fullname currentUser of
                                    "admin" -> post
                                                |> buildPost
                                                |> ifValid \case
                                                    Left post -> render EditView { .. }
                                                    Right post -> do
                                                        post <- post |> updateRecord
                                                        setSuccessMessage "Post updated"
                                                        redirectTo EditPostAction { .. }
                                    _       -> action PostsAction
            Nothing          -> action PostsAction

    action CreatePostAction = do
        let post = newRecord @Post
        case currentUserOrNothing of
            Just currentUser -> case get #fullname currentUser of
                                    "admin" -> post
                                                |> buildPost
                                                |> ifValid \case
                                                    Left post -> render NewView { .. } 
                                                    Right post -> do
                                                        post <- post |> createRecord
                                                        setSuccessMessage "Post created"
                                                        redirectTo PostsAction
                                    _ -> action PostsAction
            Nothing -> action PostsAction

    action DeletePostAction { postId } = do
        post <- fetch postId
        case currentUserOrNothing of
            Just currentUser -> case get #fullname currentUser of
                                    "admin" -> do
                                                deleteRecord post
                                                setSuccessMessage "Post deleted"
                                                redirectTo PostsAction
                                    _ -> action PostsAction
            Nothing -> action PostsAction

buildPost post = post
    |> fill @["originaltitle","originalbody", "translatedtitle", "translatedbody"]
