{-# LANGUAGE TypeFamilies, DeriveDataTypeable, TemplateHaskell #-}
module Main (main) where

import Data.Acid

import Control.Monad.State                   ( get, put )
import Control.Monad.Reader                  ( ask )
import System.Environment                    ( getArgs )
import Data.SafeCopy

type Item = String
data YakStack = YakStack [Item]

$(deriveSafeCopy 0 'base ''YakStack)

push :: Item -> Update YakStack ()
push yak = do
    YakStack yaks <- get
    put $ YakStack (yak:yaks)

peek :: Query YakStack [Item]
peek = do
    YakStack yaks <- ask
    return yaks

pop :: Update YakStack Item
pop = do
    YakStack xs <- get
    case xs of
      (item:items) -> do put $ YakStack items
                         return item
      []           -> do put $ YakStack []
                         return "Your yak stack is empty."

$(makeAcidic ''YakStack ['push, 'peek, 'pop])

usage :: IO ()
usage = putStrLn "yak [push <message>|pop|peek] - store brief TODOs so you don't forget"

main :: IO ()
main = do
    yakStack <- openLocalStateFrom ".yak/" (YakStack ["Your yak stack is empty, use \"yak push\""])
    let showAll = query yakStack Peek >>= mapM_ putStrLn

    args <- getArgs
    case args of
        ("push":xs) -> update yakStack (Push $ unwords xs)
        ("pop" :_)   -> update yakStack Pop >>= putStrLn
        ("peek":_)  -> showAll
        _           -> usage
