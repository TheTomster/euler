-- Each character on a computer is assigned a unique code and the preferred
-- standard is ASCII (American Standard Code for Information Interchange). For
-- example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.  A modern
-- encryption method is to take a text file, convert the bytes to ASCII, then XOR
-- each byte with a given value, taken from a secret key. The advantage with the
-- XOR function is that using the same encryption key on the cipher text, restores
-- the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.
--
-- For unbreakable encryption, the key is the same length as the plain text
-- message, and the key is made up of random bytes. The user would keep the
-- encrypted message and the encryption key in different locations, and without
-- both "halves", it is impossible to decrypt the message.
--
-- Unfortunately, this method is impractical for most users, so the modified
-- method is to use a password as a key. If the password is shorter than the
-- message, which is likely, the key is repeated cyclically throughout the
-- message. The balance for this method is using a sufficiently long password key
-- for security, but short enough to be memorable.  Your task has been made easy,
-- as the encryption key consists of three lower case characters. Using cipher.txt
-- (right click and 'Save Link/Target As...'), a file containing the encrypted
-- ASCII codes, and the knowledge that the plain text must contain common English
-- words, decrypt the message and find the sum of the ASCII values in the original
-- text.

import Data.Bits
import Data.Char
import Data.List
import qualified Data.Text as T   -- splitOn

type ASCII = Int
type Key = [ASCII]

getInput :: IO [ASCII]
getInput = do
    contents <- readFile "p059_cipher.txt"
    let strs = map T.unpack $ T.splitOn (T.pack ",") (T.pack contents)
    return $ map read strs

decrypt :: Key -> [ASCII] -> [ASCII]
decrypt k t = map xorPair $ zip (cycle k) t
    where xorPair (a, b) = a `xor` b

keys :: [Key]
keys = [[a,b,c] | a <- [0..127], b <- [0..127], c <- [0..127]]

countSpaces :: [ASCII] -> Int
countSpaces ascii = length $ filter (== 32) ascii

moreSpaces :: [ASCII] -> [ASCII] -> Ordering
moreSpaces a b = compare (countSpaces a) (countSpaces b)

message t ks = maximumBy moreSpaces [decrypt k t | k <- ks]

toString :: [ASCII] -> String
toString ascii = map chr ascii

main = do
    i <- getInput
    let result = sum $ message i keys
    putStrLn $ show $ result
