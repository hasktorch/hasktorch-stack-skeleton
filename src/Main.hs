module Main where

import Torch

main :: IO ()
main = print x where
    t = asTensor ([0..5] :: [Float])
    x = Torch.exp (-t)
