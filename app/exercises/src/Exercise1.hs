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
  deriving (Show, Read, Eq, Generic, ToJSON, FromJSON)

data Person = Person
  { firstName :: String
  , lastName  :: String
  , age       :: Int
  , address   :: Address
  }
  deriving (Show, Read, Eq, Generic, ToJSON, FromJSON)




instance ToJSON Address where
  toJSON (Address { street = street, city = city, postalIndex = postalIndex }) =
    object [ "street" .= street
           , "city"  .= city
           , "postalIndex" .= postalIndex
            ]

instance ToJSON Person where
  toJSON (Person { firstName = firstName, lastName = lastName, age = age, address = Address }) =
    object [ "first_name" .= firstName
           , "last_name"  .= lastName
           , "age"        .= age
           , "address"    .=? Address
           ]



instance FromJSON Address where
  parseJSON = withObject Address $ \o -> do
    street <- o .: "street"
    city <- o .: "city"
    postalIndex <- o .: "postalIndex"
    return (Address street city postalIndex)

instance FromJSON Person where
  parseJSON = withObject Person $ \o -> do
    firstName <- o .: "firstName"
    lastName <- o .: "lastName"
    age <- o .: "age"
    address <- o .:? "address"
    return (Person firstName lastName age Address street city postalIndex)






jasonJSON :: LB.ByteString
karlJSON = Person "Jason" "Jam" 49


johnDoe_Address :: Address
johnAddress = Address "123 Avalon" "Evanston" "94536"

johnnyD_Address :: Address
johnnyAddress = Address "321 Morningside" "Millvale" "36219"

johnDoe :: Person
johnDoe = Person "John" "Doe" 32 johnDoe_Address--Address "123 Avalon" "Evanston" "94536"

johnnyD :: Person
johnnyD = Person "Johnny" "D." 33 Address "321 Morningside" "Millvale" "36219"




exercise1 :: IO ()
exercise1 = do
  putStrLn "Put your code here."
