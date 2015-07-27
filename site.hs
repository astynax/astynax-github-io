--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "files/*" $ do
        route   (gsubRoute "files/" (const ""))
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.md", "contact.md"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= render defaultContext

    match "posts/*" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html" postCtx
            >>= render postCtx

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            ctx <- withPosts $ "Archive" `titled` defaultContext
            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" ctx
                >>= render ctx

    match "index.html" $ do
        route   idRoute
        compile $ do
            ctx <- withPosts $ "Home" `titled` defaultContext
            getResourceBody
                >>= applyAsTemplate ctx
                >>= render ctx

    match "templates/*" $ compile templateCompiler

    where
        titled t = mappend $ constField "title" t

        withPosts ctx = do
            posts <- recentFirst =<< loadAll "posts/*"
            return $ listField "posts" postCtx (return posts) `mappend` ctx

        render ctx =
            (>>= relativizeUrls)
            . loadAndApplyTemplate "templates/default.html" ctx

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
