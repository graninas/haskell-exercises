-- Exercise 1: Serialization

-- Task 1:
-- * Serialize and deserialize the johnDoe person to string with Show / Read functionality.
-- * Write the serialized info about JohnDoe into a text file.
-- * Load this data from the file.
-- * Print the result to console.

-- Task 2:
-- * Do the same as in Task 1 but serialize data with ToJSON / FromJSON functionality (the aeson library).

-- Task 3:
-- * Add a new field - address into the Person data structure.
-- * Make the new data structure serializable.
-- * Repeat Tasks 1 and 2.

{-# LANGUAGE DeriveAnyClass #-}

module Exercise1 where

import Data.Aeson
import GHC.Generics (Generic)

data Address = Address
  { street      :: String
  , city        :: String
  , postalIndex :: String
  }

data Person = Person
  { firstName :: String
  , lastName  :: String
  , age       :: Int
  -- , address   :: Address
  }
  deriving (Show, Read, Eq, Generic, ToJSON, FromJSON)


johnDoe :: Person
johnDoe = Person "John" "Doe" 32


exercise1 :: IO ()
exercise1 = do
  putStrLn "Put your code here."
