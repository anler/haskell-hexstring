module Data.HexStringSpec where

import           Data.HexString

import qualified Data.ByteString.Lazy.Char8 as BSL8
import qualified Data.Text             as T

import qualified Data.Binary as B ( encode )

import           Test.Hspec

spec :: Spec
spec = do
  describe "when decoding hex data" $ do
    it "should be able to parse basic hex data" $ do
      (B.encode . decodeByteString) (BSL8.pack "ffff") `shouldBe` BSL8.pack "\255\255"
      (B.encode . decodeString) "ffff"                 `shouldBe` BSL8.pack "\255\255"
      (B.encode . decodeText) (T.pack "ffff")          `shouldBe` BSL8.pack "\255\255"

    it "should be able to recode basic hex data to different formats" $
      let hex = BSL8.pack "ffff"
      in do
        (encodeText . decodeByteString) hex       `shouldBe` T.pack "ffff"
        (encodeString . decodeByteString) hex     `shouldBe` "ffff"
        (encodeByteString . decodeByteString) hex `shouldBe` BSL8.pack "ffff"
