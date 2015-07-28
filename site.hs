--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    serve "images/*"
    serve "static/*"
    serve "files/*"

    match "old_files/*" $ do
        route   (gsubRoute "old_files/" (const ""))
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "about.md" $ do
        route   $ setExtension "html"
        compile $ renderMD commonContext

    match "posts/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= render postCtx

    match "archive.md" $ do
        route   $ setExtension "html"
        compile $ withPosts id commonContext >>= renderMD

    match "index.md" $ do
        route   $ setExtension "html"
        compile $ withPosts (take 5) commonContext >>= renderMD

    match "templates/*" $ compile templateCompiler

    where
        titled t = mappend $ constField "title" t

        withPosts f ctx = do
            posts <- recentFirst =<< loadAll "posts/*"
            return $ listField "posts" postCtx (return $ f posts) `mappend` ctx

        render ctx =
            (>>= relativizeUrls)
            . loadAndApplyTemplate "templates/default.html" ctx

        renderMD ctx =
            getResourceBody
            >>= applyAsTemplate ctx
            >>= return . renderPandoc
            >>= render ctx

        serve = flip match $ do
            route idRoute
            compile copyFileCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    commonContext

commonContext :: Context String
commonContext =
    constField "twitter" "https://twitter.com/alex_pir" `mappend`
    constField "github"  "https://github.com/astynax"   `mappend`
    defaultContext
